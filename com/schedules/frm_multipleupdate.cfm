<cfoutput>
<cfquery name="getMIS" datasource="employee_db">
select  emp33, concat(emp3," ",emp2) as name from m_employee where emp24 = 1 and emp27 = 1 and emp5 NOT LIKE "OJT" ORDER BY emp1 DESC
</cfquery>

<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />
<cfset getForUpdating = objSchedules.getForUpdating(form.year,form.group)>


     <div class="modal-dialog">
      <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title">Set Actual Date for Multiple Computers</h3>
      </div>
      <form name="frmMultipleUpdate" enctype="multipart/form-data" method="post" action="com/schedules/setactual.cfm?multiple=true">
        <div class="modal-body">
        <div class="container-fluid">
          <!-- DATA GOES HERE -->
          <label>Select date:</label>
          <input type="date" class="form-control" name="txtDate" >
          <label>Performed by:</label>
          <select class="form-control" name="slcPerformer">
                <option value="" selected="">---</option>
            <cfloop query="#getMIS#">
                <option value="#getMIS.emp33#">#getMIS.name#</option>
            </cfloop>
          </select>
          <label>Attach evidence:(jpg,png)</label>
          <input type="file" class="form-control" name="evidence">

      <label>Select Computers:</label>
        <div class="row" style="margin: 0">
          <div class="col-lg-12" style="padding-right: 2px; padding-left: 2px">
            <label class="label-pcname"><input id="select_all" type="checkbox" name="" > Select All</label>
          </div>
          <cfloop query="getForUpdating">
            <div style="padding-right: 2px; padding-left: 2px" class="col-lg-2">
              <center><label class="label-pcname" style=""> <input type="checkbox" value="#getForUpdating.sched_id#" class="selection" name="selection[]"> #getForUpdating.computer_name#</label></center>
            </div>
          </cfloop>
        </div>

        </div>    
      </div>
     <center> <input type="submit"  name="" id="btnSetActualMultiple" hidden=""></center>
      </form>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" onclick="setActualMultiple()">Save</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <!--- <button type="button" class="btn btn-primary" id="btnSaveUser" onclick="">UPDATE</button> --->
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->



</cfoutput>

<script type="text/javascript">
  
  $(document).ready(function(){
    $('#select_all').on('click',function(){
        if(this.checked){
            $('.selection').each(function(){
                this.checked = true;
            });

        }else{
             $('.selection').each(function(){
                this.checked = false;
            });


        }
    });
    
    $('.selection').on('click',function(){
        if($('.selection:checked').length == $('.selection').length){
            $('#select_all').prop('checked',true);
        }else{
            $('#select_all').prop('checked',false);
        }
    });


});



function setActualMultiple(){

 var chkArray = [];
    $(".selection:checked").each(function() {
    chkArray.push($(this).val());
  });
  var selected;
  selected = chkArray.join(',') ;

      var actual_date = $("[name='txtDate']").val();
      var performer = $("[name='slcPerformer']").val();
      var evidence = $("[name='evidence']").val();

      if (!actual_date) {
        toastr.error("Please choose actual date")
      } else if (!performer) {
        toastr.error("Please choose MIS in-charge")
      } else if (!evidence) {
        toastr.error("Please attach image evidence of maintenance")
      } else if (selected.length == 0) {
        toastr.error("Please select at least one of the checkbox")
      } else {

        var con = confirm("Save record?")

        if (con) {
          $("#btnSetActualMultiple").click()
        }

      }


}

</script>