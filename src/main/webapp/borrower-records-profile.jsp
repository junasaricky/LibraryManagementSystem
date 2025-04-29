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
  	<!-- nice select -->
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
  	<!-- datepicker -->
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css">
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  	<!-- datatable-->
  	<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
  	<!-- Custom styles for this template -->
  	<link href="css/style.css" rel="stylesheet" />
  	<!-- Font Awesome CDN -->
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" /> 
  	<!-- responsive style -->
  	<link href="css/responsive.css" rel="stylesheet" />
  	<style>
    	.dashboard-box {
    		background: #f8f9fa;
		    padding: 30px;
		    border-radius: 15px;
		    margin: 10px;
		    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
		    transition: 0.3s ease-in-out;
    	}
    	.dashboard-box:hover {
    		transform: translateY(-5px);
    		box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    	}
    	@media (max-width: 991.98px) {
    		.dropdown-menu[aria-labelledby="userMenu"] {
      			left: 50% !important;
		      	transform: translateX(-50%) !important;
		      	right: auto !important;
		      	text-align: center;
    		}
    		.navbar-collapse .dropdown {
		      	width: 100%;
		      	text-align: left;
		      	margin-top: 10px;
		      	padding-left: 15px;
    		}
    		.navbar-collapse .dropdown .dropdown-toggle {
      			display: inline-block;
      			width: 100%;
    		}
    		.dropdown-menu .dropdown-item {
    			width: fit-content;
			    margin-left: auto;
			    margin-right: auto;
			    text-align: center;
  			}
  		}
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
		/* Hover effect for table rows */
		#statusTable tbody tr:hover {
	  		background-color: #dcdcdc; /* Light grey background on hover */
	  		transition: background-color 0.3s ease;
		}
		.swal-text {
  			text-align: center;
		}
	</style>
</head>
<body>
	<%
    	String status = request.getParameter("status");
  	%>
	<input type="hidden" id="updatedstatus" value="<%= status %>">
  	<div class="hero_area">
    	<jsp:include page="borrower-header.jsp" />
		<section class="book_section layout_padding">
        	<div class="container">
          		<div class="mb-3">
            		<p class="text-muted" style="margin: 0;">My Records  &gt; <strong>Profile</strong></p>
          		</div>
          		<div class="table-responsive">
		          	<table id="statusTable" class="table table-bordered table-striped">
		            	<thead class="thead-light">
		                	<tr>
		                  		<th>#</th>
			                  	<th>Name</th>
			                  	<th>Email</th>
			                  	<th>Contact No.</th>
			                  	<th>Username</th>
			                  	<th>Password</th>
			                  	<th>Role</th>
			                  	<th>Action</th>
		                	</tr>
		              	</thead>
		              	<tbody>
		              		<%
		            			User_Dao dao = new User_Dao();
					            String username = (String) session.getAttribute("username");
					            ResultSet rs = dao.getBorrowerData(username);
					            int count = 0;
					            while(rs != null && rs.next()){
		          			%>
		                	<tr>
		                		<td><%= count = count+1 %></td>
		                		<td><%= rs.getString("fname") %> <%= rs.getString("lname") %></td>
		                			<%
										String email = rs.getString("email");
										String masked = "";
										if (email != null && email.contains("@")) {
						    				String[] parts = email.split("@");
						    				if (parts.length == 2 && parts[0].length() >= 3) {
						        				masked = parts[0].substring(0, 3) + "***@" + parts[1];
						    				} else {
						        				masked = email; // fallback if too short or malformed
						    				}
										} else {
						    				masked = "Invalid email";
										}
									%>
								<td><%= masked %></td>
				                <td><%= rs.getString("cnumber") %></td>
				                <td><%= rs.getString("username") %></td>
				                <td><%= rs.getString("password").replaceAll(".", "*") %></td>
				                <td><%= rs.getString("role") %></td>
				                <td class="text-center">
				                	<button 
				                  		class="btn btn-primary btn-sm" 
				                  		data-toggle="modal" 
				                  		data-target="#editModal"
				                  		data-id="<%= rs.getInt("user_id") %>"
				                  		data-fname="<%= rs.getString("fname") %>"
							          	data-lname="<%= rs.getString("lname") %>"
							          	data-email="<%= rs.getString("email") %>"
							          	data-cnumber="<%= rs.getString("cnumber") %>">
				                  		<i class="fa fa-pencil"></i> Edit
				                  	</button>
				                </td>
				             </tr>
				              <%
							    }
				              %>
		              	</tbody>
		            </table>
				</div>
        	</div>
		</section>
      	<div id="imgOverlay" class="img-overlay">
			<img id="overlayImage" src="" />
	  	</div>
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
        					ResultSet rs2 = dao.getAvailableBooks();
	    					while(rs2.next()){
	 					%>
			        	<div class="item">
			            	<div class="box">
			              		<div class="img-box">
			                		<img src="images/<%= rs2.getString("image") %>" onerror="this.onerror=null; this.src='images/default-book.jpg';" alt="" />
			              		</div>
			              		<div class="detail-box text-center">
							  		<h5><%= rs2.getString("title") %></h5>
							  		<h6><%= rs2.getString("author") %></h6>
							  		<%
							  			String publisher = rs2.getString("publisher");
							  			String displayPublisher = publisher.length() > 15 ? publisher.substring(0, 15) + "..." : publisher;
							  		%>
							  		<p title="<%= publisher %>">
							  			<strong>Publisher:</strong> <%= displayPublisher %>
							  		</p>
							  		<p>
								  		<strong>Genre:</strong>
								  		<%= rs2.getString("genre") %>
							  		</p>
							  		<%
						      			String statusText = rs2.getString("available_quantity").equals("0") ? "Not Available" : "Available";
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
  		<%
			request.setAttribute("currentPage", "BorrowerRecordsProfile");
		%>
		<jsp:include page="borrower-info-section.jsp" /> 
  		<jsp:include page="footer.jsp" />
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
		<!-- Edit Modal -->
	  	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
	    	<div class="modal-dialog" role="document">
	      		<div class="modal-content">
	        		<div class="modal-header">
	          			<h5 class="modal-title" id="editModalLabel">Edit Information</h5>
	          			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	            			<span aria-hidden="true">&times;</span>
	          			</button>
	        		</div>
	        		<form action="UpdateBorrowerInfo" method="post">
		        		<div class="modal-body">
		          			<!-- Form content here -->
		            		<input type="hidden" id="userId" name="userId">
		          			<div class="form-group">
				             	<label for="userFname">First Name</label>
				              	<input type="text" class="form-control" id="userFname" name="fname">
		            		</div>
		          			<div class="form-group">
		              			<label for="userLname">Last Name</label>
		              			<input type="text" class="form-control" id="userLname" name="lname">
		            		</div> 
		            		<div class="form-group">
		              			<label for="userNumber">Contact Number</label>
		              			<input type="text" class="form-control" id="userNumber" maxlength="13" name="number">
		            		</div>
		        			<div class="modal-footer">
		          				<button type="submit" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
		          				<button type="submit" class="btn btn-primary" id="saveChangesBtn">Save Changes</button>
		        			</div>
		        		</div>
	        		</form>
	      		</div>
	    	</div>
	  	</div>
	  	<!-- Change Password Modal -->
		<div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
	  		<div class="modal-dialog" role="document">
	    		<form action="ChangePasswordServlet" method="post">
	      			<input type="hidden" name="source" value="BorrowerRecordsProfile">
			      	<div class="modal-content">
			        	<div class="modal-header">
			          		<h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
			          		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			            		<span aria-hidden="true">&times;</span>
			          		</button>
			        	</div>
			        	<div class="modal-body">
			          		<input type="hidden" name="userId" id="modalPasswordUserId">
			          		<div class="form-group">
			            		<label for="currentPassword">Current Password</label>
			            		<input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
			          		</div>
			          		<div class="form-group">
						  		<label for="newPassword">New Password</label>
						  		<input type="password" class="form-control" id="newPassword" name="newPassword" required>
					  		</div>
					  		<div class="form-group">
						  		<label for="confirmPassword">Confirm New Password</label>
						  		<input type="password" class="form-control" id="confirmPassword" required>
						  		<small id="matchMessage" class="form-text text-danger">Passwords do not match.</small>
					  		</div>
					  		<ul class="pl-3 mb-0" style="list-style-type: circle;">
					  			<li id="pw-uppercase" class="text-danger">At least one uppercase letter</li>
							  	<li id="pw-lowercase" class="text-danger">At least one lowercase letter</li>
							  	<li id="pw-number" class="text-danger">At least one number</li>
							  	<li id="pw-length" class="text-danger">Minimum 6 characters</li>
					  		</ul>
			        	</div>
			        	<div class="modal-footer">
			  				<button type="submit" class="btn btn-primary" id="updatePasswordBtn" disabled>Update Password</button>
						</div>
			      	</div>
			    </form>
			</div>
		</div>
	  	<!-- Change Email Modal -->
		<div class="modal fade" id="changeEmailModal" tabindex="-1" role="dialog" aria-labelledby="changeEmailModalLabel" aria-hidden="true">
	  		<div class="modal-dialog" role="document">
	    		<form action="ChangeEmailServlet" method="post">
	      			<input type="hidden" name="source" value="BorrowerRecordsProfile">
	      			<div class="modal-content">
	        			<div class="modal-header">
	          				<h5 class="modal-title" id="changeEmailModalLabel">Change Email Address</h5>
			          		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			            		<span aria-hidden="true">&times;</span>
			          		</button>
			        	</div>
			        	<div class="modal-body">
			          		<input type="hidden" name="userId" id="modalUserId">
			          		<div class="form-group">
			            		<label for="newEmail">New Email Address</label>
			            		<input type="email" class="form-control" id="newEmail" name="newEmail" required>
			          		</div>
			        	</div>
			        	<div class="modal-footer">
			          		<button type="submit" class="btn btn-primary">Update Email</button>
			        	</div>
			      	</div>
			    </form>
			</div>
		</div>
	</div>
<script>
	$('#editModal').on('show.bs.modal', function (event) {
    	var button = $(event.relatedTarget); // Button that triggered the modal
    	var userId = button.data('id');
    	var fname = button.data('fname');
    	var lname = button.data('lname');
    	var cnumber = button.data('cnumber');

    	var modal = $(this);
    	modal.find('#userId').val(userId);
    	modal.find('#userFname').val(fname);
    	modal.find('#userLname').val(lname);
    	modal.find('#userNumber').val(cnumber);
  	});
</script>
<script>
	$('#changePasswordModal').on('show.bs.modal', function (event) {
    	var button = $(event.relatedTarget);
    	var userId = button.data('id');

    	var modal = $(this);
    	modal.find('#modalPasswordUserId').val(userId);
  	});
</script>
<script>
	$('#changeEmailModal').on('show.bs.modal', function (event) {
    	var button = $(event.relatedTarget); 
    	var userId = button.data('id'); 
    	var email = button.data('email');
    
    	var modal = $(this);
    	modal.find('#modalUserId').val(userId);
    	modal.find('#newEmail').val(email);
  	});
</script>
<!-- Password validation -->
<script>
	const newPasswordInput = document.getElementById("newPassword");
  	const confirmPasswordInput = document.getElementById("confirmPassword");
  	const matchMessage = document.getElementById("matchMessage");
  	const updateBtn = document.getElementById("updatePasswordBtn");

  	const passwordRequirements = {
    	uppercase: document.getElementById("pw-uppercase"),
    	lowercase: document.getElementById("pw-lowercase"),
    	number: document.getElementById("pw-number"),
    	length: document.getElementById("pw-length")
  	};

  	function updateRequirement(element, isValid) {
    	if (isValid) {
      		element.classList.remove("text-danger");
     	 	element.classList.add("text-success");
    	} else {
      		element.classList.add("text-danger");
      		element.classList.remove("text-success");
    	}
  	}

  	function validatePasswords() {
    	const password = newPasswordInput.value;
    	const confirmPassword = confirmPasswordInput.value;

    	const hasUppercase = /[A-Z]/.test(password);
    	const hasLowercase = /[a-z]/.test(password);
    	const hasNumber = /[0-9]/.test(password);
    	const hasMinLength = password.length >= 6;
    	const passwordsMatch = password === confirmPassword && confirmPassword.length > 0;

	    updateRequirement(passwordRequirements.uppercase, hasUppercase);
	    updateRequirement(passwordRequirements.lowercase, hasLowercase);
	    updateRequirement(passwordRequirements.number, hasNumber);
	    updateRequirement(passwordRequirements.length, hasMinLength);

    	if (passwordsMatch) {
      		matchMessage.textContent = "Passwords match.";
	      	matchMessage.classList.remove("text-danger");
	      	matchMessage.classList.add("text-success");
    	} else {
      		matchMessage.textContent = "Passwords do not match.";
      		matchMessage.classList.add("text-danger");
      		matchMessage.classList.remove("text-success");
    	}
    	// Enable button only if all are valid
    	if (hasUppercase && hasLowercase && hasNumber && hasMinLength && passwordsMatch) {
      		updateBtn.disabled = false;
    	} else {
      		updateBtn.disabled = true;
    	}
  	}
  	newPasswordInput.addEventListener("input", validatePasswords);
  	confirmPasswordInput.addEventListener("input", validatePasswords);
</script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(document).ready(function () {
    	const status = $("#updatedstatus").val();

    	if (status === "updated") {
      		swal("Success!", "Profile updated successfully.\nChanges will take effect on your next login.", "success").then(() => {
        	// Remove ?status=success from URL without reloading the page
        		window.history.replaceState(null, null, window.location.pathname);
      		});
    	} else if (status === "failed") {
      		swal("Error!", "Failed to update your details.", "error").then(() => {
        		window.history.replaceState(null, null, window.location.pathname);
      		});
    	}
  	});
</script>
<script>
	const contactInput = document.getElementById("userNumber");

  	contactInput.addEventListener("input", function () {
	    // Keep only digits after "+63"
	    if (!this.value.startsWith("+63")) {
	    	this.value = "+63";
	    }
	    const digits = this.value.slice(3).replace(/\D/g, "");
	    this.value = "+63" + digits;
  	});
</script>
</body>
</html>