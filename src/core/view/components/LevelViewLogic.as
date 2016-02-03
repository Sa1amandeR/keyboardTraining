package core.view.components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	import utils.event.EventTrans;
	import utils.event.LevelOpenEvent;
		
	public class LevelViewLogic extends ViewLogic
	{	
		
		private var _class_name:String;	
		private var wordFields:Array;
		private var level:DisplayObjectContainer;
		private var sonic:MovieClip;
		private var sonicstartX:int;
		private var removedring:DisplayObject;
		public function LevelViewLogic(name:String)
		{
			_class_name=name;
			super(_class_name,null);
			sonic=_content.getChildByName("Sonic") as MovieClip;
			sonic.gotoAndStop("ready");
			sonicstartX=sonic.x;
		}
		public function textInRing(textArray:Array):void
		{
			wordFields=new Array();
			var y:int=textArray.length;
			for (var i:int=0; i<y; i++)
			{
				var ring:DisplayObject=_content.getChildByName("Ring_"+[i]);
				wordFields[i]=ring;
				((wordFields[i])["Word"] as TextField).text=String(textArray[i]);
			}
		}
		public function removeRing(index:int):void
		{
			removedring=wordFields[index];
			(sonic as MovieClip).gotoAndPlay('jump');
			
			(sonic as MovieClip).addEventListener(Event.ENTER_FRAME,sonicmove);
		}
		protected function sonicmove(event:Event):void
		{
			if ((event.currentTarget as MovieClip).currentLabel == "stopmoveSonic")
			{
				sonic.x=removedring.x+12;
				(event.currentTarget as MovieClip).removeEventListener(Event.ENTER_FRAME,sonicmove);
				_content.removeChild(removedring) as DisplayObject;
				(sonic as MovieClip).gotoAndStop("ready");
				dispatchEvent(new EventTrans(EventTrans.SONIC_MOVE_FINISHED));
			}
		}
		public function replaceRing(textArrays:Array):void
		{
			sonic.x=sonicstartX;
			var y:int=textArrays.length;
			for (var i:int=0; i<y; i++)
			{
				var p:DisplayObject=wordFields[i];
				_content.addChild(p);
				((wordFields[i])["Word"] as TextField).text=String(textArrays[i]);
			}
		}
		public function stopSonicMovie():void
		{
			(sonic as MovieClip).gotoAndStop("ready");
		}
		
	}
}


