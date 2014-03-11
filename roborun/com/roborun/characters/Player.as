package com.roborun.characters
{
	import com.roborun.*;
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	
	
	public class Player extends Character
	{
		public static const MAX_LIFE:Number = 100;
		public static const INVINCIBLE_TIME:int = 24;
		private static var _instance:Player;
		
		private var _up:Boolean = false;
		private var _down:Boolean = false;
		private var _left:Boolean = false;
		private var _right:Boolean = false;
		private var _shoot:Boolean = false;
		
		private var jumpStrength:Number = 12;
		private var gravityModifier:Number = 1;
		private var life:Number = MAX_LIFE;
		private var invincibleTime:Number = 0;
		
		public function Player():void
		{
			_instance = this;
			this.speed = 5;
		}
		
		override public function run():void
		{
			this.vx = 0;
			this.vx = this.leftDown ? -this.speed:this.vx;
			this.vx = this.rightDown ? this.speed:this.vx;
			this.invincibleTime--;
			var floor:Floor = this.floor;
			if(!floor)
			{
				this.vy += GRAVITY * this.gravityModifier;
				if(this.gravityNormal)
				{
					this.vy = this.vy > TERMINAL_VELOCITY * this.gravityModifier ? TERMINAL_VELOCITY * this.gravityModifier:this.vy;
				}
				else
				{
					this.vy = this.vy < TERMINAL_VELOCITY * this.gravityModifier ? TERMINAL_VELOCITY * this.gravityModifier:this.vy;
				}
				
				if(this.jumping && !this.upDown)
				{
					this.vy += GRAVITY * this.gravityModifier;
					this.vy += GRAVITY * this.gravityModifier;
				}
				if(this.jumping && this.cieling)
				{
					this.vy = 0;
					if(this.gravityNormal)
					{
						this.top = this.cieling.bottom;
					}
					else
					{
						this.bottom = this.cieling.top;
					}
					
				}
			}
			else //we are on a floor
			{
				var oldVY:Number = this.vy;
				this.vy = 0;
				if(this.gravityNormal)
				{
					this.bottom = floor.top;
				}
				else
				{
					this.top = floor.bottom;
				}
				
				if(this.upDown)
				{
					this.vy = -this.jumpStrength * this.gravityModifier;
				}
				else if(Math.abs(oldVY) == TERMINAL_VELOCITY)
				{
					this.vy = -(this.jumpStrength/2) * this.gravityModifier;
				}
				this.downDown ? this.flipGravity():null;
			}
			
			super.run();
			this.arm.run();
			
			if(this.shootDown)
			{
				this.arm.weapon.fire();
			}
			
			if(this.gx < Level.LEFT_WALL)
			{
				this.x -= this.vx;
			}
			if(this.invincible)
			{
				this.alpha = this.alpha == 0 ? 1:0;
			}
			else
			{
				this.alpha = 1;
			}
		}
		
		private function flipGravity()
		{
			this.gravityModifier *= -1;
			this.foot.y *= -1;
			this.head.y *= -1;
			if(this.gravityNormal)
			{
				TweenLite.to(this.puppet, 0.5, {rotation:0, scaleX:this.puppet.scaleX*-1});
			}
			else
			{
				TweenLite.to(this.puppet, 0.5, {rotation:180, scaleX:this.puppet.scaleX*-1});
			}
			
		}
		
		public function hitByEnemy(enemy:Enemy):void
		{
			if(this.invincible)
			{
				return;
			}
			this.life -=  enemy.strength;
			this.invincibleTime = INVINCIBLE_TIME;
			LifeBar.instance.percent = this.life / MAX_LIFE;
			if(this.life <= 0)
			{
				Game.instance.gameOver();
			}
		}
		
		public function get upDown():Boolean
		{
			return this._up;
		}
		
		public function set upDown(b:Boolean):void
		{
			this._up = b;
		}
		
		public function get downDown():Boolean
		{
			return this._down;
		}
		
		public function set downDown(b:Boolean):void
		{
			this._down = b;
		}
		
		public function get leftDown():Boolean
		{
			return this._left;
		}
		
		public function set leftDown(b:Boolean):void
		{
			this._left = b;
			if(b)
			{
				//this.puppet.scaleX = -1;
				TweenLite.to(this.puppet, 0.5, {scaleX:-1*this.gravityModifier});
				this._right = false;
			}
		}
		
		public function get rightDown():Boolean
		{
			return this._right;
		}
		
		public function set rightDown(b:Boolean):void
		{
			this._right = b;
			if(b)
			{
				//this.puppet.scaleX = 1;
				TweenLite.to(this.puppet, 0.5, {scaleX:1*this.gravityModifier});
				this._left = false;
			}
		}
		
		public function get shootDown():Boolean
		{
			return this._shoot;
		}
		
		public function set shootDown(b:Boolean):void
		{
			this._shoot = b;
			if(!b)
			{
				this.arm.weapon.resetROF();
			}
		}
		
		
		public function get floor():Floor
		{
			for(var i:uint = 0; i < this.floors.length;++i)
			{
				if(this.floors[i].onStage && this.foot.hitTestObject(this.floors[i]))
				{
					return this.floors[i];
				}
			}
			return null;
		}
		
		public function get cieling():Floor
		{
			for(var i:uint = 0; i < this.floors.length;++i)
			{
				if(this.head.hitTestObject(this.floors[i]))
				{
					return this.floors[i];
				}
			}
			return null;
		}
		
		public function get foot():Sensor
		{
			return this.getChildByName("_foot") as Sensor;
		}
		
		public function get head():Sensor
		{
			return this.getChildByName("_head") as Sensor;
		}
		
		public function get gravityNormal():Boolean
		{
			return this.gravityModifier == 1;
		}
		
		public function get jumping():Boolean
		{
			return (this.vy < 0 && this.gravityNormal) || (this.vy > 0 && !this.gravityNormal);
		}
		
		public function get falling():Boolean
		{
			return (this.vy > 0 && this.gravityNormal) || (this.vy < 0 && !this.gravityNormal);
		}
		
		override public function get height():Number
		{
			return 56;
		}
		
		override public function get width():Number
		{
			return 37;
		}
		
		public function get invincible():Boolean
		{
			return this.invincibleTime > 0;
		}
		
		public static function get instance():Player
		{
			return _instance;
		}
	}
}