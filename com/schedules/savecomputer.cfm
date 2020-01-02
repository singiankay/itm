<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset data = structNew()>
<cfset data.computer_name = trim(uCase(form.pcname))>
<cfset data.computer_group = form.pcgroup>
<cfset data.is_active = 1>
<cfset objSchedules.saveComputer(data)>
<cfset SESSION.actualset = true>
</cfoutput>