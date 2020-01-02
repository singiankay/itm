$(function(){
	getData()

	$("#slcYear").on("change", function () {
		$("#loadingSpinner").show()
		getData()
		// window.location = `http://npi-appserver/itmanagement/sched_graph.cfm?year=${$(this).val()}`
	})

})

function getData() {
	var year = $("#slcYear").val();

	var div = "#div_sched_summary";
	var data = {
		year: year
	}
		$.get('com/schedules/get_sched_summary.cfm', data, function(data) {
				setTimeout(function () {
					$(div).html(data);			
					$("#loadingSpinner").hide();		
				} , 500)
	})
}