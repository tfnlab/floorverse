<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.UUID" %>

<html>
<head>
  <style>
    .thumbnail img {
      width: 100%;
      height: auto;
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 5px;
      box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1);
    }
</style>
<title>PNG Files</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</head>
<body>
  <div class="container mt-5">
  <h1>Create a Meme</h1>
  <form method="POST" action="index.jsp">
    <div class="form-group">
      <label for="meme-text">Enter the subject for your meme:</label>
      <input type="text" class="form-control" id="meme_text" name="meme_text">
    </div>
    <HR>
    <button type="submit" class="btn btn-primary">Create Meme</button>
  </form>

<%
    // Create an instance of the APIConfig class
    String meme_text = request.getParameter("meme_text");
    String uuid = java.util.UUID.randomUUID().toString();
    String ocrDescription = "";


    // Validate form data
    if (meme_text != null && meme_text.trim().length() > 0) {

      try{
           Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/meme.py", "'" + meme_text + "'", uuid).start();
           String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
           String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
           ocrDescription = stdout + stderr + " MEME " ;

       }catch(IOException ex){
           ocrDescription = ex.getMessage();
       }

    }
    APIConfig conf = new APIConfig();

    // Get the directory path and list all PNG files
    String dirPath = conf.getPdfloc() +  "../img/";
    File dir = new File(dirPath);
    File[] files = dir.listFiles(new FilenameFilter() {
        public boolean accept(File dir, String name) {
            return name.toLowerCase().endsWith(".png");
        }
    });
    %>
    <HR>
    <%=ocrDescription%>
    <HR>
      <img src="img.jsp?filename=<%=uuid %>" alt="<%=uuid %>">
    <HR>
<div class="d-flex flex-wrap">
  <% for (File file : files) { %>
    <div class="p-2">
      <div class="thumbnail">
        <img src="img.jsp?filename=<%=file.getName().replaceAll("\\.png$", "") %>" alt="<%=file.getName() %>">
      </div>
    </div>
  <% } %>
</div>

  </div>
</body>
</html>
