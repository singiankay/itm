<cfoutput>

<cfset db = "itmanagement">

<!--- <cfquery name="getAll" datasource="#db#">
	SELECT 	* FROM tbl_schedules WHERE sched_year = 2018
</cfquery>

<!--- <cfdump var="#getAll#"> --->

<table border="1">
	<tr>
		<td>Month</td>
		<td>Count</td>
	</tr>

<cfset total = 0>
<cfloop from="7" to="12" index="m">

<cfquery name="query2" datasource="#db#">
	SELECT count(id) as countx FROM tbl_schedules WHERE MONTH(sched_date) = #m#
</cfquery>
	
	<tr>
		<td>#monthAsString(m)#</td>
		<td>#query2.countx#</td>
		<cfset total += query2.countx>
	</tr>

</cfloop>

<tr>
	<td>TOTAL</td>
	<td>#total#</td>
</tr>
</table> --->






</cfoutput>