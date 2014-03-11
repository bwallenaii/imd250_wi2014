package com.roborun.characters
{
	import com.roborun.Character;
	import flash.events.Event;
	import com.roborun.Sensor;
	import com.roborun.Floor;
	import flash.display.Sprite;
	import com.roborun.Bullet;
	import com.greensock.TweenLite;
	import com.greensock.easing.BounceOut;
	
	public class Enemy extends Character
	{
		private static var enemies:Vector.<Enemy> = new Vector.<Enemy>();
		
		protected var floor:Floor;
		
		public function Enemy():void
		{
			enemies.push(this);
			this.speed = 3;
			this.setup();
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
		}
		
		protected function setup()
		{
			this.vx = -this.speed;
			this.puppet.scaleX = -1;
		}
		
		protected function findFloor():void
		{
			for(var i:uint = 0; i < this.floors.length;++i)
			{
				if(this.leftFoot.hitTestObject(this.floors[i])
				||	this.rightFoot.hitTestObject(this.floors[i]))
				{
					this.floor = this.floors[i];
					break;
				}
			}
		}
		
		override public function run():void
		{
			if(!this.floor)
			{
				this.findFloor();
				return;
			}
			if(!this.leftFoot.hitTestObject(this.floor))
			{
				this.vx = this.speed;
			}
			if(!this.rightFoot.hitTestObject(this.floor))
			{
				this.vx = -this.speed;
			}
			var targScale:Number = this.vx < 0 ? -1:1;
			TweenLite.to(this.puppet, 0.5, {scaleX:targScale});
			super.run();
			if(this.body.hitTestObject(Player.instance.body))
			{
				Player.instance.hitByEnemy(this);
			}
		}
		
		public function attacked(bullet:Bullet):void
		{
			this.kill();
		}
		
		protected function kill():void
		{
			for(var i:uint = 0; i < enemies.length;++i)
			{
				if(enemies[i] == this)
				{
					enemies.splice(i, 1);
					TweenLite.to(this.puppet, 1, {scaleX:0, scaleY: 0, ease:BounceOut.ease, onComplete:this.removeFromStage});
					break;
				}
			}
		}
		
		protected function removeFromStage():void
		{
			parent.removeChild(this);
		}
		
		private function destroy(e:* = null):void
		{
			for(var i:uint = 0; i < enemies.length;++i)
			{
				if(enemies[i] == this)
				{
					enemies.splice(i, 1);
					break;
				}
			}
		}
		
		public static function runEnemies():void
		{
			for(var i:uint = 0; i < enemies.length;++i)
			{
				enemies[i].onStage && enemies[i].run();
			}
		}
		
		public static function hitAnEnemy(bullet:Bullet):Boolean
		{
			for(var i:uint = 0; i < enemies.length;++i)
			{
				if(enemies[i].onStage && bullet.hitTestObject(enemies[i].body))
				{
					enemies[i].attacked(bullet);
					return true;
				}
			}
			return false;
		}
		
		public function get leftFoot():Sensor
		{
			return this._leftFoot as Sensor;
		}
		
		public function get rightFoot():Sensor
		{
			return this._rightFoot as Sensor;
		}
		
		public function get body():Sensor
		{
			return this._body as Sensor;
		}
		
		public function get strength():Number
		{
			return 13;
		}
	}
}