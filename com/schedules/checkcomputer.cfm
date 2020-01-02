<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset check = objSchedules.checkComputer(uCase(trim(url.id)))>
#check.recordcount#
</cfoutput>