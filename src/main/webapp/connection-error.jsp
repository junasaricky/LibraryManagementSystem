<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>No Connection - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #00c6a9, #764ba2);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .error-container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
        }
        .error-container h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        .error-container p {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
        .retry-btn {
            background-color: #fff;
            color: #00937d;
            border: none;
            padding: 10px 20px;
            font-size: 1.1rem;
            border-radius: 30px;
            transition: background-color 0.3s ease;
        }
        .retry-btn:hover {
            background-color: #ddd;
        }
        .spinner-border {
            margin-top: 20px;
            display: none;
        }
    </style>
</head>
<body>
<div class="error-container">
    <h1>🔌 Oops! No Internet Connection</h1>
    <p>Please check your connection and try again.</p>
    <button class="retry-btn" onclick="retryConnection()">Retry Connection</button>
    <div id="loading" class="spinner-border text-light" role="status">
    	<span class="visually-hidden">Loading...</span>
    </div>
</div>
<script>
    function retryConnection() {
        document.getElementById('loading').style.display = 'inline-block'; 
        
        setTimeout(function () {
        	if (navigator.onLine) {
            	const previousPage = sessionStorage.getItem('previousPage');
                if (previousPage) {
                    window.location.href = previousPage;
                } else {
                    window.location.href = "login.jsp"; 
                }
            } else {
                document.getElementById('loading').style.display = 'none'; 
                alert("Still no connection. Please try again.");
            }
        }, 1500); 
    }
    // Auto Retry Every 5 seconds (optional)
    setInterval(function () {
        if (navigator.onLine) {
            const previousPage = sessionStorage.getItem('previousPage');
            if (previousPage) {
                window.location.href = previousPage;
            } else {
                window.location.href = "login.jsp";
            }
        }
    }, 5000); // Every 5 seconds try reconnect
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>