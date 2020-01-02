function initIcheckElements() {
 $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
   checkboxClass: 'icheckbox_flat-red',
   radioClass: 'iradio_flat-red'
 });
}

function getInputDateMask() {
   $("[data-mask]").inputmask();
}

function initTimepickerModal() {
   $(".timepicker").timepicker({
      showInputs: false,
      minuteStep: 1,
      showSeconds: true,
    });
}

function loadBaseURL() {
   $(function() {
      $("#datemask").inputmask("mm/dd/yyyy", {"placeholder": "mm/dd/yyyy"});
   });
   getInputDateMask();
   getAssetRecords();

   getAssetModalContent($("#selectAssetType option:selected").val()); 

   $("#selectAssetType").change(function (e) {
      getAssetModalContent($("#selectAssetType option:selected").val());
   });
}

function loadComputersURL() {
   $(function() {
      $("#datemask").inputmask("mm/dd/yyyy", {"placeholder": "mm/dd/yyyy"});
   });
   getInputDateMask();
   getComputerRecords();
   if(sessionStorage.getItem("type") === "Computer") {
      ComputerHistory(sessionStorage.getItem("id"),sessionStorage.getItem("computer_id"),sessionStorage.getItem("type"));
   }
}

function loadEquipmentURL() {
   $(function() {
      $("#datemask").inputmask("mm/dd/yyyy", {"placeholder": "mm/dd/yyyy"});
   });
   getInputDateMask();
   getEquipmentRecords();
   if(sessionStorage.getItem("type") === "Equipment") {
      EquipmentHistory(sessionStorage.getItem("id"),sessionStorage.getItem("equipment_id"),sessionStorage.getItem("type"));
   }
}

function loadSchedulesURL() {
   $(function() {
      $("#datemask").inputmask("mm/dd/yyyy", {"placeholder": "mm/dd/yyyy"});
   });
   getInputDateMask();
   getScheduleRecords();
   // if(sessionStorage.getItem("type") === "Equipment") {
   //    EquipmentHistory(sessionStorage.getItem("id"),sessionStorage.getItem("equipment_id"),sessionStorage.getItem("type"));
   // }
}


function loadOthersURL() {
   $(function() {
      $("#datemask").inputmask("mm/dd/yyyy", {"placeholder": "mm/dd/yyyy"});
   });
   getInputDateMask();
   getOthersRecords();
   if(sessionStorage.getItem("type") === "Others") {
      OthersHistory(sessionStorage.getItem("id"),sessionStorage.getItem("others_id"),sessionStorage.getItem("type"));
   }
}

function loadImportURL() {
   $(function() {
      ImportComputerTable = $("#importComputerTable").DataTable({
         "scrollX": true, 
         "language": {
            "emptyTable": "No data available in table"
         },
         "lengthMenu": [ 5, 10, 20, 25, 50, 100 ],
         "pageLength": 5,
         "columnDefs": [{
            "width": 300, "targets": 13
         }],
         "stateSave": true,
         "deferRender": true
      });
   }); 
}

function loadConsumablesURL() {
   // $("#update-date-recorded").inputmask("mm/dd/yyyy", {"placeholder": "mm/dd/yyyy"});
   $("#update-quantity").TouchSpin({
      min: 0,
      max: 99999999,
      verticalbuttons: true,
      verticalupclass: 'glyphicon glyphicon-plus',
      verticaldownclass: 'glyphicon glyphicon-minus'
   });
   // $("#create-date-recorded").inputmask("mm/dd/yyyy", {"placeholder": "mm/dd/yyyy"});
   $("#create-quantity").TouchSpin({
      min: 0,
      max: 99999999,
      verticalbuttons: true,
      verticalupclass: 'glyphicon glyphicon-plus',
      verticaldownclass: 'glyphicon glyphicon-minus'
   });
   
   $.get('com/consumables/getconsumablesknob.cfm')
   .done(function(data) {
      result = JSON.parse(data);
      $.each(result, function(index, row) {
         var arrayColor = ["#3c8dbc", "#f56954", "#00a65a", "#00c0ef", "#932ab6", "#39cccc"];
         var color = arrayColor[Math.floor(Math.random()*arrayColor.length)];
         var knob = '';
         knob += '<div class="col-md-4">';
         knob += '<div class="box box-solid">';
         knob += '<div class="box-header with-border">';
         knob += '<h3 class="box-title">'+row.NAME+'</h3>';
         knob += '</div>';
         knob += '<div class="box-body">';
         knob += '<div class="text-center">';
         knob += '<input type="text" id="dial_'+index+'" value="'+row.QTY_ON_HAND+'" data-max="'+row.MAXIMUM_LEVEL+'">';
         knob += '</div>';

         knob += '<dl class="dl-horizontal">'
         knob += '<dt>Minimum Level</dt><dd>'+row.MINIMUM_LEVEL+'</dd>';
         knob += '<dt>Maximum Level</dt><dd>'+row.MAXIMUM_LEVEL+'</dd>';
         
         if(row.QTY_ON_HAND < 0) {
            knob += '<dt>Status</dt><dd class="text-red">Error: Negative Value</dd><dd class="text-red">Quantity ('+row.QTY_ON_HAND+') is a negative value</dd>';
            color = '#f56954';
         }
         else if((row.QTY_ON_HAND <= row.MINIMUM_LEVEL)&&(row.MINIMUM_LEVEL != 0)&&(row.MAXIMUM_LEVEL != 0)) {
            knob += '<dt>Status</dt><dd class="text-maroon">For Replenishment</dd><dd class="text-maroon">Please replenish '+eval(row.MAXIMUM_LEVEL-row.QTY_ON_HAND)+'pcs of '+row.NAME+'.</dd>';
            color = '#D81B60';
         }
         else  if((row.QTY_ON_HAND > row.MAXIMUM_LEVEL)) {
            knob += '<dt>Status</dt><dd class="text-teal">Error</dd><dd class="text-teal">Stock ('+row.QTY_ON_HAND+') is above Maximum Level</dd>';
            color = '#39CCCC';
         }
         else {
            knob += '<dt>Status</dt><dd class="text-green">Okay</dd><dd class="text-green">Stock ('+row.QTY_ON_HAND+') is sufficient</dd>';
            color = '#00a65a';
         }
         if(row.REMARKS) {
            knob += '<dt>Remarks</dt><dd>'+row.REMARKS+'</dd>';
         }
         else {
            knob += '<dt>Remarks</dt><dd>n/a</dd>';
         }
         knob += '</dl>';

         knob += '<p><input type="button" value="Create Entry" data-value="'+row.CONSUMABLES_ID+'" class="btn btn-block btn-primary btn-flat create-consumable-item"></p>';
         knob += '<p><input type="button" value="Toggle Entry History" data-value="'+row.CONSUMABLES_ID+'" class="btn btn-block btn-success btn-flat show-consumable-items"></p>';
         knob += '<div class="collapse" id="collapse-consumable-'+row.CONSUMABLES_ID+'" aria-expanded="false">';
         knob += '<table id="table-consumable-items'+row.CONSUMABLES_ID+'" class="table table-bordered table-hover" style="cursor:pointer">';
         knob += '<thead><tr><th>ID</th><th>Description</th><th>Action</th><th>Quantity</th><th>Date Recorded</th><th>Remarks</th></tr></thead><tbody id="consumable-items-body"></tbody></table>';
         knob += '</div>';
         knob += '</div>';
         knob += '</div>';
         knob += '</div>';
         $('#consumable-dashboard').append(knob);
         if((row.QTY_ON_HAND >= 0)&&(row.QTY_ON_HAND <= row.MAXIMUM_LEVEL)) {
            $("#dial_"+index).knob({
               'readOnly' : true,
               'fgColor': color,
               'inputColor' : color,
               'min' : 0
            });
         }
         else {
            $("#dial_"+index).hide();
         }
      });
      var divs = $("#consumable-dashboard > div");
      for(var i = 0; i < divs.length; i+=3) {
        divs.slice(i, i+3).wrapAll("<div class='row'></div>");
      }
   });
}

function loadConsumablesConfigURL() {
   getConsumableRecords();
   initIcheckElements();
   $("#minimum-level").TouchSpin({
      min: 0,
      max: 99999999,
      verticalbuttons: true,
      verticalupclass: 'glyphicon glyphicon-plus',
      verticaldownclass: 'glyphicon glyphicon-minus'
   });
   $("#maximum-level").TouchSpin({
      min: 0,
      max: 99999999,
      verticalbuttons: true,
      verticalupclass: 'glyphicon glyphicon-plus',
      verticaldownclass: 'glyphicon glyphicon-minus'
   });
   $("#update-minimum-level").TouchSpin({
      min: 0,
      max: 99999999,
      verticalbuttons: true,
      verticalupclass: 'glyphicon glyphicon-plus',
      verticaldownclass: 'glyphicon glyphicon-minus'
   });
   $("#update-maximum-level").TouchSpin({
      min: 0,
      max: 99999999,
      verticalbuttons: true,
      verticalupclass: 'glyphicon glyphicon-plus',
      verticaldownclass: 'glyphicon glyphicon-minus'
   });
}

function resetImportComputer() {
   ImportComputerTable.clear().draw();
   errorcounter = 0;
   $('#importErrorCounter').html(errorcounter);
   $('#uploadImportComputer').prop("disabled",true);
   $('#uploadImportComputer').attr("class", "btn btn-primary disabled");
}

function verifyImportComputer() {
   errorcounter = 0;
   resetImportComputer();
   $('input[id=importFileComputer]').parse({
      config: {
         header: true,
         skipEmptyLines: true,
         step: function(results) {
            $('#importErrorCounter').html(errorcounter);
            $.each(results.data, function(index, data) {
               $.post('com/import/getcomputerimport.cfm', {uploadData: JSON.stringify(data)}, function(data) {
                  var dataReturn =  $.parseJSON(data);
                  var status = "<ul class='list-unstyled'";
                  if(dataReturn.is_active == 1) {
                     var is_active = "<i class='fa fa-check text-green' aria-hidden='true'></i>";
                  }
                  else if(dataReturn.is_active == 0) {
                     var is_active = "<i class='fa fa-close text-red' aria-hidden='true'></i>" ;
                  }
                  jQuery.each(dataReturn.error, function() {
                     status+= "<li><i class='fa fa-close fa-fw text-red' aria-hidden='true'></i>"+this+"<li>";
                     errorcounter++;
                  });
                  status += "</ul>";
                  ImportComputerTable.row.add([
                     dataReturn.asset_id,
                     dataReturn.asset_tag,
                     dataReturn.computer_type,
                     dataReturn.computer_name,
                     dataReturn.ip_address,
                     dataReturn.processor,
                     dataReturn.memory,
                     dataReturn.operating_system,
                     dataReturn.office,
                     dataReturn.graphics_card,
                     dataReturn.date_issued,
                     dataReturn.remarks,
                     is_active,
                     status
                  ]).draw(false);
                  $('#importErrorCounter').html(errorcounter);
               }).done(function() {
                  if(errorcounter > 0) {
                     $('#uploadImportComputer').prop("disabled",true);
                     $('#uploadImportComputer').attr("class", "btn btn-primary disabled");
                  }
                  else if(errorcounter == 0) {
                     $('#uploadImportComputer').prop("disabled", false);
                     $('#uploadImportComputer').attr("class","btn btn-primary");
                  }
               });
            });
         }
      },
   });
}

function uploadImportComputer() {
   errorcounter = 0;
   resetImportComputer();
   $('input[id=importFileComputer]').parse({
      config: {
         header: true,
         skipEmptyLines: true,
         step: function(results) {
            $('#importErrorCounter').html(errorcounter);
            $.each(results.data, function(index, data) {
               $.post('com/import/getcomputerimport.cfm', {importData: JSON.stringify(data)}, function(data) {
                  var dataReturn =  $.parseJSON(data);
                  if(dataReturn.is_active == 1) {
                     var is_active = "<i class='fa fa-check text-green' aria-hidden='true'></i>";
                  }
                  else if(dataReturn.is_active == 0) {
                     var is_active = "<i class='fa fa-close text-red' aria-hidden='true'></i>" ;
                  }
                  var status = "<ul class='list-unstyled'";
                  jQuery.each(dataReturn.error, function() {
                     if(this == "Success") {
                        status+= "<li><i class='fa fa-check fa-fw text-green' aria-hidden='true'></i>"+this+"</li>";
                     }
                     else {
                        status+= "<li><i class='fa fa-close text-red' fa-check fa-fw aria-hidden='true'></i>"+this+"</li>";
                        errorcounter++;
                     }
                  });
                  status += "</ul>"
                  ImportComputerTable.row.add([
                     dataReturn.asset_id,
                     dataReturn.asset_tag,
                     dataReturn.computer_type,
                     dataReturn.computer_name,
                     dataReturn.ip_address,
                     dataReturn.processor,
                     dataReturn.memory,
                     dataReturn.operating_system,
                     dataReturn.office,
                     dataReturn.graphics_card,
                     dataReturn.date_issued,
                     dataReturn.remarks,
                     is_active,
                     status
                  ]).draw(false);
                  $('#importErrorCounter').html(errorcounter);
               }).done(function() {
                  if(errorcounter > 0) {
                     $('#uploadImportComputer').prop("disabled",true);
                     $('#uploadImportComputer').attr("class", "btn btn-primary disabled");
                  }
                  else if(errorcounter == 0) {
                     $('#uploadImportComputer').prop("disabled", false);
                     $('#uploadImportComputer').attr("class","btn btn-primary");
                  }
               });
            });
         }
      },
   });
}

//ADDED BY CLYDE SEPT 20


function getScheduleRecords() {

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

var group = getUrlParameter('group');
var year = getUrlParameter('year');

   var data = {
      group : group,
      year : year
   }

      $.post('com/schedules/getschedules.cfm', data ,function(data) {
      $("#scheduleRecords").html(data);
      $(function () {
         var table = $("#Schedules").DataTable({
               "aaSorting": [],
               "pageLength": 100
         });
      });      
      $("#loadingSpinner").hide();
      getInputDateMask();
      // initIcheckElements();
   });
}

function getScheduleByYearOrGroup(year,group) {
   var data = {
      group : group,
      year : year
   }

      $.post('com/schedules/getschedules.cfm', data ,function(data) {
      $("#scheduleRecords").html(data);
      $(function () {
         var table = $("#Schedules").DataTable();
      });      
      $("#loadingSpinner").hide();
      getInputDateMask();
      // initIcheckElements();
   });
}


function getAssetRecords() {
   $.get('com/assetmanagement/getassetmanagement.cfm', function(data) {
      $("#AssetManagementRecords").html(data);
      $(function () {
         var table = $("#Assets").DataTable({
            "scrollX": true, 
            "language": {
               "emptyTable": "No data available in table"
            },
            "stateSave": true,
            "deferRender": true
         });
         $("#Assets").on('click','.AssetRows',function(e){
            e.preventDefault();
            var id = $(this).data('value');
            $("#createAssetModal").modal("show");
            $("#AssetID").val(id);
         }); 
      });      
      $("#loadingSpinner").hide();
      getInputDateMask();
   });
}

function getAssetModalContent(data) {

 var optionSelected = $("#selectAssetType option:selected", this);
 var valueSelected = data;
 var displayContent = $.get('templates/forms/form_createassetmodalcontent.cfm', {option: data} , function(data) {
   $("#modalContent").html(data);
   getInputDateMask();
   initIcheckElements();
 });
}

function getComputerRecords() {
   $.get('com/computers/getcomputers.cfm', function(data) {
      $('#ComputerRecords').html(data);
      $(function() {
         var table2 = $("#Computers").DataTable({
            "scrollX": true,
            "columnDefs": [{
               "width": 500, "targets": 13
            }],
            "language": {
               "emptyTable": "No data available in table"
            },
            "stateSave": true,
            "deferRender": true,
            "deferLoading": 25
         });
      });
      $("#loadingSpinner").hide();
      getInputDateMask();
   });
}

function editComputer(id) {
   $.get('com/computers/editcomputermodal.cfm', {id:id} ,function(data) {
      $('#ComputerModal').html(data);
      getInputDateMask();
      initIcheckElements();
      $('#ComputerModal').modal("show");
   });
}

function archiveComputer(id) {
   $.get('com/computers/archivecomputermodal.cfm', {id:id} ,function(data) {
      $('#archiveModalContent').html(data);
      $('#archiveComputerModal').modal("show");
   });
}

function deleteComputerAttachment(attachmentName, computerID) {
   var confirm = window.confirm("Are you sure you want to delete the attachment "+attachmentName+"?");
   if (confirm == true) {
      $.post('com/computers/deletecomputerattachment.cfm', {attachmentName: attachmentName, computerID: computerID}, function(data) {
         if(data == "true") {
            var link = $('input[data-attachment_id="' + attachmentName + '"]');
            var parent = link.parent();
            parent.remove();
         }
         else {
            alert("Error deleting file");
         }
         
      });
   }
}

function getEquipmentRecords() {
   $.get('com/equipment/getequipment.cfm', function(data) {
      $('#EquipmentRecords').html(data);
      $(function() {
         var table2 = $("#Equipment").DataTable({
            "scrollX": true,
            "columnDefs": [{
               "width": 500, "targets": 8
            }],
            "language": {
               "emptyTable": "No data available in table"
            },
            "stateSave": true,
            "deferRender": true,
            "deferLoading": 25
         });
      });
      $("#loadingSpinner").hide();
      getInputDateMask();
   });
}

function editEquipment(id) {
   $.get('com/equipment/editequipmentmodal.cfm', {id:id} ,function(data) {
      $('#EquipmentModal').html(data);
      getInputDateMask();
      initIcheckElements();
      $('#EquipmentModal').modal("show");
   });
}

function archiveEquipment(id) {
   $.get('com/equipment/archiveequipmentmodal.cfm', {id:id} ,function(data) {
      $('#archiveModalContent').html(data);
      $('#archiveEquipmentModal').modal("show");
   });
}

function deleteEquipmentAttachment(attachmentName, equipmentID) {
   var confirm = window.confirm("Are you sure you want to delete the attachment "+attachmentName+"?");
   if (confirm == true) {
      $.post('com/equipment/deleteequipmentattachment.cfm', {attachmentName: attachmentName, equipmentID: equipmentID}, function(data) {
         if(data == "true") {
            var link = $('input[data-attachment_id="' + attachmentName + '"]');
            var parent = link.parent();
            parent.remove();
         }
         else {
            alert("Error deleting file");
         }
         
      });
   }
}

function getOthersRecords() {
   $.get('com/others/getothers.cfm', function(data) {
      $('#OthersRecords').html(data);
      $(function() {
         var table2 = $("#Others").DataTable({
            "scrollX": true,
            "columnDefs": [{
               "width": 500, "targets": 7
            }],
            "language": {
               "emptyTable": "No data available in table"
            },
            "stateSave": true,
            "deferRender": true,
            "deferLoading": 25
         });
      });
      $("#loadingSpinner").hide();
      getInputDateMask();
   });
}

function editOthers(id) {
   $.get('com/others/editothersmodal.cfm', {id:id} ,function(data) {
      $('#OthersModal').html(data);
      getInputDateMask();
      initIcheckElements();
      $('#OthersModal').modal("show");
   });
}

function archiveOthers(id) {
   $.get('com/others/archiveothersmodal.cfm', {id:id} ,function(data) {
      $('#archiveModalContent').html(data);
      $('#archiveOthersModal').modal("show");
   });
}

function deleteOthersAttachment(attachmentName, othersID) {
   var confirm = window.confirm("Are you sure you want to delete the attachment "+attachmentName+"?");
   if (confirm == true) {
      $.post('com/others/deleteothersattachment.cfm', {attachmentName: attachmentName, othersID: othersID}, function(data) {
         if(data == "true") {
            var link = $('input[data-attachment_id="' + attachmentName + '"]');
            var parent = link.parent();
            parent.remove();
         }
         else {
            alert("Error deleting file");
         }
         
      });
   }
}

function showComputerHistory(id, computer_id, type) {
   sessionStorage.setItem("id", id);
   sessionStorage.setItem("computer_id", computer_id);
   sessionStorage.setItem("type", type);
   ComputerHistory(id, computer_id, type);
   $('html, body').animate({scrollTop: $("#historyContent").offset().top}, 500);
}

function ComputerHistory(id, computer_id, type) {
   $.get('templates/boxes/history.cfm', {id:id, computer_id:computer_id, type:type}, function(data) {
      $('#historyContent').html(data);
      $(function() {
         var table3 = $("#History").DataTable({
            "scrollX": true,
            "language": {
               "emptyTable": "No data available in table"
            },
            "stateSave": true,
            "deferRender": true,
            "deferLoading": 25
         });
      });
   });
}

function showEquipmentHistory(id, equipment_id, type) {
   sessionStorage.setItem("id", id);
   sessionStorage.setItem("equipment_id", equipment_id);
   sessionStorage.setItem("type", type);
   EquipmentHistory(id, equipment_id, type);
   $('html, body').animate({scrollTop: $("#historyContent").offset().top}, 500);
}

function EquipmentHistory(id, equipment_id, type) {
   $.get('templates/boxes/history.cfm', {id:id, equipment_id:equipment_id, type:type}, function(data) {
      $('#historyContent').html(data);
      $(function() {
         var table3 = $("#History").DataTable({
            "scrollX": true,
            "language": {
               "emptyTable": "No data available in table"
            },
            "stateSave": true,
            "deferRender": true,
            "deferLoading": 25
         });
      });
   });
}

function showOthersHistory(id, others_id, type) {
   sessionStorage.setItem("id", id);
   sessionStorage.setItem("others_id", others_id);
   sessionStorage.setItem("type", type);
   OthersHistory(id, others_id, type);
   $('html, body').animate({scrollTop: $("#historyContent").offset().top}, 500);
}

function OthersHistory(id, others_id, type) {
   $.get('templates/boxes/history.cfm', {id:id, others_id:others_id, type:type}, function(data) {
      $('#historyContent').html(data);
      $(function() {
         var table3 = $("#History").DataTable({
            "scrollX": true,
            "language": {
               "emptyTable": "No data available in table"
            },
            "stateSave": true,
            "deferRender": true,
            "deferLoading": 25
         });
      });
   });
}

function createHistory(id, type) {
   $.get('com/history/createhistorymodal.cfm', {id:id, type:type}, function(data) {
      $('#createHistoryModal').html(data);
      $('#createHistoryModal').modal("show");
      getInputDateMask();
      initTimepickerModal();
   });
}

function updateHistory(id, id_itassets, type) {
   $.get('com/history/updatehistorymodal.cfm', {id:id, id_itassets:id_itassets, type:type}, function(data) {
      $('#updateHistoryModal').html(data);
      $('#updateHistoryModal').modal("show");
      getInputDateMask();
      initTimepickerModal();
   });
}

function deleteHistoryAttachment(attachment, id, type) {
   var confirm = window.confirm("Are you sure you want to delete the attachment "+attachment+"?");
   if (confirm == true) {
      $.post('com/history/deletehistoryattachment.cfm', {attachment: attachment, id: id, type: type}, function(data) {
         if(data == "true") {
            var link = $('input[data-historyattachment_id="' + attachment + '"]');
            var parent = link.parent();
            parent.remove();
         }
         else {
            alert("Error deleting file");
         }
      });
   }
}

function scrollHistory() {
   $('html, body').animate({scrollTop: $("#historyContent").offset().top}, 500);
}

function getConsumable(id) {
   $.get('com/consumables/getconsumable.cfm',{get_consumable:true, id:id})
   .done(function(data) {
      var result = JSON.parse(data);
      $('#update-id').val(result.id);
      $('#update-name').val(result.name);
      $('#consumable-name').html(result.name);
      $('#update-minimum-level').val(result.minimum_level);
      $('#update-maximum-level').val(result.maximum_level);
      $('#update-remarks').val(result.remarks);
      $('#update-consumables').modal("toggle");
      if(parseInt($('#update-minimum-level').val()) > parseInt($('#update-maximum-level').val())) {
         $('#submit-update-consumable').attr("disabled", "disabled");
      }
      else {
         $('#submit-update-consumable').removeAttr('disabled');
      }
   }).fail(function() {
      alert("Error getting data. Please try again.");
   });
}

function getConsumableRecords() {
   $.get('com/consumables/getconsumables.cfm', function(data) {
      $('#consumable-records').html(data);
      $(function() {
         var table2 = $("#consumables").DataTable({
            "scrollX": true,
            "language": {
               "emptyTable": "No data available in table"
            },
            "stateSave": true,
            "deferRender": true,
            "deferLoading": 25
         });
      });
      $("#loadingSpinner").hide();
   });
}

function createConsumableItem(element) {
   $('#create-action').empty();
   var id = $(element).data('value');

   $.get('com/consumables/getconsumablename.cfm',{ id:id }, function(data) {
      $('.label-primary.consumable-item-name').html(data);
   });

   $('#create-fk-consumables-id').val(id);
   $.get('com/consumables/getconsumableactions.cfm', function(result) {
      data = JSON.parse(result);
      $.each(data, function(index, val) {
         $('#create-action').append('<option value=' + val + '>' + val + '</option>');
      });
   });
   
   $('#create-consumable-item').modal("toggle");
}

function showConsumableItems(element) {
   var id = $(element).data('value');

   if($('#collapse-consumable-'+id).attr('aria-expanded') == "false") {
      $.get('com/consumables/getconsumableitems.cfm', {id:id})
      .done(function(data) {
         // $('#collapse-consumable-'+id).html("");
         jsondata = JSON.parse(data);
         // console.log(jsondata);
         $('#table-consumable-items'+id).DataTable({
            data: jsondata,
            "scrollX": true,
            columns: [
               { data: 'ID', 'name': 'id' },
               { data: 'DESCRIPTION', 'name': 'description' },
               { data: 'ACTION', 'name': 'action' },
               { data: 'QUANTITY', 'name': 'quantity' },
               { data: 'DATE_RECORDED', 'name': 'date_recorded' },
               { data: 'REMARKS', 'name': 'remarks' }
            ],
            columnDefs: [ 
               { "name": "id", "targets": 0 },
               { "name": "description",  "targets": 1 },
               { "name": "action", "targets": 2 },
               { "name": "quantity",  "targets": 3 },
               { 
                  "name": "date_recorded", 
                  "targets": 4, 
                  render: $.fn.dataTable.render.moment('MMMM, DD YYYY HH:mm:ss', 'MMMM DD, YYYY') 
               },
               { "name": "remarks",    "targets": 5 }
            ]
         });
         $('#collapse-consumable-'+id).collapse('toggle');
      }).fail(function() {
         alert("Error getting data. Please try again.");
      });
   }
   else {
      $('#table-consumable-items'+id).DataTable().destroy();
      $('#collapse-consumable-'+id).collapse('toggle');
   }
}

function showConsumableItemsEditModal(id) {
   $('#update-action').empty();

   $.get('com/consumables/getconsumableitem.cfm', { id:id })
   .done(function(result) {
      data = JSON.parse(result);
      $.each(data.actions, function(index, val) {
         $('#update-action').append('<option value=' + val + '>' + val + '</option>');
      });
      $('#update-description').val(data.description);
      $('#update-id').val(data.id);
      $('#update-fk-consumables-id').val(data.fk_consumables_id);
      $('#update-action').val(data.action);
      $('#update-quantity').val(data.quantity);
      // $('#update-date-recorded').val(moment(data.date_recorded,'MMMM, DD YYYY HH:mm:ss').format('MM/DD/YYYY'));   
      $('#update-remarks').val(data.remarks);

      $.get('com/consumables/getconsumablename.cfm',{ id:data.fk_consumables_id, }, function(data) {
         $('.label-primary.consumable-item-name').html(data);
      });

      $('#update-consumable-item').modal("toggle");
   }).fail(function() {
      alert("Error getting data. Please try again.");
   });
}

jQuery(document).ready(function($) {
   if(window.location.href.indexOf("computers.cfm") > -1) {
      loadComputersURL();
   }
   else if(window.location.href.indexOf("equipment.cfm") > -1) {
      loadEquipmentURL();
   }
   else if(window.location.href.indexOf("others.cfm") > -1) {
      loadOthersURL();
   }
   else if(window.location.href.indexOf("import.cfm") > -1) {
      loadImportURL();
   }
   else if(window.location.href.indexOf("consumables.cfm") > -1) {
      loadConsumablesURL();
   }
   else if(window.location.href.indexOf("consumables-config.cfm") > -1) {
      loadConsumablesConfigURL();
   } 
   else if(window.location.href.indexOf("schedule.cfm") > -1) {
      loadSchedulesURL();
   }
   else {
      loadBaseURL();
   }
   initIcheckElements();

   $('#verifyImportComputer').click(function() {
      verifyImportComputer();
   });
   $('#resetImportComputer').click(function() {
      resetImportComputer();
   });
   $('#uploadImportComputer').click(function() {
      uploadImportComputer();
   })

   $('input[id=importFileComputer]').change(function() {
      errorcounter = 0;
      $('#importErrorCounter').html(errorcounter);
      $('#uploadImportComputer').prop("disabled",true);
      $('#uploadImportComputer').attr("class", "btn btn-primary disabled");
   });

   $('#minimum-level').change(function() {
      if(parseInt($('#minimum-level').val()) > parseInt($('#maximum-level').val())) {
         $('#submit-create-consumables').attr("disabled", "disabled");
      }
      else {
         $('#submit-create-consumables').removeAttr('disabled');
      }
   });
   $('#maximum-level').change(function() {
      if(parseInt($('#minimum-level').val()) > parseInt($('#maximum-level').val())) {
         $('#submit-create-consumables').attr("disabled", "disabled");
      }
      else {
         $('#submit-create-consumables').removeAttr('disabled');
      }
   });
   $('#update-minimum-level').change(function() {
      if(parseInt($('#update-minimum-level').val()) > parseInt($('#update-maximum-level').val())) {
         $('#submit-update-consumable').attr("disabled", "disabled");
      }
      else {
         $('#submit-update-consumable').removeAttr('disabled');
      }
   });
   $('#update-maximum-level').change(function() {
      if(parseInt($('#update-minimum-level').val()) > parseInt($('#update-maximum-level').val())) {
         $('#submit-update-consumable').attr("disabled", "disabled");
      }
      else {
         $('#submit-update-consumable').removeAttr('disabled');
      }
   });

   $('#consumables').on('click', 'tr', function(event) {
      var id = $(this).data("value");
      getConsumable(id);
   });

   $('#consumable-dashboard').on('click','input.btn.btn-block.btn-primary.btn-flat.create-consumable-item', function(event) {
      createConsumableItem(this);
   });

   $('#consumable-dashboard').on('click','input.btn.btn-block.btn-success.btn-flat.show-consumable-items', function(event) {
      showConsumableItems(this);
   });

   $('#consumable-dashboard').on('click', '#consumable-items-body tr', function () {
      var id = $.trim($(this).find("td:first").html());
      if ($.isNumeric(id)) {
         showConsumableItemsEditModal(id);
      } 
   });


   //ADDED BY CLYDE SEPT 20


      //LOAD TOASTR
   function loadtoaster(){
      toastr.options = {
      "closeButton": true,
      "timeOut": "5000",
      "positionClass": "toast-top-right"
      }
   }
   
   loadtoaster();



});