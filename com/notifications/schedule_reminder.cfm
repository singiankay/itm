<cfoutput>

<cfset dbmain = "itmanagement"/>
<!--- <cfset recipient = "mis_assistant@nicera.ph"/> --->
<cfset recipient = "clyde.clavo@nicera.ph"/>

<cfset weeknow = week(now())>
<cfset yearnow = year(now())>
<cfset nextweek = weeknow+1>

week now : #weeknow# <br>
next week : #nextweek# <br>

<cfquery name="getSchedulesNextWeek" datasource="#dbmain#">
SELECT a.computer_id, a.week_no, b.computer_name

FROM tbl_schedules a 
LEFT JOIN tbl_computer_copy b
ON a.computer_id = b.id_record
WHERE 
week_no = #nextweek#
AND sched_year = #yearnow#
ORDER BY b.computer_name ASC
</cfquery>

<!--- <cfdump var="#getSchedulesNextWeek#"> --->


<cfmail to="#recipient#" cc="" from="ITManagement@nicera.ph" subject="Maintenance Schedule" priority=1 type="text/html">

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
	Please be informed that the computers listed below are scheduled for maintenance next week <b>(Week #nextweek#)</b>. <br> 
	<br>
	<table>
		<tr>
			<th>Computer Name</th>
		</tr>
		<cfloop query="getSchedulesNextWeek">
			<tr>
				<td>#getSchedulesNextWeek.computer_name#</td>
			</tr>
		</cfloop>

	</table>

</font>

<cfmailparam name="Reply-By" value="#DateFormat(NOW(), 'd mmm yyyy')#">
</cfmail>
*********************************************************
<br><br>


</cfoutput> 