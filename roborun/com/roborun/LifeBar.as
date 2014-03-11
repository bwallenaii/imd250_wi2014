package com.roborun
{
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import com.greensock.easing.BounceOut;
	
	public class LifeBar extends Sprite
	{
		private static var _instance:LifeBar;
		private var perc:Number = 1;
		
		public function LifeBar():void
		{
			_instance = this;
		}
		
		public function set percent(n:Number):void
		{
			this.perc = n;
			TweenLite.to(this.bar, .5, { scaleX:n, ease:BounceOut.ease } );
		}
		
		public function get percent():Number
		{
			return this.perc;
		}
		
		public static function get instance():LifeBar
		{
			return _instance;
		}
	}
}