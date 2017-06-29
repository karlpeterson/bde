"use strict";

function parseDate(s) {
  var b = s.split("-");
  return new Date(b[0], --b[1], b[2]).getTime();
}
function addDays(date, days) {
  var result = new Date(date);
  result.setDate(result.getDate() + days);
  return result;
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

  // Hide 'Edit' after two weeks
  var last_day = $('#datapoint_list tbody tr:last-child').data('date');
  last_day = parseDate(last_day);
  last_day = addDays(last_day,14);
  if (today.valueOf() >= last_day.valueOf()) {
    $('#datapoint_list .edit').each(function(){
      $(this).hide();
    });
  }
  
});