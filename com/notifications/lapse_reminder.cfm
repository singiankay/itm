<cfoutput>


<cfset dbmain = "itmanagement"/>
<!--- <cfset recipient = "mis_assistant@nicera.ph"/> --->
<cfset recipient = "clyde.clavo@nicera.ph"/>

<cfset weeknow = week(now())>
<cfset yearnow = year(now())>
<cfset nextweek = weeknow+1>

week now : #weeknow# <br>
next week : #nextweek# <br>

<cfquery name="getLapse" datasource="#dbmain#">
	SELECT a.computer_id, a.week_no, b.computer_name
		FROM tbl_schedules a 
		LEFT JOIN tbl_computer_copy b
		ON a.computer_id = b.id_record
		WHERE 1=1
		AND week_no < #weeknow#
		AND sched_year = #yearnow#
		AND date_actual IS NULL
		ORDER BY week_no ASC
</cfquery>

<!--- <cfdump var="#getLapse#"> --->

<cfmail to="#recipient#" cc="" from="ITManagement@nicera.ph" subject="Maintenance Schedule (OFF TARGET)" priority=1 type="text/html">
<style type="text/css">

	table {
		/*border: px solid black;*/
		background: black;
		margin-top: 5px;
	}

	table tr th {
		background: white;
		padding: 5px;
		font-size: 9pt;
	}

	table tr td {
		background: white;
		padding: 3px 3px;
		font-size: 9pt;
	}

</style>

<font face="verdana, arial, tahoma" size='2'>
	Dear MIS In-charge, <br><br>
	Good day! <br><br>
	Please be informed that there are computers that <b style="color:red">were not maintained on the right schedule</b> of maintenance. <br> 
	<br>
	Week now: #week(now())# <br>
	Total count: #getLapse.recordcount# <br>
	<table>
		<tr>
			<th>Computer Name</th>
			<th>Week Number</th>
		</tr>
		<cfloop query="getLapse">
			<tr>
				<td>#getLapse.computer_name#</td>
				<td>#getLapse.week_no#</td>
			</tr>
		</cfloop>

	</table>

</font>

<cfmailparam name="Reply-By" value="#DateFormat(NOW(), 'd mmm yyyy')#">
</cfmail>



</cfoutput>