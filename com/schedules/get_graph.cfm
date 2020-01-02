<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset dbmain = "itmanagement"/>

<cfquery name="getMonths" datasource="#dbmain#">
	SELECT month(sched_date) as sched_month FROM tbl_schedules WHERE sched_year = #url.year#
	GROUP BY month(sched_date)
	ORDER BY week_no ASC
</cfquery>

<cfquery name="getAnalysis" datasource="#dbmain#">
	SELECT * FROM tbl_analysis WHERE sched_year = #url.year# AND analysis IS NOT NULL
	ORDER BY sched_month ASC
</cfquery>


<cfset arrMonths = listToArray(valueList(getMonths.sched_month))>
<cfset arrOnTarget = arrayNew(1)>
<cfset arrOnRecovery = arrayNew(1)>
<cfset arrOffTarget = arrayNew(1)>
<cfset newarrmonths = arrayNew(1)>
<cfset listed = arrayNew(1)>

<cfloop from=1 to=12 index="m">
		<cfset datenow = DateFormat(now(),"yyyy-mm-dd")>
		<cfset month = "'"&monthAsString(m)&"'">
		<cfset arrayAppend(newarrmonths, month)>
		<cfquery name="getOnTargetCount" datasource="#dbmain#">
			SELECT computer_id, week_no, sched_date, date_actual, week(date_actual) as week_actual
			FROM tbl_schedules 
			WHERE 1=1
			AND month(sched_date) = #m#
			AND date_actual IS NOT NULL
			AND year(sched_date) = #url.year#
			AND datediff(date_actual,sched_date) < 60
		</cfquery>
		<cfset countOnTarget = getOnTargetCount.recordcount>
		<cfset arrayAppend(arrOnTarget, countOnTarget)>

		<cfset tempdate = createDate(url.year, m, 1)>
		<cfset lastdayofmonth = createDate(url.year, m, daysInMonth(tempdate))>


	 <cfquery name="getOffTarget" datasource="#dbmain#">
			SELECT b.computer_name, id, computer_id, week_no, sched_date, date_actual, week(date_actual) as week_actual, 
			DATEDIFF (#lastdayofmonth#,sched_date) as lapse
			FROM tbl_schedules a
			LEFT JOIN tbl_computer_copy b
			ON a.computer_id = b.id_record
			WHERE 1=1
			<cfif m gt 1>
				<cfif listed[m-1] neq ''>
					AND id NOT IN (#listed[m-1]#)
				</cfif>
			</cfif>
			AND DATEDIFF (#lastdayofmonth#,sched_date) > 60
			AND month(sched_date) <= #m#
			AND year(sched_date) = #url.year#
			AND date_actual IS NULL
		</cfquery>

		<cfquery name="getOffTargetCon" datasource="#dbmain#">
			SELECT b.computer_name, id, computer_id, week_no, sched_date, date_actual, week(date_actual) as week_actual, 
			DATEDIFF (#lastdayofmonth#,sched_date) as lapse
			FROM tbl_schedules a
			LEFT JOIN tbl_computer_copy b
			ON a.computer_id = b.id_record
			WHERE 1=1
			AND DATEDIFF (#lastdayofmonth#,sched_date) > 60
			AND month(sched_date) <= #m#
			AND year(sched_date) = #url.year#
			AND date_actual IS NULL
		</cfquery>


<!--- 		#monthasstring(m)#: <br>
		<cfdump var="#getOffTarget#">
		end of 	#monthasstring(m)# <br><br>
 --->

				<!--- #listed[m-1]# --->
		<cfif year(now()) eq url.year>
				<cfif m lt month(now())>
					<cfset arrayAppend(arrOffTarget, getOffTarget.recordcount)>
					<cfset arrayAppend(listed, valueList(getOffTargetCon.id))>
				<cfelse>
					<cfset arrayAppend(arrOffTarget, 0)>
					<cfset arrayAppend(listed, valueList(getOffTargetCon.id))>
				</cfif>
		<cfelse>
					<cfset arrayAppend(arrOffTarget, getOffTarget.recordcount)>
					<cfset arrayAppend(listed, valueList(getOffTargetCon.id))>
		</cfif>


		<cfquery name="getOnRecovery" datasource="#dbmain#">
			SELECT computer_id, week_no, sched_date, date_actual, week(date_actual) as week_actual, 
			DATEDIFF (#lastdayofmonth#,sched_date) as lapse
			FROM tbl_schedules 
			WHERE 1=1
			<cfif getOffTarget.id neq ''>
				AND id NOT IN (#valueList(getOffTarget.id)#)
			</cfif>
			<cfif m gt 1>
				<cfif listed[m-1] neq ''>
					AND id NOT IN (#listed[m-1]#)
				</cfif>
			</cfif>
			AND DATEDIFF (#lastdayofmonth#,sched_date) <= 60
			AND month(sched_date) = #m#
			AND year(sched_date) = #url.year#
			AND date_actual IS NULL
		</cfquery>
		<!--- <cfdump var="#getOnRecovery#"> --->
		<!--- <cfset arrayAppend(arrOnRecovery, getOnRecovery.recordcount)> --->

		<cfif year(now()) eq url.year>
				<cfif m lt month(now())>
					<cfset arrayAppend(arrOnRecovery, getOnRecovery.recordcount)>
				<cfelse>
					<cfset arrayAppend(arrOnRecovery, 0)>
				</cfif>
		<cfelse>
				<cfset arrayAppend(arrOnRecovery, getOnRecovery.recordcount)>
		</cfif>





			<!--- <cfdump var="#getOffTarget#"> --->

			<!--- <cfdump var="#listed#"> --->
</cfloop>


<canvas id="target-chart" width="600" height="170"></canvas>


<table class="table table-bordered table-striped" style="margin-top: 10px">
	<thead>
		<tr>
			<th>Month</th>
			<th>Analysis</th>
		</tr>
	</thead>
	<tbody>
		<cfloop query="getAnalysis">
			<tr>
				<td>#MonthAsString(getAnalysis.sched_month)#</td>
				<td>#getAnalysis.analysis#</td>
			</tr>
		</cfloop>
	</tbody>

</table>

<script>

var ontarget = [#arrayToList(arrOnTarget,",")#];
var onrecovery = [#arrayToList(arrOnRecovery,",")#];
var offtarget = [#arrayToList(arrOffTarget,",")#];
var months = [#arrayToList(newarrmonths,",")#];

var bar_ctx = document.getElementById('target-chart');
var bar_chart = new Chart(bar_ctx, {
    type: 'bar',
    data: {
        labels: months,
        datasets: [
				{
            label: 'On Target',
            data: ontarget,
						backgroundColor: "rgba(52, 152, 219,1.0)",
						borderColor: "white",
						fill:false
        },
				{
            label: 'On Recovery',
            data: onrecovery,
						backgroundColor: "rgba(241, 196, 15,1.0)",
						borderColor: "white",
						fill:false
        },
        {
            label: 'Off Target',
            data: offtarget,
						backgroundColor: "rgba(192, 57, 43,1.0)",
						borderColor: "white",
						fill:false
        },
        ]
    },
	options: {
     		animation: {
        	duration: 1500,
        },
        tooltips: {
					mode: 'label',
          callbacks: {
           label: function (tooltipItem, data) {
		                  const tooltip = data.datasets[tooltipItem.datasetIndex];
		                  const value = tooltip.data[tooltipItem.index];
		                  return value === 0 ? null : tooltip.label + ': ' + value;
                    }
          }
         }, //tooltips
        scales: {
          xAxes: [{ 
          	stacked: true, 
            gridLines: { display: false },
            }],
          yAxes: [{ 
          	stacked: true, 
            ticks: {
        			callback: function(value) { return value; },
     				}, 
            }],
        }, // scales
        onClick: function (c,i) {
        	// console.log(c)
        	// console.log(i)

        	if (i.length > 0) {
		        	e = i[0];
		   				var month = e._index+1;
		   				var year = getUrlValue('year');
		   				console.log(`Month: ${month}`)
		   				console.log(`Year: ${year}`)

		   					var modal = "##modalAnalysis";
								var data = {
									month:month,
									year:year
								}
									$.get('templates/forms/form_summary_analysis.cfm', data, function(data) {
											$(modal).html(data);
										 	$(modal).modal("show");
								})		
        	}
        

        }
    
    } // options
   }
);





var getUrlValue = function getUrlValue(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

	</script>




</cfoutput>