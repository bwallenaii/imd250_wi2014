package com.breakout
{
	import flash.events.Event;
	import com.breakout.GameObject;
	import com.breakout.Game;
	
	public class Ball extends GameObject
	{
		private static const DEATH_PAD:Number = 100;
		public static var balls:Vector.<Ball> = new Vector.<Ball>();
		private static var numBalls:int = 0;
		
		private var vx:Number = 8;
		private var vy:Number = 10;
		
		public function Ball():void
		{
			numBalls++;
			balls.push(this);
		}
		
		public function run():void
		{
			this.x += this.vx;
			this.y += this.vy;
			
			if(this.right > Game.STAGE_RIGHT)
			{
				this.vx = -Math.abs(this.vx);
				this.right = Game.STAGE_RIGHT;
			}
			else if(this.left < Game.STAGE_LEFT)
			{
				this.vx = Math.abs(this.vx);
				this.left = Game.STAGE_LEFT;
			}
			
			if(this.top > Game.STAGE_BOTTOM + DEATH_PAD)
			{
				Game.instance.die();
			}
			else if(this.top < Game.STAGE_TOP)
			{
				this.vy = Math.abs(this.vy);
				this.top = Game.STAGE_TOP;
			}
			
			if(this.bottom > Paddle.instance.top 
				&& this.bottom < Paddle.instance.y 
				&& this.hitTestObject(Paddle.instance))
			{
				this.bottom = Paddle.instance.top;
				this.vy = -Math.abs(this.vy);
			}
			
			for(var i:uint = 0; i < Brick.bricks.length;++i)
			{
				//test top
				if(Brick.bricks[i].hitTestPoint(this.x, this.top))
				{
					Brick.bricks[i].hit();
					this.vy = Math.abs(this.vy);
					i--;
				}
				//test left
				if(Brick.bricks[i].hitTestPoint(this.left, this.y))
				{
					Brick.bricks[i].hit();
					this.vx = Math.abs(this.vx);
					i--;
				}
				//test right
				if(Brick.bricks[i].hitTestPoint(this.right, this.y))
				{
					Brick.bricks[i].hit();
					this.vx = -Math.abs(this.vx);
					i--;
				}
				//test bottom
				if(Brick.bricks[i].hitTestPoint(this.x, this.top))
				{
					Brick.bricks[i].hit();
					this.vy = -Math.abs(this.vy);
					i--;
				}
			}
		}
		
		override public function set alpha(n:Number):void
		{
			super.alpha = n;
			this.visible = !(n == 0);
		}
	}
}






