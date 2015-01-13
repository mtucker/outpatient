
$('#calendar').fullCalendar({
  defaultView: 'agendaWeek',
  dayClick: function(date, jsEvent, view) {

    $('#calendar_event_starts_at_date').pickadate('picker').set('select', date.toDate());
    $('#calendar_event_starts_at_time').pickatime('picker').set('select', date.format("hh:mm a"));

    $('#calendar_event_ends_at_date').pickadate('picker').set('select', date.toDate());
    $('#calendar_event_ends_at_time').pickatime('picker').set('select', date.add(1, 'hours').format("hh:mm a"));

    $("#modal").click();

  },
  events: function(start, end, timezone, callback) {
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

$('#calendar_event_starts_at_date').pickadate({format: 'yyyy/mm/dd'});
$('#calendar_event_starts_at_time').pickatime({format: 'h:i A'});
$('#calendar_event_ends_at_date').pickadate({format: 'yyyy/mm/dd'});
$('#calendar_event_ends_at_time').pickatime({format: 'h:i A'});

$(document).bind('ajaxError', 'form#new_calendar_event', function(event, jqxhr, settings, exception){

  // note: jqxhr.responseJSON undefined, parsing responseText instead
  $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

});

$('#new_calendar_event').on('ajax:success', function(e, data, status, xhr){

  // note: jqxhr.responseJSON undefined, parsing responseText instead
  $(event.data).modal_success( data );

});

$.fn.modal_success = function(event){
  // close modal
  $("#modal").click();

  // clear error state
  this.clear_previous_errors();

  $('#calendar').fullCalendar( 'renderEvent', { title: 'calendar_event', start: event["starts_at"], end: event["ends_at"]});
};

$.fn.render_form_errors = function(errors){

  this.clear_previous_errors();
  model = this.data('model');

  // show error messages in input form-group help-block
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
