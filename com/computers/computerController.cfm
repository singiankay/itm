<cfscript>
if(structKeyExists(FORM, "archiveComputerFormValue")) {
	if(FORM.archiveComputer == "Yes") {
		if(objComputers.archiveComputer(FORM.archiveComputerFormValue) == true) {
			ComputerName = objComputers.getComputerName(FORM.archiveComputerFormValue);
			if(objAssetManagement.unlinkAssetManagement(FORM.AssetID) == true) {
				Alert = objAlerts.setAlertMessage("Success", ComputerName&" has been archived.");
			}
			else {
				Alert = objAlerts.setAlertMessage("Error", "Error updating record. "&ComputerName&" has been archived but Fixed Asset Management Record still has not yet been unlinked to the archived record. Please contact the System Administrator about this issue");
			}
		}
		else {
			Alert = objAlerts.setAlertMessage("Error", "Error archiving "&ComputerName&" has not been archived. Please contact the System Administrator about this issue");
		}
	}
}
if(structKeyExists(FORM, "updateComputer")) {
	
	if(objITManagementValidator.validateComputer(FORM.IPAddress, FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked) == true) {
		updateComputer = structNew();

		updateComputer.ComputerID = FORM.ComputerID;
		updateComputer.ComputerType = FORM.ComputerType;
		updateComputer.ComputerName = FORM.ComputerName;
		updateComputer.IPAddress = FORM.IPAddress;
		updateComputer.ProcessorType = FORM.ComputerProcessor;
		updateComputer.MemoryType =  FORM.Memory;
		updateComputer.OperatingSystem = FORM.OperatingSystem;
		updateComputer.Office = FORM.Office;
		updateComputer.GraphicsCard = FORM.GraphicsCard;
		updateComputer.DateIssued = objValidator.setEmptyStringOrDate(FORM.DateIssued);
		updateComputer.DateDestroyed = objValidator.setEmptyStringOrDate(FORM.DateDestroyed);
		updateComputer.DateStocked = objValidator.setEmptyStringOrDate(FORM.DateStocked);
		updateComputer.Remarks = FORM.Remarks;
		updateComputer.Attachment = "";
		isContinueAfterAttachment = false;
		
		if(FORM.Attachment != "") {
			deleteExistingAttachment = objComputers.deleteFileIfExists(updateComputer.ComputerID);
			if (deleteExistingAttachment == true) {
				uploadAttachment = objComputers.uploadAttachment("Attachment");
				updateComputer.Attachment = objComputers.getFilename(uploadAttachment);
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
				updateComputer.isActive = objValidator.setCheckboxValue(FORM.isActive);
			}
			else {
				updateComputer.isActive = objValidator.setCheckboxValue();
			}
			updateComputerRecord = objComputers.updateComputer(updateComputer);

			if(updateComputerRecord == true) {
				Alert = objAlerts.setAlertMessage("Success",updateComputer.ComputerName&" Updated.");
			}
			else {
				Alert = objAlerts.setAlertMessage("Error","Something Went Wrong. Please Try Again.");
			}
		}
	}
	else {
		Alert = objITManagementValidator.validateComputer(FORM.IPAddress, FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked);
	}
}
</cfscript>