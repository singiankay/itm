$(function(){

getTargetChart()

})



function getTargetChart() {
	// body...

	var year = $("#slcYear").val();

	var div = "#div_graph";
	var data = {
		year: year
	}
		$.get('com/schedules/get_graph.cfm', data, function(data) {
				setTimeout(function () {
					$(div).html(data);			
					    $("#loadingSpinner").hide();		
				} , 1)
	})


}


$("#slcYear").on("change", function () {
	// getTargetChart()
			window.location = `http://npi-appserver/itmanagement/sched_graph.cfm?year=${$(this).val()}`
})