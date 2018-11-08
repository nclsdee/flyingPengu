import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!

// flatpickr(".datepicker", {});



// let startpicker = flatpickr('#trip_hometowns_date_from', {
//     minDate: 'today',
//     showAlways: false,
//     theme: 'airbnb',
//     altInput: true,
//     altFormat: 'F j, Y',
//     dateFormat: 'Z',
//     weekNumbers: true,
//     maxDate: $('#trip_hometowns_date_to').attr('value'),
//     onClose: function(selectedDates, dateStr, instance) {
//       var newDate = new Date(dateStr);
//       var finalDay = new Date();
//       finalDay.setDate(newDate.getDate() + 1);
//         endpicker.set('minDate', finalDay);
//     },
//   });



//   let endpicker = flatpickr('#trip_hometowns_date_to', {
//     showAlways: false,
//     theme: 'airbnb',
//     altInput: true,
//     altFormat: 'F j, Y',
//     dateFormat: 'Z',
//     weekNumbers: true,
//     minDate: $('#trip_hometowns_date_from').attr('value'),
//     onClose: function(selectedDates, dateStr, instance) {
//       startpicker.set('maxDate', dateStr);
//     },
//   });


for (let i = 0; i <= 15; i++) {

let startpicker = flatpickr('#start_date' + i, {
    minDate: 'today',
    showAlways: false,
    theme: 'airbnb',
    altInput: true,
    altFormat: 'F j, Y',
    dateFormat: 'Z',
    weekNumbers: true,
    maxDate: $('#end_date' + i).attr('value'),
    onClose: function(selectedDates, dateStr, instance) {
      var newDate = new Date(dateStr);
      var finalDay = new Date();
      finalDay.setDate(newDate.getDate());
      endpicker.set('minDate', finalDay);
    },
  });

  let endpicker = flatpickr('#end_date' + i, {
    showAlways: false,
    theme: 'airbnb',
    altInput: true,
    altFormat: 'F j, Y',
    dateFormat: 'Z',
    weekNumbers: true,
    minDate: $('#start_date' + i).attr('value'),
    onClose: function(selectedDates, dateStr, instance) {
      startpicker.set('maxDate', dateStr);
    },
  });

}
