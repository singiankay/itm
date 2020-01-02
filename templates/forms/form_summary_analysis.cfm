<style type="text/css">
  
.analysis-ontarget {
  background: #C5E4FF;
  margin: 2px;
  padding: 5px 10px;
  width: 100%
}

.analysis-recovery {
  background: #FFFDCF;
  margin: 2px;
  padding: 5px 10px;
  width: 100%
}

.analysis-offtarget {
  background: #FFC5C5;
  margin: 2px;
  padding: 5px 10px;
  width: 100%
}

.cs-col {
  padding: 0px 2px !important
}

</style>
<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset getAnalysis = objSchedules.getAnalysis(url.month,url.year)>
<cfset dbmain = "itmanagement"/>

<cfset tempdate = createDate(url.year, url.month, 1)>
<cfset lastdayofmonth = createDate(url.year, url.month, daysInMonth(tempdate))>

<cfset tempdate2 = createDate(year(now()), month(now()), 1)>
<cfset lastdayofmonth2 = createDate(year(now()), month(now()), daysInMonth(now()))>


<cfset listed = arrayNew(1)>



<cfloop from=1 to=#url.month# index="m">
  <cfif m LT url.month>
    <cfset tempdate = createDate(url.year, m, 1)>
    <cfset lastdayofmonth3 = createDate(url.year, m, daysInMonth(tempdate))>    

    <cfquery name="getOffTargetCon" datasource="#dbmain#">
      SELECT b.computer_name, id, computer_id, week_no, sched_date, date_actual, week(date_actual) as week_actual, 
      DATEDIFF (#lastdayofmonth3#,sched_date) as lapse
      FROM tbl_schedules a
      LEFT JOIN tbl_computer_copy b
      ON a.computer_id = b.id_record
      WHERE 1=1
      AND DATEDIFF (#lastdayofmonth3#,sched_date) > 60
      AND month(sched_date) <= #m#
      AND year(sched_date) = #url.year#
      AND date_actual IS NULL
    </cfquery>    

      <cfset arrayAppend(listed, valueList(getOffTargetCon.id))>
  </cfif>
</cfloop>

<!--- <cfdump var="#listed#"> --->

<cfquery name="getOnTarget" datasource="#dbmain#">
  SELECT b.computer_name, id, computer_id, week_no, sched_date, date_actual, week(date_actual) as week_actual, 
  DATEDIFF (#lastdayofmonth#,sched_date) as lapse
  FROM tbl_schedules a
  LEFT JOIN tbl_computer_copy b
  ON a.computer_id = b.id_record
  WHERE 1=1
  AND month(sched_date) = #url.month#
  AND date_actual IS NOT NULL
  AND year(sched_date) = #url.year#
  AND datediff(date_actual,sched_date) < 60
</cfquery>

<cfquery name="getOffTarget" datasource="#dbmain#">
  SELECT b.computer_name, id, computer_id, week_no, sched_date, date_actual, week(date_actual) as week_actual, 
  DATEDIFF (#lastdayofmonth#,sched_date) as lapse
  FROM tbl_schedules a
  LEFT JOIN tbl_computer_copy b
  ON a.computer_id = b.id_record
  WHERE 1=1
      <cfif url.month gt 1>
        <cfif listed[url.month-1] neq ''>
          AND id NOT IN (#listed[url.month-1]#)
        </cfif>
      </cfif>  
  AND DATEDIFF (#lastdayofmonth#,sched_date) > 60
  AND month(sched_date) <= #url.month#
  AND year(sched_date) = #url.year#
  AND date_actual IS NULL
</cfquery>

<!--- <cfquery name="getOffTarget" datasource="#dbmain#">
  SELECT b.computer_name, id, computer_id, week_no, sched_date, date_actual, week(date_actual) as week_actual, 
  DATEDIFF (#lastdayofmonth2#,sched_date) as lapse
  FROM tbl_schedules a
  LEFT JOIN tbl_computer_copy b
  ON a.computer_id = b.id_record
  WHERE 1=1
      <cfif url.month gt 1>
        <cfif listed[url.month-1] neq ''>
          AND id NOT IN (#listed[url.month-1]#)
        </cfif>
      </cfif>  
  AND DATEDIFF (#lastdayofmonth2#,sched_date) > 60
  AND month(sched_date) <= #url.month#
  AND year(sched_date) = #url.year#
  AND date_actual IS NULL
</cfquery>
 --->


<cfquery name="getOnRecovery" datasource="#dbmain#">
  SELECT computer_name, computer_id, week_no, sched_date, date_actual, week(date_actual) as week_actual, 
  DATEDIFF (#lastdayofmonth#,sched_date) as lapse
  FROM tbl_schedules a
  LEFT JOIN tbl_computer_copy b
  ON a.computer_id = b.id_record
  WHERE 1=1
  <cfif getOffTarget.id neq ''>
    AND id NOT IN (#valueList(getOffTarget.id)#)
  </cfif>  
  AND DATEDIFF (#lastdayofmonth#,sched_date) <= 60
  AND month(sched_date) = #url.month#
  AND year(sched_date) = #url.year#
  AND date_actual IS NULL
</cfquery>

<!--- <cfquery name="getOnRecovery" datasource="#dbmain#">
  SELECT computer_name, computer_id, week_no, sched_date, date_actual, week(date_actual) as week_actual, 
  DATEDIFF (#lastdayofmonth#,sched_date) as lapse
  FROM tbl_schedules a
  LEFT JOIN tbl_computer_copy b
  ON a.computer_id = b.id_record
  WHERE 1=1
  AND DATEDIFF (#lastdayofmonth#,sched_date) <= 60
  AND month(sched_date) = #url.month#
  AND year(sched_date) = #url.year#
  AND date_actual IS NULL
</cfquery>

 --->
 <!--- <cfdump var="#getOffTarget#"> --->
 <!--- <cfdump var="#getOnRecovery#"> --->


   <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title">#MonthAsString(url.month)# #url.year# </h3>
      </div>
      
        <div class="modal-body">
        <div class="container-fluid">
          <!-- DATA GOES HERE -->
          <table class="table table-bordered">
            <tr>
              <th><center>Analysis</center></th>
            </tr>
            <tr>
              <td>
                <cfif getAnalysis.recordcount eq 0 || getAnalysis.id eq ''>
                  
                  <cfif listFindNoCase("8,7351", SESSION.loginid) gt 0>
                    <input type="hidden" id="txtYear" value="#url.year#" name="">
                    <input type="hidden" id="txtMonth" value="#url.month#" name="">
                    <textarea class="form-control" id="txtAnalysis"></textarea>
                    <br>
                    <button type="button" class="btn btn-success pull-right" onclick="saveAnalysis()">Save</button>
                  <cfelse>
                    <center><b>N/A</b></center>
                  </cfif>

                <cfelse>
                  #getAnalysis.analysis#
                </cfif>
              </td>
            </tr>
          </table>

          <div class="row">
            <div class="col-lg-12 cs-col">
             <h4>On Target (#getOnTarget.recordcount#)</h4>
            </div>
          </div>
          <div class="row myrow">
            <cfif getOnTarget.recordcount gt 0>
            <cfloop query="getOnTarget">
                <div class="col-lg-2 cs-col">
                  <div class="analysis-ontarget">
                    #getOnTarget.computer_name#
                  </div>
                </div>
            </cfloop>
            <cfelse>
                <b><i>No records</i></b>
            </cfif>
          </div>

          <div class="row">
            <div class="col-lg-12 cs-col">
             <h4>On Recovery (#getOnRecovery.recordcount#)</h4>
            </div>
          </div>          
          <div class="row myrow">
            <cfif getOnRecovery.recordcount gt 0>
            <cfloop query="getOnRecovery">
                <div class="col-lg-2 cs-col">
                  <div class="analysis-recovery">
                    #getOnRecovery.computer_name#
                  </div>
                </div>
            </cfloop>
            <cfelse>
             <b><i>No records</i></b>
            </cfif>
          </div>          

          <div class="row">
            <div class="col-lg-12 cs-col">
             <h4>Off target (#getOffTarget.recordcount#)</h4>
            </div>
          </div>
          <div class="row myrow">
            <cfif getOffTarget.recordcount gt 0>
            <cfloop query="getOffTarget">
                <div class="col-lg-2 cs-col">
                  <div class="analysis-offtarget">
                    #getOffTarget.computer_name#
                  </div>
                </div>
            </cfloop>
            <cfelse>
              <b><i>No records</i></b>
            </cfif>
          </div>

        </div>    
      </div>

      <div class="modal-footer">
        
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <!--- <button type="button" class="btn btn-primary" id="btnSaveUser" onclick="">UPDATE</button> --->
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</cfoutput>

<script type="text/javascript">
  
  function saveAnalysis() {
    var year = $("#txtYear").val();
    var month = $("#txtMonth").val();
    var analysis = $("#txtAnalysis").val();
    var str = myTrim(analysis);

    if (!str || str === '') {
      toastr.error("Enter your analysis")
    } else {
      if (confirm("Confirm save")) {
        var data = {
          year: year,
          month: month,
          analysis: analysis
        }

        $.post('com/schedules/save_analysis.cfm', data, function(data) {
          if (data == 1) {
            alert("Record saved!")
            location.reload();
          }    
        })
      }

    }
  }

  function myTrim(x) {
    return x.replace(/^\s+|\s+$/gm,'');
  }

</script>
