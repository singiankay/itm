<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset id = url.id>
<cfset getComputer = objSchedules.getComputerByID(url.id)>

<input type="hidden" value="#getComputer.computer_group#" id="txtGroup" name="">
   <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title">Set Schedule: <span class="bg-info">#getComputer.computer_name#</span> </h3>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
          <!-- DATA GOES HERE -->
          <cfif getComputer.computer_group eq 'SERVER'>
            <label>Select date:</label>
            <input type="date" class="form-control" name="" id="txtWeek">
          <cfelse>
            <label>Select week:</label>
            <input type="week" class="form-control" name="" id="txtWeek">
          </cfif>
          
        </div>    
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" onclick="setSingleSched(#id#)">Save</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <!--- <button type="button" class="btn btn-primary" id="btnSaveUser" onclick="">UPDATE</button> --->
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->





</cfoutput>