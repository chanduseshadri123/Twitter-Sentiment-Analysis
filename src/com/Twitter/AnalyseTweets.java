package com.Twitter;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.StringTokenizer;

public class AnalyseTweets {
	String Tweet;
	double score = 0;
	MapsInitialisation maps = new MapsInitialisation();

	
	public double Analyse(String tweet) throws FileNotFoundException,
			IOException {
		score = 0;
		this.Tweet = tweet;
		Tweet = Tweet.toLowerCase();
		removeHyperLink();
		Tweet = removeRepeats(Tweet);
		analyseEmoticons();
		replaceSpecialChar();
		Tweet = removeJunk(Tweet);
		process();
		return score;
	}

	public double process() throws IOException {
		StringTokenizer word = new StringTokenizer(Tweet);
		int count = 0;
		double intensity = 0.0;
		int polarity = 1;
		StringBuilder str = new StringBuilder(0);
		int flag = 0;
		while (word.hasMoreElements()) {
			String nextword = word.nextToken();
			if (maps.getIntensifierMap().containsKey(nextword)) {
				intensity = intensity + maps.getIntensifierMap().get(nextword);
				count++;
			} else if (maps.getPosAndNegMap().containsKey(nextword)) {
				if (count == 0) {
					score = score + maps.getPosAndNegMap().get(nextword)
							* polarity;
					polarity = 1;
				} else {
					score = score
							+ (intensity * maps.getPosAndNegMap().get(nextword));
				}
			} else if (maps.getNegationList().contains(nextword)) {
				polarity = polarity * -1;
			} else if (maps.getAbbreviationsMap().containsKey(nextword)) {
				if (flag == 0) {
					str.append(maps.getAbbreviationsMap().get(nextword) + " ");
					if (word.countTokens() == 0) {
						word = new StringTokenizer(str.toString());
						flag = 1;
					}
				}
			} else if (nextword.equals("but")) {
				score = 0.0;
			}
		}

		return score;
	}

	public void removeHyperLink() {
		String[] hyperlinks = { "www.", "https://", "ssh://", "ftp://",
				"http://" };
		for (String index : hyperlinks) {
			while (Tweet.contains(index)) {
				StringBuilder sb = new StringBuilder(0);
				for (int i = Tweet.indexOf(index); i < Tweet.length(); i++) {
					sb.append(Tweet.charAt(i));
					if (Tweet.charAt(i) == ' ')
						break;
				}
				Tweet = Tweet.replace(sb, "");
			}
		}

	}

	public String removeJunk(String Tweet) {
		StringBuilder sb = new StringBuilder(0);
		char[] words = Tweet.toCharArray();
		for (char letter : words) {
			if ((letter > 64 && letter < 91) || (letter > 96 && letter < 123)
					|| (letter == ' ')) {
				sb.append(letter);
			}
		}

		String s = sb.toString();
		return s;
	}

	public String removeRepeats(String word) {
		int count = 0;
		StringBuilder sb = new StringBuilder(0);
		for (int i = 0; i < word.length() - 1; i++) {
			if (word.charAt(i) == word.charAt(i + 1)) {
				count++;
			} else {
				count = 0;
			}
			if (count <= 1) {
				sb.append(word.charAt(i));
			}
		}
		sb.append(word.charAt(word.length() - 1));
		String s = sb.toString();
		return s;
	}

	public String removeRepeats1(String word) {
		int count = 0;
		StringBuilder sb = new StringBuilder(0);
		for (int i = 0; i < word.length() - 1; i++) {
			if (word.charAt(i) == word.charAt(i + 1)) {
				count++;
			} else {
				if (count > 1)
					sb.deleteCharAt(sb.length() - 1);
				count = 0;
			}
			if (count <= 1) {
				sb.append(word.charAt(i));
			}
		}
		if (!(word.charAt(word.length() - 2) == word.charAt(word.length() - 1) && word
				.charAt(word.length() - 3) == word.charAt(word.length() - 1)))
			sb.append(word.charAt(word.length() - 1));
		String s = sb.toString();
		return s;
	}

	public void replaceSpecialChar() throws FileNotFoundException, IOException {
		for (String s : maps.getSpecialCharsMap().keySet()) {
			if (Tweet.contains(s)) {
				while (Tweet.indexOf(s) != Tweet.lastIndexOf(s)) {
					if (Tweet.indexOf(s) > 0
							&& Tweet.indexOf(s) < Tweet.length() - 1) {
						String s1 = removeJunk(Tweet
								.charAt(Tweet.indexOf(s) - 1) + "");
						String s2 = removeJunk(Tweet
								.charAt(Tweet.indexOf(s) + 1) + "");
						if (s1.length() == 1 && s2.length() == 1) {
							Tweet = Tweet.replace(s, maps.getSpecialCharsMap()
									.get(s));
						}
						else{
							Tweet = Tweet.replace(s, "");
						}
					}
					else{
						Tweet = Tweet.replace(s, "");
					}
					
				}
				if (Tweet.indexOf(s) > 0
						&& Tweet.indexOf(s) < Tweet.length() - 1) {
					String s1 = removeJunk(Tweet
							.charAt(Tweet.indexOf(s) - 1) + "");
					String s2 = removeJunk(Tweet
							.charAt(Tweet.indexOf(s) + 1) + "");
					if (s1.length() == 1 && s2.length() == 1) {
						Tweet = Tweet.replace(s, maps.getSpecialCharsMap()
								.get(s));
					}
					else{
						Tweet = Tweet.replace(s, "");
					}
				}
			}
		}
	}

	public void analyseEmoticons() throws FileNotFoundException, IOException {
		StringTokenizer str = new StringTokenizer(Tweet);
		while (str.hasMoreTokens()) {
			String s = str.nextToken();
			if (maps.getEmoticonMap().containsKey(s)) {
				score = score + maps.getEmoticonMap().get(s);
			}
		}

	}
}
