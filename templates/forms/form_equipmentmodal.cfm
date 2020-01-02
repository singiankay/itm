<!-- Modal -->
<div class="modal fade" id="EquipmentModal" role="dialog"></div>
<!-- /.modal -->

<!-- Modal -->
<div class="modal fade" id="archiveEquipmentModal" role="dialog">
  <form class="form-horizontal" method="POST">
    <div class="modal-dialog" role="document">
      <div class="modal-content modal-danger">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Delete Equipment</h4>
        </div>
        <div class="modal-body">
          <div id="archiveModalContent"></div>
        </div>
        <!--- / .modal-body --->
        <div class="modal-footer">
          <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>
          <input type="submit" name="archiveEquipment" class="btn btn-outline" value="Yes">
        </div>
      </div> 
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </form>
</div>
<!-- /.modal -->

<!-- Modal -->
<div class="modal fade" id="createHistoryModal" role="dialog"></div>
<div class="modal fade" id="updateHistoryModal" role="dialog"></div>
<!-- /.modal -->