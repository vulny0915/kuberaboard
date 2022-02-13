<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/custom.css" />
<meta charset="UTF-8">
<title>kuberaBoard</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>	
			</button>
			<a href="boardMain.jsp" class="navbar-brand">CODEGATE 2021 Image board</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form action="boardLogin.jsp" method="post">
					<h3 style="text-align: center;">Sign in</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="nickname" name="user" maxlength="20"/>
					</div>
					<input type="submit" class="btn btn-primary form-control" value="submit"/>
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>