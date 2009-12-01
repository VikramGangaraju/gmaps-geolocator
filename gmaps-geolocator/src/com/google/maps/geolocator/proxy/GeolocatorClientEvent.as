package com.google.maps.geolocator.proxy {
	import com.google.maps.services.GeocodingEvent;
	
	import flash.events.Event;
	
	/**
	 * 
	 */
	public class GeolocatorClientEvent extends Event {
		
		public static const GEOLOCATOR_RESULT:String = "geolocatorResult";
		
		public static const GEOLOCATOR_FAULT:String = "geolocatorFault";
		
		private var _callingEvent:GeocodingEvent;
		
		private var _tokenId:String;
		
		public function GeolocatorClientEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,
				callingEvent:GeocodingEvent, tokenId:String = null) {
			super(type, bubbles, cancelable);
			_callingEvent = callingEvent;
			_tokenId = tokenId;
		}
		
		override public function clone():Event {
			return new GeolocatorClientEvent(type, bubbles, cancelable,
				callingEvent, tokenId);
		}
		
		public function get callingEvent():GeocodingEvent { return _callingEvent; }
		
		public function get tokenId():String { return _tokenId; }
	}
}