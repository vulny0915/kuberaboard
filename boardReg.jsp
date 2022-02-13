<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/codegate/css/bootstrap.css" />
<link rel="stylesheet" href="/codegate/css/custom.css" />
<title>kuberaBoard</title>
</head>
<%
String user = (String)session.getAttribute("user");
if(user == null) {
	response.sendRedirect("/codegate/index.jsp");
	return;
}
%>
<body>
        <nav class="navbar navbar-default">
                <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed"
                                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                                aria-expanded="false">
                                <span class="icon-bar"></span> <span class="icon-bar"></span> <span
                                        class="icon-bar"></span>
                        </button>
                        <a href="boardMain.jsp" class="navbar-brand">CODEGATE 2021 Image board</a>
                </div>
                <div class="collapse navbar-collapse"
                        id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav navbar-right">
                                <li class="active"><a><%=session.getAttribute("user") %></a></li>
                        </ul>
                </div>
        </nav>


	<div class="container">
		<div class="row">

			<form action="/codegate/boardRegSuccess.jsp" method="post" enctype="multipart/form-data">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">
								Write a post
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="title" name="title" maxlength="50" /></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="content"
									name="content" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
						<tr>
							<td><input type="file" name="file"></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary" value="Upload" />
				<a href="/codegate/boardMain.jsp" class="btn btn-primary">List</a>
			</form>
		</div>
	</div>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
<!-- <footer> © 2022 kuberaBoard GitHub, inc. image board development by kubera. </footer>  -->
</html>


