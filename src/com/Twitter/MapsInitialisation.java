package com.Twitter;

import java.util.List;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class MapsInitialisation {
	private static Map<String, Integer> emoticons;
	private static Map<String, Double> multipliers;
	private static Map<String, Integer> posAndNeg;
	private static Map<String, String> shortCuts;
	private static Map<String, String> specialChars;
	private static Map<String, String[]> countries;
	private static List<String> negations;
	
	public static Map<String, Integer> getEmoticonMap()
			throws FileNotFoundException, IOException {
		if (emoticons == null) {
			emoticons = new HashMap<String, Integer>();
			InputStream in = new FileInputStream(new File(
					"/Users/KeerthiChandu/Desktop/TwitterFiles/emoticons.txt"));
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(in));
			String line;
			while ((line = reader.readLine()) != null) {
				String[] s = line.split("\t");
				emoticons.put(s[0],
						Integer.parseInt(s[1]));
			}
			reader.close();
		}
		return emoticons;
	}
	public static Map<String, String[]> getCountriesMap()
			throws FileNotFoundException, IOException {
		if (countries == null) {
			countries = new HashMap<String, String[]>();
			InputStream in = new FileInputStream(new File(
					"/Users/KeerthiChandu/Desktop/TwitterFiles/countries.txt"));
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(in));
			String line;
			while ((line = reader.readLine()) != null) {
				String[] s = line.split("\t");
				String[] latitude = new String[2];
				latitude[0] = s[1];
				latitude[1] = s[2];
				countries.put(s[0],
						latitude);
			}
			reader.close();
		}
		return countries;
	}

	public static Map<String, Double> getIntensifierMap()
			throws FileNotFoundException, IOException {
		if (multipliers == null) {
			multipliers = new HashMap<String,Double>();
			InputStream in = new FileInputStream(
					new File(
							"/Users/KeerthiChandu/Desktop/TwitterFiles/multipliers.txt"));
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(in));
			String line;
			while ((line = reader.readLine()) != null) {
				String[] s = line.split("\t");
				multipliers.put(s[0], Double.parseDouble(s[1]));
			}
			reader.close();
		}
		return multipliers;
	}
	public static Map<String, Integer> getPosAndNegMap()
			throws FileNotFoundException, IOException {
		if (posAndNeg == null) {
			posAndNeg = new HashMap<String,Integer>();
			InputStream in = new FileInputStream(new File(
					"/Users/KeerthiChandu/Desktop/TwitterFiles/posAndNeg.txt"));
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(in));
			String line;
			while ((line = reader.readLine()) != null) {
				String[] s = line.split("\t");
				posAndNeg.put(s[0],
						Integer.parseInt(s[1]));
			}
			reader.close();
		}
		return posAndNeg;
	}
	public static Map<String, String> getAbbreviationsMap()
			throws FileNotFoundException, IOException {
		if (shortCuts == null) {
			shortCuts = new HashMap<String, String>();
			InputStream in = new FileInputStream(new File(
					"/Users/KeerthiChandu/Desktop/TwitterFiles/shortCuts.txt"));
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(in));
			String line = null;
			while ((line = reader.readLine()) != null) {
				String[] s = line.split("\t");
				shortCuts.put(s[0],s[1]);
			}
			reader.close();
		}
		return shortCuts;
	}

	public static List<String> getNegationList() throws FileNotFoundException,
			IOException {
		if (negations == null) {
			negations = new ArrayList<String>();
			InputStream in = new FileInputStream(new File(
					"/Users/KeerthiChandu/Desktop/TwitterFiles/negations.txt"));
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(in));
			String line;
			while ((line = reader.readLine()) != null) {
				negations.add(line);
			}
			reader.close();
		}
		return negations;
	}
	
	public static Map<String, String> getSpecialCharsMap() throws FileNotFoundException,
	IOException {
		if(specialChars == null){
			specialChars = new HashMap<String, String>();
			InputStream in = new FileInputStream(new File(
					"/Users/KeerthiChandu/Desktop/TwitterFiles/specialChars.txt"));
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(in));
			String line = null;
			while ((line = reader.readLine()) != null) {
				String[] s = line.split("\t");
				specialChars.put(s[0],s[1]);
			}
			reader.close();
		}
		return specialChars;
	}

}
