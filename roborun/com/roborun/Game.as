﻿package com.roborun
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.roborun.*;
	import com.Main;
	import com.roborun.characters.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Game extends Sprite
	{
		public static const STAGE_LEFT:Number = 0;
		public static const STAGE_RIGHT:Number = 712;
		public static const STAGE_TOP:Number = 0;
		public static const STAGE_BOTTOM:Number = 400;
		private static var _instance:Game;
		
		private var _level:Level;
		private var levelNum:int = 1;
		private var timer:Timer;
		private var timeAmount:int = 90;
		
		public function Game():void
		{
			_instance = this;
			this.addEventListener(Event.ADDED_TO_STAGE, this.ready);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
			this.timer = new Timer(1000);
			this.timer.addEventListener(TimerEvent.TIMER, this.tick);
		}
		
		public function ready(e:* = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.ready);
			this.stage.focus = this.stage;
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUp);
			this.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, this.mouseUp);
			this.loadLevel();
		}
		
		public function keyDown(e:KeyboardEvent)
		{
			switch(e.keyCode)
			{
				case Keyboard.W:
				case Keyboard.UP:
					Player.instance.upDown = true;
				break;
				case Keyboard.A:
				case Keyboard.LEFT:
					Player.instance.leftDown = true;
				break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					Player.instance.rightDown = true;
				break;
				case Keyboard.S:
				case Keyboard.DOWN:
					Player.instance.downDown = true;
				break;
			}
		}
		
		public function keyUp(e:KeyboardEvent)
		{
			switch(e.keyCode)
			{
				case Keyboard.W:
				case Keyboard.UP:
					Player.instance.upDown = false;
				break;
				case Keyboard.A:
				case Keyboard.LEFT:
					Player.instance.leftDown = false;
				break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					Player.instance.rightDown = false;
				break;
				case Keyboard.S:
				case Keyboard.DOWN:
					Player.instance.downDown = false;
				break;
			}
		}
		
		public function mouseDown(e:* = null):void
		{
			Player.instance.shootDown = true;
		}
		
		public function mouseUp(e:* = null):void
		{
			Player.instance.shootDown = false;
		}
		
		public function loadLevel():void
		{
			switch(this.levelNum)
			{
				case 1:
					this._level = new Level1();
				break;
				case 2:
					this._level = new Level2();
				break;
			default:
					this.gameOver();
					return;
				break;
			}
			
			this.levelContainer.addChild(this._level);
			this.startGame();
		}
		
		public function startGame(e:* = null):void
		{
			this.addEventListener(Event.ENTER_FRAME, this.run);
			this.timeOut.text = this.timeToString(this.timeAmount);
			this.timer.start();
		}
		
		public function haltGame(e:* = null):void
		{
			this.removeEventListener(Event.ENTER_FRAME, this.run);
			this.timer.stop();
		}
		
		public function run(e:* = null):void
		{
			this.stage.focus = this.stage;
			Player.instance.run();
			this.level.run();
			Enemy.runEnemies();
			Bullet.runBullets();
		}
		
		public function nextLevel():void
		{
			this.levelContainer.removeChild(this.level);
			this.levelNum++;
			this.loadLevel();
		}
		
		public function tick(e:TimerEvent):void
		{
			this.timeAmount--;
			
			this.timeOut.text = this.timeToString(this.timeAmount);
			if (this.timeAmount <= 0)
			{
				this.gameOver();
			}
		}
		
		public function timeToString(secnds:int):String
		{
			var seconds:int = secnds;
			var minutes:int = Math.floor(seconds / 60);
			seconds = seconds - (minutes * 60);
			var secString:String = seconds.toString();
			
			if (secString.length < 2)
			{
				secString = "0" + secString;
			}
			
			return minutes.toString() + ":" + secString;
		}
		
		private function destroy(e:* = null):void
		{
			this.haltGame();
		}
		
		public function gameOver():void
		{
			Main.instance.gotoEnd();
		}
		
		public static function degToRad(deg:Number):Number
		{
			return deg * Math.PI / 180;
		}
		
		public static function radToDeg(rad:Number):Number
		{
			return rad * 180 / Math.PI;
		}
		
		public function get level():Level
		{
			return this._level;
		}
		
		public function get floors():Vector.<Floor>
		{
			return this.level.floors;
		}
		
		public static function get instance():Game
		{
			return _instance;
		}
	}
}