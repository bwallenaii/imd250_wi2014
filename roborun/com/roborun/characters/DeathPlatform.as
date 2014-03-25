package com.roborun.characters
{
	import flash.display.DisplayObject;
	public class DeathPlatform extends Enemy
	{
		
		public function DeathPlatform():void
		{
			this.speed = 0;
		}
		
		override protected function setup():void{}
		
		override public function run():void
		{
			if(this.hitTestObject(Player.instance.body))
			{
				Player.instance.hitByEnemy(this);
			}
		}
		
		override public function didHitMe(obj:DisplayObject):Boolean
		{
			return false;
		}
		
		override public function get onStage():Boolean
		{
			return true;
		}
		
		override public function get strength():Number
		{
			return 100;
		}
	}
}