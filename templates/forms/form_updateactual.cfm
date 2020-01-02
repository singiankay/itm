<cfoutput>
<cfquery name="getMIS" datasource="employee_db">
	select 	emp33, concat(emp3," ",emp2) as name from m_employee where emp24 = 1 and emp27 = 1 and emp5 NOT LIKE "OJT" ORDER BY emp1 DESC
</cfquery>

	 <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title">Set Actual Date</h3>
      </div>
      <form name="frm_setactual" enctype="multipart/form-data" method="post" action="com/schedules/setactual.cfm?id=#url.id#">



      	<div class="modal-body">
        <div class="container-fluid">
          <!-- DATA GOES HERE -->
          <label>Select date:</label>
          <input type="date" class="form-control" name="txtDate" id="txtDate" >
          <label>Performed by:</label>
          <select class="form-control" name="slcPerformer" id="slcPerformer">
          			<option value="" selected="">---</option>
          	<cfloop query="#getMIS#">
          			<option value="#getMIS.emp33#">#getMIS.name#</option>
          	</cfloop>
          </select>
          <label>Attach evidence:(jpg,png)</label>
          <input type="file" class="form-control" name="evidence">
          <label>Remarks:</label>
          <textarea rows="5" class="form-control" name="remarks"></textarea>

        </div>    
      </div>
      <input type="submit"  name="" id="btnSetActualSingle" hidden="">
      </form>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" onclick="setActual()">Save</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <!--- <button type="button" class="btn btn-primary" id="btnSaveUser" onclick="">UPDATE</button> --->
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->




</cfoutput>