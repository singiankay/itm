<style type="text/css">
	

.week_no {
	background: #3382D9;
	color: white
}

</style>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />

<cfoutput>

<cfset weeks = objSchedules.getWeeks(url.year)>
<cfset arrayweeks = listToArray(valueList(weeks.week_no))>


<div class="container-fluid">
	<div class="row myrow">
		<cfif arrayLen(arrayweeks) lt 1>
			<center><h3 style="margin: 50px">No schedules set</h3></center>

		<cfelse>
		<cfloop array="#arrayweeks#" index="week_no">
			<cfset datestart = objSchedules.GetDateByWeek(url.year,week_no)>
			<cfset dateend = DateAdd("d",7,datestart)>
			<cfset dateend = dateFormat(dateend, "mmmm dd, yyyy" )>
			<cfset getcomputers = objSchedules.getScheduleByWeek(week_no,url.year)>

			<div class="col-lg-3 cs-col">
<!--- 				
					<table class="table table-bordered">
					<tr>
						<th class="week_no" colspan="2"><h4 style="margin-top: 10px">Week #week_no#</h4></th>
					</tr>
					<tr>
						<td colspan="2">(#datestart# - #dateend#)</td>
					</tr>
				</table>
				<div class="table-responsive" style="max-height: 300px">
				<table class="table table-bordered">
					<tr>
						<th>Computer name</th>
						<th>Done</th>
					</tr>
					<cfloop query="getcomputers">
						<tr>
							<td>#getcomputers.computer_name#</td>
							<td>
								
							</td>
						</tr>
					</cfloop>
				</table>
				</div> --->

				<div class="panel panel-primary">
		      <div class="panel-heading">
		      	<h4 style="margin-top: 10px">Week #week_no#</h4>
		      	<td colspan="2">(#datestart# - #dateend#)</td>
		      </div>
		      <div class="panel-body">
						<div class="table-responsive" style="max-height: 300px">
							<table class="table table-bordered table-hover">
								<tr>
									<th>Computer name</th>
									<th>Done</th>
								</tr>
								<cfloop query="getcomputers">
									<tr

											<cfset diff = week(now())-getcomputers.week_no>
											<cfset weeknow = week(now())>
											<cfset sched = getcomputers.week_no>

											<cfif getcomputers.date_actual eq ''>
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

												<cfset actual = week(getcomputers.date_actual)>
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
				
									>
										<td>#getcomputers.computer_name#</td>
										<td>
											<center>
												<cfif getcomputers.date_actual neq "">
													<i class="fa fa-check text-success"></i>
												<cfelse>
													<i class="fa fa-remove text-danger"></i>
												</cfif>
											</center>
										</td>
									</tr>
								</cfloop>
							</table>
							</div>
		      </div>
		    </div>

			</div>
		</cfloop>

		<div class="col-lg-3 cs-col">
			<cfset getTotalCount = objSchedules.getCount(url.year)>
			<table class="table table-bordered">
				<tr>
					<th colspan="2"><center><h3 style="margin-top: 10px">Total count</h3></center></th>
				</tr>
				<tr>
					<th class="text-center">Maintained</th>
					<th class="text-center">Unmaintained</th>
				</tr>
				<tr>
					<td class="text-center">#getTotalCount.maintained#</td>
					<td class="text-center">#getTotalCount.unmaintained#</td>
				</tr>
			</table>
		</div>

	</cfif>
	</div>
</div>




</cfoutput>