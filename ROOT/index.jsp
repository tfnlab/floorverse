<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.UUID" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>PhotoFolio Bootstrap Template - Index</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Inter:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Cardo:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/main.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: PhotoFolio - v1.2.0
  * Template URL: https://bootstrapmade.com/photofolio-bootstrap-photography-website-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="header d-flex align-items-center fixed-top">
    <div class="container-fluid d-flex align-items-center justify-content-between">

      <a href="index.jsp" class="logo d-flex align-items-center  me-auto me-lg-0">
        <!-- Uncomment the line below if you also wish to use an image logo -->
        <!-- <img src="assets/img/logo.png" alt=""> -->
        <h1>Meme Genesis</h1>
      </a>

      <nav id="navbar" class="navbar">
        <ul>
          <li><a href="https://mint.memegenesis.com">Mint</a></li>
          <li><a href="https://opensea.io/collection/meme-genesis-1">OpenSea</a></li>
          <!--
          <li><a href="about.html">About</a></li>
          <li class="dropdown"><a href="#"><span>Gallery</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
            <ul>
              <li><a href="gallery.html">Nature</a></li>
              <li><a href="gallery.html">People</a></li>
              <li><a href="gallery.html">Architecture</a></li>
              <li><a href="gallery.html">Animals</a></li>
              <li><a href="gallery.html">Sports</a></li>
              <li><a href="gallery.html">Travel</a></li>
              <li class="dropdown"><a href="#"><span>Sub Menu</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
                <ul>
                  <li><a href="#">Sub Menu 1</a></li>
                  <li><a href="#">Sub Menu 2</a></li>
                  <li><a href="#">Sub Menu 3</a></li>
                </ul>
              </li>
            </ul>
          </li>
          <li><a href="services.html">Services</a></li>
          <li><a href="contact.html">Contact</a></li>
          -->
        </ul>
      </nav><!-- .navbar -->

      <div class="header-social-links">
        <a href="https://twitter.com/genesis_meme" class="twitter"><i class="bi bi-twitter"></i></a>
        <!--
        <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
        <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
        <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></i></a>
        -->
      </div>
      <i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i>
      <i class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>

    </div>
  </header><!-- End Header -->

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
        String dirPath = "/var/lib/tomcat9/floorverse/ROOT/meme/";
        File dir = new File(dirPath);
        File[] files = dir.listFiles(new FilenameFilter() {
            public boolean accept(File dir, String name) {
                return name.toLowerCase().endsWith(".png");
            }
        });

          %>
  <!-- ======= Hero Section ======= -->
  <section id="hero" class="hero d-flex flex-column justify-content-center align-items-center" data-aos="fade" data-aos-delay="1500">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6 text-center">
          <h2>The <span>Art</span> of meme</h2>
          <p>
            The Realm of Memetic Delight is a world where memes are the currency and the creative minds who can make the funniest ones hold the keys to the kingdom. In this land, laughter and creativity reign supreme, making it a beacon of humor and inspiration in an often bleak world.
            The Total Number of Memes Created stands at <%=files.length%>
          </p>
          <a href="https://mint.memegenesis.com" class="btn-get-started">Available for mint at 0.01 ETH</a>
        </div>
        <div class="mt-5">
          <%
          if (meme_text != null && meme_text.trim().length() > 0) {
             File newimage = new File(dirPath + uuid + ".png");
             if (newimage.exists()) {
               %>
               <!--<small><%=ocrDescription%></small>-->
                     <HR>
                     <a href="index.meme.jsp?meme_id=<%=uuid %>" >
               <img src="img.jsp?filename=<%=uuid %>" alt="<%=uuid %>">
                     </a>
                         <HR>
               <%
             } else {
               %>
                 There was an error trying to generate meme, please try again
               <%
             }
          }
          %>
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
        </div>

      </div>
    </div>
  </section><!-- End Hero Section -->

  <main id="main" data-aos="fade" data-aos-delay="1500">

    <!-- ======= Gallery Section ======= -->
    <section id="gallery" class="gallery">
      <div class="container-fluid">
        <div class="row gy-4 justify-content-center">
        <% for (File file : files) { %>
            <div class="col-xl-3 col-lg-4 col-md-6">
              <div class="gallery-item h-100">
                <img src="meme/<%=file.getName()%>" class="img-fluid" alt="">
                <div class="gallery-links d-flex align-items-center justify-content-center">
                  <a href="index.meme.jsp?meme_id=<%=file.getName().replaceAll("\\.png$", "") %>" class="details-link"><i class="bi bi-link-45deg"></i></a>
                </div>
              </div>
            </div>
        <%}%>
        </div>
      </div>
    </section><!-- End Gallery Section -->

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="container">
      <div class="copyright">
        &copy; Copyright <strong><span>TFNLab</span></strong>. All Rights Reserved
      </div>
      <div class="credits">
        <!-- All the links in the footer should remain intact. -->
        <!-- You can delete the links only if you purchased the pro version. -->
        <!-- Licensing information: https://bootstrapmade.com/license/ -->
        <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/photofolio-bootstrap-photography-website-template/ -->
        Designed by <a href="https://TFNLab.com/">TFNLab.com</a>
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <div id="preloader">
    <div class="line"></div>
  </div>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>
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
