package com.creatorish.net {
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.HTTPStatusEvent;
	public class SimpleLoader extends EventDispatcher{
		private var path:String="";
		public var data:*;
		public var loader:*;
		public var userData:Object;
		private var type:int = 0;
		private var target:EventDispatcher;
		
		public function load(url:String):void {
			var swfReg:RegExp = new RegExp(/(\.swf)$/i);
			var result:int = url.search(swfReg);
			if (result != -1) {
				type = 0;
				loadBinary(url);
			} else {
				var imageReg:RegExp = new RegExp(/(\.gif|\.jpg|\.png|\.jpeg|.bmp)$/i);
				result = url.search(imageReg);
				if (result < 0) {
					type = 1;
					loadText(url);
				} else {
					type = 2;
					loadBinary(url);
				}
			}
		}
		public function unload():void {
			target = null;
			data = null;
		}
		private function remove():void {
			target.removeEventListener(Event.OPEN, onOpen);
			target.removeEventListener(Event.INIT,onInit);
			target.removeEventListener(Event.COMPLETE,onComp);
			target.removeEventListener(ProgressEvent.PROGRESS,onProg);
			target.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			target.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusEvent);
		}
		
		private function loadBinary(url:String):void {
			var imageUrl:URLRequest = new URLRequest(url);
			loader = new Loader();
			addEvent(loader.contentLoaderInfo);
			loader.load(imageUrl);
		}
		
		private function loadText(url:String):void {
			var xmlUrl:URLRequest=new URLRequest(url);
			loader = new URLLoader();
			loader.dataFormat=URLLoaderDataFormat.TEXT;
			addEvent(loader);
			loader.load(xmlUrl);
		}
		private function addEvent(ed:EventDispatcher):void {
			target = ed;
			target.addEventListener(Event.OPEN, onOpen);
			target.addEventListener(Event.INIT,onInit);
			target.addEventListener(Event.COMPLETE,onComp);
			target.addEventListener(ProgressEvent.PROGRESS,onProg);
			target.addEventListener(IOErrorEvent.IO_ERROR, onError);
			target.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			target.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusEvent);
		}
		private function onOpen(e:Event):void {
			dispatchEvent(new Event(Event.OPEN));
		}
		private function onInit(e:Event):void {
			switch(type) {
				case 0:
					data = e.target.content;
					break;
				case 1:
					data = e.target.data;
					break;
				case 2:
					data = Bitmap(e.target.content);
					break;
				default:
					data = e.target;
			}
			dispatchEvent(new Event(Event.INIT));
		}
		private function onComp(e:Event):void {
			switch(type) {
				case 0:
					data = e.target.content;
					break;
				case 1:
					data = e.target.data;
					break;
				case 2:
					data = Bitmap(e.target.content);
					break;
				default:
					data = e.target;
			}
			dispatchEvent(new Event(Event.COMPLETE));
			remove();
		}
		private function onProg(e:ProgressEvent):void {
			dispatchEvent(e);
		}
		private function onError(e:IOErrorEvent):void {
			dispatchEvent(e);
			remove();
		}
		private function onSecurityError(e:SecurityErrorEvent):void {
			dispatchEvent(e);
			remove();
		}
		private function onHttpStatusEvent(e:HTTPStatusEvent):void {
			dispatchEvent(e);
		}
	}
}