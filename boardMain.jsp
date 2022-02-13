<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ page import="codegate.board.BoardDAO" %>
<%@ page import="codegate.board.BoardVO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/codegate/css/bootstrap.css" />
<link rel="stylesheet" href="/codegate/css/custom.css" />
<title>kuberaBoard</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
	
	.thumbnail {cursor: pointer;}
</style>

<% 
List<BoardVO> listBoard = new ArrayList<BoardVO>();
BoardDAO dao = new BoardDAO();
String user = (String)session.getAttribute("user");

if(user == null) {
	response.sendRedirect("/codegate/index.jsp");
	return;
}


listBoard = dao.listBoard(user);
request.setAttribute("listBoard", listBoard);
%>
<c:set var="listBoard" value="<%=listBoard %>" />
</head>

<script>
	function goRegist()
	{
		document.location.href="/codegate/boardReg.jsp";
	}
	
	function goView(id)
	{
		document.location.href="/codegate/boardView.jsp?id=" + id;
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
                                <li class="active"><a><%=session.getAttribute("user") %></a></li>
                        </ul>
                </div>
        </nav>
	
	
	<div class="container">
		<div class="row">
        <div class=bs-example data-example-id=thumbnails-with-custom-content >
            <div class=row>
   				<c:forEach items="${listBoard }" var="list" varStatus="i">
   					<div class="col-sm-4 col-md-3">
                  		<div class=thumbnail onclick="goView(<c:out value="${list.id}"/>)"><img src=<c:url value='/filedownload.jsp?id=${list.id}&user=${list.user}' /> height="200" width="200" alt="Generic placeholder thumbnail">
                      		<div class=caption style="text-align:center;">
                          		<h4>${list.title}</h4>
                      		</div>
                  		</div>
               		</div>	
				</c:forEach>
            </div>
        </div>
			<a href="/codegate/boardReg.jsp" class="btn btn-primary">Write</a>
		</div>
	</div>
	
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
<!-- <footer> © 2022 <a href="https://github.com/vulny0915/kuberaboard">kuberaBoard GitHub</a>, inc. image board development by kubera. </footer>  -->
</html>
