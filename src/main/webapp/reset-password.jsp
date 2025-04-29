<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Reset Password - LMS</title>
  <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <style>
    body {
      background-color: #f2f2f2;
    }
    .reset-password-container {
      max-width: 400px;
      margin: 80px auto;
      padding: 30px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .reset-password-container h4 {
      margin-bottom: 20px;
      text-align: center;
    }
    .password-toggle {
      position: relative;
    }
    .password-toggle i {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
      color: #888;
    }
    .text-danger {
      font-size: 0.85rem;
    }
    <style>
  .password-requirements {
    list-style-type: none;
    padding-left: 0;
    font-size: 0.9rem;
  }

  .password-requirements li {
    margin: 5px 0;
  }

  .valid {
    color: green;
    font-weight: bold;
  }

  .invalid {
    color: red;
    font-weight: normal;
  }
</style>
    
  </style>
</head>
<body>
  <div class="reset-password-container">
    <h4>Reset Password</h4>
    <div class="mb-3">
	  	<h6 class="text-secondary">Password Requirements.</h6>
		  <ul class="password-requirements" style="font-size: 0.9rem; color: #666;">
		    <li id="lengthRequirement" class="invalid">Password must be at least 6 characters</li>
    		<li id="uppercaseRequirement" class="invalid">Must include at least one uppercase letter</li>
		    <li id="lowercaseRequirement" class="invalid">Must include at least one lowercase letter</li>
		    <li id="numberRequirement" class="invalid">Must contain at least one number</li>
		  </ul>
	</div>
    <form id="resetForm" action="ResetPasswordServlet" method="post">
	    <input type="hidden" name="userId" value="${user.id}">  
	    <div class="form-group">
	      <label for="newPassword">New Password</label>
	      <div class="password-toggle">
	        <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Enter new password">
	        <i class="fa fa-eye" id="toggleNewPassword"></i>
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="confirmPassword">Confirm New Password</label>
	      <div class="password-toggle">
	        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password">
	        <i class="fa fa-eye" id="toggleConfirmPassword"></i>
	      </div>
	      <small id="passwordError" style="color: red; display: none;">Passwords do not match.</small>
	    </div>
	
	    <button type="submit" class="btn btn-primary btn-block">Reset Password</button>
	</form>
  </div>
  <script>
  const toggleNew = document.getElementById("toggleNewPassword");
  const newPassword = document.getElementById("newPassword");
  const confirmPassword = document.getElementById("confirmPassword");
  
  // Password toggle
  toggleNew.addEventListener("click", () => {
    const type = newPassword.getAttribute("type") === "password" ? "text" : "password";
    newPassword.setAttribute("type", type);
    toggleNew.classList.toggle("fa-eye-slash");
  });

  const toggleConfirm = document.getElementById("toggleConfirmPassword");
  toggleConfirm.addEventListener("click", () => {
    const type = confirmPassword.getAttribute("type") === "password" ? "text" : "password";
    confirmPassword.setAttribute("type", type);
    toggleConfirm.classList.toggle("fa-eye-slash");
  });

  const form = document.getElementById("resetForm");
  const errorMsg = document.getElementById("passwordError");

  // Add icons for live validation
  const passwordRequirements = {
    length: document.getElementById("lengthRequirement"),
    uppercase: document.getElementById("uppercaseRequirement"),
    lowercase: document.getElementById("lowercaseRequirement"),
    number: document.getElementById("numberRequirement"),
  };

  // Listen for input on new password
  newPassword.addEventListener("input", function () {
    const newPass = newPassword.value.trim();
    const hasUppercase = /[A-Z]/.test(newPass);
    const hasLowercase = /[a-z]/.test(newPass);
    const hasNumber = /[0-9]/.test(newPass);

    // Validate length
    if (newPass.length >= 6) {
      passwordRequirements.length.classList.add("valid");
      passwordRequirements.length.classList.remove("invalid");
    } else {
      passwordRequirements.length.classList.add("invalid");
      passwordRequirements.length.classList.remove("valid");
    }

    // Validate uppercase
    if (hasUppercase) {
      passwordRequirements.uppercase.classList.add("valid");
      passwordRequirements.uppercase.classList.remove("invalid");
    } else {
      passwordRequirements.uppercase.classList.add("invalid");
      passwordRequirements.uppercase.classList.remove("valid");
    }

    // Validate lowercase
    if (hasLowercase) {
      passwordRequirements.lowercase.classList.add("valid");
      passwordRequirements.lowercase.classList.remove("invalid");
    } else {
      passwordRequirements.lowercase.classList.add("invalid");
      passwordRequirements.lowercase.classList.remove("valid");
    }

    // Validate number
    if (hasNumber) {
      passwordRequirements.number.classList.add("valid");
      passwordRequirements.number.classList.remove("invalid");
    } else {
      passwordRequirements.number.classList.add("invalid");
      passwordRequirements.number.classList.remove("valid");
    }
  });

  // Listen for confirm password input
  confirmPassword.addEventListener("input", function () {
    const confirmPass = confirmPassword.value.trim();
    const newPass = newPassword.value.trim();

    if (newPass === confirmPass) {
      confirmPassword.classList.add("valid");
      confirmPassword.classList.remove("invalid");
    } else {
      confirmPassword.classList.add("invalid");
      confirmPassword.classList.remove("valid");
    }
  });

  // Submit event
  form.addEventListener("submit", function (e) {
    const newPass = newPassword.value.trim();
    const confirmPass = confirmPassword.value.trim();

    const hasUppercase = /[A-Z]/.test(newPass);
    const hasLowercase = /[a-z]/.test(newPass);
    const hasNumber = /[0-9]/.test(newPass);

    // Submit validation checks
    if (newPass.length < 6) {
      e.preventDefault();
      errorMsg.textContent = "Password must be at least 6 characters.";
      errorMsg.style.display = "block";
    } else if (!hasUppercase) {
      e.preventDefault();
      errorMsg.textContent = "Password must contain at least one uppercase letter.";
      errorMsg.style.display = "block";
    } else if (!hasLowercase) {
      e.preventDefault();
      errorMsg.textContent = "Password must contain at least one lowercase letter.";
      errorMsg.style.display = "block";
    } else if (!hasNumber) {
      e.preventDefault();
      errorMsg.textContent = "Password must contain at least one number.";
      errorMsg.style.display = "block";
    } else if (newPass !== confirmPass) {
      e.preventDefault();
      errorMsg.textContent = "Passwords do not match.";
      errorMsg.style.display = "block";
    } else {
      errorMsg.style.display = "none";
    }
  });
</script>

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