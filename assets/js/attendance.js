$(function () {
	
	getData()

	$("#slcYear").on("change", function () {
		window.location=`http://npi-appserver/itmanagement/attendance.cfm?year=${$(this).val()}`;
	})
})


function updateAttendance(year) {
	var modal = "#modalUpdateAttendance";

		$.post('com/attendance/modal_updateAttendance.cfm', {year:year} ,  function(data) {
				$(modal).html(data)
			 	$(modal).modal("show");
	});

}

function getData() {
	var year = $("#slcYear").val();

	var div = "#div-attendance";
	var data = {
		year: year
	}
		$.get('com/attendance/get_attendance.cfm', data, function(data) {
				setTimeout(function () {
					$(div).html(data);			
					$("#loadingSpinner").hide();		
				} , 500)
	})
}


var getUrlParam = function getUrlParam(sParam) {
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