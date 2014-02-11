package com
{
	import flash.display.MovieClip;
	import com.FrameListener;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Main extends MovieClip
	{
		public static const LANDING:String = "landing";
		public static const INSTRUCTIONS:String = "instructions";
		public static const GAME:String = "game";
		public static const END:String = "end";
		public var fListen:FrameListener;
		private static var _instance:Main;
		
		public function Main():void
		{
			_instance = this;
			this.stop();
			this.fListen = new FrameListener(this);
			this.fListen.addListener(LANDING, this.buildLanding);
			this.fListen.addListener(INSTRUCTIONS, this.buildInstructions);
			this.fListen.addListener(GAME, this.buildGame);
			this.fListen.addListener(END, this.buildEnd);
			
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.loading);
			this.loaderInfo.addEventListener(Event.COMPLETE, this.ready);
		}
		
		private function loading(e:ProgressEvent):void
		{
			var perc:Number = Math.floor((e.bytesLoaded/e.bytesTotal)*100);
			trace(perc);
		}
		
		public function ready(e:* = null):void
		{
			this.gotoLanding();
		}
		
		public function gotoLanding(e:* = null):void
		{
			this.gotoAndStop(LANDING);
		}
		
		public function gotoInstructions(e:* = null):void
		{
			this.gotoAndStop(INSTRUCTIONS);
		}
		
		public function gotoGame(e:* = null):void
		{
			this.gotoAndStop(GAME);
		}
		
		public function gotoEnd(e:* = null):void
		{
			this.gotoAndStop(END);
		}
		
		public function buildLanding():void
		{
			this._play.addEventListener(MouseEvent.CLICK, this.gotoGame);
			this._halp.addEventListener(MouseEvent.CLICK, this.gotoInstructions);
		}
		
		public function buildInstructions():void
		{
			this._play.addEventListener(MouseEvent.CLICK, this.gotoGame);
			this._back.addEventListener(MouseEvent.CLICK, this.gotoLanding);
		}
		
		public function buildGame():void
		{
			this._end.addEventListener(MouseEvent.CLICK, this.gotoEnd);
		}
		
		public function buildEnd():void
		{
			this._start.addEventListener(MouseEvent.CLICK, this.gotoLanding);
		}
		
		public static function get instance():Main
		{
			return _instance;
		}
	}
}