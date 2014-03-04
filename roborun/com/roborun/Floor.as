package com.roborun
{
	import flash.events.Event;
	
	public class Floor extends GameObject
	{
		
		public function Floor():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.loaded);
		}
		
		public function loaded(e:* = null):void
		{
			Game.instance.level.addFloor(this);
		}
	}
}