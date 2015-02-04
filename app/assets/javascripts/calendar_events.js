// Initialize a calendar and render on the page using FullCalendar
// http://fullcalendar.io/
$('#calendar').fullCalendar({
  defaultView: 'agendaWeek',
  timezone: 'local',
  allDaySlot: false,
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
                  id: $(this).attr('id'),
                  title: $(this).attr('title'),
                  start: $(this).attr('starts_at'),
                  end: $(this).attr('ends_at'),
                  type: $(this).attr('type')
              });
          });
          callback(events);
      }
    });
  },
  eventRender: function(event, element) {
    element.attr('data-starts-at', new moment(event.start).format());
    element.attr('data-ends-at', new moment(event.end).format());
  },
  eventClick: function(calEvent, jsEvent, view) {

    window.location = '/calendar_events/' + calEvent.id + '/edit';
    
  }
  
});


