"use strict";

function parseDate(s) {
  var b = s.split("-");
  return new Date(b[0], --b[1], b[2]).getTime();
}

$(document).on('turbolinks:load', function() {
	// Responsive Nav
  var mainNav = responsiveNav("#main-nav", {
    customToggle: "navToggle"
  });

  var today = new Date();
	today.setHours(0,0,0,0);

	// Highlight current day on Dashboard
  $('#datapoint_list tbody tr').each(function(){
  	var list_date = $(this).data('date');
  	list_date = parseDate(list_date);

  	if (list_date.valueOf() === today.valueOf()) {
  		$(this).addClass('today');
  	}

  });
  
});