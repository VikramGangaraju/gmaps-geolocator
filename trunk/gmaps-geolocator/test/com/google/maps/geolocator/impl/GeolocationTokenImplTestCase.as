package com.google.maps.geolocator.impl {
	import com.google.maps.LatLng;
	import com.google.maps.services.ClientGeocoder;
	
	import org.flexunit.Assert;

	/**
	 * 
	 */
	public class GeolocationTokenImplTestCase {
		
		private var instance:GeolocationTokenImpl;
		
		public function GeolocationTokenImplTestCase() {
			
		}
		
		[Before]
		public function setup():void {
			instance = new GeolocationTokenImpl("1234 West Valley Parkway, Escondido CA, 92025",
				new PooledGeolocator(new ClientGeocoder()), new LatLng(0, 0), 
				"1234 West Valley Parkway, Escondido CA, 92025");
		}
		
		[After]
		public function tearDown():void {
			
		}
		
		[Test]
		public function testConstructor():void {
//			Assert.assertNotNull("Instance is null? What the heck?", instance);
//			Assert.assertEquals("Constructor failed to set 'address'", 
//				"1234 West Valley Parkway, Escondido CA, 92025", instance.address);
//			Assert.assertNotNull("Constructor failed to set 'geolocator'",
//				instance.geolocator);
//			Assert.assertNotNull("Constructor failed to set 'latLng'",
//				instance.latLng);
//			Assert.assertEquals("Constructor failed to set 'request'",
//				"1234 West Valley Parkway, Escondido CA, 92025", instance.request);
//			commentified
		}
		
		
	}
}