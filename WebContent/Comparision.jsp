<%@page import="com.Twitter.DatabaseConnection"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="twitter4j.*"%>
<%@page import="com.Twitter.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.sql.*"%>
<%! int neu = 0, pos = 0, neg = 0, pos1 = 0, neu1 = 0, neg1 = 0; %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"	/>

<style type="text/css">
body{
	background-color : #f0e9dd;
}
#left{
float : left;
width : 45%;
margin-left : 3%;
}
#right{
float : right;
width : 45%;
margin-right : 3%;
}
.neutral {
  display: inline-block;
  padding: 16px 16px 16px 16px;
  margin: 5px 0;
  width : 95%;
  height:50px;
  border: #ddd 1px solid;
  border-top-color: #eee;
  border-bottom-color: #bbb;
  border-radius: 5px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.15);
  font: bold 14px/18px Helvetica, Arial, sans-serif;
  color: #FFA500;
}
</style>
<title>Twitter Analysis</title>
</head>
<body>
	<div id="left">
					<div align="center"><h2><%=request.getParameter("keyword").toString()%><h2></div>	
						    <div id="chart_div" align="center"></div>
	
				<%
				String keyword = "";
				if (request.getParameter("keyword") != null) {
					 keyword = request.getParameter("keyword").toString();
					TwitterTweets t = new TwitterTweets();
					List<Status> tweets = t.getTweets(keyword);
					AnalyseTweets p = new AnalyseTweets();
					List<String> al = new ArrayList<String>();
					try { 
						
						if (tweets.size() > 0) {
							for (Status s : tweets) {
								double score = p.Analyse(s.getText());
								if (score == 0) {
								%>
								<div class="neutral">
								<% 
									out.write(s.getText() + "<BR />");
									neu1++;
								%>
								</div>
							<%
							}							
							else if (score < 0) {
								%>
								<div class="neutral" style="color : #f00">
								<%
								out.write(s.getText() + "<BR />");
								neg1++;
								%>
								</div>
							<%
							} else{
								%>
								<div class="neutral" style="color : #00f">
								<%
								out.write(s.getText() + "<BR />");
								pos1++;
								%>
								</div>
								<%
							}			
						}
						
						DatabaseConnection db = new DatabaseConnection();
						db.databaseEntry(pos1,neg1,neu1,keyword);
			
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
					          ['Positive', <%=pos1%>],
					          ['Negative', <%=neg1%>],
					          ['Neutral', <%=neu1%>]
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
		
	</div>
	
	<div id="right">
	<div align="center"><h2><%=request.getParameter("keyword1").toString()%><h2></div>
	  <div id="chart_div1" align="center"></div>
					<%
					
				if ( request.getParameter("keyword1") != null) {
					String keyword1 = request.getParameter("keyword1").toString();
					TwitterTweets t = new TwitterTweets();
					List<Status> tweets = t.getTweets(keyword1);
					AnalyseTweets p = new AnalyseTweets();
					List<String> al = new ArrayList<String>();
					try { 
						
						if (tweets.size() > 0) {
							for (Status s : tweets) {
								double score = p.Analyse(s.getText());
							%>
													<% 
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
						db.databaseEntry(pos,neg,neu,keyword1);
						%>				
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
					        var chart = new google.visualization.PieChart(document.getElementById('chart_div1'));
					        chart.draw(data, options);
					      }
					    </script>
					  	</div>
</body>
</html>