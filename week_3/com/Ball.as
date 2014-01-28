package com
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Ball extends MovieClip
	{
		public static const STAGE_LEFT:Number = 0;
		public static const STAGE_RIGHT:Number = 550;
		public static const STAGE_TOP:Number = 0;
		public static const STAGE_BOTTOM:Number = 400;
		public static var balls:Vector.<Ball> = new Vector.<Ball>();
		private static var numBalls:int = 0;
		
		private var vx:Number = 3;
		private var vy:Number = 3;
		
		public function Ball():void
		{
			numBalls++;
			balls.push(this);
		}
		
		public function move(e:* = null):void
		{
			this.x += this.vx;
			this.y += this.vy;
			
			if(this.x > STAGE_RIGHT)
			{
				this.vx = -Math.abs(this.vx);
			}
			else if(this.x < STAGE_LEFT)
			{
				this.vx = Math.abs(this.vx);
			}
			
			if(this.y > STAGE_BOTTOM)
			{
				this.vy = -Math.abs(this.vy);
			}
			else if(this.y < STAGE_TOP)
			{
				this.vy = Math.abs(this.vy);
			}
		}
	}
}