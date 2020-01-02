<div class="box">
  <div class="box-header">
    <h3 class="box-title">Configuration</h3>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="consumables" class="table table-bordered table-hover" style="cursor:pointer">
      <thead>
      <tr>
        <th>Name</th>
        <th>Minimum Level</th>
        <th>Maximum Level</th>
        <th>Remarks</th>
      </tr>
      </thead>
      <tbody data-link="row" class="rowlink" id="consumable-records"></tbody>
    </table>
    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#create-consumables">
      Create
    </button>
  </div>
  <!-- /.box-body -->
  <div class="overlay" id="loadingSpinner">
    <i class="fa fa-refresh fa-spin"></i>
  </div>
</div>
<!-- /.box -->
<div class="modal fade" id="create-consumables">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Create Consumable</h4>
      </div>
      <form role="form" method="POST">
        <div class="modal-body">
          <div class="box-body">
            <div class="form-group">
              <label for="name">Name</label>
              <input type="text" class="form-control" id="name" name="name" placeholder="Consumable Name" required>
            </div>
            <div class="row">
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="minimum_level">Minimum Level</label>
                  <input type="text" class="form-control" id="minimum-level" name="minimum_level" placeholder="Minimum Level" pattern="[0-9\/]*" value="0" required>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="maximum_level">Maximum Level</label>
                  <input type="text" class="form-control" id="maximum-level" name="maximum_level" placeholder="Maximum Level" pattern="[0-9\/]*" value="0" required>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label for="remarks">Remarks</label>
              <textarea name="remarks" id="remarks" class="form-control" rows="3" placeholder="Enter additional info"></textarea>
            </div>
          </div>
          <!-- /.box-body -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
          <input type="submit" id="submit-create-consumables" name="createConsumable" class="btn btn-primary" value="Create">
        </div>
      </form>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<div class="modal fade" id="update-consumables">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Consumable <span class="label-primary" id="consumable-name"></span></h4>
      </div>
      <form role="form" method="POST">
        <div class="modal-body">
          <div class="box-body">
            <div class="form-group">
              <label for="name">Name</label>
              <input type="hidden" id="update-id" name="id" value="">
              <input type="text" class="form-control" id="update-name" name="name" placeholder="Consumable Name" required>
            </div>
            <div class="row">
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="minimum_level">Minimum Level</label>
                  <input type="text" class="form-control" id="update-minimum-level" name="minimum_level" placeholder="Minimum Level" pattern="[0-9\/]*" value="0" required>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="maximum_level">Maximum Level</label>
                  <input type="text" class="form-control" id="update-maximum-level" name="maximum_level" placeholder="Maximum Level" pattern="[0-9\/]*" value="0" required>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label for="remarks">Remarks</label>
              <textarea name="remarks" id="update-remarks" class="form-control" rows="3" placeholder="Enter additional info"></textarea>
            </div>
          </div>
          <!-- /.box-body -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
          <input type="submit" id="submit-update-consumable" name="updateConsumable" class="btn btn-primary" value="Update">
          <input type="submit" id="submit-delete-consumable" name="deleteConsumable" class="btn btn-danger" value="Delete" onclick="return confirm('Are you sure you want to Delete this record?')">
        </div>
      </form>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>