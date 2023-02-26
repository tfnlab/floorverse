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
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    &nbsp;&nbsp;<a class="navbar-brand" href="index.jsp">Meme Genesis</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="https://mint.memegenesis.com">Mint</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="https://opensea.io/collection/meme-genesis-1">OpenSea</a>
        </li>
      </ul>
    </div>
  </nav>


  </div>
  <% String meme_id = request.getParameter("meme_id"); %>
  <div class="container mt-5">
  <h4>The Art of Meme</h4>
  <HR>
<div class="d-flex flex-wrap">
    <div class="p-2">
      <div class="thumbnail">
        <a href="index.meme.jsp?meme_id=<%=meme_id %>" ><img src="img.jsp?filename=<%=meme_id %>" alt="<%=meme_id %>"></a>
      </div>
    </div>
</div>

  </div>
</body>
</html>
