// to get current year
function getYear() {
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    document.querySelector("#displayYear").innerHTML = currentYear;
}

getYear();

// nice select
$(document).ready(function () {
    $('select').niceSelect();
});

// date picker
$(function () {
    $("#inputDate").datepicker({
        autoclose: true,
        todayHighlight: true
    }).datepicker('update', new Date());
});

// owl carousel slider js
$('.team_carousel').owlCarousel({
    loop: true,
    margin: 15,
    dots: true,
    autoplay: true,
    navText: [
        '<i class="fa fa-angle-left" aria-hidden="true"></i>',
        '<i class="fa fa-angle-right" aria-hidden="true"></i>'
    ],
    autoplayHoverPause: true,
    responsive: {
        0: {
            items: 1,
            margin: 0
        },
        576: {
            items: 2,
        },
        992: {
            items: 3
        }
    }
});

// Disabled pervious date
document.addEventListener("DOMContentLoaded", function () {
    var today = new Date().toISOString().split('T')[0];
    var dateInput = document.getElementById("dateInput");
    if (dateInput) {
      dateInput.setAttribute("min", today);
    }
});
  
// Edit Modal
  $(document).ready(function () {
    $('#saveChangesBtn').on('click', function () {
      // Do save logic here (e.g., send data to server)
      
      // Then close the modal
      $('#editModal').modal('hide');
    });
  })

