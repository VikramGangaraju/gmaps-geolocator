package com.google.maps.geolocator {
	import com.google.maps.LatLng;
	import com.google.maps.services.GeocodingResponse;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * 
	 */
	public interface GeolocationToken extends IEventDispatcher {
		
		function get status():Number;
		
		function get request():Object;
		
		function get response():GeocodingResponse;
		
		function get latLng():LatLng;
		
		function get address():String;
		
		function get geolocator():Geolocator;
		
		function get info():Object;
		function set info(value:Object):void;
		
		function get uid():String;
	}
}