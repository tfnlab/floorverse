<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>

<html>
<head>
<title>PNG Files</title>
</head>
<body>

<%
    // Create an instance of the APIConfig class
    APIConfig conf = new APIConfig();

    // Get the directory path and list all PNG files
    String dirPath = conf.getPdfloc() +  "../img/";
    File dir = new File(dirPath);
    File[] files = dir.listFiles(new FilenameFilter() {
        public boolean accept(File dir, String name) {
            return name.toLowerCase().endsWith(".png");
        }
    });

    // Iterate through the PNG files and display each as an <img> tag
    for (File file : files) {
        String filename = file.getName();
        String filepath = file.getAbsolutePath();
%>
        <img src="img.jsp?filename=<%=filename.replaceAll("\\.png$", "") %>" alt="<%=filename%>"><br>
<%
    }
%>

</body>
</html>
