
<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset data = objSchedules.getChecklist(url.year, url.id)>

<form name="frm_checklist" action="com/schedules/update_checklist.cfm?id=#url.id#&year=#url.year#" method="post">
	 <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title">Server Maintenance Checklist</h3>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
        	<table class="table table-bordered" id="basic-details">
        		<tr>
        			<th colspan="2" class="main-part"><h4 class="myh">Basic Details</h4></th>
        		</tr>
        		<tr>
        			<td style="width: 150px">IP Address</td>
        			<td><input type="text" autocomplete="off" class="my-text" name="basic_ip" value="#data.basic_ip#"></td>
        		</tr>
        		<tr>
        			<td>Mac Address</td>
        			<td><input type="text" autocomplete="off" class="my-text" name="basic_mac" value="#data.basic_mac#"></td>
        		</tr>
        		<tr>
        			<td>Remarks</td>
        			<td><input type="text" autocomplete="off" class="my-text" name="basic_remarks" value="#data.basic_remarks#"></td>
        		</tr>
        	</table>
        	<!--- //basic details --->

        	<table class="table table-bordered" id="software-system">
        		<tr>
        			<th colspan="4" class="main-part"> <h4 class="myh">Software and system checks</h4></th>
        		</tr>
        		<tr>
        			<td style="width: 20px"><i class="fa fa-minus"></i></td>
        			<td class="sub-N" colspan="3">Check and update software</td>
        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" class="big-check" value="Y" name="a1" #data.a1_os_installed eq 'Y'? 'checked' : ''#></td>
		        			<td>Operating system updates have been installed</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="a1_remarks" value="#data.a1_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" class="big-check" value="Y" name="a2" #data.a2_updates_installed eq 'Y'? 'checked' : ''#></td>
		        			<td>Other application updates have been installed</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="a2_remarks" value="#data.a2_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="a3" #data.a3_kernel_reboot eq 'Y'? 'checked' : ''#></td>
		        			<td>Server rebooted (if kernel updated was installed)</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="a3_remarks" value="#data.a3_remarks#"></td>
		        		</tr>	
		        <tr>
        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="b" #data.b_control_panel eq 'Y'? 'checked' : ''# ></td>
        			<td class="sub-N" colspan="2">Update your control panel</td>
        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="b_remarks" value="#data.b_remarks#"></td>
        		</tr>
        		<tr>
        			<td style="width: 20px"><i class="fa fa-minus"></i></td>
        			<td class="sub-N" colspan="3">Check remote management tools</td>
        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="c1" #data.c1_remote_console eq 'Y'? 'checked' : ''#></td>
		        			<td>Remote Console</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="c1_remarks" value="#data.c1_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="c2" #data.c2_remote_reboot eq 'Y'? 'checked' : ''# ></td>
		        			<td>Remote reboot</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="c2_remarks" value="#data.c2_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="c3" #data.c3_rescue_mode eq 'Y'? 'checked' : ''# ></td>
		        			<td>Rescue mode</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="c3_remarks" value="#data.c3_remarks#"></td>
		        		</tr>	
		        <tr>
        			<td style="width: 20px"><i class="fa fa-minus"></i></td>
        			<td class="sub-N" colspan="3">Check the server resource usage</td>
        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="d1" #data.d1_resource_disk eq 'Y'? 'checked' : ''#></td>
		        			<td>Disk</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="d1_remarks" value="#data.d1_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="d2" #data.d2_resource_cpu eq 'Y'? 'checked' : ''#></td>
		        			<td>CPU</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="d2_remarks" value="#data.d2_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="d3" #data.d3_resource_ram eq 'Y'? 'checked' : ''#></td>
		        			<td>RAM</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="d3_remarks" value="#data.d3_remarks#"></td>
		        		</tr>	
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="d4" #data.d4_resource_network eq 'Y'? 'checked' : ''#></td>
		        			<td>Network</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="d4_remarks" value="#data.d4_remarks#"></td>
		        		</tr>	
		        	<tr>
		        		<td></td>
		        		<td></td>
		        		<td>Which resources were under high strain? <br>
		        			(Multiple options can be selected from this list) <br> <br>
		        			<input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="d5_remarks" value="#data.d5_remarks#">
		        		</td>
		        		<td>
		        			<select multiple="" class="form-control" name="d5[]">
		        				<option value="Disk" #listFindNoCase(data.d5_resource_strain, "Disk")? 'selected' : ''#>Disk</option>
		        				<option value="CPU" #listFindNoCase(data.d5_resource_strain, "CPU")? 'selected' : ''#>CPU</option>
		        				<option value="RAM" #listFindNoCase(data.d5_resource_strain, "RAM")? 'selected' : ''#>RAM</option>
		        				<option value="Network" #listFindNoCase(data.d5_resource_strain, "Network")? 'selected' : ''#>Network</option>
		        			</select>
		        		</td>
		        	</tr>
		        <tr>
        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="e" #data.e_troubleshoot_cpu eq 'Y'? 'checked' : ''#></td>
        			<td class="sub-N" colspan="2">Troubleshoot CPU utilization</td>
        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="e_remarks" value="#data.e_remarks#"></td>
        		</tr>
		        <tr>
        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="f" #data.f_troubleshoot_ram eq 'Y'? 'checked' : ''#></td>
        			<td class="sub-N" colspan="2">Troubleshoot RAM utilization</td>
        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="f_remarks" value="#data.f_remarks#"></td>
        		</tr>
		        <tr>
        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="g" #data.g_troubleshoot_network eq 'Y'? 'checked' : ''#></td>
        			<td class="sub-N" colspan="2">Troubleshoot network utilization</td>
        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="g_remarks" value="#data.g_remarks#"></td>
        		</tr>
		        <tr>
        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="h" #data.h_freeup_storage eq 'Y'? 'checked' : ''#></td>
        			<td class="sub-N" colspan="2">Free up server storage space</td>
        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="h_remarks" #data.h_remarks#></td>        		
        		</tr>          		        		
        	</table>
        	<!--- //software-system --->

        	<table class="table table-bordered" id="data-check">
        		<tr>
        			<th colspan="4" class="main-part"><h4 class="myh">Data checks</h4></th>
        		</tr>
		        <tr>
        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="i" #data.i_backup_working eq 'Y'? 'checked' : ''#></td>
        			<td class="sub-N" colspan="2">Verify your backups are working</td>
        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="i_remarks" value="#data.i_remarks#"></td>
        		</tr>
		        <tr>
        			<td style="width: 20px"><i class="fa fa-minus"></i></td>
        			<td class="sub-N" colspan="3">Review user accounts</td>
        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="j1" #data.j1_user_old_emp eq 'Y'? 'checked' : ''#></td>
		        			<td>Old employee data</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="j1_remarks" value="#data.j1_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="j2" #data.j2_user_web_files eq 'Y'? 'checked' : ''#></td>
		        			<td>Obsolete / inactive website files</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="j2_remarks" value="#data.j2_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="j3" #data.j3_user_data eq 'Y'? 'checked' : ''#></td>
		        			<td>Additional outdated user data</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="j3_remarks" value="#data.j3_remarks#"></td>
		        		</tr>		        				        		
        	</table>
        	<!--- //data check --->        	

        	<table class="table table-bordered" id="security-check">
        		<tr>
        			<th colspan="4" class="main-part"><h4 class="myh">Security checks</h4></th>
        		</tr>
		        <tr>
        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="k" #data.k_malware_scan eq 'Y'? 'checked' : ''#></td>
        			<td class="sub-N" colspan="2">Perform server malware scan</td>
        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="k_remarks" value="#data.k_remarks#"></td>
        		</tr>
		        <tr>
        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="l" #data.l_change_password eq 'Y'? 'checked' : ''#></td>
        			<td class="sub-N" colspan="2">Change server passwords</td>
        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="l_remarks" value="#data.l_remarks#"></td>
        		</tr>       				        		
        	</table>
        	<!--- //security check --->     


        	<table class="table table-bordered" id="hardware-checks">
        		<tr>
        			<th colspan="4" class="main-part"><h4 class="myh">Hardware checks</h4></th>
        		</tr>
<!--- 		        <tr>
        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name=""></td>
        			<td class="sub-N" colspan="2">Verify your backups are working</td>
        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name=""></td>
        		</tr> --->
		        <tr>
        			<td style="width: 20px"><i class="fa fa-minus"></i></td>
        			<td class="sub-N" colspan="3">Check Redundant Array of Independent Disks (RAID) fault tolerance</td>
        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="m1" #data.m1_raid_disk eq 'Y'? 'checked' : ''#></td>
		        			<td>Check for disk read errors</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="m1_remarks" value="#data.m1_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="m2" #data.m2_raid_driver eq 'Y'? 'checked' : ''#></td>
		        			<td>Perform all recommended driver, controller firmware, and <br> storage management application updates</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="m2_remarks" value="#data.m2_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="m3" #data.m3_raid_consistency eq 'Y'? 'checked' : ''#></td>
		        			<td>Run system consistency check</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="m3_remarks" value="#data.m3_remarks#"></td>
		        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="m4" #data.m4_raid_replace eq 'Y'? 'checked' : ''#></td>
		        			<td>Replace drivers that have either failed completely or are starting to <br> show signs of failing (medium erros, S.M.A.R.T. errirsm etc.) immediately.</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="m4_remarks" value="#data.m3_remarks#"></td>
		        		</tr>		        		
		        <tr>
        			<td style="width: 20px"><i class="fa fa-minus"></i></td>
        			<td class="sub-N" colspan="3">Check cable intergrity</td>
        		</tr>
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="n1" #data.n1_cable_secure eq 'Y'? 'checked' : ''#></td>
		        			<td>Cables are securely fixed at each connection point</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="n1_remarks" value="#data.n1_remarks#"></td>
		        		</tr>	
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="n2" #data.n2_twisted eq 'Y'? 'checked' : ''#></td>
		        			<td>Cables are not twisted or under unnecessary straing</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="n2_remarks" value="#data.n2_remarks#"></td>
		        		</tr>	
		        		<tr>
		        			<td style="width: 10px"></td>
		        			<td style="width: 20px"><input type="checkbox" value="Y" class="big-check" name="n3" #data.n3_condition eq 'Y'? 'checked' : ''#></td>
		        			<td>Cables are all in good condition (no exposed wiring)</td>
		        			<td><input type="text" autocomplete="off" class="my-text" placeholder="Remarks" name="n3_remarks" value="#data.n3_remarks#"></td>
		        		</tr>				        				        				        				        		
        	</table>
        	<!--- //hardware check --->        	







        </div>    
      </div>
      <div class="modal-footer">
      	<input type="submit" hidden="" name="submitUpdateChecklist" id="submitUpdateChecklist">
        <button type="button" class="btn btn-success" onclick="updateChecklist()">Save</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <!--- <button type="button" class="btn btn-primary" id="btnSaveUser" onclick="">UPDATE</button> --->
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</form>

</cfoutput>


<script type="text/javascript">
	

		function updateChecklist() {
			if (confirm("Update checklist?")) {
				$("#submitUpdateChecklist").click()
			}
		}
	
</script>