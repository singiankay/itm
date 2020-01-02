<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset SESSION.actualset = true>
<cfset data = structNew()>
<cfset data.date_actual = form.txtDate>
<cfset data.performed_by = form.slcPerformer>


<cfif structKeyExists(form, 'evidence')>
	<cffile 
			action="upload"
			filefield="evidence"
			destination="\\npi-appserver\sourcecode\itmanagement\attachments\"
			nameConflict="makeUnique"
			result="uploadResult" >
			<cfset filename = uploadResult.serverFile>
</cfif>
<cfset data.attachment = filename>

<cfif structKeyExists(url, "multiple")>
	<cfdump var="#form['selection[]']#">

	<cfset arr = listToArray(form['selection[]'])>
	<cfloop array="#arr#" index="id">
		<cfset data.id = id>
		<cfdump var="#data#">
		<cfset objSchedules.setActualDate(data)>
	</cfloop>

<cfelse>
		<cfset data.id = url.id>
		<cfset objSchedules.setActualDate(data)>
</cfif>



<cflocation url="#CGI.HTTP_REFERER#" addtoken="no">


</cfoutput>