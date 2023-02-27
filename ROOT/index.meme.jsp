<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.mg.mysql.Review" %>
<%@ page import="com.tfnlab.mg.mysql.ReviewDAO" %>
<%@ page import="java.sql.Timestamp" %>
<% String meme_id = request.getParameter("meme_id"); %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>[Template] Sample Inner Page</title>
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

  <main id="main" data-aos="fade" data-aos-delay="1500">

    <!-- ======= End Page Header ======= -->


    <section class="sample-page">
      <div class="container" data-aos="fade-up">

        <p>
          <img src="img.jsp?filename=<%=meme_id %>" alt="<%=meme_id %>">
          <HR>
            Share On Tweeter
          <a href="https://twitter.com/share?text=hey%20@genesis_meme%20Check%20out%20this%20meme!%20%23MemeEngagement%20%23LaughOutLoud%20%23NFT%20%23MEMEGENESIS&url=https://memegenesis.com/index.meme.jsp?meme_id=<%=meme_id %>" target="_blank">
            <i class="bi bi-twitter"></i>
          </a>

        </p>

      </div>

      <div class="container mt-5">
      <%
        ReviewDAO reviewDAO = new ReviewDAO();
        if (request.getMethod().equals("POST")) {
            // Get the form data and create a new Review object
          int memeId = Integer.parseInt("0");
          String meme_uuid = request.getParameter("meme_id");
          int rating = Integer.parseInt(request.getParameter("rating"));
          String comment = request.getParameter("comment");
          Timestamp now = new Timestamp(System.currentTimeMillis());
          Review review = new Review(0, memeId, rating, comment, now, now, meme_uuid);

          // Use the ReviewDAO object to insert the new review into the database
          try {
            reviewDAO.insertReview(review);
            out.println("<p class='text-success'>Review added successfully!</p>");
          } catch (Exception e) {
            e.printStackTrace();
            out.println("<p class='text-danger'>Error adding review.</p> ");
          }
        }
      %>
      <form action="index.meme.jsp" method="post">
          <input type="hidden" class="form-control" id="meme_id" name="meme_id" required value="<%=meme_id %>">
        <div class="form-group">
          <label for="rating">Rating:</label>
          <select class="form-control" id="rating" name="rating" required>
            <option value="">-- Select Rating --</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
          </select>
        </div>
        <div class="form-group">
          <label for="comment">Comment:</label>
          <textarea class="form-control" id="comment" name="comment" rows="3"></textarea>
        </div>
        <HR>
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>

        </div>

          <div class="container mt-5">
            <% double averageRating = reviewDAO.getAverageRatingByMemeUUID(meme_id); %>
            <p>Average Rating: <%= averageRating %></p>
              <HR>
        <% List<Review> reviews = reviewDAO.getAllReviewsByMemeUUID(meme_id); %>

        <% for (Review review : reviews) { %>
            <div class="mt-2">
                <p>Rating: <%= review.getRating() %></p>
                <p>Comment: <%= review.getComment() %></p>
            </div>
        <% } %>

      </div>
    </section>

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
        Designed by <a href="https://tfnlab.com/">TFNLab</a>
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

</body>

</html>
