package com.google.maps.geolocator.impl {
	import com.google.maps.LatLng;
	import com.google.maps.geolocator.GeolocationToken;
	import com.google.maps.geolocator.Geolocator;
	import com.google.maps.geolocator.GeolocatorIDGenerator;
	import com.google.maps.services.GeocodingResponse;
	import com.google.maps.services.Placemark;
	
	import flash.events.EventDispatcher;
	
	/**
	 * 
	 */
	[Bindable]
	public class GeolocationTokenImpl extends EventDispatcher implements GeolocationToken {
		
		private var _status:Number = -1;
		
		private var _request:Object;
		
		private var _response:GeocodingResponse;
		
		private var _latLng:LatLng;
		
		private var _address:String;		

		private var _geolocator:Geolocator;		
		
		private var _info:Object;
		
		private var _uid:String;
		
		public function GeolocationTokenImpl(request:Object, geolocator:Geolocator, latLng:LatLng,
				address:String) {
			_uid = GeolocatorIDGenerator.createUID();
			_geolocator = geolocator;
			_latLng = latLng;
			_address = address;
		}
		
		public function get status():Number { return _status; }
		public function set status(value:Number):void { _status = value; }
		
		public function get request():Object { return _request; }
		
		public function get response():GeocodingResponse { return _response; }
		public function set response(value:GeocodingResponse):void { 
			_response = value; 
			latLng = Placemark(response.placemarks[0]).point;
			address = Placemark(response.placemarks[0]).address;
		}
		
		public function get latLng():LatLng { return _latLng; }
		public function set latLng(value:LatLng):void { _latLng = value; }
		
		public function get address():String { return _address; }
		public function set address(value:String):void { _address = value; }
		
		public function get geolocator():Geolocator { return _geolocator; }
		
		public function get info():Object { return _info; }
		public function set info(value:Object):void { _info = value; }
		
		public function get uid():String { return _uid;	}
	}
}