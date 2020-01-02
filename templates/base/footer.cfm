 
  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">
      Developed by: Kay Singian
    </div>
    <!-- Default to the left -->
    <strong>Copyright &copy; <cfoutput>#year(now())#</cfoutput> <a href="#">Nicera Philippines</a>.</strong> All rights reserved.
  </footer>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 2.2.3 -->
<script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="plugins/bootstrap-touchspin/jquery.bootstrap-touchspin.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="plugins/moment/moment.min.js"></script>
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/plugins/datetime.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="plugins/input-mask/jquery.inputmask.js"></script>
<script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
<script src="plugins/iCheck/icheck.min.js"></script>
<script src="plugins/timepicker/bootstrap-timepicker.min.js"></script>
<script src="plugins/bootstrap-fileinput/js/fileinput.min.js"></script>
<script src="plugins/knob/jquery.knob.js"></script>
<script src="plugins/papaparse/papaparse.min.js"></script>
<script src="assets/js/app.min.js"></script>
<script src="assets/js/toastr.min.js"></script>
<script src="assets/js/custom.js"></script>
<script src="assets/js/Chart.bundle.min.js"></script>

<cfset loadedscript = listlast(cgi.script_name, "/")>

<cfif loadedscript EQ "schedule.cfm">
	<script src="assets/js/schedule.js"></script>  
<cfelseif loadedscript EQ "sched_summary.cfm">
  <script src="assets/js/sched_summary.js"></script>
<cfelseif loadedscript EQ "sched_graph.cfm">
  <script src="assets/js/sched_charts.js"></script>
<cfelseif loadedscript EQ "attendance.cfm">
  <script src="assets/js/attendance.js"></script>
</cfif>



<script type="text/javascript">  
  <cfif structKeyExists(SESSION, 'actualset')>
      toastr.success("Record saved!")
  </cfif>
  <cfset structDelete(SESSION, 'actualset')>

  // schedulesaved
  <cfif structKeyExists(SESSION, 'schedulesaved')>
      toastr.success("Schedule saved!")
  </cfif>
  <cfset structDelete(SESSION, 'schedulesaved')>

  <cfif structKeyExists(SESSION, 'computerdeleted')>
      toastr.success("<cfoutput>#SESSION.computerdeleted#</cfoutput> deleted")
  </cfif>
  <cfset structDelete(SESSION, 'computerdeleted')>

  <cfif structKeyExists(SESSION, 'checklistupdated')>
      toastr.success("Checklist updated")
  </cfif>
  <cfset structDelete(SESSION, 'checklistupdated')>


</script>



</body>
</html>