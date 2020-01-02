<div class="modal fade" id="setSchedModal" role="dialog"></div>
<div class="modal fade" id="updateActualModal" role="dialog"></div>
<div class="modal fade" id="setActualMultipleModal" role="dialog"></div>
<div class="modal fade" id="setSchedMultipleModal" role="dialog"></div>
<div class="modal fade" id="modalViewSchedule" role="dialog"></div>

<cfoutput>
<div class="modal fade" id="addComputerModal" role="dialog">
	 <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title">Add Computer</h3>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
          <!-- DATA GOES HERE -->
          <label>Computer Name:</label>
          <input type="text" class="form-control" name="" value="#URL.group#" id="txtComputerName">
          <label>Group:</label>
          <select class="form-control" id="slcAddGroup">
            <cfloop query="getGroups">
                <option value="#getGroups.group_name#" <cfif getGroups.group_name eq url.group> selected </cfif>>#getGroups.group_name#</option>
            </cfloop>
          </select>
        </div>    
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" onclick="addComputer()">Save</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <!--- <button type="button" class="btn btn-primary" id="btnSaveUser" onclick="">UPDATE</button> --->
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->

</div>
</cfoutput>