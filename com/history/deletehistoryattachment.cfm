<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
<cfset objHistory = createObject('/itmanagement.com.history.History').init() />
<cfscript>
if(structKeyExists(FORM, "attachment")) {
	isDelete = objHistory.deleteFileIfExists(FORM.id,FORM.type);
	if(isDelete == true) {
		Delete =objHistory.updateDeletedAttachment(FORM.id);
		if(Delete == true) {
			writeOutput("true");
		}
		else {
			writeOutput("false");
		}
	}
	else {
		writeOutput("false");
	}
}
</cfscript>