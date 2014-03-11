package com.roborun
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import com.roborun.Game;
	
	public class GameObject extends Sprite
	{
		public static const SCREEN_BUFFER:Number = 15;
		
		
		public function GameObject():void
		{
			
		}
		
		public function get gx():Number
		{
			var point:Point = new Point(this.x, this.y);
			var global:Point = Game.instance.level.localToGlobal(point);
			return global.x;
		}
		
		public function get gy():Number
		{
			var point:Point = new Point(this.x, this.y);
			var global:Point = Game.instance.level.localToGlobal(point);
			return global.y;
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
			this.y = n - (this.height/2);
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
		
		public function get onStage():Boolean
		{
			return (this.gx > Game.STAGE_LEFT - SCREEN_BUFFER
				&& this.gx < Game.STAGE_RIGHT + SCREEN_BUFFER
				&& this.gy > Game.STAGE_TOP - SCREEN_BUFFER
				&& this.gy < Game.STAGE_BOTTOM + SCREEN_BUFFER);
		}
	}
}