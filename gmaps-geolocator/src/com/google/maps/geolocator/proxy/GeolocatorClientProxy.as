package com.google.maps.geolocator.proxy {
	import com.google.maps.geolocator.Geolocator;
	import com.google.maps.services.GeocodingEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * Dispatched when a result has been returned from the remote geolocation 
	 * service.
	 */
	[Event(name="geolocatorResult",type="com.google.maps.geolocator.proxy.GeolocatorClientEvent")]
	/**
	 * Dispatched when the remote geolocator failed to geocode the request.
	 */
	[Event(name="geolocatorFault",type="com.google.maps.geolocator.proxy.GeolocatorClientEvent")]
	/**
	 * 
	 */
	public class GeolocatorClientProxy extends Proxy implements IEventDispatcher {
		
		private var dispatcher:EventDispatcher = new EventDispatcher();
		
		private var geolocator:Geolocator;
		
		public function GeolocatorClientProxy(geolocator:Geolocator) {
			this.geolocator = geolocator;
		}
		
		flash_proxy override function getProperty(name:*):* {
			var context:* = this;
			var memberName:String = Object(name).toString();
			
			switch (memberName) {
//				IEventDispatcher methods
				case "addEventListener": return Function(addEventListener);
				case "removeEventListener": return Function(removeEventListener);
				case "dispatchEvent": return Function(dispatchEvent);
				case "hasEventListener": return Function(hasEventListener);
				case "willTrigger": return Function(willTrigger);
//				local members
				case "dispatcher": return dispatcher;
				case "geolocator": return geolocator;
				case "onMethodCalled": return Function(onMethodCalled);
			}
			
//			if it's not declared on this object, send it an anonymous function
//			which points to onMethodCalled()
			return function(...parameters):void {
				try {
					parameters.unshift(memberName);
					onMethodCalled.apply(context, parameters);
				} catch (error:Error) {
//					something weird happened, once logger framework is built, log something :)
				}
			}
		}
		
		private function onMethodCalled(methodName:String, ...parameters):void {
//			get the uid from the method name
			var token:String = methodName.replace(new RegExp("m([0-9]+)_(result|fault)","i"), "$1");
//			determine if it's a result or fault call
			if (methodName.toLowerCase().indexOf("_result") != -1) {
//				remote call succeeded
				dispatcher.dispatchEvent(new GeolocatorClientEvent(GeolocatorClientEvent.GEOLOCATOR_RESULT, false,
					false, GeocodingEvent(parameters[0]), token));
			} else {
//				remote call failed
				dispatcher.dispatchEvent(new GeolocatorClientEvent(GeolocatorClientEvent.GEOLOCATOR_FAULT, false,
					false, GeocodingEvent(parameters[0]), token));
			}
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, 
				useWeakReference:Boolean=false):void {
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean {
			return dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean {
			return dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean {
			return dispatcher.willTrigger(type);
		}
	}
}