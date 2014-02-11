package com.breakout
{
	
	public class Paddle extends GameObject
	{
		private static var _instance:Paddle;
		
		public function Paddle():void
		{
			_instance = this; //last paddle created is the one I am using
		}
		
		public function run():void
		{
			this.x = Game.instance.mouseX;
			this.right = this.right > Game.STAGE_RIGHT ? Game.STAGE_RIGHT:this.right;
			this.left = this.left < Game.STAGE_LEFT ? Game.STAGE_LEFT:this.left;
			
		}
		
		//allows us to grab the paddle
		public static function get instance():Paddle
		{
			return _instance;
		}
	}
}