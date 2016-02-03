package core.model.proxy
{
	import core.config.GeneralNotifications;
	import core.config.SimpleNotifications;
	import core.model.dateobj.UsersDO;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.FocusDirection;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import utils.WH.SharedObjectUtil;

	public class KeyboardProxy extends Proxy
	{
		static public const NAME:String="Keybord_Proxy";
		private var _lvlViewComponent:DisplayObjectContainer;
		private var keyInLvl:Array;
		private var _index:int;
		private var _errors:int;
		private var _score:int;
		private var _time:int;
		private var keyClickCode:int;
		private var pressedKey:Array;
		private var usersDO:UsersDO;
		private var minuteTimer:Timer;
		public function KeyboardProxy(lvlViewComponent:DisplayObjectContainer,textArr:Array,index:int,errors:int,time:int)
		{
			super(NAME,lvlViewComponent);
			_lvlViewComponent=lvlViewComponent.parent.parent;
			_index=index;
			_errors=errors;
			keyInLvl=new Array();
			pressedKey=new Array();
			keyInLvl=textArr;
			usersDO=new UsersDO();
			_time=time;
			
		}
		override public function onRegister():void
		{
			for(var i:int=0;i<keyInLvl.length;i++)
			{
				if((keyInLvl[i].toString()).charCodeAt(0)<90)
				{
					keyInLvl[i]=(keyInLvl[i].toString()).charCodeAt(0);
				}
				else{
					keyInLvl[i]=(keyInLvl[i].toString()).charCodeAt(0)-32;
				}
			}
		    _lvlViewComponent.stage.focus=_lvlViewComponent;
			_lvlViewComponent.addEventListener(KeyboardEvent.KEY_UP,clickVerification);
		}
		public function clickVerification(event:KeyboardEvent):void
		{
			keyClickCode=event.charCode;
			if(keyClickCode>=65&&keyClickCode<=90)
			{
			sendNotification(GeneralNotifications.KEYBOARD_PRESS_COMMAND,{keyClickCode:keyClickCode,keyInLvl:keyInLvl,index:_index,errors:_errors});
			} else if(keyClickCode>=91&&keyClickCode<=122)
			{
				keyClickCode=keyClickCode-32;
				sendNotification(GeneralNotifications.KEYBOARD_PRESS_COMMAND,{keyClickCode:keyClickCode,keyInLvl:keyInLvl,index:_index,errors:_errors});
			}
 		}
		public function updateIndexLetter():void
		{
			_index++;
			if (_index>=keyInLvl.length)
			{
				_lvlViewComponent.removeEventListener(KeyboardEvent.KEY_UP,clickVerification);
			}
		}
		public function errorsUpdate(errorUpd:int):void
		{
			_errors=errorUpd;
			if(_errors<=0)
			{
			sendNotification(GeneralNotifications.LEVEL_STOPPED_COMMAND,SimpleNotifications.GAME_OVER);
			_lvlViewComponent.removeEventListener(KeyboardEvent.KEY_UP,clickVerification);
			}
		}
		override public function onRemove():void
		{
			_lvlViewComponent.removeEventListener(KeyboardEvent.KEY_UP,clickVerification);
		}
		public function setpressedKeys(index:int):void
		{
			pressedKey.push(index);
			if(pressedKey.length==1)
			{
				sendNotification(GeneralNotifications.CORRECTLY_WORD,index);
			}
		}
		public function lastIndex():void
		{
			if (_index>=keyInLvl.length && pressedKey.length == 0)
			{
				sendNotification(GeneralNotifications.LEVEL_STOPPED_COMMAND,SimpleNotifications.LEVEL_COMPLETE);
			}
		}
		public function getpressedKeys():Array
		{
			return pressedKey as Array;
		}
		public function rewritePressKeyArray():void
		{	
			if(pressedKey.length>0)
			{
				pressedKey.shift();
			}
		}
		public function timerStart():void
		{	
			minuteTimer = new Timer(1000, _time); 
			minuteTimer.addEventListener(TimerEvent.TIMER, onTick); 
			minuteTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
			minuteTimer.start(); 
		}
		public function onTick(event:TimerEvent):void  
		{ 
			var l:*=event.target.currentCount; 
			sendNotification(GeneralNotifications.TIME_UPDATE,l);
		} 
		public function onTimerComplete(event:TimerEvent):void 
		{ 
			(event.target as Timer).stop();
			(event.target as Timer).removeEventListener(TimerEvent.TIMER, onTick);
			(event.target as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
		} 
		public function timerStop():void
		{	
			if(minuteTimer.running==true)
			{
				minuteTimer.reset();
			}
		}
		
	}
}