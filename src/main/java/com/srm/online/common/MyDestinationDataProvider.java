package com.srm.online.common;

import java.util.HashMap;
import java.util.Properties;


public class MyDestinationDataProvider {
	
	private HashMap<String, Properties> destinations;

	private static MyDestinationDataProvider provider = new MyDestinationDataProvider();

	private MyDestinationDataProvider() {
		if (provider == null) {
			destinations = new HashMap<String, Properties>();
		}
	}

	public static MyDestinationDataProvider getInstance() {
		return provider;
	}
	
	public Properties getDestinationProperties(String destinationName) {
		if (destinations.containsKey(destinationName)) {
			return destinations.get(destinationName);
		} else {
			return null;
		}
	}

	public void addDestination(String destinationName, Properties properties) {
		synchronized (destinations) {
			destinations.put(destinationName, properties);
		}
	}

	public boolean supportsEvents() {
		return true;
	}

}