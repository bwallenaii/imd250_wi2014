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
		private static const ROTATE_MULTIPLIER:Number = 7;
		public static var balls:Vector.<Ball> = new Vector.<Ball>();
		private static var numBalls:int = 0;
		
		private var vx:Number = 5;
		private var vy:Number = 5;
		
		public function Ball():void
		{
			numBalls++;
			balls.push(this);
		}
		
		public function move(e:* = null):void
		{
			this.x += this.vx;
			this.y += this.vy;
			
			if(this.right > STAGE_RIGHT)
			{
				this.vx = -Math.abs(this.vx);
				this.right = STAGE_RIGHT;
			}
			else if(this.left < STAGE_LEFT)
			{
				this.vx = Math.abs(this.vx);
				this.left = STAGE_LEFT;
			}
			
			if(this.bottom > STAGE_BOTTOM)
			{
				this.vy = -Math.abs(this.vy);
				this.bottom = STAGE_BOTTOM;
			}
			else if(this.top < STAGE_TOP)
			{
				this.vy = Math.abs(this.vy);
				this.top = STAGE_TOP;
			}
			
			//this.rotation += this.vx * ROTATE_MULTIPLIER;
		}
		
		public function get top():Number
		{
			return this.y - (this.height/2);
		}
		
		public function set top(n:Number):void
		{
			this.y = n + (this.height/2);
		}
		
		public function get bottom():Number
		{
			return this.y + (this.height/2);
		}
		
		public function set bottom(n:Number):void
		{
			trace(n, (this.height/2));
			this.y = n - (this.height/2);
			trace(this.y);
		}
		
		public function get left():Number
		{
			return this.x - (this.width/2);
		}
		
		public function set left(n:Number):void
		{
			this.x = n + (this.width/2);
		}
		
		public function get right():Number
		{
			return this.x + (this.width/2);
		}
		
		public function set right(n:Number):void
		{
			this.x = n - (this.width/2);
		}
		
		override public function set alpha(n:Number):void
		{
			super.alpha = n;
			this.visible = !(n == 0);
		}
		
		/*override public function get height():Number
		{
			return 32;//height of my ball movie clip
		}
		
		override public function get width():Number
		{
			return 32;//width of my ball movie clip
		}*/
	}
}






