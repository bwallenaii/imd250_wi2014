package com
{
	import flash.display.MovieClip;
	import com.Ball;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		
		public function Main():void
		{
			this.addEventListener(Event.ENTER_FRAME, this.move);
		}
		
		public function move(e:* = null):void
		{
			for(var i:int = 0; i < Ball.balls.length; ++i)
			{
				Ball.balls[i].move();
			}
		}
	}
}