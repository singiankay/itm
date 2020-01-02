<cfoutput>

<cfset attendance = createObject('/itmanagement.com.attendance.Attendance').init()/>
<cfset dbmain = "itmanagement"/>

<cfquery name="getAll" datasource="#dbmain#">
	SELECT 
	<cfloop from=1 to=52 index="i">
	(
		SELECT percentage
		FROM tbl_attendance WHERE week_num = #i# AND year_num = #url.year#
		) as week_#i#,
	</cfloop>
	year_num
	FROM tbl_attendance
	WHERE year_num = #url.year#
	LIMIT 1
</cfquery>

<cfquery name="getCount" datasource="#dbmain#">
		SELECT count(id) as thecount FROM tbl_attendance WHERE year_num = #url.year# AND percentage IS NOT NULL
</cfquery>



<!--- <cfdump var="#getAll#"> --->

<cfset arrValues = arrayNew(1)>
<cfset arrWeeks = arrayNew(1)>
<cfset arrTarget = arrayNew(1)>

<cfloop from="1" to="#getCount.thecount#" index="w">
		<cfset insertthis = 0>

		<cfif evaluate("getAll.week_#w#") neq ''>
			<cfset insertthis = evaluate("getAll.week_#w#")>
		</cfif>

		<cfset arrayAppend(arrValues, insertthis)>
		<cfset arrayAppend(arrWeeks, w)>
		<cfset arrayAppend(arrTarget, 97.25)>
</cfloop>

<!--- <cfdump var="#arrValues#"> --->

<canvas id="target-chart" width="600" height="170"></canvas>



<script>


$(function () {
	
var vals = [#arrayToList(arrValues,",")#];
var weeks = [#arrayToList(arrWeeks,",")#];
var target = [#arrayToList(arrTarget,",")#];

var ctx = document.getElementById('target-chart');
var bar_chart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: weeks,
        datasets: [
				{
            label: 'Actual',
            data: vals,
						backgroundColor: "green",
						borderColor: "green",
						fill:false
        },
				{
            label: 'Target',
            data: target,
						backgroundColor: "red",
						borderColor: "red",
						fill:false
        },
        ]
    },
	options: {
     		animation: {
        	duration: 1500,
        },
        showLInes: true,
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
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Week number'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Percentage'
						},
						ticks: {
							min: 75
						}
					}]
				},
        onClick: function (c,i) {
        	console.log(c)
        	console.log(i)

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

})

	</script>




</cfoutput>