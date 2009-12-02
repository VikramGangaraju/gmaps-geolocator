package com.google.maps.geolocator.impl {
	import com.google.maps.LatLng;
	import com.google.maps.geolocator.GeolocationToken;
	import com.google.maps.geolocator.Geolocator;
	import com.google.maps.geolocator.GeolocatorEvent;
	import com.google.maps.geolocator.GeolocatorIDGenerator;
	import com.google.maps.services.ClientGeocoder;
	import com.google.maps.services.GeocodingEvent;
	
	import flash.events.EventDispatcher;
	
	[Event(name="result",type="com.google.maps.geolocator.GeolocatorEvent")]
	
	[Event(name="fault",type="com.google.maps.geolocator.GeolocatorEvent")]
	/**
	 * 
	 */
	public class PooledGeolocator extends EventDispatcher implements Geolocator {
		
		private var _clientGeocoder:ClientGeocoder;
		
		private var _uid:String;
		
		private var jobQueue:Array = [];
		
		private var pendingQueue:Array = [];
		
		private var poolSize:int = 5;
		
		public function PooledGeolocator(clientGeocoder:ClientGeocoder, concurrentRequests:int = 5) {
			_uid = GeolocatorIDGenerator.createUID();
			_clientGeocoder = clientGeocoder;
			poolSize = concurrentRequests;
			
			clientGeocoder.addEventListener(GeocodingEvent.GEOCODING_SUCCESS, onClientResult, false, 0, true);
			clientGeocoder.addEventListener(GeocodingEvent.GEOCODING_FAILURE, onClientFault, false, 0, true);
		}
		
		public function getLatLng(address:String):GeolocationToken {
			var token:GeolocationToken = new GeolocationTokenImpl(address, this, null, address);
			jobQueue.push(token);
			exec();
			
			return token;
		}
		
		public function getAddress(latLng:LatLng):GeolocationToken {
			return null;
		}
		
		private function exec():void {			
			if (jobQueue.length == 0) 
				return;
			
			while (pendingQueue.length <= poolSize && jobQueue.length > 0) {
				var nextJob:GeolocationToken = GeolocationToken(jobQueue.shift());
				if (nextJob.request is LatLng) {
					clientGeocoder.reverseGeocode(LatLng(nextJob.request));
				} else {
					clientGeocoder.geocode(String(nextJob.request));
				}
				
				pendingQueue.push(nextJob);
			}
		}
		
		private function onClientResult(e:GeocodingEvent):void {			
			for each (var job:GeolocationToken in pendingQueue) {
				if (job.request == e.request) {
					GeolocationTokenImpl(job).response = e.response;
					var threevent:GeolocatorEvent = new GeolocatorEvent(GeolocatorEvent.RESULT, 
						false, false, this, job);
					job.dispatchEvent(threevent);
					this.dispatchEvent(threevent);
					
					pendingQueue.splice(pendingQueue.indexOf(job), 1);
					break;
				}
			}
			
			exec();
		}
		
		private function onClientFault(e:GeocodingEvent):void {
			for each (var job:GeolocationToken in pendingQueue) {
				if (job.request == e.request) {
					GeolocationTokenImpl(job).response= e.response;
					var threevent:GeolocatorEvent = new GeolocatorEvent(GeolocatorEvent.FAULT,
						false, false, this, job);
					job.dispatchEvent(threevent);
					this.dispatchEvent(threevent);
					
					pendingQueue.splice(pendingQueue.indexOf(job), 1);
					break;
				}
			}
			
			exec();
		}
		
		public function get uid():String {
			return _uid;
		}
		
		[Bindable]
		public function set clientGeocoder(value:ClientGeocoder):void { }
		public function get clientGeocoder():ClientGeocoder { return _clientGeocoder; }
	}
}