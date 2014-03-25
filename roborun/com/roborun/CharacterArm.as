package com.roborun
{
	import com.roborun.weapons.Spread;
	import flash.display.Sprite;
	import com.roborun.characters.Player;
	
	public class CharacterArm extends Sprite
	{
		private var _weapon:Weapon;
		
		public function CharacterArm():void
		{
			this._weapon = new Spread();
		}
		
		public function run():void
		{
			//first figure out the distance
			var vx = Game.instance.level.mouseX - Player.instance.x;
			var vy = Game.instance.level.mouseY - Player.instance.y;
			var angle = Math.atan2(vy, vx);//angle in radians
			this.rotation = Game.radToDeg(angle);//set rotation in degrees
		}
		
		public function get weapon():Weapon
		{
			return this._weapon;
		}
	}
}