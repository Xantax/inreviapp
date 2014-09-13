var ready;
ready = function() {
  
  jQuery(function() {
    var completer;

    completer = new GmapsCompleter({
      inputField: '#gmaps-input-address',
      errorField: '#gmaps-error'
    });

    completer.autoCompleteInit({
      country: "us"
    });
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);      