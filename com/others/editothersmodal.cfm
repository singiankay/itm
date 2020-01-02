<cfif structKeyExists(URL, "id")>
	<cfset objOthers = createObject('itmanagement.com.others.Others').init() />
	<cfset objValidator = createObject('itmanagement.com.config.Validator').init() />
	<cfset Others = objOthers.getOthers(URL.id) />
	<cfoutput>
		<form class="form-horizontal" enctype="multipart/form-data" method="POST">
			<div class="modal-dialog modal-lg" role="document">
		   	<div class="modal-content modal-success">
		     	<div class="modal-header">
		      	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		         <span aria-hidden="true">&times;</span></button>
		      	<h4 class="modal-title">Edit Others: <b>#Others.brand#: #Others.model#</b></h4>
		      	<input type="hidden" id="OthersID" name="OthersID" value="#Others.id_record#">
		      </div>
		      <div class="modal-body">
		      	<div class="box-body">
						<div class="form-group">
						   <label for="Brand" class="col-sm-3 control-label">Brand&##42;</label>
						   <div class="col-sm-9">
							   <input type="text" class="form-control" id="Brand" name="Brand" placeholder="Brand" maxlength="50" required="required" value="#Others.brand#">
						   </div>
						</div>
						<div class="form-group">
						   <label for="Model" class="col-sm-3 control-label">Model&##42;</label>
						   <div class="col-sm-9">
							   <input type="text" class="form-control" id="Model" name="Model" placeholder="Model" maxlength="50" required="required" value="#Others.model#">
						   </div>
						</div>
						<div class="form-group">
						  	<div class="col-sm-offset-3 col-sm-9">
							   <div class="checkbox">
						      	<label><input type="checkbox" name="isActive" class="flat-red" #objValidator.getCheckboxValue(Others.is_active)#>&nbsp;Is Active?</label>
						      </div>
						   </div>
						</div>
						<div class="form-group">
							<label for="DateIssued" class="col-sm-3 control-label">Date Issued</label>
							<div class="col-sm-4">
						 		<div class="input-group">
						    		<div class="input-group-addon">
						      		<i class="fa fa-calendar"></i>
						   		</div>
						   		<input type="text" class="form-control" id="DateIssued" name="DateIssued" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask value="#dateFormat(Others.date_issued, 'mm/dd/yyyy')#">
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
						   		<input type="text" class="form-control" id="DateDestroyed" name="DateDestroyed" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask value="#dateFormat(Others.date_destroyed, 'mm/dd/yyyy')#">
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
					   			<input type="text" class="form-control" id="DateStocked" name="DateStocked" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask value="#dateFormat(Others.date_stocked, 'mm/dd/yyyy')#">
					   		</div>
					   	</div>
					   </div>
						<div class="form-group">
						  	<label for="Attachment" class="col-sm-3 control-label">Attachment</label>
						  	<div class="col-sm-6">
						  		<cfif Others.Attachment NEQ ''>
						  			<a href="downloads.cfm?download=true&type=Others&file=#URLEncodedFormat(Others.Attachment)#" class="btn bg-navy" target="_blank" role="button">#Others.Attachment#<i class="fa fa-download"></i></a>
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
								<textarea class="form-control" rows="6" id="Remarks" name="Remarks" placeholder="Remarks ...">#Others.remarks#</textarea>
							</div>
						</div>
		      	</div>
		     </div>
		     <!--- / .modal-body --->
		     <div class="modal-footer">
		       <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>
		       <input type="reset" class="btn btn-outline" value="Reset">
		       <input type="submit" class="btn btn-outline" value="Update" name="updateOthers">
		     </div>
		   </div> 
		   <!-- /.modal-content -->
		 </div>
		 <!-- /.modal-dialog -->
		</form>
	</cfoutput>
</cfif>