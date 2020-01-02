<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />




<cfscript>
	if (structKeyExists(url, "multiple")) {

			myarray = listToArray(form.selected,",");

		for (item in myarray) {
			SESSION.computerdeleted = "Computer deleted";
			objSchedules.deleteComputer(item);
		}

	} else {
			getdata = objSchedules.getComputerByID(url.id);
	    SESSION.computerdeleted = getdata.computer_name;
			objSchedules.deleteComputer(url.id);
	}
</cfscript>

</cfoutput>