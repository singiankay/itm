<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset getAllRecords = objSchedules.getComputers(form.group,form.year)>
<cfset getList = objSchedules.getList(form.group)>

<cfoutput>


<cfloop list="#getList#" index="pc">
	<cfset getSched = objSchedules.getScheduleByComputer(pc,form.year)>
	<cfset getDetails = objSchedules.getComputerByID(pc)>

	<tr data-value="#pc#"

	<cfif getSched.week_no neq ''>
		<cfset diff = week(now())-getSched.week_no>
		<cfset weeknow = week(now())>
		<cfset sched = getSched.week_no>

		<cfif getSched.date_actual eq ''>
			<!--- IF NOT YET CLOSED --->

			<cfif weeknow gt sched>
				<cfif diff gt 8>
					class="bg-danger"
				<cfelseif diff lte 8>
					class="bg-warning"
				<cfelse>

				</cfif>
			</cfif>

		<cfelse>
			<!--- IF CLOSED --->

			<cfset actual = week(getSched.date_actual)>
			<cfset diff = actual-sched>

			<cfif actual gt sched>
				<cfif diff gte 8>
					class="bg-danger"
				<cfelse>
					class="bg-success"
				</cfif>
			<cfelse>
					class="bg-success"
			</cfif>

		</cfif>
</cfif>

	>

		<td>
			<input type="checkbox" class="selection-delete" value="#pc#"  name=""> &emsp;
			<button class="btn btn-xs btn-danger btn-block" type="button" onclick="deleteComputer(#pc#,'#getDetails.computer_name#')"><i class="fa fa-trash-o"></i> Delete Computer</button>
			<cfif getSched.week_no neq ''>
					<button type="button" class="btn btn-warning btn-xs btn-block" onclick="deleteSchedule(#getSched.id#)"><i class="fa fa-trash-o"></i> Delete Schedule</button>
			</cfif>
		</td>
			<td>
				<span style="font-size: 11pt" class="label label-default"><i class="fa fa-tv"></i> #getDetails.computer_name# </span>
				&nbsp;<small>ID: #pc#</small>
			</td>
			<td>

				<cfif getSched.week_no eq ''>
					<div class="">
		      	<button type="button" class="btn btn-xs bg-purple" onclick="updateSingleSched(#pc#)"><i class="fa fa-edit"></i> Set Schedule</button>
		      </div>
		    <cfelse>
		    		<cfif form.group eq 'SERVER'>
		    			#DateFormat(getSched.sched_date,"mmmm dd, yyyy")#
		    		<cfelse>
		    			Week #getSched.week_no#
		    		</cfif>
		    </cfif>

			</td>
			<td>
				<cfif getSched.week_no neq '' and getSched.date_actual eq ''>
						<cfif form.group eq 'SERVER'>
							<button type="button" class="btn btn-xs btn-success" onclick="viewChecklist(#pc#,#form.year#)"><i class="fa fa-check-square-o"></i> Checklist</button>
						<cfelse>
							<button type="button" class="btn btn-xs btn-success" onclick="updateSingleActual(#getSched.id#)"><i class="fa fa-edit"></i> Update</button>
					  </cfif>
				<cfelse>
						#getSched.date_actual#
				</cfif>
			</td>
			<td>#getSched.performer_name#</td>
			<td>
				<cfif getSched.attachment neq ''>
					<a href="attachments/#getSched.attachment#" target="_blank" class="">#getSched.attachment#</a>
					<!--- <img src="attachments/#getSched.attachment#" width="100"> --->

				</cfif>
			</td>
	</tr>

</cfloop>

</cfoutput>