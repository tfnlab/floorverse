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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
  <link href="aos/aos.css" rel="stylesheet">
</head>
<body>


  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center">
      <h1 class="logo me-auto"><a href="index.html">Meme Genesis</a></h1>
      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto" href="https://mint.memegenesis.com">Mint</a></li>
          <li><a class="nav-link scrollto" href="https://opensea.io/collection/meme-genesis-1">OpenSea</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->
    </div>
  </header><!-- End Header -->

  <div class="container mt-5">
      <HR>
      <h4>The Art of Meme</h4>
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

          <%
             if (meme_text != null && meme_text.trim().length() > 0) {
                File newimage = new File(dirPath + uuid + ".png");
                if (newimage.exists()) {
                  %>
                  <!--<small><%=ocrDescription%></small>-->
                        <HR><a href="index.meme.jsp?meme_id=<%=uuid %>" >
                  <img src="img.jsp?filename=<%=uuid %>" alt="<%=uuid %>">
                            </a>
                  <%
                } else {
                  %>
                    There was an error trying to generate meme, please try again
                  <%
                }
             }
          %>
        <HR>
        The Total Number of Memes Created stands at <%=files.length%>
        <HR>
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
  <script src="aos/aos.js"></script>
</body>
</html>
