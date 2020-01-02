<!-- Modal -->
<div class="modal fade" id="createAssetModal" role="dialog">
  <form class="form-horizontal" enctype="multipart/form-data" method="POST">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content modal-primary">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Create IT Record</h4>
          <input type="hidden" id="AssetID" name="AssetID" value="">
        </div>
        <div class="modal-body">
          <div class="box-body">
            <div class="form-group">
              <label for="selectAssetType" class="col-sm-3 control-label">Select Asset Type</label>
              <div class="col-sm-9">
                <select class="form-control" id="selectAssetType" name="AssetType" placeholder="Asset Type">
                  <option value="Computer">Computer</option>
                  <option value="Equipment">Equipment</option>
                  <option value="Others">Others</option>
                </select>
              </div>  
            </div> 
          </div>    
          <div id="modalContent"></div>
        </div>
        <!--- / .modal-body --->
        <div class="modal-footer">
          <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>
          <input type="submit" class="btn btn-outline" value="Save">
        </div>
      </div> 
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </form>
</div>
<!-- /.modal -->