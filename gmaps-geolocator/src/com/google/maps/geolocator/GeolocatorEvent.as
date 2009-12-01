package com.google.maps.geolocator {
	import flash.events.Event;
	
	/**
	 * 
	 */
	public class GeolocatorEvent extends Event {
		
		public static const RESULT:String = "result";
		
		public static const FAULT:String = "fault";
		
		private var _token:GeolocationToken;
		
		private var _geolocator:Geolocator;
		
		public function GeolocatorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,
				geolocator:Geolocator = null, token:GeolocationToken = null) {
			super(type, bubbles, cancelable);
			_token = token;
			_geolocator = geolocator;
		}
		
		public function get token():GeolocationToken { return _token; }
		
		public function get geolocator():Geolocator { return _geolocator; }
	}
}