<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ page import="codegate.board.BoardDAO" %>
<%@ page import="codegate.board.BoardVO" %>
<%@ page import="codegate.Util" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>kuberaBoard</title>
</head>
<% 
String user = (String)session.getAttribute("user");
if(user == null) {
	response.sendRedirect("/codegate/index.jsp");
	return;
}

BoardVO vo = new BoardVO();
BoardDAO dao = new BoardDAO();
int id = 0;

id = Util.validCheck(request.getParameter("id"));

if(id == 0){
	out.print("<script>	alert('This post does not exist.');	location.href = '/codegate/boardMain.jsp'; </script>");
	return ;
}

vo = dao.viewBoard(id, user);
if(vo.getId() == 0){
	out.print("<script>	alert('This post does not exist.');	location.href = '/codegate/boardMain.jsp'; </script>");
	return ;
}

int ret = dao.deleteBoard(id, user);
if(ret == 0)
{
	out.print("<script>	alert('The post has not been deleted.');	location.href = '/codegate/boardMain.jsp'; </script>");
}else
{
	out.print("<script>	alert('Post has been deleted.');	location.href = '/codegate/boardMain.jsp'; </script>");
}
%>
<body>
</body>
</html>