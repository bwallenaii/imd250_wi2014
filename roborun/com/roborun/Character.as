package com.roborun
{
	import flash.display.Sprite;
	
	public class Character extends GameObject
	{
		public const GRAVITY:Number = 0.55;
		public const TERMINAL_VELOCITY:Number = 20;
		protected var vx:Number = 0;
		protected var vy:Number = 0;
		protected var speed:Number = 0;
		
		public function Character():void
		{
			
		}
		
		public function run():void
		{
			this.x += this.vx;
			this.y += this.vy;
		}
		
		public function get floors():Vector.<Floor>
		{
			return Game.instance.floors;
		}
		
	}
}