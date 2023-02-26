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
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Meme Genesis</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="https://mint.memegenesis.com" target="_blank">Mint</a>
        </li>
      </ul>
    </div>
  </nav>

  <div class="container mt-5">
  <h4>The Art of Memes</h4>
  <HR>
  <form method="POST" action="index.jsp">

      <div class="form-group">
    <label for="popular-meme-subjects">Select a Popular Meme Subject:</label>
    <select name="popular_meme_subjects" id="popular_meme_subjects" class="form-control" >
      <option value="pepe">Pepe</option>
      <option value="doge">Doge</option>
      <option value="grumpy-cat">Grumpy Cat</option>
      <option value="bad-luck-brian">Bad Luck Brian</option>
      <option value="distracted-boyfriend">Distracted Boyfriend</option>
      <option value="success-kid">Success Kid</option>
      <option value="drake-hotline-bling">Drake Hotline Bling</option>
      <option value="woman-yelling-at-a-cat">Woman Yelling at a Cat</option>
      <option value="surprised-pikachu">Surprised Pikachu</option>
      <option value="this-is-fine">This is Fine</option>
      <option value="rickroll">Rickroll</option>
      <option value="expanding-brain">Expanding Brain</option>
      <option value="the-dress">The Dress</option>
      <option value="hide-the-pain-harold">Hide the Pain Harold</option>
      <option value="y-u-no">Y U No</option>
      <option value="shut-up-and-take-my-money">Shut Up and Take My Money</option>
      <option value="aliens-guy">Aliens Guy</option>
      <option value="two-buttons">Two Buttons</option>
      <option value="ight-imma-head-out">Ight Imma Head Out</option>
      <option value="arthur-fist">Arthur Fist</option>
    </select>
    </div>

    <HR>
    <div class="form-group">
      <label for="meme-text">Enter the topic for your meme: (NFT, Degen, WAGMI ...)</label>
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
      meme_text += " sujbect " + request.getParameter("popular_meme_subjects") ;
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
      <% if (meme_text != null && meme_text.trim().length() > 0) {%>
    <!--<small><%=ocrDescription%></small>-->
          <HR>
    <img src="img.jsp?filename=<%=uuid %>" alt="<%=uuid %>">
      <% } %>
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
