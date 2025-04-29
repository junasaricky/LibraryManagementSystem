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
  	<!-- datatable-->
  	<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
  	<!-- Custom styles for this template -->
  	<link href="css/style.css" rel="stylesheet" />
  	<!-- Font Awesome CDN -->
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" /> 
  	<!-- responsive style -->
  	<link href="css/responsive.css" rel="stylesheet" />
	<style>
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
		/* Afte user click the image */
		.img-overlay {
		    display: none;
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100vw;
		    height: 100vh;
		    background-color: rgba(0, 0, 0, 0.8); /* dark overlay background */
		    justify-content: center;
		    align-items: center;
		    z-index: 9999;
		}
		.img-overlay img {
		    max-width: 90%;
		    max-height: 90%;
		    object-fit: contain;
		    border-radius: 10px;
		    box-shadow: 0 0 20px rgba(255,255,255,0.5);
		}
		.book-img {
			width: 100px;
		  	height: 100px;
		  	object-fit: cover;
		  	border-radius: 4px;
		}
		/* Hover effect for table rows */
		#statusTable tbody tr:hover {
			background-color: #dcdcdc; /* Light grey background on hover */
		  	transition: background-color 0.3s ease;
		}
	</style>
</head>
<body>
	<%
    String status = request.getParameter("status");
  	%>
	<input type="hidden" id="updatestatus" value="<%= status %>">
	<input type="hidden" id="deletedstatus" value="<%= status %>">
	<input type="hidden" id="addedstatus" value="<%= status %>">
  
  	<div class="hero_area">
    	<jsp:include page="admin-header.jsp" />
    	<!-- book section -->
    	<section class="book_section layout_padding">
      		<div class="container">
        		<!-- Breadcrumb / Path -->
		        <div class="mb-3">
		        	<p class="text-muted" style="margin: 0;">Book Management &gt; <strong>View Books</strong></p>
		        </div>
		        <!-- Add Book Button -->
				<div class="d-flex justify-content-end mb-3">
					<a href="AddBookForm" class="btn btn-success">
				    	<i class="fas fa-plus"></i> Add Book
				  	</a>
				</div>
        		<div class="table-responsive">
          			<table id="statusTable" class="table table-bordered table-striped">
            			<thead class="thead-light">
              				<tr>
                				<th>#</th>
							    <th>Cover</th>
							    <th>Title</th>
							    <th>Author</th>
							    <th>Publisher</th>
							    <th>Genre</th>
							    <th>Availability</th>
							    <th>Action</th>
              				</tr>
            			</thead>
            			<tbody>
			           		<%
					      	User_Dao dao = new User_Dao();
						  	ResultSet rs = dao.getBookData();
						  	int count = 0;
					      	while(rs.next()){
						  	%>
	              			<tr>
                				<td><%= count = count+1 %></td>
                				<td><img src="images/<%= rs.getString("image") %>" onerror="this.onerror=null; this.src='images/default-book.jpg';" class="book-img clickable-img" /></td>
				                <td><%= rs.getString("title") %></td>
				                <td><%= rs.getString("author") %></td>
				                <td><%= rs.getString("publisher") %></td>
				                <td><%= rs.getString("genre") %></td>
				                <td style="color: <%= (rs.getInt("available_quantity") == 0) ? "red" : "green" %>;">
				 				 <%= (rs.getInt("available_quantity") == 0) ? "Not Available" : "Available" %>
								</td>
                				<td style="display: flex; align-items: center;">
				                	<button 
							        	class="btn btn-primary btn-sm editBtn"
								        data-toggle="modal" 
								        data-target="#editModal"
								        data-id="<%= rs.getInt("book_id") %>"
								        data-title="<%= rs.getString("title") %>"
								        data-author="<%= rs.getString("author") %>"
								        data-publisher="<%= rs.getString("publisher") %>">
								        <i class="fa fa-pencil"></i> Edit
							      	</button>
                  					<button 
			          					class="btn btn-danger btn-sm" 
			          					style="margin-left: 10px;"
			          					onclick="deleteBook(<%= rs.getInt("book_id") %>)">
			          					<i class="fa fa-trash"></i> Delete
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
  		<!-- end book section -->
  		<!-- team section -->
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
	        			ResultSet rs2 = dao.getBookData();
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
  		<!-- end team section -->
		<%
	    request.setAttribute("currentPage", "ViewBooks");
		%>
		<jsp:include page="admin-info-section.jsp" /> 
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
          				<h5 class="modal-title" id="editModalLabel">Edit Book</h5>
          				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
            				<span aria-hidden="true">&times;</span>
          				</button>
        			</div>
        			<form action="UpdateBook" method="post">
	        			<div class="modal-body">
	          				<!-- Form content here -->
	          				<input type="hidden" id="bookId" name="bookId">
	            			<div class="form-group">
	              				<label for="bookTitle">Title</label>
	              				<input type="text" class="form-control" id="bookTitle" name="title">
	            			</div>
	            			<div class="form-group">
	              				<label for="bookAuthor">Author</label>
	              				<input type="text" class="form-control" id="bookAuthor" name="author">
	            			</div>
				            <div class="form-group">
				            	<label for="bookPublisher">Publisher</label>
				            	<input type="text" class="form-control" id="bookPublisher" name="publisher">
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
      				<input type="hidden" name="source" value="ViewBooks">
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
      				<input type="hidden" name="source" value="ViewBooks">
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
  		<!-- Retrieved data from row -->
 	 	<script>
  			$('#editModal').on('show.bs.modal', function (event) {
    			var button = $(event.relatedTarget); // Button that triggered the modal
			    var bookId = button.data('id');
			    var title = button.data('title');
			    var author = button.data('author');
			    var publisher = button.data('publisher');

			    var modal = $(this);
			    modal.find('#bookId').val(bookId);
			    modal.find('#bookTitle').val(title);
			    modal.find('#bookAuthor').val(author);
			    modal.find('#bookPublisher').val(publisher);
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
 		<!-- Retrieved data from row -->
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
  		<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
		<script>
  			$(document).ready(function () {
    			$('#statusTable').DataTable({
			    	"pageLength": 10,
			      	"lengthMenu": [10, 20, 30],
			      	"order": [[0, "asc"]],
			    });
			});
		</script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script>
  			$(document).ready(function () {
    			const status = $("#updatestatus").val();

    			if (status === "success") {
      				swal("Success!", "Book details updated successfully.", "success").then(() => {
        			// Remove ?status=success from URL without reloading the page
        			window.history.replaceState(null, null, window.location.pathname);
      				});
    			} else if (status === "failed") {
      				swal("Error!", "Failed to update book details.", "error").then(() => {
       	 			window.history.replaceState(null, null, window.location.pathname);
      				});
    			}
  			});
		</script>
		<script>
  			$(document).ready(function () {
    			const status = $("#deletedstatus").val();

    			if (status === "deleted") {
      				swal("Success!", "Book details deleted successfully.", "success").then(() => {
        			// Remove ?status=success from URL without reloading the page
        			window.history.replaceState(null, null, window.location.pathname);
      				});
    			} else if (status === "failed") {
      				swal("Error!", "Failed to delete book details.", "error").then(() => {
        			window.history.replaceState(null, null, window.location.pathname);
      				});
    			}
  			});
		</script>
		<script>
			$(document).ready(function () {
    			const status = $("#addedstatus").val();

    			if (status === "success") {
      				swal("Success!", "Book details added successfully.", "success").then(() => {
        			// Remove ?status=success from URL without reloading the page
        			window.history.replaceState(null, null, window.location.pathname);
      				});
    			} else if (status === "failed") {
      				swal("Error!", "Failed to added book details.", "error").then(() => {
        			window.history.replaceState(null, null, window.location.pathname);
      				});
    			}
  			});
		</script>
		<script>
  			document.addEventListener("DOMContentLoaded", function () {
	    		const images = document.querySelectorAll('.clickable-img');
			    const overlay = document.getElementById("imgOverlay");
			    const overlayImg = document.getElementById("overlayImage");
			
			    images.forEach(img => {
	      			img.addEventListener('click', function () {
	       			overlayImg.src = this.src;
	        		overlay.style.display = "flex";
	      			});
	    		});
	
	    		overlay.addEventListener('click', function () {
	      			overlay.style.display = "none";
	    		});
  			});
		</script>
		<!-- use when delete button is clicked to call servlet -->
		<script>
		function deleteBook(bookId) {
    		if (confirm('Are you sure you want to delete this book?')) {
        		// Create a hidden form element
        		const form = document.createElement('form');
        		form.method = 'POST';
        		form.action = 'DeleteBook';

       	 		// Create hidden input field for the book ID
        		const input = document.createElement('input');
		        input.type = 'hidden';
		        input.name = 'id';
		        input.value = bookId;

        		form.appendChild(input);
        		document.body.appendChild(form);
        		form.submit();
    		}
		}
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
	</div>
</body>
</html>