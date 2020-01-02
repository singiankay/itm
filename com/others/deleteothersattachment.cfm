<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
<cfset objOthers = createObject('/itmanagement.com.others.Others').init() />
<cfscript>
if(structKeyExists(FORM, "attachmentName")) {
	isDelete = objOthers.deleteFileIfExists(FORM.OthersID);
	if(isDelete == true) {
		Delete =objOthers.updateDeletedAttachment(FORM.OthersID);
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