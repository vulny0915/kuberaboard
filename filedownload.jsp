<%@ page contentType="application/octet-stream;charset=UTF-8"%>
<%@ page import="codegate.board.BoardDAO" %>
<%@ page import="codegate.Util" %>
<%@ page import="java.io.*"%>
 
<%

BoardDAO dao = new BoardDAO();	
int id = 0;
try{
	id = Util.validCheck(request.getParameter("id"));
	String user = request.getParameter("user");
	
	String filename = dao.getImageFile(id, user);
	String downFileName = filename.substring(filename.lastIndexOf("\\")+1);
	downFileName = downFileName.substring(14); 
	System.out.println(downFileName);
	File file = new File(filename);
	byte b[] = new byte[(int)file.length()];
	
	
	
	if (file.isFile())
	{
		response.setHeader("Content-Type","image/png");
		response.setHeader("Content-Disposition", "attachment;filename=file;");
	    BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
	    BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
	    int read = 0;
	    while ((read = fin.read(b)) != -1){
	                outs.write(b,0,read);
	    }
	    outs.close();
	           fin.close();
	}
}catch(Exception e)
{
	response.setHeader("Content-Type","image/png");
	response.setHeader("Content-Disposition", "attachment;filename=file;");
}
%>
