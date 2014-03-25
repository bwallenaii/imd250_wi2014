package com.roborun.weapons
{
	import com.roborun.characters.Player;
	import com.roborun.Weapon;
	import com.roborun.Bullet;
	import com.roborun.Game;
	
	public class Spread extends Weapon
	{
		
		public function Spread():void
		{
			this.rof = 4;
		}
		
		override public function fire():void
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
			new Bullet(Player.instance.arm.rotation + 15, startX, startY);
			new Bullet(Player.instance.arm.rotation - 15, startX, startY);
			this.lastFire = FRAME_RATE/this.rof;
		}
	}
}