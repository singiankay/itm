<cfoutput>
<cfset attendance = createObject('/itmanagement.com.attendance.Attendance').init() />
<cfset dbmain = "itmanagement"/>

<cfquery name="getAll" datasource="#dbmain#">
  SELECT 
  <cfloop from=1 to=52 index="i">
  (
    SELECT percentage
    FROM tbl_attendance WHERE week_num = #i# AND year_num = #form.year#
    ) as week_#i#,
  </cfloop>
  year_num
  FROM tbl_attendance
  WHERE year_num = #form.year#
  LIMIT 1
</cfquery>
  <form name="frmAtt" method="POST" action="com/attendance/update_attendance.cfm?year=#form.year#">
   <div class="modal-dialog modal-lg" style="width: 95%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title">Update Attendance: <span class="bg-info">#form.year#</span> </h3>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
   
         <!-- DATA GOES HERE -->
          <table class="table table-condensed table-bordered table-striped">           
            <tr>
              <td>Week no.</td>
              <cfloop from="1" to="12" index="x">
                <td>#x#</td>
              </cfloop>
            </tr>
            <tr>
              <td>Percentage</td>
              <cfloop from="1" to="12" index="x">
                <td><input type="text" name="txtWeek#x#" value="#evaluate('getAll.week_#x#')#" style="width: 100%" name=""></td>
              </cfloop>
            </tr>            

<!--- END OF ROW 1 ################################################ --->
            <tr>
              <td>Week no.</td>
              <cfloop from="13" to="24" index="x">
                <td>#x#</td>
              </cfloop>
            </tr>

            <tr>
              <td>Percentage.</td>
              <cfloop from="13" to="24" index="x">
                <td><input type="text" name="txtWeek#x#" value="#evaluate('getAll.week_#x#')#" style="width: 100%" name=""></td>
              </cfloop>
            </tr>            
<!--- END ROW 2 ##################################################--->

            <tr>
              <td>Week no.</td>
              <cfloop from="25" to="36" index="x">
                <td>#x#</td>
              </cfloop>
            </tr>

            <tr>
              <td>Percentage</td>
              <cfloop from="25" to="36" index="x">
                <td><input type="text" name="txtWeek#x#" value="#evaluate('getAll.week_#x#')#" style="width: 100%" name=""></td>
              </cfloop>
            </tr>
  
<!--- END OF ROW 3 ##############################################--->

            <tr>
              <td>Week no.</td>
              <cfloop from="37" to="48" index="x">
                <td>#x#</td>
              </cfloop>
            </tr>    

            <tr>
              <td>Percentage</td>
              <cfloop from="37" to="48" index="x">
                <td><input type="text" name="txtWeek#x#" value="#evaluate('getAll.week_#x#')#" style="width: 100%" name=""></td>
              </cfloop>
            </tr>    

<!--- END OF ROW 4 ############################################## --->

            <tr>
              <td>Week no.</td>
              <cfloop from="49" to="52" index="x">
                <td>#x#</td>
              </cfloop>
            </tr>  

            <tr>
              <td>Percentage.</td>
              <cfloop from="49" to="52" index="x">
                <td><input type="text" name="txtWeek#x#" value="#evaluate('getAll.week_#x#')#" style="width: 100%" name=""></td>
              </cfloop>
            </tr>                       

          </table>   

          
        </div>    
      </div>
      <div class="modal-footer">
        <!--- <button type="button" class="btn btn-success" onclick="saveAttendance()">Save</button> --->
        <input type="submit" onclick="return confirm('Update maintenance?')" class="btn btn-success" value="Save" name="">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <!--- <button type="button" class="btn btn-primary" id="btnSaveUser" onclick="">UPDATE</button> --->
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
     </form>




</cfoutput>