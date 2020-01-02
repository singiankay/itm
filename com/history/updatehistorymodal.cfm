<cfif structKeyExists(URL, "id")>
  <cfif URL.type EQ "Computer">
    <cfset objComputer = createObject('itmanagement.com.computers.Computers').init() />
    <cfset objComputerHistory = createObject('itmanagement.com.history.ComputerHistory').init() />
    <cfset Name = objComputer.getComputerName(URL.id_itassets) />
    <cfset ID = URL.id />
    <cfset updateHistory = objComputerHistory.getHistoryByID(ID) />
  <cfelseif URL.type EQ "Equipment">
    <cfset objEquipment = createObject('itmanagement.com.equipment.Equipment').init() />
    <cfset objEquipmentHistory = createObject('itmanagement.com.history.EquipmentHistory').init() />
    <cfset Name = objEquipment.getEquipmentName(URL.id_itassets) />
    <cfset ID = URL.id />
    <cfset updateHistory = objEquipmentHistory.getHistoryByID(ID) />
  <cfelseif URL.type EQ "Others">
    <cfset objOthers = createObject('itmanagement.com.others.Others').init() />
    <cfset objOthersHistory = createObject('itmanagement.com.history.OthersHistory').init() />
    <cfset Name = objOthers.getOthersName(URL.id_itassets) />
    <cfset ID = URL.id />
    <cfset updateHistory = objOthersHistory.getHistoryByID(ID) />
  </cfif>

  <form class="form-horizontal" method="POST" enctype="multipart/form-data">
    <div class="modal-dialog" role="document">
      <div class="modal-content modal-success">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Update History Record for <b><cfoutput>#Name#</cfoutput></b></h4>
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
                  <input type="text" class="form-control" id="HistoryDate" name="HistoryDate" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask required="required" value="<cfoutput>#DateFormat(updateHistory.date,"mm/dd/yyyy")#</cfoutput>">
                </div>
              </div>
            </div>
            <!--- <div class="bootstrap-timepicker"> --->
              <div class="form-group">
                <label for="HistoryTime" class="col-sm-3 control-label">Time&#42;</label>
                <div class="col-sm-4">
                  <div class="bootstrap-timepicker">
                    <div class="input-group">
                      <input type="text" class="form-control timepicker" name="HistoryTime" required="required" value="<cfoutput>#TimeFormat(updateHistory.time, "hh:mm:ss tt")#</cfoutput>">
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
            <cfoutput>
            <div class="form-group">
                <label for="Attachment" class="col-sm-3 control-label">Attachment</label>
                <div class="col-sm-6">
                  <cfif updateHistory.Attachment NEQ ''>
                    <a href="downloads.cfm?download=true&type=History#URL.type#&file=#URLEncodedFormat(updateHistory.Attachment)#" class="btn bg-navy" target="_blank" role="button">#updateHistory.Attachment#<i class="fa fa-download"></i></a>
                  </cfif>
                </div>
            </div>
            <div class="form-group">
              <div class="col-sm-offset-3 col-sm-9">
                <dt>Replace Existing Attached File</dt>
                  <input id="Attachment" type="file" class="file" name="Attachment">
                </div>
            </div>
            </cfoutput>
            <div class="form-group">
              <label for="Remarks" class="col-sm-3 control-label">Remarks&#42;</label>
              <div class="col-sm-9">
                <textarea class="form-control" rows="6" id="Remarks" name="Remarks" placeholder="Remarks ..." required="required"><cfoutput>#updateHistory.remarks#</cfoutput></textarea>
              </div>
            </div>
          </div>
          <!--- / .modal-body --->
          </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>
          <input type="reset" class="btn btn-outline" value="Reset">
          <input type="submit" name="updateHistory" class="btn btn-outline" value="Update">
        </div>
      </div> 
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </form>

</cfif>