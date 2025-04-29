<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Forgot Password - LMS</title>
  <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="css/style.css">
  <style>
    body {
      background-color: #f9f9f9;
    }
    .forgot-password-container {
      max-width: 400px;
      margin: 80px auto;
      padding: 30px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .forgot-password-container h4 {
      margin-bottom: 20px;
      text-align: center;
    }
  </style>
</head>
<body>
  <div class="forgot-password-container">
    <h4>Forgot Password</h4>
    <form action="ForgotPasswordServlet" method="POST">
	  <div class="form-group">
	    <label for="email">Enter your registered email</label>
	    <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" required>
	  </div>
	  <button type="submit" class="btn btn-primary btn-block">Send Reset Link</button>
	  <div class="text-center mt-3">
	    <a href="login.jsp">Back to Login</a>
	  </div>
	</form>
  </div>
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
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
</body>
</html>