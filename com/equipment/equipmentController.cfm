<cfscript>
if(structKeyExists(FORM, "archiveEquipmentFormValue")) {
	if(FORM.archiveEquipment == "Yes") {
		if(objEquipment.archiveEquipment(FORM.archiveEquipmentFormValue) == true) {
			EquipmentName = objEquipment.getEquipmentName(FORM.archiveEquipmentFormValue);
			if(objAssetManagement.unlinkAssetManagement(FORM.AssetID) == true) {
				Alert = objAlerts.setAlertMessage("Success", EquipmentName&" has been archived.");
			}
			else {
				Alert = objAlerts.setAlertMessage("Error", "Error updating record. "&EquipmentName&" has been archived but Fixed Asset Management Record still has not yet been unlinked to the archived record. Please contact the System Administrator about this issue");
			}
		}
		else {
			Alert = objAlerts.setAlertMessage("Error", "Error archiving "&EquipmentName&" has not been archived. Please contact the System Administrator about this issue");
		}
	}
}
if(structKeyExists(FORM, "updateEquipment")) {
	
	if(objITManagementValidator.validateEquipment(FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked) == true) {
		updateEquipment = structNew();

		updateEquipment.EquipmentID = FORM.EquipmentID;
		updateEquipment.Brand = FORM.Brand;
		updateEquipment.Model = FORM.Model;
		updateEquipment.Provider = FORM.Provider;
		updateEquipment.DateIssued = objValidator.setEmptyStringOrDate(FORM.DateIssued);
		updateEquipment.DateDestroyed = objValidator.setEmptyStringOrDate(FORM.DateDestroyed);
		updateEquipment.DateStocked = objValidator.setEmptyStringOrDate(FORM.DateStocked);
		updateEquipment.Remarks = FORM.Remarks;
		updateEquipment.Attachment = "";
		isContinueAfterAttachment = false;

		if(FORM.Attachment != "") {
			deleteExistingAttachment = objEquipment.deleteFileIfExists(updateEquipment.EquipmentID);
			if (deleteExistingAttachment == true) {
				uploadAttachment = objEquipment.uploadAttachment("Attachment");
				updateEquipment.Attachment = objEquipment.getFilename(uploadAttachment);
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
				updateEquipment.isActive = objValidator.setCheckboxValue(FORM.isActive);
			}
			else {
				updateEquipment.isActive = objValidator.setCheckboxValue();
			}
			updateEquipmentRecord = objEquipment.updateEquipment(updateEquipment);

			if(updateEquipmentRecord == true) {
				Alert = objAlerts.setAlertMessage("Success",updateEquipment.Brand&": "&updateEquipment.Model&" Updated.");
			}
			else {
				Alert = objAlerts.setAlertMessage("Error","Something Went Wrong. Please Try Again.");
			}
		}
	}
	else {
		Alert = objITManagementValidator.validateEquipment(FORM.IPAddress, FORM.DateIssued, FORM.DateDestroyed,FORM.DateStocked);
	}
}
</cfscript>