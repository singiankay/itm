<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfscript>
	objSchedules.deleteSchedule(url.id);
</cfscript>

</cfoutput>