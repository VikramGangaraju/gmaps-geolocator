package com.google.maps.geolocator {
	/**
	 * 
	 */
	public class GeolocatorIDGenerator {
		
		private static var index:Number = 0;
		
		public static function createUID():String {
			return Number(index++).toString();
		}
	}
}