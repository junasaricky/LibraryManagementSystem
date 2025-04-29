<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<section class="info_section">
  <div class="container">
    <div class="info_bottom layout_padding2">
      <div class="row info_main_row">
        <div class="col-md-6 col-lg-3">
          <h5>Address</h5>
          <div class="info_contact">
            <a href="#" data-bs-toggle="modal" data-bs-target="#locationModal">
    			<i class="fas fa-map-marker" aria-hidden="true"></i>
    			<span>Location</span>
			</a>
            <a href=""><i class="fas fa-phone" aria-hidden="true"></i><span>Call +63 9609249583</span></a>
            <a href=""><i class="fas fa-envelope"></i><span>junasa.ricky@gmail.com</span></a>
          </div>
          <div class="social_box">
            <a href=""><i class="fab fa-facebook" aria-hidden="true"></i></a>
            <a href=""><i class="fab fa-twitter" aria-hidden="true"></i></a>
            <a href=""><i class="fab fa-linkedin" aria-hidden="true"></i></a>
            <a href=""><i class="fab fa-instagram" aria-hidden="true"></i></a>
          </div>
        </div>

        <div class="col-md-6 col-lg-3">
          <div class="info_links">
            <h5>Useful link</h5>
            <div class="info_links_menu">
              <a class="${currentPage == 'BorrowerHome' ? 'active' : ''}" href="BorrowerHome">Home</a>
              <a class="${currentPage == 'BorrowerViewBooks' ? 'active' : ''}" href="BorrowerViewBooks">View Books</a>
              <a class="${currentPage == 'BorrowerRecordsStatus' ? 'active' : ''}" href="BorrowerRecordsStatus">My Borrowing Status</a>
              <a class="${currentPage == 'BorrowerHistory' ? 'active' : ''}" href="BorrowerHistory">My Borrowing History</a>
              <a class="${currentPage == 'BorrowerRecordsProfile' ? 'active' : ''}" href="BorrowerRecordsProfile">Profile</a>
            </div>
          </div>
        </div>

        <div class="col-md-6 col-lg-3">
          <div class="info_post">
            <h5>OPENING HOURS</h5>
            <p>Mon - Fri: 8:00 AM - 6:00 PM</p>
            <p>Sat: 9:00 AM - 1:00 PM</p>
            <p>Sun: Closed</p>
          </div>
        </div>

        <div class="col-md-6 col-lg-3">
          <div class="info_post">
            <h5>DEVELOPER</h5>
            <p>Created by Ricky Junasa</p>
            <p>For educational purposes</p>
            <p>Follow me on GitHub</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- Location Modal -->
<div class="modal fade" id="locationModal" tabindex="-1" role="dialog" aria-labelledby="locationModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="locationModalLabel">Library Location</h5>
        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body text-center">
        <p class="mb-3">Location is not yet available. Coming Soon!</p>
        <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png" alt="Coming Soon" style="width:100px;">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Okay</button>
      </div>
    </div>
  </div>
</div>