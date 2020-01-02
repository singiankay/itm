<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset SESSION.checklistupdated = true>
<cfset data = structNew()>
<cfif structKeyExists(form, "d5[]")>
	<cfset data.d5 = FORM['d5[]']>
<cfelse>
	<cfset data.d5 = "">
</cfif>

<cfscript>


data.computer_id = url.id;
data.year = url.year;
data.basic_ip = form.basic_ip;
data.basic_mac = form.basic_mac;
data.basic_remarks = form.basic_remarks;
data.a1 =  (structKeyExists(form, 'a1')? "Y" : "N");
data.a1_remarks = form.a1_remarks;
data.a2 = (structKeyExists(form, 'a2')? "Y" : "N");
data.a2_remarks = form.a2_remarks;
data.a3 = (structKeyExists(form, 'a3')? "Y" : "N");
data.a3_remarks = form.a3_remarks;
data.b = (structKeyExists(form, 'b')? "Y" : "N");
data.b_remarks = form.b_remarks;
data.c1 = (structKeyExists(form, 'c1')? "Y" : "N");
data.c1_remarks = form.c1_remarks;
data.c2 = (structKeyExists(form, 'c2')? "Y" : "N");
data.c2_remarks = form.c2_remarks;
data.c3 = (structKeyExists(form, 'c3')? "Y" : "N");
data.c3_remarks = form.c3_remarks;
data.d1 = (structKeyExists(form, 'd1')? "Y" : "N");
data.d1_remarks = form.d1_remarks;
data.d2 = (structKeyExists(form, 'd2')? "Y" : "N");
data.d2_remarks = form.d2_remarks;
data.d3 = (structKeyExists(form, 'd3')? "Y" : "N");
data.d3_remarks = form.d3_remarks;
data.d4 = (structKeyExists(form, 'd4')? "Y" : "N");
data.d4_remarks = form.d4_remarks;
data.d5_remarks = form.d5_remarks;
data.e = (structKeyExists(form, 'e')? "Y" : "N");
data.e_remarks = form.e_remarks;
data.f = (structKeyExists(form, 'f')? "Y" : "N");
data.f_remarks = form.f_remarks;
data.g = (structKeyExists(form, 'g')? "Y" : "N");
data.g_remarks = form.g_remarks;
data.h = (structKeyExists(form, 'h')? "Y" : "N");
data.h_remarks = form.h_remarks;
data.i = (structKeyExists(form, 'i')? "Y" : "N");
data.i_remarks = form.i_remarks;
data.j1 = (structKeyExists(form, 'j1')? "Y" : "N");
data.j1_remarks = form.j1_remarks;
data.j2 = (structKeyExists(form, 'j2')? "Y" : "N");
data.j2_remarks = form.j2_remarks;
data.j3 = (structKeyExists(form, 'j3')? "Y" : "N");
data.j3_remarks = form.j3_remarks;
data.k = (structKeyExists(form, 'k')? "Y" : "N");
data.k_remarks = form.k_remarks;
data.l = (structKeyExists(form, 'l')? "Y" : "N");
data.l_remarks = form.l_remarks;
data.m1 = (structKeyExists(form, 'm1')? "Y" : "N");;
data.m1_remarks = form.m1_remarks;
data.m2 = (structKeyExists(form, 'm2')? "Y" : "N");
data.m2_remarks = form.m2_remarks;
data.m3 = (structKeyExists(form, 'm3')? "Y" : "N");
data.m3_remarks = form.m3_remarks;
data.m4 = (structKeyExists(form, 'm4')? "Y" : "N");
data.m4_remarks = form.m4_remarks;
data.n1 = (structKeyExists(form, 'n1')? "Y" : "N");
data.n1_remarks = form.n1_remarks;
data.n2 = (structKeyExists(form, 'n2')? "Y" : "N");
data.n2_remarks = form.n2_remarks;
data.n3 = (structKeyExists(form, 'n3')? "Y" : "N");
data.n3_remarks = form.n3_remarks;

objSchedules.updateChecklist(data);

</cfscript>


<cfdump var="#data#">

<cflocation url="#CGI.HTTP_REFERER#" addtoken="no">



</cfoutput>