<cfscript>
if(structKeyExists(FORM, "createHistory")) {
	objHistory = createObject('itmanagement.com.history.History').init();
	objComputerHistory = createObject('itmanagement.com.history.ComputerHistory').init();
	if(objITManagementValidator.validateHistory(FORM.HistoryDate,FORM.HistoryTime) == true) {
		createHistory = structNew();
		createHistory.id = FORM.ID;
		createHistory.HistoryDate = FORM.HistoryDate;
		createHistory.HistoryTime = FORM.HistoryTime;
		createHistory.Remarks = FORM.Remarks;
		createHistory.Type = FORM.Type;
		createHistory.Attachment = "";
		isContinueAfterAttachment = false;

		if(FORM.Attachment != "") {
			uploadAttachment = objHistory.uploadAttachment("Attachment",createHistory.Type);
			createHistory.Attachment = objHistory.getFilename(uploadAttachment);
			isContinueAfterAttachment = true;
		}
		else {
			isContinueAfterAttachment = true;
		}
		if(isContinueAfterAttachment == true) {
			createHistoryRecord = objComputerHistory.createHistory(createHistory);
			if(createHistoryRecord == true) {
				Alert = objAlerts.setAlertMessage("Success"," History Created");
			}
			else {
				Alert = objAlerts.setAlertMessage("Error","Something Went Wrong. Please Try Again.");
			}
		}		
	}
	else {
		Alert = objITManagementValidator.validateHistory(FORM.HistoryDate,FORM.HistoryTime);
	}
}
if(structKeyExists(FORM, "updateHistory")) {
	objHistory = createObject('itmanagement.com.history.History').init();
	objComputerHistory = createObject('/itmanagement.com.history.ComputerHistory').init();
	if(objITManagementValidator.validateHistory(FORM.HistoryDate,FORM.HistoryTime) == true) {
		updateHistory = structNew();
		updateHistory.id = FORM.ID;
		updateHistory.HistoryDate = FORM.HistoryDate;
		updateHistory.HistoryTime = FORM.HistoryTime;
		updateHistory.Remarks = FORM.Remarks;
		updateHistory.Type = FORM.Type;
		updateHistory.Attachment = "";
		isContinueAfterAttachment = false;

		if(FORM.Attachment != "") {
			deleteExistingAttachment = objHistory.deleteFileIfExists(updateHistory.id,updateHistory.Type);
			if (deleteExistingAttachment == true) {
				uploadAttachment = objHistory.uploadAttachment("Attachment",updateHistory.Type);
				updateHistory.Attachment = objHistory.getFilename(uploadAttachment);
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
			updateHistoryRecord = objComputerHistory.updateHistory(updateHistory);
			if(updateHistoryRecord == true) {
				Alert = objAlerts.setAlertMessage("Success"," History Updated");
			}
			else {
				Alert = objAlerts.setAlertMessage("Error","Something Went Wrong. Please Try Again.");
			}
		}
	}
	else {
		Alert = objITManagementValidator.validateHistory(FORM.HistoryDate,FORM.HistoryTime);
	}
}
</cfscript>