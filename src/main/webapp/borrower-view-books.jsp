<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.junasa.DAO.User_Dao" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

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
  	<!-- font awesome style -->
  	<!-- <link href="css/font-awesome.min.css" rel="stylesheet" /> -->
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
			#searchInput {
	    		width: 70% !important; 
	    		max-width: 150px !important; 
	  		}
	  		.card-img-top {
    			width: 100%;
			    height: auto;
			    max-height: 1000px;
			    object-fit: contain; /* Preserve aspect ratio and show entire image */
			    box-shadow: 0 0 10px #ccc;
  			}
  			.col-md-9, .col-md-3 {
      			margin-bottom: 20px;
    		}
    		.book-card {
      			max-width: 100%;
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
  		.card {
    		height: 100%;
		    display: flex;
		    flex-direction: column;
  		}
  		.card-img-top {
 			width: 100%;
		  	height: 250px;    /* Fixed height for consistency */
		  	object-fit: cover;
		}
  		.card-body {
    		flex: 1 1 auto;
		    display: flex;
		    flex-direction: column;
  		}
  		#borrowed-list .book-card {
    		display: none;
  		}
	</style>
</head>
<body>
	<div class="hero_area">
    	<jsp:include page="borrower-header.jsp" />
    	<!-- book section -->
		<section class="book_section layout_padding">
  			<div class="container">
    			<div class="row">
      				<!-- Left side: Available Books -->
      				<div class="col-md-9">
      					<div class="mb-4 d-flex justify-content-between align-items-center">
      						<p class="text-muted mb-0"><strong>View Books</strong></p>
      						<input type="text" id="searchInput" class="form-control w-25" placeholder="Search books...">
    					</div>
				        <div class="row" id="book-list">
				          <% 
				            int loggedInUserId = (Integer) session.getAttribute("user_id");
				            User_Dao dao = new User_Dao();
				            ResultSet rs = dao.getAvailableBooksWithBorrowStatus(loggedInUserId);
				
				            List<Map<String, Object>> availableBooks = new ArrayList<>();
				            List<Map<String, Object>> borrowedOrPendingBooks = new ArrayList<>();
				
				            Set<Integer> displayedBookIds = new HashSet<>();
				
				            while (rs.next()) {
				                int bookId = rs.getInt("book_id");
				                if (displayedBookIds.contains(bookId)) continue;
				                displayedBookIds.add(bookId);
				
				                Map<String, Object> book = new HashMap<>();
				                book.put("book_id", bookId);
				                book.put("title", rs.getString("title"));
				                book.put("author", rs.getString("author"));
				                book.put("publisher", rs.getString("publisher"));
				                book.put("genre", rs.getString("genre"));
				                book.put("image", rs.getString("image"));
				                book.put("status", rs.getString("status"));
				                book.put("borrow_date", rs.getString("borrow_date"));
				                book.put("available_quantity", rs.getInt("available_quantity"));
				                book.put("user_id", rs.getInt("user_id"));
				
				                String borrowStatus = rs.getString("status");
				                boolean isBookBorrowedByUser = rs.getInt("user_id") == loggedInUserId && "Borrowed".equals(borrowStatus);
				                boolean isPendingByUser = rs.getInt("user_id") == loggedInUserId && "Pending".equals(borrowStatus);
				
				                if (isBookBorrowedByUser || isPendingByUser) {
				                    borrowedOrPendingBooks.add(book);
				                } else {
				                    availableBooks.add(book);
				                }
				            }
				          %>
				
				          <% for (Map<String, Object> book : availableBooks) { %>
				            <div class="col-md-4 mb-4 book-card">
				              <div class="card h-100">
				                <img src="images/<%= book.get("image") %>" 
				                     onerror="this.onerror=null; this.src='images/default-book.jpg';" 
				                     class="card-img-top" 
				                     alt="<%= book.get("title") %>">
				                <div class="card-body d-flex flex-column">
				                  <h5 class="card-title"><%= book.get("title") %></h5>
				                  <p class="card-text"><strong>Author:</strong> <%= book.get("author") %></p>
				                  <p class="card-text"><strong>Publisher:</strong> <%= book.get("publisher") %></p>
				                  <p class="card-text"><strong>Genre:</strong> <%= book.get("genre") %></p>
				                  <div class="mt-auto text-center">
				                    <button class="btn btn-sm btn-primary"
				                      data-toggle="modal"
				                      data-target="#borrowModal"
				                      data-bookid="<%= book.get("book_id") %>"
				                      data-userid="<%= loggedInUserId %>"
				                      data-title="<%= book.get("title") %>"
				                      data-author="<%= book.get("author") %>"
				                      data-publisher="<%= book.get("publisher") %>"
				                      data-genre="<%= book.get("genre") %>"
				                      data-borrowed="<%= book.get("status") %>"
				                      data-borrowdate="<%= book.get("borrow_date") %>"
				                      data-availablequantity="<%= book.get("available_quantity") %>">
				                      <i class="fa fa-book"></i> Borrow
				                    </button>
				                  </div>
				                </div>
				              </div>
				            </div>
				          <% } %>
				        </div>
       	 				<!-- Pagination -->
        				<div class="pagination-controls text-center mt-4">
          					<button class="btn btn-outline-primary" id="prev-page">Previous</button>
          					<span id="page-info" class="mx-2">Page 1 of 1</span>
          					<button class="btn btn-outline-primary" id="next-page">Next</button>
        				</div>
        				<div id="no-books-message" class="text-center" style="display: none; font-weight: bold; font-family: Arial, sans-serif; color: #666;">
          					<p>No Results Found</p>
        				</div>
      				</div>
      				
					<!-- Right Side: Borrowed / Pending Books -->
					<div class="col-md-3">
  						<h5 class="text-muted mb-3 text-center">My Borrowed / Pending</h5>
  						<div id="borrowed-list">
						    <% 
						      borrowedOrPendingBooks.sort((a, b) -> {
						          String statusA = (String) a.get("status");
						          String statusB = (String) b.get("status");
						
						          if ("Pending".equals(statusA) && "Borrowed".equals(statusB)) {
						              return -1;
						          } else if ("Borrowed".equals(statusA) && "Pending".equals(statusB)) {
						              return 1;
						          } else {
						              return 0;
						          }
						      });
						    %>
						    <% for (Map<String, Object> book : borrowedOrPendingBooks) { %>
						      <div class="card mb-3">
						      	<img src="images/<%= book.get("image") %>" 
						             onerror="this.onerror=null; this.src='images/default-book.jpg';" 
						             class="card-img-top" 
						             alt="<%= book.get("title") %>">
						        <div class="card-body text-center">
						        	<h6 class="card-title"><%= book.get("title") %></h6>
						          	<p class="card-text">
							            <% if ("Borrowed".equals(book.get("status"))) { %>
							              <span class="badge badge-secondary">Borrowed</span>
							            <% } else if ("Pending".equals(book.get("status"))) { %>
							              <span class="badge badge-warning">Pending</span>
							            <% } %>
						          	</p>
						        </div>
						      </div>
						    	<% } %>
  						</div>
  						<!-- Load More Button -->
  						<div class="text-center mt-4">
    						<button 
      							class="btn btn-outline-primary rounded-pill px-4 py-2 shadow-sm transition-all hover:scale-105" 
      							id="load-more-btn"
      							style="font-weight: 500; font-size: 1rem; border-width: 2px; transition: all 0.3s ease;">
      							Load More
    						</button>
  						</div>
					</div>
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
			request.setAttribute("currentPage", "BorrowerViewBooks");
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
		<!-- Change Password Modal -->
		<div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
  			<div class="modal-dialog" role="document">
    			<form action="ChangePasswordServlet" method="post">
      				<input type="hidden" name="source" value="BorrowerViewBooks">
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
      				<input type="hidden" name="source" value="BorrowerViewBooks">
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
		<!-- Borrow Book Modal -->
		<div class="modal fade" id="borrowModal" tabindex="-1" role="dialog" aria-labelledby="borrowModalLabel" aria-hidden="true">
  			<div class="modal-dialog" role="document">
    			<form action="BorrowServlet" method="post">
      				<div class="modal-content">
        				<div class="modal-header">
		          <h5 class="modal-title" id="borrowModalLabel">Book Details</h5>
		          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		            <span aria-hidden="true">&times;</span>
		          </button>
		        </div>
		        <div class="modal-body">
		          <p><strong>Title:</strong> <span id="bookTitle"></span></p>
		          <p><strong>Author:</strong> <span id="bookAuthor"></span></p>
		          <p><strong>Publisher:</strong> <span id="bookPublisher"></span></p>
		          <p><strong>Genre:</strong> <span id="bookGenre"></span></p>
		          <p><strong>Status:</strong> <span id="bookStatus"></span></p>
		          <p><strong>Due Date:</strong> <span id="bookDueDate"></span></p>
		
		          <!-- Availability message -->
		          <p id="availabilityMessage" class="text-danger"></p> <!-- For showing "out of stock" message -->
		
		          <!-- Hidden fields -->
		          <input type="hidden" name="book_id" id="hiddenBookId">
		          <input type="hidden" name="user_id" id="hiddenUserId">
		          <input type="hidden" name="borrow_date" id="hiddenBorrowDate">
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		          <button type="submit" class="btn btn-primary" id="borrowBookBtn" disabled>Borrow</button>
		        </div>
		      </div>
		    </form>
		  </div>
		</div>
	</div>
<script>
	var displayedBooks = [];  // Array to track displayed book IDs

	$('#borrowModal').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget); // Button that triggered the modal
	    var bookId = button.data('bookid');
	
	    // Check if the book has already been displayed
	    if(displayedBooks.includes(bookId)) {
	        return; // If already displayed, prevent further processing
	    }
	
	    // Otherwise, proceed with modal setup
	    var userId = button.data('userid');
	    var title = button.data('title');
	    var author = button.data('author');
	    var publisher = button.data('publisher');
	    var genre = button.data('genre');
	    var borrowedStatus = button.data('borrowed');
	    var borrowDate = button.data('borrowdate');
	    var availableQuantity = button.data('availablequantity');
	
	    var modal = $(this);
	    modal.find('#bookTitle').text(title);
	    modal.find('#bookAuthor').text(author);
	    modal.find('#bookPublisher').text(publisher);
	    modal.find('#bookGenre').text(genre);

	    // Default due date
	    var dueDateText = 'N/A';
	    var dueDateValue = '';

	    // Clear availability message initially
	    modal.find('#availabilityMessage').text('');
	
	    // Check if this book has been borrowed or returned by the current user
	    if (borrowedStatus === "Borrowed") {
	        modal.find('#bookStatus').text("Borrowed");
	        dueDateText = new Date(borrowDate).toLocaleDateString();
	        modal.find('#bookDueDate').text(dueDateText); // Show due date
	        modal.find('#borrowBookBtn').prop('disabled', true); // Disable the button if the user has borrowed it
	    } else if (borrowedStatus === "Returned") {
	        modal.find('#bookStatus').text("Returned");
	
	        // Remove the book from the displayedBooks array when it's returned
	        var index = displayedBooks.indexOf(bookId);
	        if (index !== -1) {
	            displayedBooks.splice(index, 1); // Remove the book ID from the array
	        }
	
	        // Enable the button if available quantity is greater than 0
	        if (availableQuantity > 0) {
	            // Compute due date: today + 7 days
	            var today = new Date();
	            var dueDate = new Date(today);
	            dueDate.setDate(today.getDate() + 7);
	            dueDateText = dueDate.toLocaleDateString();
	            dueDateValue = dueDate.toISOString().split('T')[0];
	
	            modal.find('#bookDueDate').text(dueDateText); // Show due date if book is available
	            modal.find('#borrowBookBtn').prop('disabled', false); // Enable the button
	        } else {
	            modal.find('#availabilityMessage').text('Sorry, this book is currently unavailable.');
	            modal.find('#borrowBookBtn').prop('disabled', true); // Disable button if no quantity is available
	        }
	    } else {
	        modal.find('#bookStatus').text("Available");
	
	        // Enable the button if available quantity is greater than 0
	        if (availableQuantity > 0) {
	            // Compute due date: today + 7 days
	            var today = new Date();
	            var dueDate = new Date(today);
	            dueDate.setDate(today.getDate() + 7);
	            dueDateText = dueDate.toLocaleDateString();
	            dueDateValue = dueDate.toISOString().split('T')[0];
	
	            modal.find('#bookDueDate').text(dueDateText); // Show due date if book is available
	            modal.find('#borrowBookBtn').prop('disabled', false); // Enable the button
	        } else {
	            modal.find('#availabilityMessage').text('Sorry, this book is currently unavailable.');
	            modal.find('#borrowBookBtn').prop('disabled', true); // Disable the button if no quantity is available
	        }
	    }

	    // Set the hidden due date input
	    modal.find('#hiddenBookId').val(bookId);
	    modal.find('#hiddenUserId').val(userId);
	    modal.find('#hiddenBorrowDate').val(borrowDate);
	
	    // Add this bookId to the array to track it's already displayed
	    displayedBooks.push(bookId);
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
<!-- Include jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	let pageNum = 1; 
	const cardsPerPage = 6;
	let totalPages = 1;

	function renderPage() {
  		console.log('Rendering page...');
  		const cards = $(".book-card");
  		const searchText = $("#searchInput").val().toLowerCase();
  		let visibleCards = [];

  		cards.hide();

  		cards.each(function() {
    		const title = $(this).find(".card-title").text().toLowerCase();
    		const author = $(this).find(".card-text").first().text().toLowerCase(); 
    		if (title.includes(searchText) || author.includes(searchText)) {
      			visibleCards.push($(this));
    		}
  		});

  		totalPages = Math.ceil(visibleCards.length / cardsPerPage);
  		if (totalPages === 0) totalPages = 1; 

  		if (pageNum > totalPages) pageNum = totalPages;
  		if (pageNum < 1) pageNum = 1; 

  		const startIndex = (pageNum - 1) * cardsPerPage;
  		const endIndex = startIndex + cardsPerPage;
  		const cardsToDisplay = visibleCards.slice(startIndex, endIndex);

  		cardsToDisplay.forEach(function(card) {
    		card.show();
  		});

  		console.log("pageNum:", pageNum, "totalPages:", totalPages);
  		$("#page-info").text('Page ' + pageNum + ' of ' + totalPages);

  		if (visibleCards.length > 0) {
    		$(".pagination-controls").show(); 
    		$("#prev-page").prop("disabled", pageNum === 1); 
    		$("#next-page").prop("disabled", pageNum === totalPages); 
    		$("#no-books-message").hide(); 
  		} else {
    		$(".pagination-controls").hide(); 
    		$("#no-books-message").show();
  		}
	}

	function changePage(direction) {
  		if (direction === -1 && pageNum > 1) {
    		pageNum--;
  		} else if (direction === 1 && pageNum < totalPages) {
    		pageNum++;
  		}
  		renderPage();
	}

	$(document).ready(function() {
  		renderPage(); 

	  	$("#searchInput").on("input", function() {
	    	pageNum = 1; 
	    	renderPage();
	  	});
	
	  	$("#prev-page").on("click", function() {
	    	changePage(-1);
	  	});
	
	  	$("#next-page").on("click", function() {
	    	changePage(1);
	  	});
	});
</script>
<script>
	const books = document.querySelectorAll('#borrowed-list .card');
	const loadMoreBtn = document.getElementById('load-more-btn');

	let booksToShow = 3;
	let currentVisible = 0;

	books.forEach(book => book.style.display = 'none');

	for (let i = 0; i < booksToShow && i < books.length; i++) {
  		books[i].style.display = 'block';
  		currentVisible++;
	}
	loadMoreBtn.addEventListener('click', function() {
  		let nextVisible = currentVisible + booksToShow;

  		for (let i = currentVisible; i < nextVisible && i < books.length; i++) {
    		books[i].style.display = 'block';
  		}

  		currentVisible = nextVisible;

  		if (currentVisible >= books.length) {
    		loadMoreBtn.style.display = 'none';
  		}
	});
</script>
</body>
</html>