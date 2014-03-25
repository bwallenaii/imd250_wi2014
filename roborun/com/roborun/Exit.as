package com.roborun
{
	import flash.events.Event;
	
	public class Exit extends GameObject
	{
		private static var _exits:Vector.<Exit> = new Vector.<Exit>();
		
		public function Exit():void
		{
			exits.push(this);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
		}
		
		public function destroy(e:* = null):void
		{
			for (var i:uint = 0; i < exits.length;++i)
			{
				if (exits[i] == this)
				{
					exits.splice(i, 1);
				}
			}
		}
		
		public static function get exits():Vector.<Exit>
		{
			return _exits;
		}
	}
}