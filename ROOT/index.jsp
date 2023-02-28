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

<title>Meme Genesis</title>
<meta name="description" content="Meme Genesis is a website that provides a collection of the latest and most popular memes on the internet. Our website is updated daily with new memes, and we have a community section where users can submit their own memes. Join us to stay up-to-date with the funniest memes on the web!">
<meta name="keywords" content="meme, memes, funny memes, internet memes, viral memes, popular memes, meme collection, meme community, submit memes">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
      <a class="navbar-brand" href="index.jsp">Meme Genesis</a>
      <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
        <li class="nav-item active">
          <a class="nav-link" href="index.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="https://mint.memegenesis.com">Mint</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="https://opensea.io/collection/meme-genesis-1">OpenSea</a>
        </li>
      </ul>
      <!--
      <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
      </form>
      -->
    </div>
  </nav>

  <div class="container mt-5">
      <h4>The Art of Meme</h4>

    <%
        // Create an instance of the APIConfig class
        String meme_text = request.getParameter("meme_text");
        String uuid = java.util.UUID.randomUUID().toString();
        String ocrDescription = "";


        // Validate form data
        if (meme_text != null && meme_text.trim().length() > 0) {
          meme_text += " " + request.getParameter("popular_meme_subjects") ;
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
        Ladies and gentlemen, we've got ourselves a number. And it's not just any old number, no sir. It's the Total Number of Memes Created - a mind-boggling <%=files.length%>!

        This number may seem insignificant to the untrained eye, but to the true meme connoisseur, it represents a veritable gold mine of comedic genius. With every new meme created, a spark of inspiration is born, a flame of laughter that spreads like wildfire through the digital world.

        So, my dear friends, whether you're a seasoned veteran of the meme game or a fresh-faced newcomer, take heed of this number. It's not just a number - it's a statement, a challenge, a call to arms. Will you be the one to create the <%=files.length +1%> meme? The <%=files.length +2%>? The 1,000th?

        The choice is yours, my friends. <a href="https://mint.memegenesis.com">Mint</a> or <a href="https://opensea.io/collection/meme-genesis-1">Buy</a>, create or consume - the world of memes is waiting for you. So what are you waiting for? Let's get memeing!
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
            <option value="drake_hotline_bling">Drake Hotline Bling</option>
            <option value="pikachu_surprised">Pikachu Surprised</option>
            <option value="kermit-tea">Kermit Tea</option>
            <option value="crying-cat">Crying Cat</option>
            <option value="confused-mr-krabs">Confused Mr. Krabs</option>
            <option value="dank-meme">Dank Meme</option>
            <option value="mocking-spongebob">Mocking Spongebob</option>
            <option value="evil-toddler">Evil Toddler</option>
            <option value="travolta-confused">Travolta Confused</option>
            <option value="distracted-puppy">Distracted Puppy</option>
            <option value="gru-plan">Gru Plan</option>
            <option value="karen">Karen</option>
            <option value="roll-safe">Roll Safe</option>
            <option value="wait-thats-illegal">Wait, That's Illegal</option>
            <option value="spongebob-imagination">Spongebob Imagination</option>
            <option value="savage-patrick">Savage Patrick</option>
            <option value="you-know-i-had-to-do-it-to-em">You Know I Had to Do It to Em</option>
            <option value="mr-bean">Mr. Bean</option>
            <option value="the-most-interesting-man-in-the-world">The Most Interesting Man in the World</option>
            <option value="bad-joke-eel">Bad Joke Eel</option>
            <option value="change-my-mind">Change My Mind</option>
          </select>
          </div>

          <HR>
          <div class="form-group">
            <label for="meme-text">Enter the topic for your meme: (NFT, Degen, WAGMI ...)</label>
            <input type="text" class="form-control" id="meme_text" name="meme_text" required>
          </div>
          <HR>
          <button type="submit" class="btn btn-primary">Create Meme</button>
        </form>
        <!--<small><%=ocrDescription%></small>-->
        <%
           if (meme_text != null && meme_text.trim().length() > 0) {
              File newimage = new File(dirPath + uuid + ".png");
              if (newimage.exists()) {
                %>
                <!--<small><%=ocrDescription%></small>-->
                      <HR><a href="index.meme.jsp?meme_id=<%=uuid %>" >
                <img src="img.jsp?filename=<%=uuid %>" alt="<%=uuid %>">
                          </a>
                          <HR>
                <%
              } else {
                %>
                  There was an error trying to generate meme, please try again
                <%
              }
           }else{
             %><HR><%
           }
        %>
    <div class="d-flex flex-wrap">
      <% for (File file : files) { %>
        <div class="p-2">
          <div class="thumbnail">
            <a href="index.meme.jsp?meme_id=<%=file.getName().replaceAll("\\.png$", "") %>" ><img src="img.jsp?filename=<%=file.getName().replaceAll("\\.png$", "") %>" alt="<%=file.getName() %>"></a>
          </div>
        </div>
      <% } %>
    </div>

  </div>
  <!-- Google tag (gtag.js) -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-HH16PDS3VF"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'G-HH16PDS3VF');
  </script>
</body>
</html>
