<div class="box">
  <div class="box-header">
    <h3 class="box-title">Click on an item below to create an IT record.</h3>

  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="Assets" class="table table-bordered table-hover" style="cursor:pointer">
      <thead>
      <tr>
        <th>ID</th>
        <th>Asset Tag</th>
        <th>Date Issued</th>
        <th>Description</th>
      </tr>
      </thead>
      <tbody data-link="row" class="rowlink" id="AssetManagementRecords"></tbody>
      <tfoot>
      <tr>
        <th>ID</th>
        <th>Asset Tag</th>
        <th>Date Issued</th>
        <th>Description</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
  <div class="overlay" id="loadingSpinner">
    <i class="fa fa-refresh fa-spin"></i>
  </div>
</div>
<!-- /.box -->