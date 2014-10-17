package com.Twitter;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.DriverManager;
import java.util.List;
import java.util.Map;

import twitter4j.Status;

public class SentimentAnalysis {
	public static void main(String[] args) {

		TwitterTweets t = new TwitterTweets();
	//	List<Status> tweets = t.getTweets("Finland");
		AnalyseTweets p = new AnalyseTweets();
		MapsInitialisation maps = new MapsInitialisation();
		try {
			Map<String,String[]> cou = maps.getCountriesMap();
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
			try {
				System.out.println(p.Analyse("I was v€ry h@ppy but, i am sad now"));
				/*List<Status> tweets = t.getTweets("chandu");
			int neu = 0, pos = 0, neg = 0;
			if (tweets.size() > 0) {
				for (Status s : tweets) {
					double score = p.Analyse(s.getText());
					System.out.println(s.getText() + "  " + score);
					if (score == 0) {
						neu++;
					} else if (score < 0) {
						neg++;
					} else
						pos++;
				}
				System.out.println("Positive " + pos);
				System.out.println("Negative " + neg);
				System.out.println("Neutral " + neu); 
			} 
			else
				System.out.println("The score is 0"); */
		} 
		catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	

	}

