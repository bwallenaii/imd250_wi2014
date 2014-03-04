package com.roborun
{
	import com.roborun.characters.Player;
	
	public class Weapon
	{
		private static const FRAME_RATE:Number = 24;
		private static const BARREL_LENGTH:Number = 24;
		protected var rof:Number = 2; //number of times it can be fired per second
		protected var lastFire:Number = 0; // how many frames since last fire
		
		public function Weapon():void
		{
			
		}
		
		public function fire():void
		{
			if(this.lastFire > 0)
			{
				this.lastFire--;
				return;
			}
			var rad:Number = Game.degToRad(Player.instance.arm.rotation);
			var startX:Number = (Math.cos(rad) * BARREL_LENGTH) + Player.instance.x;
			var startY:Number = (Math.sin(rad) * BARREL_LENGTH) + Player.instance.y;
			new Bullet(Player.instance.arm.rotation, startX, startY);
			this.lastFire = FRAME_RATE/this.rof;
		}
		
		public function resetROF()
		{
			this.lastFire = 0;
		}
	}
}