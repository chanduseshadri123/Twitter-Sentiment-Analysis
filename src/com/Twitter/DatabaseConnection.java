package com.Twitter;
import java.util.Calendar;
import java.util.Date;
import java.sql.*;
import java.text.*;

public class DatabaseConnection {
		static Connection myConnection;
		static Statement myStatement;
		static ResultSet myResultSet;

		static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		static final String DB_URL = "jdbc:mysql://localhost:8889/";
		static final String DB_NAME = "twitter";
		static final String USER = "root";
		static final String PASS = "root";
		public void databaseEntry(int positive, int negative, int neutral, String keyword) {
				System.out.println("Positive " + positive);
				System.out.println("Negative " + negative);
				System.out.println("Neutral " + neutral);
				try{
				Class.forName(JDBC_DRIVER);
			    myConnection = DriverManager.getConnection(DB_URL + DB_NAME,USER,PASS);
			    myStatement = myConnection.createStatement();
			    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
				   Date date = new Date();
			      myStatement.executeUpdate("INSERT INTO keywordInfo values('" + keyword + "','"+ dateFormat.format(date)  + "','" + positive + "','" + neutral + "','" + negative + "');");
			      myConnection.close();
			   }catch(SQLException se){
			      //Handle errors for JDBC
			      se.printStackTrace();
			   }catch(Exception e){
			      //Handle errors for Class.forName
			      e.printStackTrace();
			   }finally{
			      //finally block used to close resources
			      try{
			         if(myStatement!=null)
			        	 myStatement.close();
			      }catch(SQLException se2){
			      }// nothing we can do
			      try{
			         if(myConnection!=null)
			        	 myConnection.close();
			      }catch(SQLException se){
			         se.printStackTrace();
			      }
			   }
	       
		}
		public double[] databaseHistory(int day, String keyword){
			   double[] scores = new double[3];
			try{
					Class.forName(JDBC_DRIVER);
			      myConnection = DriverManager.getConnection(DB_URL + DB_NAME,USER,PASS);
			      myStatement = myConnection.createStatement();
			      DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/");
				  Date date = new Date();
				  Calendar cal = Calendar.getInstance();
				  cal.setTime(date);
				  int today = cal.get(Calendar.DAY_OF_MONTH);
				  day = today - day;
				  String sql = "SELECT AVG(Positive),AVG(Negative),AVG(Neutral) FROM keywordInfo WHERE Keyword='" + keyword + "' AND DateOfSearch='" + dateFormat.format(date) + "" + day + "';";
				  myResultSet = myStatement
							   .executeQuery(sql);
				  int i = 0;
				  while(myResultSet.next()){
				    scores[i++] = myResultSet.getDouble("AVG(Positive)");
				    scores[i++] = myResultSet.getDouble("AVG(Negative)");
				    scores[i] = myResultSet.getDouble("AVG(Neutral)");	
				  }
			      myConnection.close();
			   }
				catch(SQLException se){
			      //Handle errors for JDBC
			      se.printStackTrace();
			   }catch(Exception e){
			      //Handle errors for Class.forName
			      e.printStackTrace();
			   }finally{
			      //finally block used to close resources
			      try{
			         if(myStatement!=null)
			        	 myStatement.close();
			      }catch(SQLException se2){
			      }// nothing we can do
			      try{
			         if(myConnection!=null)
			        	 myConnection.close();
			      }catch(SQLException se){
			         se.printStackTrace();
			      }
			   }
			return scores;
		}
		}


