<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
<meta charset="EUC-KR">
<title>kuberaBoard</title>
</head>
<%
		String user = (String)session.getAttribute("user");
		if(user == null) {
			response.sendRedirect("/codegate/index.jsp");
			return;
		}
		
		SimpleDateFormat dtf = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar calendar = Calendar.getInstance();
		BoardVO vo = new BoardVO();
		BoardDAO dao = new BoardDAO();
		int size=10*1024*1024;
		int id = 0;
		

		String savePath = "/usr/local/tomcat/webapps/codegate/upload";

		
		
		Date dateObj = calendar.getTime();
		String formattedDate = dtf.format(dateObj);
		
		MultipartRequest multi = new MultipartRequest(request, savePath, size, "utf-8", new DefaultFileRenamePolicy());
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		id = Util.validCheck(multi.getParameter("id"));
		
		if(id == 0)
		{
			out.print("<script> alert('This post does not exist.'); history.back(); </script>");
			return;
		}
		if(title.trim().isEmpty() || content.trim().isEmpty() )
		{
			out.print("<script> alert('Please enter a title or content.'); history.back(); </script>");
			return;
		}
		
		Enumeration uploadFiles = multi.getFileNames();
		
		if(uploadFiles.hasMoreElements()){
			
			String fileElement = (String)uploadFiles.nextElement();
			String filename = multi.getFilesystemName(fileElement);
			
			if(filename==null){
				vo.setId(id);
				vo.setTitle(title);
				vo.setContent(content);
				vo.setUser((String)session.getAttribute("user"));
				
				dao.updateBoard(vo);
				out.print("<script> alert('Upload Complete.'); location.href='/codegate/boardMain.jsp'; </script>");
				return;
			}else{
				
				File file = new File(savePath +"/"+ filename);
				file.renameTo(new File(savePath +"/"+ formattedDate+ user + filename));
				
				try{
					vo.setId(id);
					vo.setTitle(title);
					vo.setContent(content);
					vo.setPath(savePath +"/"+ formattedDate + user  + filename);
					vo.setUser((String)session.getAttribute("user"));
					
					dao.updateBoard(vo);
					
					out.print("<script> alert('Upload Complete.'); location.href='/codegate/boardMain.jsp'; </script>");

				}catch(Exception e){
					out.print("<script> alert('Failed to create thumbnail. Please use a different image file.'); history.back(); </script>");
				}
			}
			
		}else{
			out.print("<script> alert('No image attached.'); location.href='/codegate/boardMain.jsp'; </script>");
		}
%>
<body>
</body>
</html>
