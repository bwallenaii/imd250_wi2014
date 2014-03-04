package com.roborun
{
	import flash.display.Sprite;
	
	public class Bullet extends Character
	{
		private static var _bullets:Vector.<Bullet> = new Vector.<Bullet>();
		
		protected var range:Number = 300; //number of pixels till bullet dies
		protected var distance:Number = 0; //tracks how far traveled
		
		public function Bullet(rot:Number = 0, startX:Number = 0, startY:Number = 0)
		{
			_bullets.push(this);
			this.speed = 10;
			this.setup(rot, startX, startY);
		}
		
		protected function setup(rot:Number, startX:Number, startY:Number)
		{
			rot = Game.degToRad(rot); //rot is now in radians
			this.vx = Math.cos(rot) * this.speed; //find velocity x
			this.vy = Math.sin(rot) * this.speed; //find velocity y
			this.x = startX;
			this.y = startY;
			Game.instance.level.addChild(this);
		}
		
		override public function run():void
		{
			super.run();
			this.distance += this.speed;
			if(this.distance > this.range)
			{
				this.destroy();
			}
			for(var i:uint = 0; i < this.floors.length;++i)
			{
				if(this.floors[i].hitTestObject(this))
				{
					this.destroy();
					break;
				}
			}
		}
		
		public function destroy():void
		{
			for(var i:uint = 0; i < _bullets.length;++i)
			{
				if(_bullets[i] == this)
				{
					_bullets.splice(i, 1);
					Game.instance.level.removeChild(this);
					break;
				}
			}
		}
		
		public static function runBullets():void
		{
			for(var i:uint = 0; i < _bullets.length;++i)
			{
				_bullets[i].run();
			}
		}
	}
}