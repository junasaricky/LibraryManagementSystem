<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.junasa.DAO.User_Dao" %>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic -->
  	<meta charset="utf-8" />
  	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
  	<!-- Mobile Metas -->
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  	<!-- Site Metas -->
  	<meta name="keywords" content="" />
  	<meta name="description" content="" />
  	<meta name="author" content="" />
  	<title>Library Management System</title>
  	<!-- Bootstrap 5 CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
	<!-- Bootstrap 5 JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  	<!-- bootstrap core css -->
  	<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  	<!-- fonts style -->
  	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap" rel="stylesheet">
  	<!--owl slider stylesheet -->
  	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  	<!-- font awesome style -->
  	<!-- <link href="css/font-awesome.min.css" rel="stylesheet" /> -->
  	<!-- Font Awesome CDN -->
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />
  	<!-- Code for Phone Number -->
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css"/>
  	<!-- nice select -->
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
  	<!-- datepicker -->
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css">
  	<!-- Custom styles for this template -->
  	<link href="css/style.css" rel="stylesheet" />
  	<!-- responsive style -->
  	<link href="css/responsive.css" rel="stylesheet" />
  	<style>
		.img-box img {
	  		height: 400px;
	  		width: 125%;
	  		object-fit: cover;
	  		border-radius: 10px;
		}
		.box {
	  		height: 100%;
	  		padding: 15px;
	  		box-shadow: 0 0 10px #ccc;
	  		border-radius: 10px;
	  		background: #fff;
		}
    	.card-text-limit {
 	 		white-space: nowrap;
  	 		overflow: hidden;
 	 		text-overflow: ellipsis;
		}
		.signup-box {
  			background: #fff;
  			padding: 30px;
  			border-radius: 10px;
		}
  	</style>
</head>
<body>
	<input type="hidden" id="registrationStatus" value="<%= request.getParameter("status") %>">
  	<div class="hero_area">
    	<!-- header section strats -->
    	<header class="header_section">
      		<div class="header_bottom">
        		<div class="container-fluid">
          			<nav class="navbar navbar-expand-lg custom_nav-container ">
            			<a class="navbar-brand" href="homepage.html">
              				<img src="images/logo.png" alt="">
            			</a>
            			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              				<span class=""> </span>
            			</button>
            			<div class="collapse navbar-collapse" id="navbarSupportedContent">
              				<div class="d-flex mr-auto flex-column flex-lg-row align-items-center"></div>
              					<div class="quote_btn-container">
                					<a href="login.jsp">
                  						<i class="fa fa-user" aria-hidden="true"></i>
                  						<span>Login</span>
				                	</a>
				                	<a href="registration.jsp">
				                  		<i class="fa fa-user" aria-hidden="true"></i>
				                  		<span>Sign Up</span>
				                	</a>
				              	</div>
				        </div>
				    </nav>
				</div>
			</div>
		</header>
    	<!-- end header section -->
  		<!-- registration section -->
  		<section class="book_section layout_padding">
    		<div class="container">
      			<div class="row justify-content-center">
        			<div class="col-lg-10">
        				<div class="signup-box">
				        	<form action="RegisterUser" method="post">
				            	<h4>
				              		<span>SIGN UP</span>
				            	</h4>
				            	<div class="form-row ">
				              		<div class="form-group col-lg-4">
				                		<label>First Name </label>
				                		<input type="text" class="form-control" name="fname" placeholder="" required>
				              		</div>
				              		<div class="form-group col-lg-4">
				                		<label>Last Name</label>
				                		<input type="text" class="form-control" name="lname" placeholder="" required>
				              		</div>
				              		<div class="form-group col-lg-4">
				                		<label>Email Address</label>
				                		<input type="email" class="form-control" name="email" placeholder="you@example.com" required>
				              		</div>
				              		<div class="form-group col-lg-4">
				  						<label for="inputPhone">Contact Number</label>
				 					 	<input type="text" class="form-control" id="contactNumber" name="cnumber" value="+63" maxlength="13" required>
									</div>
				              		<div class="form-group col-lg-4">
				                		<label>Username</label>
				                		<input type="text" class="form-control" name="username" placeholder="" required>
				              		</div>
				              		<div class="form-group col-lg-4">
				                		<label>Password</label>
				                		<input type="password" class="form-control" name="password" placeholder="" required>
				              		</div>
				            	</div>
				            	<div class="btn-box">
				              		<button type="submit" class="btn ">Sign Up</button>
				            	</div>
				          	</form>
				        </div>
				    </div>
				</div>
			</div>
		</section>
  		<!-- end registration section -->
  		<section class="team_section layout_padding">
    		<div class="container">
      			<div class="heading_container heading_center">
		        	<h2>
		          		<span>Books</span>
		        	</h2>
		      	</div>
		      	<div class="carousel-wrap ">
		        	<div class="owl-carousel team_carousel">
				        <%
					  		User_Dao dao = new User_Dao();
					    	ResultSet rs = dao.getBookData();
					    	while(rs.next()){
					 	%>
				    	<div class="item">
				        	<div class="box">
				            	<div class="img-box">
				                	<img src="images/<%= rs.getString("image") %>" onerror="this.onerror=null; this.src='images/default-book.jpg';" alt="" />
				              	</div>
				              	<div class="detail-box text-center">
									<h5><%= rs.getString("title") %></h5>
								  	<h6><%= rs.getString("author") %></h6>
								  	<%
								  		String publisher = rs.getString("publisher");
								  		String displayPublisher = publisher.length() > 15 ? publisher.substring(0, 15) + "..." : publisher;
								  	%>
								  	<p title="<%= publisher %>">
								  		<strong>Publisher:</strong> <%= displayPublisher %>
								  	</p>
								  	<p>
										<strong>Genre:</strong>
									  	<%= rs.getString("genre") %>
								  	</p>
								  	<%
							      		String statusText = rs.getString("available_quantity").equals("0") ? "Not Available" : "Available";
							      		String statusColor = statusText.equals("Not Available") ? "red" : "green";
								  	%>
									<p>
										<strong>Status:</strong>
									  	<span style="color:<%= statusColor %>"><%= statusText %></span>
									</p>
							  	</div>
				            </div>
				        </div>
				          <%
				  		  	}
				  		  %>
		        	</div>
		      	</div>
		    </div>
		</section>
  		<!-- end team section -->
  		<!-- info section -->
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
				              	<a href="">
				                	<i class="fa fa-phone" aria-hidden="true"></i>
				                	<span>Call +63 9609249583</span>
				              	</a>
				              	<a href="">
				                	<i class="fa fa-envelope"></i>
				                	<span>junasa.ricky@gmail.com</span>
				             	</a>
				            </div>
				            <div class="social_box">
								<a href="">
							    	<i class="fab fa-facebook"></i>
							  	</a>
							  	<a href="">
							    	<i class="fab fa-twitter"></i>
							  	</a>
							  	<a href="">
							    	<i class="fab fa-linkedin"></i>
							  	</a>
							  	<a href="">
							    	<i class="fab fa-instagram"></i>
							  	</a>
							</div>
				        </div>
				        	<div class="col-md-6 col-lg-3">
				            	<div class="info_links">
				              		<h5>Useful link</h5>
				              		<div class="info_links_menu">
				                		<a href="login.jsp">
				                  			Login
				                		</a>
				                		<a class="active" href="registration.jsp">
				                  			Sign Up
				                		</a>
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
  		<!-- end info_section -->
  		<!-- footer section -->
  		<jsp:include page="footer.jsp" />
  		<!-- footer section -->
	  	<!-- jQery -->
	  	<script src="js/jquery-3.4.1.min.js"></script>
	  	<!-- bootstrap js -->
	  	<script src="js/bootstrap.js"></script>
	  	<!-- nice select -->
	  	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
	  	<!-- owl slider -->
	  	<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
	  	<!-- datepicker -->
	  	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
	  	<!-- custom js -->
	  	<script src="js/custom.js"></script>
	  	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script type="text/javascript">
	  		var registrationStatus = document.getElementById("registrationStatus").value;
	
	  		if (registrationStatus === "taken") {
	    		swal("Oops!", "Username or email already exists!", "warning");
	  		} else if (registrationStatus === "failed") {
	    		swal("Error", "Registration failed. Please try again.", "error");
	  		}
		</script>
		<script>
	  		const contactInput = document.getElementById("contactNumber");
	
	  		contactInput.addEventListener("input", function () {
	    		// Keep only digits after "+63"
	    		if (!this.value.startsWith("+63")) {
	      			this.value = "+63";
	   	 		}
	    		const digits = this.value.slice(3).replace(/\D/g, "");
	    		this.value = "+63" + digits;
	  		});
		</script>
		<script>
			window.addEventListener('load', function () {
			    if (!navigator.onLine) {
			        sessionStorage.setItem('previousPage', window.location.href);
			        window.location.href = 'connection-error.jsp';
			    }
			});
			window.addEventListener('offline', function () {
			    sessionStorage.setItem('previousPage', window.location.href);
			    window.location.href = 'connection-error.jsp';
			});
		</script>
		<script src="js/offline-check.js"></script>
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
</body>
</html>