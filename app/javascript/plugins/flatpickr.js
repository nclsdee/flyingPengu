import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import moment from "moment"
require("flatpickr/dist/themes/airbnb.css");

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
    locale: {
        firstDayOfWeek: 1
    },
    showAlways: false,
    theme: 'airbnb',
    altInput: true,
    altFormat: 'F j, Y',
    dateFormat: 'd/m/Y',
    weekNumbers: false,
    maxDate: $('#end_date' + i).attr('value'),
    onClose: function(selectedDates, dateStr, instance) {
      var newDate = new Date(dateStr);
      var finalDayMoment = moment(dateStr, "DD-MM-YYYY");
      var finalDay = moment(finalDayMoment).toDate();
      endpicker.set('minDate', finalDay);

      if (i === 0) {
        $(".js-date-from").val(dateStr);
      }

    },
  });

  let endpicker = flatpickr('#end_date' + i, {
    showAlways: false,
    locale: {
        firstDayOfWeek: 1
    },
    theme: 'airbnb',
    altInput: true,
    altFormat: 'F j, Y',
    dateFormat: 'd/m/Y',
    weekNumbers: false,
    minDate: $('#start_date' + i).attr('value'),
    onClose: function(selectedDates, dateStr, instance) {
      startpicker.set('maxDate', dateStr);

      if (i === 0) {
        $(".js-date-to").val(dateStr);
      }
    },
  });

}


