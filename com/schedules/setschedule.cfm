<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset SESSION.schedulesaved = true>
<cfset sched = structNew()>


<cfif structKeyExists(form, 'group') AND FORM.group eq 'SERVER'>

	<cfset sched.sched_date = form.sched>
	<cfset sched.week_no = week(form.sched)>
	<cfset sched.sched_year = year(form.sched)>
	date: #sched.sched_date# <br>
	week: #sched.week_no#

<cfelse>

	<cfset tempdate = form.sched>
	<cfset arr1 = listToArray(tempdate,"-")>
	<cfset sched.sched_year = arr1[1]>
	<cfset sched.week_no = RemoveChars(arr1[2],1,1)>
	<cfset getdate = objSchedules.GetDateByWeek(sched.sched_year,sched.week_no)>
	<cfset sched.sched_date = DateAdd("d",6,getdate)>

</cfif>


<cfif structKeyExists(url, 'multiple')>
<cfdump var="#form.id_selected#">
<cfdump var="#sched#">

<cfset myarray = listToArray(form.id_selected,",")>

<cfloop array="#myarray#" index="id">
	<cfscript>
		 objSchedules.saveSched(id,sched);

		 if (structKeyExists(form, "group") AND form.group eq 'SERVER') {
		 	objSchedules.addToChecklist(sched.sched_year,id);
		 }

	</cfscript>




</cfloop>

<cfelse>
	<cfscript>
		 objSchedules.saveSched(form.id_selected,sched);
 		 if (form.group eq 'SERVER') {
		 	objSchedules.addToChecklist(sched.sched_year,form.id_selected);
		 }
	</cfscript>
</cfif>


</cfoutput>