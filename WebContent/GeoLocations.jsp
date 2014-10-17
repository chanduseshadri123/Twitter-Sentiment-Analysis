<%@page import="twitter4j.*"%>
<%@page import="com.Twitter.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.sql.*"%>
<%! int neu = 0, pos = 0, neg = 0; %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Twitter Analysis</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="style.css" rel="stylesheet" type="text/css" />
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
  <div id="content">
	<form id="tfnewsearch" method="get">
		<div id="tfheader">
			Enter your keyword  <input type="text" placeholder="Enter keyword..." class="tftextinput" name="keyword" size="60"
				maxlength="140"> <br />
			Enter the country you want the tweets about	<input type="text" placeholder="Enter country" class="tftextinput" name="country" size="60"
				maxlength="140"><br />
				<input type="submit" value="Submit">  
		</div>
		</form>		
		<%
				if (request.getParameter("keyword") != null && request.getParameter("country") != null) {
					TwitterTweets t = new TwitterTweets();
					MapsInitialisation maps = new MapsInitialisation();
					Map<String,String[]> countries = maps.getCountriesMap();
					String country = request.getParameter("country").toString();
					country = country.toLowerCase();
					if(countries.containsKey(country)){
						String[] arr = countries.get(country);
						t.latitude = Double.parseDouble(arr[0]);
						t.longitude = Double.parseDouble(arr[1]);
						List<Status> tweets = t.getTweets(request.getParameter("keyword")
							.toString());
						AnalyseTweets p = new AnalyseTweets();
						List<String> al = new ArrayList<String>();
						try { 
						
							if (tweets.size() > 0) {
								%>
								<div id="chart_div" align="center"></div>
								<% 
								for (Status s : tweets) {
									double score = p.Analyse(s.getText());

								if (score == 0) {
								%>
								<div class="neutral">
								<% 
								out.write(s.getText() + "<BR />");
								neu++;
								%>
								</div>
							<%
							}							
							else if (score < 0) {
								%>
								<div class="neutral" style="color : #f00">
								<%
								out.write(s.getText() + "<BR />");
								neg++;
								%>
								</div>
							<%
							} else{
								%>
								<div class="neutral" style="color : #00f">
								<%
								out.write(s.getText() + "<BR />");
								pos++;
								%>
								</div>
								<%
							}
						
								
							%> 
							<% 
						}
						DatabaseConnection db = new DatabaseConnection();
						db.databaseEntry(pos,neg,neu,request.getParameter("keyword")
								.toString());
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
						
					<% 
						
					} else
						System.out.println("The score is 0");
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
						
			}
					
					else{
						%>
						<h1>Please enter a valid country</h1>
						<%
					}
		}
		
		%>
	</div>


  
      </div>
  <div style="clear:both;"></div>
  
  <div style="clear:both;"></div>
  <div id="footer"> 
 <span align = "center">  This website contains fictional information and is created by Sai-Keerthi-Chandu Seshadri as a part of Software Project.</span> </div>
</div>
</body>
</html>
