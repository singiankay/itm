<cfoutput>
<cfset attendance = createObject('/itmanagement.com.attendance.Attendance').init() />
<cfset dbmain = "itmanagement"/>

<cfquery name="getAll" datasource="#dbmain#">
SELECT * FROM tbl_attendance WHERE year_num = #url.year#
</cfquery>


<cfloop from="1" to="52" index="m">

<cfset percentage = evaluate("form.txtWeek#m#")>

#evaluate("form.txtWeek#m#")# 

<cfquery name="getRecord" dbtype="query">
 SELECT * FROM getAll WHERE week_num = #m# AND year_num = #url.year#
</cfquery>




	<cfif getRecord.recordcount gt 0 and getRecord.id neq ''>
		<cfdump var="#getRecord#">
	 UPDATE QUERY
	 <cfquery datasource="#dbmain#">
	 		UPDATE tbl_attendance
	 			SET percentage = <cfqueryparam value="#percentage#" cfsqltype="CF_SQL_VARCHAR" maxlength="255" null="#not len(trim(percentage))#">
	 		WHERE week_num = #m# AND year_num = #url.year#
		</cfquery>
	
	<cfelse>
		INSERT QUERY
		<cfquery datasource="#dbmain#">
		INSERT INTO tbl_attendance
			(week_num, percentage, year_num)
			VALUES
			(#m# , <cfqueryparam value="#percentage#" cfsqltype="CF_SQL_VARCHAR" maxlength="255" null="#not len(trim(percentage))#"> , #url.year#)
		</cfquery>
	</cfif>


<br>

</cfloop>

<cflocation url="http://npi-appserver/itmanagement/attendance.cfm?year=#url.year#" addtoken="false">

</cfoutput>