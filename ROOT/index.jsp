<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.UUID" %>
<!DOCTYPE HTML>
<!--
	Multiverse by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Multiverse by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<h1><a href="index.html"><strong>Multiverse</strong> by HTML5 UP</a></h1>
						<nav>
							<ul>
								<li><a href="#footer" class="icon solid fa-info-circle">About</a></li>
							</ul>
						</nav>
					</header>
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
				<!-- Main -->
					<div id="main">
						<% for (File file : files) { %>
								<article class="thumb">
									<a href="index.meme.jsp?meme_id=<%=file.getName().replaceAll("\\.png$", "") %>" class="image"><img src="img.jsp?filename=<%=file.getName().replaceAll("\\.png$", "") %>" alt="" /></a>
									<h2>Magna feugiat lorem</h2>
									<p>Nunc blandit nisi ligula magna sodales lectus elementum non. Integer id venenatis velit.</p>
								</article>
		        <%}%>
					</div>

				<!-- Footer -->
					<footer id="footer" class="panel">
						<div class="inner split">
							<div>
								<section>
									<h2>Magna feugiat sed adipiscing</h2>
									<p>Nulla consequat, ex ut suscipit rutrum, mi dolor tincidunt erat, et scelerisque turpis ipsum eget quis orci mattis aliquet. Maecenas fringilla et ante at lorem et ipsum. Dolor nulla eu bibendum sapien. Donec non pharetra dui. Nulla consequat, ex ut suscipit rutrum, mi dolor tincidunt erat, et scelerisque turpis ipsum.</p>
								</section>
								<section>
									<h2>Follow me on ...</h2>
									<ul class="icons">
										<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
										<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
										<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
										<li><a href="#" class="icon brands fa-github"><span class="label">GitHub</span></a></li>
										<li><a href="#" class="icon brands fa-dribbble"><span class="label">Dribbble</span></a></li>
										<li><a href="#" class="icon brands fa-linkedin-in"><span class="label">LinkedIn</span></a></li>
									</ul>
								</section>
								<p class="copyright">
									&copy; Unttled. Design: <a href="http://html5up.net">HTML5 UP</a>.
								</p>
							</div>
							<div>
								<section>
									<h2>Get in touch</h2>
									<form method="post" action="#">
										<div class="fields">
											<div class="field half">
												<input type="text" name="name" id="name" placeholder="Name" />
											</div>
											<div class="field half">
												<input type="text" name="email" id="email" placeholder="Email" />
											</div>
											<div class="field">
												<textarea name="message" id="message" rows="4" placeholder="Message"></textarea>
											</div>
										</div>
										<ul class="actions">
											<li><input type="submit" value="Send" class="primary" /></li>
											<li><input type="reset" value="Reset" /></li>
										</ul>
									</form>
								</section>
							</div>
						</div>
					</footer>

			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.poptrox.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>
