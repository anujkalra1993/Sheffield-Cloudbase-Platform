<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8"/>
		<title>TUOS Cloudbase</title>
        <link rel="stylesheet" href="css/w3.css"/>
	</head>

	<body class="w3-content">
    
    	<header class="w3-row w3-padding w3-pink">
          <div class="w3-col m4 l3">
           <a href="http://www.sheffield.ac.uk">
            <img src="images/shef.gif"/>
           </a>
          </div>
          <div class="w3-col m8 l9">
           <h2>Sheffield Cloudbase Platform</h2>
           A place for Java Developers to collaborate
          </div>
        </header>
        
        <nav class="w3-topnav w3-black">
        	<a href="index.jsp"> Home </a>
            <a href="index.jsp"> About Us </a>
            <a href="login.jsp"> Login </a>
        </nav>
        
        <h1>ADMIN Login</h1>
        <div class = "w3-card">
          <div class = "w3-container w3-pale-blue">
            <h2>Members Login</h2>
          </div>
           <form class="w3-container">
          	<label class="w3-label">Enter email-id:</label>
			<input class="w3-input" type="email">
			<label class="w3-label">Enter Password</label>
			<input class="w3-input" type="password">
			<input class="w3-button w3-black" type="submit"/>
          </form>
        </div>
        
        <footer class="w3-container w3-grey">
        	<div align="center">
             <p> &copy; 
			  <script type="text/javascript">
			    var date = new Date();
				document.write(date.getFullYear());
              </script>
              The Univeristy of Sheffield | Department of Computer Science.
             </p>
            </div>
        </footer>
        
	</body>
</html>
