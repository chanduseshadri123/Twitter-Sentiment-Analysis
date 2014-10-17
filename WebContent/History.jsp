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
#content{
min-height : 300px;
}
</style>
<title>Twitter Analysis</title>
</head>
<body>
<div id="container">
  <div id="banner">
    <h3><a href="TwitterEvaluation.jsp"> homepage</a></h3>
    <h1> Setiment Analysis</h1>
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
<em> <h2> please select the day on which you want to find the analysis on </h2> </em>
<form id="tfnewsearch" method="get">
		<div id="tfheader">
			Insert your keyword  <input type="text" placeholder="Enter keyword.." class="tftextinput" name="keyword" size="60"
				maxlength="140"> <br />
			<select name="Days" id="dropdown">
  <option value="1 Day">1 Day</option>
  <option value="2 Days">2 Days</option>
  <option value="3 Days">3 Days</option>
  <option value="4 Days">4 Days</option>
  <option value="5 Days">5 Days</option>
  <option value="6 Days">6 Days</option>
  <option value="7 Days">7 Days</option>
</select> <br />
				<input type="submit" value="Submit">  
		</div>
		</form>		
		



<%
		if(request.getParameter("Days") != null){
			int day = (request.getParameter("Days").charAt(0)) - 48;
			DatabaseConnection db = new DatabaseConnection();
			double[] scores = db.databaseHistory(day, request.getParameter("keyword").toString());
			if(scores[0] == 0 && scores[1] == 0 && scores[2] == 0){
			%>
			<h1>Sorry we don't have any search results for '<%=request.getParameter("keyword")%>' before <%=request.getParameter("Days")%></h1>
			<% 
			}
			else{
				for(int i = 0; i < scores.length; i++)
					
				pos = scores[0];
				neg = scores[1];
				neu = scores[2];

%>
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
					    <script type="text/javascript">

					      // Load the Visualization API and the piechart package.
					      google.load('visualization', '1.0', {'packages':['corechart']});

					      // Set a callback to run when the Google Visualization API is loaded.
					      google.setOnLoadCallback(drawChart);

					      // Callback that creates and populates a data table,
					      // instantiates the pie chart, passes in the data and
					      // draws it.
					      function drawChart() {

					        // Create the data table.
					        var data = new google.visualization.DataTable();
					        data.addColumn('string', 'Topping');
					        data.addColumn('number', 'Slices');
					        data.addRows([
					          ['Positive', <%=pos%>],
					          ['Negative', <%=neg%>],
					          ['Neutral', <%=neu%>]
					        ]);

					        // Set chart options
					        var options = {'title':'Analysis',
					                       'width':400,
					                       'height':300,
					                       backgroundColor: '#D8D8D8',
					                        };
					  

					        // Instantiate and draw our chart, passing in some options.
					        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
					        chart.draw(data, options);
					      }
					    </script>
					    <h2>Twitter Analysis for the keyword <%=request.getParameter("keyword")%> before <%=request.getParameter("Days")%> </h2>
					    <div id="chart_div" align="center"></div>
					    <h1>Positive : <%=pos%></h1>
					    <h1>Negative : <%=neg%></h1>
					    <h1>Neutral : <%=neu%></h1>
						</div>
				<%}
				}
				
			 %>
<div style="clear:both;"></div>
  
  <div style="clear:both;"></div>
</div>
<div id="footer"> 
 <span align = "center">  This website contains fictional information and is created by Sai-Keerthi-Chandu Seshadri as a part of Software Project.</span> </div>
</body>
</html>