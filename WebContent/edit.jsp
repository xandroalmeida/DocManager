<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.io.File"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
	String base_document_directory = getServletContext().getInitParameter("base_document_directory");
	String path = base_document_directory + File.separatorChar + request.getParameter("p") + File.separatorChar + request.getParameter("m") + File.separatorChar + request.getParameter("c");

	if (request.getMethod().equalsIgnoreCase("post")) {
		FileUtils.writeStringToFile(new File(path), request.getParameter("txt"));
		response.sendRedirect("view.jsp?p=" +  request.getParameter("p")+"&m="+ request.getParameter("m") + "&c="+ request.getParameter("c"));
		return;
	}

	String txt = FileUtils.readFileToString(new File(path));
	%>
	<form method="post" action="edit.jsp">
	<input type="hidden" name="p" value="<%=request.getParameter("p")%>"/>
	<input type="hidden" name="m" value="<%=request.getParameter("m")%>"/>
	<input type="hidden" name="c" value="<%=request.getParameter("c")%>"/>
	
	<textarea rows="40" cols="80" id="cduTxt" name=txt><%=txt%></textarea>
	<input type="submit"/>
	</form>
</body>
</html>