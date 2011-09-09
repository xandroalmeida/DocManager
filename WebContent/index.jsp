<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.io.FileFilter"%>
<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<html>
<body>
<ul>
<%
	String base_document_directory = getServletContext(). getInitParameter("base_document_directory");
	File base = new File(base_document_directory);
	File projectsDir[] = base.listFiles(new FileFilter(){
		public boolean accept(File pathname) {
			return pathname.isDirectory();
		}
	});
	
	for (int i = 0; i < projectsDir.length; i++) {
		%>
		<li><%=projectsDir[i].getName()%></li>
		<ul>
		<%
		File modulesDir[] = projectsDir[i].listFiles(new FileFilter() {
			public boolean accept(File pathname) {
				return pathname.isDirectory();
			}
		});
		for (int n = 0; n < modulesDir.length; n++) {
			%>
			<li><%=modulesDir[n].getName()%></li>
			<ul>
			<% 
			File cdusDir[] = modulesDir[n].listFiles(new FileFilter() {
				public boolean accept(File pathname) {
					return pathname.isFile() && (
							pathname.getName().endsWith(".md") || 
							pathname.getName().endsWith(".textile") ||
							pathname.getName().endsWith(".wiki"));
				}
			});
			for (int c = 0; c < cdusDir.length; c++) {
			%>
			<li><a href="view.jsp?p=<%=projectsDir[i].getName()%>&m=<%=modulesDir[n].getName()%>&c=<%=cdusDir[c].getName()%>"><%=cdusDir[c].getName()%></a></li>
			<% 
			}
		}
		%>
		</ul>
		</ul>
		<% 
	}
%>
</ul>
</body>
</html>
