<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ page import="codegate.board.BoardDAO" %>
<%@ page import="codegate.board.BoardVO" %>
<%@ page import="codegate.Util" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/codegate/css/bootstrap.css" />
<link rel="stylesheet" href="/codegate/css/custom.css" />
<title>kuberaBoard</title>
</head>
<% 
BoardVO vo = new BoardVO();
BoardDAO dao = new BoardDAO();
String user = (String)session.getAttribute("user");
int id = 0;

if(user == null) {
	response.sendRedirect("/codegate/index.jsp");
	return;
}

id = Util.validCheck(request.getParameter("id"));
vo = dao.viewBoard(id, user);


if(vo.getId() == 0){
	out.print("<script> alert('This post does not exist.'); location.href = '/codegate/boardMain.jsp'; </script>");
	return;
}

request.setAttribute("vo", vo);
%>
<c:set var="vo" value="<%=vo %>" />

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
                                <li class="active"><a><%=user %></a></li>
                        </ul>
                </div>
        </nav>


	<div class="container">
		<div class="row">

			<form action="/codegate/boardEditSuccess.jsp" method="post" enctype="multipart/form-data">
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
								placeholder="title" name="title" maxlength="50" value="<c:out value="${vo.title}"/>" /></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="content"
									name="content" maxlength="2048" style="height: 350px;"><c:out value="${vo.content}"/></textarea></td>
						</tr>
						<tr>
							<td><input type="file" name="file"></td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="id" value="<c:out value="${vo.id}"/>">
				<input type="submit" class="btn btn-primary" value="Upload" />
				<a href="/codegate/boardMain.jsp" class="btn btn-primary">List</a>
				<a onclick="return confirm('Are you sure you want to delete the post?')" href="/codegate/boardDelete.jsp?id=<c:out value="${vo.id}"/>" class="btn btn-primary">Delete</a>
			</form>
		</div>
	</div>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
<!-- <footer> © 2022 <a href="https://github.com/vulny0915/kuberaboard">kuberaBoard GitHub</a>, inc. image board development by kubera. </footer>  -->
</html>
