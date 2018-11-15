import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import moment from "moment"
require("flatpickr/dist/themes/airbnb.css");

$(document).ready(function() {
  let dateCacheEnd = {};

  $(".js-date-to").each(function(index, element) {
    dateCacheEnd[index] = flatpickr(element, {
      minDate: "today",
      showAlways: false,
      disableMobile: true,
      locale: {
          firstDayOfWeek: 1
      },
      theme: 'airbnb',
      dateFormat: 'd/m/Y',
      weekNumbers: false,
      onClose: function(selectedDates, dateStr, instance) {
        if (index === 0) {
          $(".js-date-to").val(dateStr);
        }
      },
    });
  });

  $(".js-date-from").each(function(index, element) {
    flatpickr(element, {
      minDate: 'today',
      locale: {
          firstDayOfWeek: 1
      },
      showAlways: false,
      disableMobile: true,
      theme: 'airbnb',
      dateFormat: 'd/m/Y',
      weekNumbers: false,
      onClose: function(selectedDates, dateStr, instance) {
        var finalDayMoment = moment(dateStr, "DD/MM/YYYY");
        var endpicker = dateCacheEnd[index];

        endpicker.set('minDate', finalDayMoment.toDate());

        if (index === 0) {
          $(".js-date-from").val(dateStr);
        }
      },
    });
  });
});



