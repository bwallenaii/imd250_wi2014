package com.breakout
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.Main;
	
	public class Game extends Sprite
	{
		public static const STAGE_LEFT:Number = 0;
		public static const STAGE_RIGHT:Number = 418;
		public static const STAGE_TOP:Number = 0;
		public static const STAGE_BOTTOM:Number = 400;
		private static var _instance:Game;
		
		
		public function Game():void
		{
			_instance = this;
			this.addEventListener(Event.ADDED_TO_STAGE, this.added);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.removed);
		}
		
		public function added(e:* = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.added);
			this.addEventListener(Event.ENTER_FRAME, this.run);
			startLevel();
		}
		
		public function removed(e:* = null):void
		{
			this.removeEventListener(Event.ENTER_FRAME, this.run);
		}
		
		public function startLevel():void
		{
			Brick.BuildBricks(3, 11);
		}
		
		public function run(e:* = null):void
		{
			this.ball.run();
			Paddle.instance.run();
			
			if(Brick.bricks.length == 0)
			{
				this.startLevel();
			}
		}
		
		public function die():void
		{
			Main.instance.gotoEnd();
		}
		
		public function get ball():Ball
		{
			return this.getChildByName("_ball") as Ball;
		}
		
		public static function get instance():Game
		{
			return _instance;
		}
	}
}