package com.breakout
{
	import flash.display.DisplayObjectContainer;
	
	public class Brick extends GameObject
	{
		private static const PADDING:Number = 4;
		private static var _bricks:Vector.<Brick> = new Vector.<Brick>();
		
		public function Brick():void
		{
			_bricks.push(this);
		}
		
		public function hit():void
		{
			//remove from stage
			parent.removeChild(this);
			//remove from the vector
			for(var i:uint = 0; i < _bricks.length;++i)
			{
				if(_bricks[i] == this)
				{
					_bricks.splice(i, 1);
					break;
				}
			}
		}
		
		public static function BuildBricks(numLayers:uint, numWide:uint, container:DisplayObjectContainer = null):void
		{
			if(container == null)
			{
				container = Game.instance;
			}
			for(var i:uint = 0; i < numLayers;++i)
			{
				for(var j:uint = 0; j < numWide;++j)
				{
					var brick:Brick = new Brick();
					brick.left = j * (brick.width + PADDING);
					brick.top = i * (brick.height + PADDING);
					container.addChild(brick);
				}
			}
		}
		
		public static function get bricks():Vector.<Brick>
		{
			return _bricks;
		}
	}
}