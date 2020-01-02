<cfif structKeyExists(URL, "id")>
  <cfif URL.type EQ "Computer">
    <cfset objComputerHistory = createObject('/itmanagement.com.history.ComputerHistory').init() />
    <cfset objComputer = createObject('/itmanagement.com.computers.Computers').init() />
    <cfset Name = objComputer.getComputerName(URL.id) />
    <cfset ID = objComputer.getITManagementID(URL.id) />
  <cfelseif URL.type EQ "Equipment">
    <cfset objEquipmentHistory = createObject('/itmanagement.com.history.EquipmentHistory').init() />
    <cfset objEquipment = createObject('/itmanagement.com.equipment.Equipment').init() />
    <cfset Name = objEquipment.getEquipmentName(URL.id) />
    <cfset ID = objEquipment.getITManagementID(URL.id) />
  <cfelseif URL.type EQ "Others">
    <cfset objOthersHistory = createObject('/itmanagement.com.history.OthersHistory').init() />
    <cfset objOthers = createObject('/itmanagement.com.others.Others').init() />
    <cfset Name = objOthers.getOthersName(URL.id) />
    <cfset ID = objOthers.getITManagementID(URL.id) />
  </cfif>

  <form class="form-horizontal" method="POST" enctype="multipart/form-data">
    <div class="modal-dialog" role="document">
      <div class="modal-content modal-primary">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Create History Record for <b><cfoutput>#Name#</cfoutput></b></h4>
        </div>
        <div class="modal-body">
          <div class="box-body">
            <div class="form-group">
              <label for="HistoryDate" class="col-sm-3 control-label">Date&#42;</label>
              <div class="col-sm-4">
                <div class="input-group">
                  <div class="input-group-addon">
                    <i class="fa fa-calendar"></i>
                  </div>
                  <input type="text" class="form-control" id="HistoryDate" name="HistoryDate" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask required="required">
                </div>
              </div>
            </div>
            <!--- <div class="bootstrap-timepicker"> --->
              <div class="form-group">
                <label for="HistoryTime" class="col-sm-3 control-label">Time&#42;</label>
                <div class="col-sm-4">
                  <div class="bootstrap-timepicker">
                    <div class="input-group">
                      <input type="text" class="form-control timepicker" name="HistoryTime" required="required">
                      <div class="input-group-addon">
                        <i class="fa fa-clock-o"></i>
                      </div>
                      <input type="hidden" name="ID" value="<cfoutput>#ID#</cfoutput>">
                      <input type="hidden" name="Type" value="<cfoutput>#URL.type#</cfoutput>">
                    </div>
                  </div>
                </div>
              </div>
              <!-- /.form group -->
            <!--- </div> --->
            <div class="form-group">
              <label for="Attachment" class="col-sm-3 control-label">Attachment</label>
              <div class="col-sm-9">
                <input id="Attachment" type="file" class="file" name="Attachment">
              </div>
            </div>
            <div class="form-group">
              <label for="Remarks" class="col-sm-3 control-label">Remarks&#42;</label>
              <div class="col-sm-9">
                <textarea class="form-control" rows="6" id="Remarks" name="Remarks" placeholder="Remarks ..." required="required"></textarea>
              </div>
            </div>
          </div>
          <!--- / .modal-body --->
          </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>
          <input type="submit" name="createHistory" class="btn btn-outline" value="Create">
        </div>
      </div> 
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </form>
</cfif>