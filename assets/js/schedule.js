$(function(){

   $(".sched_param").on("change", function () {
      var year = $("#slcYear").val();
      var group = $("#slcGroup").val();
      window.location = `schedule.cfm?year=${year}&group=${group}`;
   })


})



$('#addComputerModal').on('shown.bs.modal', function (e) {
  $("#txtComputerName").focus()
})

$('#setSchedMultipleModal').on('hidden.bs.modal', function () {
   	$('#setSchedMultipleModal').html('');
})

$('#setActualMultipleModal').on('hidden.bs.modal', function () {
   	$('#setActualMultipleModal').html('');
})

$('#updateActualModal').on('hidden.bs.modal', function () {
   	$('#updateActualModal').html('');
})

$('#setSchedModal').on('hidden.bs.modal', function () {
   	$('#setSchedModal').html('');
})



function updateSingleActual(id) {
	var modal = "#updateActualModal";

		$.get('templates/forms/form_updateactual.cfm?id='+id, function(data) {
				$(modal).html(data)
			 	$(modal).modal("show");
	});

}


function setActual(){

			var actual_date = $("#txtDate").val();
			var performer = $("#slcPerformer").val();
			var evidence = $("[name='evidence']").val();

			if (!actual_date) {
				toastr.error("Please choose actual date")
			} else if (!performer) {
				toastr.error("Please choose MIS in-charge")
			} else if (!evidence) {
				toastr.error("Please attach image evidence of maintenance")
			} else {

				var con = confirm("Save record?")

				if (con) {
					$("#btnSetActualSingle").click()
				}

			}
}


function updateSingleSched(id) {
	
	var modal = "#setSchedModal";

		$.get('com/schedules/setschedmodal.cfm?id='+id, function(data) {
				$(modal).html(data);
			 	$(modal).modal("show");
	})

}


function setSingleSched(id) {
		var week_no = $("#txtWeek").val();
		var group = $("#txtGroup").val();
		
		var data = {
      id_selected : id,
      sched : week_no,
      group: group
   }
		
		if (!week_no) {
				toastr.error("Please select week number / date")
			} else {
				var con = confirm("Save schedule?")
	      if (con) {
	      	$.post('com/schedules/setschedule.cfm', data ,function(data) {
	      			location.reload()
	      	});
	      }
			}
	
}


function updateMultipleSched(year,group) {
	var modal = "#setSchedMultipleModal";
	var data = {
		year: year,
		group: group
	}
		$.post('com/schedules/frm_multipleschedule.cfm', data, function(data) {
				$(modal).html(data)
				 var table = $(".DataTableMultipleSched").DataTable({
               "aaSorting": [],
               "pageLength": 200
         });
			 	$(modal).modal("show");
	})

}



function updateMultipleActual(year,group) {
	var modal = "#setActualMultipleModal";
	var data = {
		year: year,
		group: group
	}
		$.post('com/schedules/frm_multipleupdate.cfm', data, function(data) {
				$(modal).html(data)
			 	$(modal).modal("show");
	})
}


function deleteComputer(id,computer_name) {
	if (confirm("Delete computer? "+computer_name)) {
      	$.get('com/schedules/deletecomputer.cfm', {id:id} ,function(data) {
  			location.reload()
  			// console.log("Ajax done")
  	});
	}
}

function deleteSchedule(id) {
	if (confirm("Delete Schedule? ")) {
      	$.get('com/schedules/deleteschedule.cfm', {id:id} ,function(data) {
  			location.reload()
  			// console.log("Ajax done")
  	});
	}
}

function addComputer(argument) {
	var pcname = $("#txtComputerName").val();
	var pcgroup = $("#slcAddGroup").val();
	var emessage = "";
	var data = {
		pcname:pcname,
		pcgroup:pcgroup
	}

  var set = new Promise(function (resolve,reject) {
		$.get('com/schedules/checkcomputer.cfm', {id:pcname} ,function(data) {
	  		if (data==1) {
	  			reject()
	  			emessage = "PC name already exists in the database";
	  		} else if (pcname == '') {
	  			reject()
	  			emessage = "Enter PC name";
	  		} else {
	  			resolve()
	  		}
	  	})
  }).then(()=>{
  		if (confirm("Add new computer? "+pcname)) {
  				 $.post('com/schedules/savecomputer.cfm', data ,function(data) {
				  			location.reload()
				  			// console.log("Ajax done")
				  	});
  		}
  	},()=>{
  			toastr.error(emessage)
  	});

}


function multipleDelete() {	

		/* declare an checkbox array */
	var chkArray = [];

	/* look for all checkboes that have a class 'chk' attached to it and check if it was checked */
	$(".selection-delete:checked").each(function() {
		chkArray.push($(this).val());
	});
	
	/* we join the array separated by the comma */
	var selected;
	selected = chkArray.join(',') ;
	
	/* check if there is selected checkboxes, by default the length is 1 as it contains one single comma */
	if(selected.length > 0){
		console.log(chkArray);

	var data = {
		selected: selected
	}

			if (confirm("Delete computer(s)?"))
					 {
			        		$.post('com/schedules/deletecomputer.cfm?multiple=true', data, function(data) {
						  			setTimeout(function (argument) {
						  				location.reload();
						  			},500)
		        		})
		      }



	}else{
		toastr.error("Please at least check one of the checkbox");	
	}


}


function viewChecklist(id,year) {
		var modal = "#modalViewSchedule";
		var data = {
			id:id,
			year:year
		}
		$.get('com/schedules/frm_checklist.cfm', data , function(data) {
				$(modal).html(data)
			 	$(modal).modal("show");
	});
}
