
// Initialize date and time form inputs for use with Pickadate
// http://amsul.ca/pickadate.js/
$('#calendar_event_starts_at_date').pickadate({format: 'yyyy/mm/dd'});
$('#calendar_event_starts_at_time').pickatime({format: 'h:i A'});
$('#calendar_event_ends_at_date').pickadate({format: 'yyyy/mm/dd'});
$('#calendar_event_ends_at_time').pickatime({format: 'h:i A'});

// Initialize a calendar and render on the page using FullCalendar
// http://fullcalendar.io/
$('#calendar').fullCalendar({
  defaultView: 'agendaWeek',
  dayClick: function(date, jsEvent, view) {

    // Set the start date and time of the Calendar Event form based on where on the
    // calendar the user clicked
    $('#calendar_event_starts_at_date').pickadate('picker').set('select', date.toDate());
    $('#calendar_event_starts_at_time').pickatime('picker').set('select', date.format("hh:mm a"));

    // Set the start date and time of the Calendar Event form based on where on the
    // calendar the user clicked, plus one hour
    $('#calendar_event_ends_at_date').pickadate('picker').set('select', date.toDate());
    $('#calendar_event_ends_at_time').pickatime('picker').set('select', date.add(1, 'hours').format("hh:mm a"));

    // Display the modal containing the CalendarEvent form
    $("#modal").click();

  },
  events: function(start, end, timezone, callback) {
    // Load Calendar Events from a JSON endpoint
    $.ajax({
      url: '/calendar_events',
      dataType: 'json',
      data: {
          start: start.format(),
          end: end.format()
      },
      success: function(json) {
          var events = [];
          $(json).each(function() {
              events.push({
                  title: 'calendar_event',
                  start: $(this).attr('starts_at'),
                  end: $(this).attr('ends_at')
              });
          });
          callback(events);
      }
    });
  }
})

$('#new_calendar_event').on('ajax:error', function(e, data, status, xhr){

  $(event.data).render_form_errors( 'calendar_event', data.responseJSON );

});

$('#new_calendar_event').on('ajax:success', function(e, data, status, xhr){

  $(event.data).modal_success( data );

});

$.fn.modal_success = function(event){
  // close modal
  $("#modal").click();

  // clear error state
  this.clear_previous_errors();

  $('#calendar').fullCalendar( 'renderEvent', { title: 'calendar_event', start: event["starts_at"], end: event["ends_at"]});
};

$.fn.render_form_errors = function(model, errors){

  this.clear_previous_errors();

  $.each(errors, function(field, messages){

    $('.' + model + '_' + field).addClass('field_with_errors');
    $('.' + model + '_' + field).append("<span class='error'>" + messages.join(' & ') + "</span>");
      
  });

};

$.fn.clear_previous_errors = function(){
  $('.form-group.field_with_errors', this).each(function(){
    $('.help-block', $(this)).html('');
    $(this).removeClass('field_with_errors');
  });
}
