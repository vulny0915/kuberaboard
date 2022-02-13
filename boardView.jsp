<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ page import="codegate.board.BoardDAO" %>
<%@ page import="codegate.board.BoardVO" %>
<%@ page import="codegate.Util" %>

<!DOCTYPE html>
<html>
<head>
</head>
<link rel="stylesheet" href="/codegate/css/bootstrap.css" />
<link rel="stylesheet" href="/codegate/css/custom.css" />
<title>kuberaBoard</title>
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

if(id == 0){
	out.print("<script>	alert('This post does not exist.');	location.href = '/codegate/boardMain.jsp'; </script>");
	return ;
}

vo = dao.viewBoard(id,user);
if(vo.getId() == 0){
	out.print("<script>	alert('This post does not exist.');	location.href = '/codegate/boardMain.jsp'; </script>");
	return ;
}
request.setAttribute("vo", vo);
%>
<c:set var="vo" value="<%=vo %>" />

<script>
	function goEdit(id)
	{
		document.location.href="/codegate/boardEdit.jsp?id=" + id;
	}
</script>


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
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;"><c:out value="${vo.title}"/></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="20%"><img src=<c:url value='/filedownload.jsp?id=${vo.id}&user=${vo.user}' /> width="200"></td>
						
						<td colspan="2">${vo.content}</td>
					
						
					</tr>
					
					</tr>
				</tbody>
			</table>
			<a href="/codegate/boardMain.jsp" class="btn btn-primary">List</a>
					<a href="/codegate/boardEdit.jsp?id=<c:out value="${vo.id}"/>" class="btn btn-primary">Edit</a>
		</div>
	</div>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>