<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <h1>Annual Maintenance Plan</h1>
  </section>
  <!-- Main content -->
  <section class="content">
    <div id="alertContent" class="row">
      <div class="col-xs-12">
        <cfoutput>#Alert#</cfoutput>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <cfinclude template="../boxes/sched_summary.cfm">
      </div>
      <!-- /.col -->
    </div>
    <!-- /.row -->
  </section>

  <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<!--- <cfinclude template="../forms/form_schedules.cfm"> --->