package com.roborun
{
	import flash.display.Sprite;
	import com.roborun.characters.Player;
	
	public class Level extends Sprite
	{
		public static const RIGHT_WALL:Number = 275;
		public static const LEFT_WALL:Number = 50;
		public static const BOTTOM_WALL:Number = 100;
		public static const TOP_WALL:Number = 50;
		private var _floors:Vector.<Floor> = new Vector.<Floor>();
		
		public function Level():void
		{
			
		}
		
		public function run():void
		{
			if(Player.instance.gx > RIGHT_WALL)
			{
				var xdiff:Number = RIGHT_WALL - Player.instance.gx;
				this.x += xdiff;
			}
			
			if(Player.instance.gy > BOTTOM_WALL)
			{
				var ydiff:Number = this.stage.stageHeight - BOTTOM_WALL - Player.instance.gy;
				this.y += ydiff;
			}
		}
		
		public function addFloor(floor:Floor):void
		{
			this._floors.push(floor);
		}
		
		public function get floors():Vector.<Floor>
		{
			return this._floors;
		}
	}
}