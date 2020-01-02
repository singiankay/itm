<cfscript>
if(structKeyExists(FORM, "archiveOthersFormValue")) {
	if(FORM.archiveOthers == "Yes") {
		if(objOthers.archiveOthers(FORM.archiveOthersFormValue) == true) {
			OthersName = objOthers.getOthersName(FORM.archiveOthersFormValue);
			if(objAssetManagement.unlinkAssetManagement(FORM.AssetID) == true) {
				Alert = objAlerts.setAlertMessage("Success", OthersName&" has been archived.");
			}
			else {
				Alert = objAlerts.setAlertMessage("Error", "Error updating record. "&OthersName&" has been archived but Fixed Asset Management Record still has not yet been unlinked to the archived record. Please contact the System Administrator about this issue");
			}
		}
		else {
			Alert = objAlerts.setAlertMessage("Error", "Error archiving "&OthersName&" has not been archived. Please contact the System Administrator about this issue");
		}
	}
}
if(structKeyExists(FORM, "updateOthers")) {
	
	if(objITManagementValidator.validateOthers(FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked) == true) {
		updateOthers = structNew();

		updateOthers.OthersID = FORM.OthersID;
		updateOthers.Brand = FORM.Brand;
		updateOthers.Model = FORM.Model;
		updateOthers.DateIssued = objValidator.setEmptyStringOrDate(FORM.DateIssued);
		updateOthers.DateDestroyed = objValidator.setEmptyStringOrDate(FORM.DateDestroyed);
		updateOthers.DateStocked = objValidator.setEmptyStringOrDate(FORM.DateStocked);
		updateOthers.Remarks = FORM.Remarks;
		updateOthers.Attachment = "";
		isContinueAfterAttachment = false;

		if(FORM.Attachment != "") {
			deleteExistingAttachment = objOthers.deleteFileIfExists(updateOthers.OthersID);
			if (deleteExistingAttachment == true) {
				uploadAttachment = objOthers.uploadAttachment("Attachment");
				updateOthers.Attachment = objOthers.getFilename(uploadAttachment);
				isContinueAfterAttachment = true;
			}
			else {
				Alert = objAlerts.setAlertMessage("Error","Could not replace attached file. Please try again.");
			}
			
		}
		else {
			isContinueAfterAttachment = true;
		}
		if(isContinueAfterAttachment == true) {
			if(structKeyExists(FORM, "isActive")) {
				updateOthers.isActive = objValidator.setCheckboxValue(FORM.isActive);
			}
			else {
				updateOthers.isActive = objValidator.setCheckboxValue();
			}
			updateEquipmentRecord = objOthers.updateOthers(updateOthers);

			if(updateEquipmentRecord == true) {
				Alert = objAlerts.setAlertMessage("Success",updateOthers.Brand&": "&updateOthers.Model&" Updated.");
			}
			else {
				Alert = objAlerts.setAlertMessage("Error","Something Went Wrong. Please Try Again.");
			}
		}
	}
	else {
		Alert = objITManagementValidator.validateOthers(FORM.IPAddress, FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked);
	}
}
</cfscript>