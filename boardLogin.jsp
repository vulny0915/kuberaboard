<%@ page import="java.util.regex.Pattern" %>
<!DOCTYPE html>
<html>
<head>
<title>kuberaBoard</title>
</head>
<body>
	<%
		String user = null;
		
		user = request.getParameter("user");
		String pattern = "^[a-zA-Z]{1}[a-zA-Z0-9_]{7,12}$";
		boolean regex = Pattern.matches(pattern, user);
		if(regex==false){
			out.println("<script>");
			out.println("alert('Please use only numbers or letters between 8 and 12 digits in length.');");
			out.println("history.back()");
			out.println("</script>");
			return;
		}
		
		session.setAttribute("user",user);
		response.sendRedirect("boardMain.jsp"); 
	%>
</body>
</html>