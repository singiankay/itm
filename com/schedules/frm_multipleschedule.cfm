<cfoutput>
<cfset objSchedules = createObject('/itmanagement.com.schedules.Schedules').init() />

<cfset getWithSched  = objSchedules.getAllRecords(form.group,form.year)>
<!--- <cfdump var="#getWithSched#"> --->
<cfset thelist = valueList(getWithSched.id_record)>
<cfset getForSchedule = objSchedules.getForSchedule(thelist,form.group)>

	 <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title">Set Schedule for Multiple Computers</h3>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
          <input type="hidden" value="#form.group#" id="txtGroup" name="">
          <!-- DATA GOES HERE -->
   
        <!--- <cfdump var="#getForSchedule#"> <br> --->
          <cfif form.group eq 'SERVER'>
           <label>Select Date:</label>
            <input type="date" class="form-control" name="" id="txtWeek">
          <cfelse>
            <label>Select week:</label>
            <input type="week" class="form-control" name="" id="txtWeek">
          </cfif>
          <br>
          <label>Select Computers:</label>
<!--- 	        <div class="row" style="margin: 0">
	        	<div class="col-lg-12" style="padding-right: 2px; padding-left: 2px">
	        		<label class="label-pcname"><input id="select_all_sched" type="checkbox" name="" > Select All</label>
	        	</div>
	          <cfloop query="getForSchedule">
	          	<div style="padding-right: 2px; padding-left: 2px" class="col-lg-2">
	          		<center><label class="label-pcname" style=""> <input type="checkbox" value="#getForSchedule.id_record#" class="selection_sched" name=""> #getForSchedule.computer_name#</label></center>
	          	</div>
	          </cfloop>
	        </div>
 --->
          <div class="row table-responsive" style="margin: 0; max-height: 500px">
            <table class="table table-bordered DataTableMultipleSched">
                <thead>
                  <tr>
                    <th>Computer name</th>
                  </tr>
                </thead>
                <tbody>
                  <cfloop query="getForSchedule">
                    <tr>
                      <td><label class="label-pcname" style=""> <input type="checkbox" value="#getForSchedule.id_record#" class="selection_sched" name=""> #getForSchedule.computer_name#</label></td>
                    </tr>
                  </cfloop>
                </tbody>
            </table>
          </div>

        </div>    
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" onclick="setMultipleSched()">Save</button>
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
    $('#select_all_sched').on('click',function(){
        if(this.checked){
            $('.selection_sched').each(function(){
                this.checked = true;
            });

        }else{
             $('.selection_sched').each(function(){
                this.checked = false;
            });


        }
    });
    
    $('.selection_sched').on('click',function(){
        if($('.selection_sched:checked').length == $('.selection_sched').length){
            $('#select_all_sched').prop('checked',true);
        }else{
            $('#select_all_sched').prop('checked',false);
        }
    });


});

function setMultipleSched(){
	/* declare an checkbox array */
	var chkArray = [];
  var group = $("#txtGroup").val();
	var week_no = $("#txtWeek").val();

	/* look for all checkboes that have a class 'chk' attached to it and check if it was checked */
	$(".selection_sched:checked").each(function() {
		chkArray.push($(this).val());
	});
	
	/* we join the array separated by the comma */
	var selected;
	selected = chkArray.join(',') ;
	
	/* check if there is selected checkboxes, by default the length is 1 as it contains one single comma */
	// if(selected.length > 0){
	// 	console.log(chkArray);	
	// 	console.log(week_no)
	// }else{
	// 	console.log("Please at least check one of the checkbox");	
	// }

  if (group == 'SERVER') {
      

  } else {

      if (!week_no) {
        toastr.error("Please select week number")
      } else if (selected.length == 0) {
        toastr.error("Please select at least one of the checkbox")
      } else {
        console.log(chkArray);  
        console.log(week_no);

        var data = {
          id_selected : selected,
          sched : week_no
       }

          var con = confirm("Save schedule?")

          if (con) {
            $.post('com/schedules/setschedule.cfm?multiple=true', data ,function(data) {
                // alert("Schedule saved!")
                location.reload()
            });
          }

      }    

  }


}


</script>