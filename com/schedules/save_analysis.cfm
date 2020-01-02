<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset data = structNew()>
<cfset data.year = form.year>
<cfset data.month = form.month>
<cfset data.analysis = trim(form.analysis)>
<cfset objSchedules.saveAnalysis(data)>
1
<!--- <cfset SESSION.actualset = true> --->
</cfoutput>