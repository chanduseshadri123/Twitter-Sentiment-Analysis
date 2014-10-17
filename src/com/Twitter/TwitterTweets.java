package com.Twitter;

import twitter4j.*;
import twitter4j.conf.ConfigurationBuilder;

import java.util.List;

public class TwitterTweets {
	public double latitude = 1111111111.0;
	public double longitude = 1111111111.0;
	public List<Status> getTweets(String keyword){
		ConfigurationBuilder cb = new ConfigurationBuilder();
		cb.setDebugEnabled(true)
				.setOAuthConsumerKey("rUEPFP7VbEz3ayES6SiNRd6Mq")
				.setOAuthConsumerSecret(
						"BuIWGBXV9UacemjoFjqO9S4QzLZaIpLGwho7Tcf9y5EeBrx3Eg")
				.setOAuthAccessToken(
						"154129414-c9vNX0JL3NqxOpOqeQyuQpRcQIcalcvWYXr2QuTs")
				.setOAuthAccessTokenSecret(
						"l3KfVyt39u3zCCaF33ao0Ei7rYWPEosSwVB0JLKCvFq52");
		TwitterFactory tf = new TwitterFactory(cb.build());
		Twitter twitter = tf.getInstance();
		if (keyword.length() < 1) {
			System.out.println("Insert your arguments");
			System.exit(-1);
		}
		try {
			Query query = new Query(keyword + " -RT");
			query.setCount(100);
			query.setLang("en");
			if(latitude != 1111111111.0 && longitude != 1111111111.0)
				query.setGeoCode(new GeoLocation(latitude, longitude), 350, "km");
			QueryResult result;
			result = twitter.search(query);
			
			List<Status> tweets = result.getTweets();
			return tweets;
		} catch (TwitterException te) {
			te.printStackTrace();
			System.out.println("Failed to search tweets: " + te.getMessage());
			System.exit(-1);
		}
		return null;
		}
}
