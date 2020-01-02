<div id="consumable-dashboard"></div>

<div class="modal fade" id="create-consumable-item">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Create Consumable Entry <span class="label-primary consumable-item-name"></span></h4>
      </div>
      <form role="form" method="POST">
        <div class="modal-body">
          <div class="box-body">
            <div class="form-group">
              <label for="description">Description</label>
              <input type="hidden" id="create-fk-consumables-id" name="fk_consumables_id" value="">
              <input type="text" class="form-control" id="create-description" name="description" placeholder="Description" required>
            </div>
            <div class="row">
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="minimum_level">Action</label>
                  <select class="form-control" id="create-action" name="action" required></select>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="quantity">Quantity</label>
                  <input type="text" class="form-control" id="create-quantity" name="quantity" placeholder="Quantity" pattern="[0-9\/]*" value="0" required>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label for="date_recorded">Date Recorded</label>
              <input type="date" class="form-control" id="create-date-recorded" value="<cfoutput>#Dateformat(now(),"mm/dd/yyyy")#</cfoutput>" name="date_recorded" placeholder="" required>
            </div>
            <div class="form-group">
              <label for="remarks">Remarks</label>
              <textarea name="remarks" id="create-remarks" class="form-control" rows="3" placeholder="Enter additional info"></textarea>
            </div>
          </div>
          <!-- /.box-body -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
          <input type="submit" id="submit-create-consumable-item" name="createConsumableItem" class="btn btn-primary" value="Create">
        </div>
      </form>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<div class="modal fade" id="update-consumable-item">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Update Consumable Entry <span class="label-primary consumable-item-name"></span></h4>
      </div>
      <form role="form" method="POST">
        <div class="modal-body">
          <div class="box-body">
            <div class="form-group">
              <label for="description">Description</label>
              <input type="hidden" id="update-id" name="id" value="">
              <input type="hidden" id="update-fk-consumables-id" name="fk_consumables_id" value="">
              <input type="text" class="form-control" id="update-description" name="description" placeholder="Description" required>
            </div>
            <div class="row">
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="minimum_level">Action</label>
                  <select class="form-control" id="update-action" name="action" required></select>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="quantity">Quantity</label>
                  <input type="text" class="form-control" id="update-quantity" name="quantity" placeholder="Quantity" pattern="[0-9\/]*" value="0" required>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label for="date_recorded">Date Recorded</label>
              <input type="text" class="form-control" id="update-date-recorded" name="date_recorded" placeholder="Date Recorded" required>
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
          <input type="submit" id="submit-update-consumable-item" name="updateConsumableItem" class="btn btn-primary" value="Update">
          <input type="submit" id="submit-delete-consumable-item" name="deleteConsumableItem" class="btn btn-danger" value="Delete" onclick="return confirm('Are you sure you want to Delete this record?')">
        </div>
      </form>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
