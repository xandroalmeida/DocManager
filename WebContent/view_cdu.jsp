<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.io.File"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="wiky.css"/>

<script type="text/javascript" src="showdown.js"></script>
<script type="text/javascript" src="wiky.js"></script>
<script type="text/javascript" src="textile.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css" media="print">
.noprint {
	display: none;
}
</style>
</head>
<body>
<a href="index.jsp" class="noprint">Voltar</a><br/>
	<% 
	String base_document_directory = getServletContext(). getInitParameter("base_document_directory");
	
	String path = base_document_directory + File.separatorChar + request.getParameter("p") + File.separatorChar + request.getParameter("m") + File.separatorChar + request.getParameter("c");
	String txt = FileUtils.readFileToString(new File(path));
	%>
	<textarea rows="40" cols="80" style="display: none;" id="cduTxt"><%=txt%></textarea>
	<script type="text/javascript">
		var text = document.getElementById("cduTxt").value;
	</script>
	<%
	if (path.endsWith(".md")) {
	%>
	<script type="text/javascript">
		var converter = new Showdown.converter();
		var html = converter.makeHtml(text);
		document.write(html);
	</script>
	<%
	} else if (path.endsWith(".textile")) {
	%>
	<script type="text/javascript">
		var html = convert(text);
		document.write(html);
	</script>
	<% 
	}  else if (path.endsWith(".wiki")) {
	%>
	<script type="text/javascript">
		var html = wiky.process(text);
		document.write(html);
	</script>
		
		<%
	}else {
		out.print("<h1>N�o suportado</h1>");		
	}
	%>
</body>
</html>