<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"  %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="codegate.board.BoardDAO" %>
<%@ page import="codegate.board.BoardVO" %>
<%@ page import="codegate.Util" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kuberaBoard</title>
</head>
<%
String user = (String)session.getAttribute("user");
if(user == null) {
	response.sendRedirect("/codegate/index.jsp");
	return;
}
		
		String savePath = "/usr/local/tomcat/webapps/codegate/upload";
		
		
		//String savePath = "C:\\Users\\USER\\eclipse-workspace\\workspace3\\codegate\\src\\main\\webapp\\upload";
		
		SimpleDateFormat dtf = new SimpleDateFormat("yyyyMMddhhmmss");
		Calendar calendar = Calendar.getInstance();
		int size=10*1024*1024;
	
		Date dateObj = calendar.getTime();
		String formattedDate = dtf.format(dateObj);
		MultipartRequest multi = new MultipartRequest(request, savePath, size, "utf-8", new DefaultFileRenamePolicy());
		
		BoardVO vo = new BoardVO();
		BoardDAO dao = new BoardDAO();
		
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");

		if(title.trim().isEmpty() || content.trim().isEmpty() )
		{
			out.print("<script> alert('Please enter a title or content.'); history.back(); </script>");
			return;
		}
		
		
		Enumeration uploadFiles = multi.getFileNames();
		
		if(!uploadFiles.hasMoreElements()){
			out.print("<script> alert('NO data'); history.back(); </script>");
			return;
		}
		
		String filename = (String)uploadFiles.nextElement();
		filename = multi.getFilesystemName(filename);
		if(filename==null){
			out.print("<script> alert('No image attached.'); history.back(); </script>");
			return;	
		}
		File file = new File(savePath +"/"+ filename);
		file.renameTo(new File(savePath +"/"+ formattedDate+ user + filename));
		
		try{
			vo.setTitle(title);
			vo.setContent(content);
			vo.setPath(savePath +"/"+ formattedDate + user + filename);
			vo.setUser((String)session.getAttribute("user"));
			dao.insertBoard(vo);
			
			out.print("<script> alert('Upload Complete.'); location.href='/codegate/boardMain.jsp'; </script>");
			
			
		}catch(Exception e){
			out.print("<script> alert('Failed to create thumbnail. Please use a different image file.'); history.back(); </script>");
		}
%>
<body>
</body>
</html>