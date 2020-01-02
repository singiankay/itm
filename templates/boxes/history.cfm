<cfif URL.type EQ "Computer">
	<cfset objComputer = createObject('itmanagement.com.computers.Computers').init() />
	<cfset Name = objComputer.getComputerName(URL.computer_id) />
	<cfset objComputerHistory = createObject('itmanagement.com.history.ComputerHistory').init() />
	<cfset getHistoryRecords = objComputerHistory.getHistory(#URL.id#,#URL.type#) />
	<cfset ID = URL.computer_id />
<cfelseif URL.type EQ "Equipment">
	<cfset objEquipment = createObject('itmanagement.com.equipment.Equipment').init() />
	<cfset Name = objEquipment.getEquipmentName(URL.equipment_id) />
	<cfset objEquipmentHistory = createObject('itmanagement.com.history.EquipmentHistory').init() />
	<cfset getHistoryRecords = objEquipmentHistory.getHistory(#URL.id#,#URL.type#) />
	<cfset ID = URL.equipment_id />
<cfelseif URL.type EQ "Others">
	<cfset objOthers = createObject('itmanagement.com.others.Others').init() />
	<cfset Name = objOthers.getOthersName(URL.others_id) />
	<cfset objOthersHistory = createObject('itmanagement.com.history.OthersHistory').init() />
	<cfset getHistoryRecords = objOthersHistory.getHistory(#URL.id#,#URL.type#) />
	<cfset ID = URL.others_id />
<cfelse>
</cfif>

<div class="row">
	<div class="col-xs-12">
	   <div class="box box-default">
		  <div class="box-header with-border">
		    <h3 class="box-title">History records of <b><cfdump var="#Name#" /></b></h3>
		    <div class="box-tools pull-right">
		      <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
		      <button class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
		    </div>
		    <!-- /.box-tools -->
		  </div>
		  <!-- /.box-header -->
		  <div class="box-body">
		    <table id="History" class="table table-bordered table-hover">
		      <thead>
		      <tr>
		        <th>Date</th>
		        <th>Time</th>
		        <th>Remarks</th>
		        <th>Attachment</th>
		        <th>Option</th>
		      </tr>
		      </thead>
		      <tbody data-link="row" class="rowlink" id="HistoryRecords">
		      	<!--- <cfdump var="#getHistoryRecords#" /> --->
		      	<cfoutput query="getHistoryRecords">
						<tr data-value="#getHistoryRecords.id_record#" class="AssetRows">
								<td>#DateFormat(getHistoryRecords.date, "mm/dd/yyyy")#</td>
								<td>#TimeFormat(getHistoryRecords.time, "hh:mm:ss tt")#</td>
								<td>#getHistoryRecords.remarks#</td>
								<td>
									<cfif getHistoryRecords.attachment NEQ ''>
										<div class="btn-group-vertical center-block">
											<a href="downloads.cfm?download=true&type=History#URL.type#&file=#URLEncodedFormat(getHistoryRecords.attachment)#" class="btn btn-sm btn-block bg-navy" target="_blank" role="button">#getHistoryRecords.attachment#&nbsp;<i class="fa fa-download"></i></a>
											<cfif DateDiff("d", getHistoryRecords.date_created, now()) LTE 7>
												<cfif getHistoryRecords.recordcount EQ getHistoryRecords.currentrow>
													<input type="button" class="btn btn-block btn-xs btn-danger" onclick="deleteHistoryAttachment('#getHistoryRecords.attachment#',#getHistoryRecords.id_record#,'#URL.type#')" data-historyattachment_id="#getHistoryRecords.attachment#" value="Delete">
												<cfelse>
													<input type="button" class="btn btn-block btn-xs btn-danger disabled" value="Delete">
												</cfif>
											<cfelse>
												<input type="button" class="btn btn-block btn-xs btn-danger disabled" value="Delete">
											</cfif>
										</div>
									</cfif>
								</td>
								<td>
									<cfif DateDiff("d", getHistoryRecords.date_created, now()) LTE 7>
										<cfif getHistoryRecords.recordcount EQ getHistoryRecords.currentrow>
											<input type="button" value="Edit" class="btn btn-block btn-success" onclick="updateHistory(#getHistoryRecords.id_record#,#ID#,'#URL.type#')">
										<cfelse>
											<input type="button" value="Edit" class="btn btn-block btn-success disabled">
										</cfif>
									<cfelse>
										<input type="button" value="Edit" class="btn btn-block btn-success disabled">
									</cfif>
								</td>
						</tr>
					</cfoutput>
		      </tbody>
		      <tfoot>
		      <tr>
		        <th>Date</th>
		        <th>Time</th>
		        <th>Remarks</th>
		        <th>Attachment</th>
		        <th>Option</th>
		      </tr>
		      </tfoot>
		    </table>
		  </div>
		  <!-- /.box-body -->
		  <div class="box-footer">
		  	<div class="col-sm-offset-2 col-sm-8 col-sm-offset-2">
		  		<input type="button" onclick="createHistory(<cfoutput>#ID#,'#URL.type#'</cfoutput>)" class="btn btn-lg btn-block btn-primary" name="createHistory" value="Create History Record">
		  	</div>
		  </div><!-- box-footer -->
		</div>
		<!-- /.box -->
   </div>
   <!-- /.col -->
</div>
<!-- /.row -->