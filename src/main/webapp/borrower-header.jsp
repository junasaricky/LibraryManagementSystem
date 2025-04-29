<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="header_section">
      <div class="header_bottom">
        <div class="container-fluid">
          <nav class="navbar navbar-expand-lg custom_nav-container ">
            <a class="navbar-brand">
              <img src="images/logo.png" alt="">
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class=""> </span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <div class="d-flex mr-auto flex-column flex-lg-row align-items-center">
                <ul class="navbar-nav">
                  <li class="nav-item">
                    <a class="nav-link" href="BorrowerHome">Home</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="BorrowerViewBooks">View Books</a>
                  </li>   
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="bookDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      My Records
                    </a>
                    <div class="dropdown-menu" aria-labelledby="bookDropdown">
                      <a class="dropdown-item" href="BorrowerRecordsStatus">My Borrowing Status</a>
                      <a class="dropdown-item" href="BorrowerHistory">Borrowing History</a>
                      <a class="dropdown-item" href="BorrowerRecordsProfile">Profile</a>
                    </div>
                  </li>   
                </ul>                
              </div>
              <div class="dropdown">
				  <button class="btn btn-transparent dropdown-toggle text-white" type="button" id="userMenu"
				    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="font-size: 1.2rem;">
				    Welcome, <%= session.getAttribute("fname") %> <%= session.getAttribute("lname") %>
				  </button>
				  <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userMenu">
				    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#changePasswordModal"
					   data-id="<%= session.getAttribute("user_id") %>">
					  <i class="fa fa-key mr-1"></i> Change Password
					</a>
				    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#changeEmailModal"
				       data-id="<%= session.getAttribute("user_id") %>" 
				       data-email="<%= session.getAttribute("email") %>">
				      <i class="fa fa-envelope mr-1"></i> Change Email
				    </a>
				    <div class="dropdown-divider"></div>
				    <a class="dropdown-item text-danger" href="Logout">
				      <i class="fa fa-sign-out mr-1"></i> Logout
				    </a>
			  	  </div>
			 </div>                    
            </div>
          </nav>
        </div>
    </div>
</header>
<script>
//offline-check.js
window.addEventListener('load', function () {
    if (!navigator.onLine) {
        sessionStorage.setItem('previousPage', window.location.href);
        window.location.href = 'connection-error.jsp';
    }
});
// listen if the user goes offline while browsing
window.addEventListener('offline', function () {
    sessionStorage.setItem('previousPage', window.location.href);
    window.location.href = 'connection-error.jsp';
});
</script>
<script src="js/offline-check.js"></script>