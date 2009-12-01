package com.google.maps.geolocator {
	import com.google.maps.LatLng;
	import com.google.maps.services.ClientGeocoder;
	
	import flash.events.IEventDispatcher;

	/**
	 * 
	 */
	public interface Geolocator extends IEventDispatcher {
		
		function getLatLng(address:String):GeolocationToken;
		
		function getAddress(latLng:LatLng):GeolocationToken;
		
		function get uid():String;
		
		function get clientGeocoder():ClientGeocoder;
	}
}