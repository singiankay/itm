<cfif structKeyExists(URL, "id")>
	<cfset objComputers = createObject('itmanagement.com.computers.Computers').init() />
	<cfset objValidator = createObject('itmanagement.com.config.Validator').init() />
	<cfset Computer = objComputers.getComputer(URL.id) />
	<cfoutput>
		<form class="form-horizontal" enctype="multipart/form-data" method="POST">
			<div class="modal-dialog modal-lg" role="document">
		   	<div class="modal-content modal-success">
		     	<div class="modal-header">
		      	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		         <span aria-hidden="true">&times;</span></button>
		      	<h4 class="modal-title">Edit Computer: <b>#Computer.computer_name#</b></h4>
		      	<input type="hidden" id="ComputerID" name="ComputerID" value="#Computer.id_record#">
		      </div>
		      <div class="modal-body">
		      	<div class="box-body">
						<div class="form-group">
						   <label for="ComputerType" class="col-sm-3 control-label">Computer Type&##42;</label>
						   <div class="col-sm-9">
							   <input type="text" class="form-control" id="ComputerType" name="ComputerType" placeholder="Computer Type" maxlength="50" required="required" value="#Computer.computer_type#">
						   </div>
						</div>
						<div class="form-group">
						   <label for="ComputerName" class="col-sm-3 control-label">Computer Name&##42;</label>
						   <div class="col-sm-9">
							   <input type="text" class="form-control" id="ComputerName" name="ComputerName" placeholder="Computer Name" maxlength="50" required="required" value="#Computer.computer_name#">
						   </div>
						</div>
						<div class="form-group">
						  	<div class="col-sm-offset-3 col-sm-9">
							   <div class="checkbox">
						      	<label><input type="checkbox" name="isActive" class="flat-red" #objValidator.getCheckboxValue(Computer.is_active)#>&nbsp;Is Active?</label>
						      </div>
						   </div>
						</div>
						<div class="form-group">
						   <label for="IPAddress" class="col-sm-3 control-label">IP Address</label>
						   <div class="col-sm-4">
								<div class="input-group">
						         <div class="input-group-addon">
						      	   <i class="fa fa-laptop"></i>
						         </div>
						         <input type="text" class="form-control" id="IPAdress" name="IPAddress" data-inputmask="'alias': 'ip'" data-mask id="IPAddress" value="#Computer.ip_address#">
						      </div>
						   </div>
						</div>
						<div class="form-group">
							<label for="ComputerProcessor" class="col-sm-3 control-label">Computer Processor</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="ComputerProcessor" name="ComputerProcessor" placeholder="Computer Processor" maxlength="50" value="#Computer.processor_type#">
							</div>
						</div>
						<div class="form-group">
							<label for="Memory" class="col-sm-3 control-label">Memory</label>
							<div class="col-sm-9">
						   	<input type="text" class="form-control" id="Memory" name="Memory" placeholder="Memory" maxlength="50" value="#Computer.memory_type#">
							</div>
						</div>
						<div class="form-group">
							<label for="OperatingSystem" class="col-sm-3 control-label">Operating System</label>
							<div class="col-sm-9">
						   	<input type="text" class="form-control" id="OperatingSystem" name="OperatingSystem" placeholder="Operating System" maxlength="50" value="#Computer.operating_system#">
							</div>
						</div>
						<div class="form-group">
							<label for="Office" class="col-sm-3 control-label">Office</label>
							<div class="col-sm-9"> 
								<input type="text" class="form-control" id="ComputerType" name="Office" placeholder="Office" maxlength="50" value="#Computer.office#">
							</div>
						</div>
						<div class="form-group">
							<label for="GraphicsCard" class="col-sm-3 control-label">Graphics Card</label>
							<div class="col-sm-9">
						   	<input type="text" class="form-control" id="GraphicsCard" name="GraphicsCard" placeholder="Graphics Card" maxlength="50" value="#Computer.graphics_card#">
							</div>
						</div>
						<div class="form-group">
							<label for="DateIssued" class="col-sm-3 control-label">Date Issued</label>
							<div class="col-sm-4">
						 		<div class="input-group">
						    		<div class="input-group-addon">
						      		<i class="fa fa-calendar"></i>
						   		</div>
						   		<input type="text" class="form-control" id="DateIssued" name="DateIssued" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask value="#dateFormat(Computer.date_issued, 'mm/dd/yyyy')#">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="DateDestroyed" class="col-sm-3 control-label">Date Destroyed</label>
							<div class="col-sm-4">
						 		<div class="input-group">
						   		<div class="input-group-addon">
						   			<i class="fa fa-calendar"></i>
						   		</div>
						   		<input type="text" class="form-control" id="DateDestroyed" name="DateDestroyed" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask value="#dateFormat(Computer.date_destroyed, 'mm/dd/yyyy')#">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="DateStocked" class="col-sm-3 control-label">Date Stocked</label>
					   	<div class="col-sm-4">
					   		<div class="input-group">
					   			<div class="input-group-addon">
					   				<i class="fa fa-calendar"></i>
					   			</div>
					   			<input type="text" class="form-control" id="DateStocked" name="DateStocked" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask value="#dateFormat(Computer.date_stocked, 'mm/dd/yyyy')#">
					   		</div>
					   	</div>
					   </div>
						<div class="form-group">
						  	<label for="Attachment" class="col-sm-3 control-label">Attachment</label>
						  	<div class="col-sm-6">
						  		<cfif Computer.Attachment NEQ ''>
						  			<a href="downloads.cfm?download=true&type=Computer&file=#URLEncodedFormat(Computer.Attachment)#" class="btn bg-navy" target="_blank" role="button">#Computer.Attachment#<i class="fa fa-download"></i></a>
						  		</cfif>
						  	</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<dt>Replace Existing Attached File</dt>
						  		<input id="Attachment" type="file" class="file" name="Attachment">
						  	</div>
						</div>
						<div class="form-group">
							<label for="Remarks" class="col-sm-3 control-label">Remarks</label>
							<div class="col-sm-9">
								<textarea class="form-control" rows="6" id="Remarks" name="Remarks" placeholder="Remarks ...">#Computer.remarks#</textarea>
							</div>
						</div>
		      	</div>
		     </div>
		     <!--- / .modal-body --->
		     <div class="modal-footer">
		       <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>
		       <input type="reset" class="btn btn-outline" value="Reset">
		       <input type="submit" class="btn btn-outline" value="Update" name="updateComputer">
		     </div>
		   </div> 
		   <!-- /.modal-content -->
		 </div>
		 <!-- /.modal-dialog -->
		</form>
	</cfoutput>
</cfif>