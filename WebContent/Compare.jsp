<%@page import="com.Twitter.DatabaseConnection"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%! double neu = 0, pos = 0, neg = 0; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"	/>
<link href="style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
#dropdown{
	width : 200px;
	height : 30px;
	font-size : 15px;
}
#submission{
width : 5em;
	size : 11em;
	font-size : 15px;
}
</style>
<title>Twitter Analysis</title>
</head>
<body>
<div id="container">
  <div id="banner">
    <h3><a href="TwitterEvaluation.jsp"> Home page</a></h3>
    <h1> Sentiment Analysis</h1>
  </div>
  <div id="sidebar">
    <h1> Features </h1>
    <div id="navcontainer">
      <ul id="navlist">
        <li id="active">
       	<li><a href="TwitterEvaluation.jsp">Home</a></li>
        <li><a href="History.jsp">Sentiment History</a></li>
        <li><a href="GeoLocations.jsp">Search by Country</a></li>
        <li><a href="Compare.jsp">Compare your searches</a></li>
		        
      </ul>
    </div>
    
  </div>
  <div id="content" style="min-height : 500px;">
<em> <h2> please enter the two keywords you want to compare </h2> </em>

		<form id="tfnewsearch" method="get" action="Comparision.jsp">
		<div id="tfheader">
			Insert your first keyword  <input type="text" placeholder="Enter keyword1" class="tftextinput" name="keyword" size="60"
				maxlength="140"> <br />
			Insert your second keyword	<input type="text" placeholder="Enter keyword2" class="tftextinput" name="keyword1" size="60"
				maxlength="140"><br />
				<input type="submit" value="Submit">  
		</div>
		</form>			    
</div>
<div style="clear:both;"></div>
  
  <div style="clear:both;"></div>
  <div id="footer"> 
 <span align = "center">  This website contains fictional information and is created by Sai-Keerthi-Chandu Seshadri as a part of Software Project.</span> </div>
</div>
</body>
</html>