package core.view.components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import mx.core.mx_internal;
	import utils.WH.WareHouse;
	import utils.event.LevelOpenEvent;
	
	public class IconsVL extends ViewLogic
	{
		private var _class_name:String="Icons_on_bg";	
		private var tooltip:DisplayObject;
		private var lvl:Array;
		private var unlockLvl:Array;
		private var textTT:TextField;
		private var _tooltipInfo:Array;
		
		public function IconsVL()
		{
			super(_class_name, null);
			createTooltip();
			defaultLevelIcons();
		}
		private function defaultLevelIcons():void
		{
			_tooltipInfo=new Array();
			lvl=new Array();
			var lockmovie:MovieClip;
			for (var i:int=1; i<_content.numChildren/3; i++)
			{
				var mc_openLvl:SimpleButton=_content.getChildByName("Open_Level_"+i) as SimpleButton;
				mc_openLvl.tabEnabled = false;
				var mc_lockLvl:MovieClip=_content.getChildByName("Level_"+i) as MovieClip;
				mc_lockLvl.gotoAndStop(1);
				var mc_tooltipHitZone:MovieClip=_content.getChildByName("Level"+i) as MovieClip;
				lvl.push([mc_lockLvl,mc_tooltipHitZone,mc_openLvl]);
			}
		}
		private function createTooltip():void
		{
			tooltip=new (WareHouse.getInstance().getAsset("Tooltip"));	
			this.addContent(tooltip);
			tooltip.visible=false;
		}
		public function unlock_lvls(arr:Array):void
		{
			unlockLvl = arr;
			for(var i:int=arr.length;i<lvl.length;i++)
			{
				lvl[i][1].addEventListener(MouseEvent.MOUSE_OVER, closeLvlToolTip);
				lvl[i][1].addEventListener(MouseEvent.MOUSE_OUT, removeToolTip);
				lvl[i][1].addEventListener(MouseEvent.MOUSE_MOVE, moveToolTip);
			}
			for(var n:int=0;n<arr.length;n++)
			{
				(_content.getChildByName(arr[n]) as MovieClip).gotoAndPlay(2);
				(_content.getChildByName(arr[n]) as MovieClip).addEventListener(Event.ENTER_FRAME,iconsMovie);
				lvl[n][2].addEventListener(MouseEvent.MOUSE_OVER, openLvlToolTip);
				lvl[n][2].addEventListener(MouseEvent.MOUSE_OUT, removeToolTip);
				lvl[n][2].addEventListener(MouseEvent.MOUSE_MOVE, moveToolTip);
				lvl[n][2].addEventListener(MouseEvent.CLICK,lvlBtnClicked);
			}	
		}
		protected function iconsMovie(event:Event):void
		{
			var y:MovieClip;
			if ((event.currentTarget as MovieClip).currentFrame == (event.currentTarget as MovieClip).totalFrames)
			{
				(event.currentTarget as MovieClip).visible=false;
				var currentTarget_lvl_number:int=int((event.currentTarget as MovieClip).name.substring(6));
				y=lvl[currentTarget_lvl_number-1][1];
				y.visible=false;
			}
		}
		protected function lvlBtnClicked(event:MouseEvent):void
		{
			var level:int=int((event.target as DisplayObject).name.substring(11));
			for(var i:int=unlockLvl.length;i<lvl.length;i++)
			{
				lvl[i][1].addEventListener(MouseEvent.MOUSE_OVER, closeLvlToolTip);
				lvl[i][1].addEventListener(MouseEvent.MOUSE_OUT, removeToolTip);
				lvl[i][1].addEventListener(MouseEvent.MOUSE_MOVE, moveToolTip);
			}
			for(var n:int=0;n<unlockLvl.length;n++)
			{
				lvl[n][2].addEventListener(MouseEvent.MOUSE_OVER, openLvlToolTip);
				lvl[n][2].addEventListener(MouseEvent.MOUSE_OUT, removeToolTip);
				lvl[n][2].addEventListener(MouseEvent.MOUSE_MOVE, moveToolTip);
				lvl[n][2].addEventListener(MouseEvent.CLICK,lvlBtnClicked);
			}
			dispatchEvent(new LevelOpenEvent(LevelOpenEvent.OPEN_LVL,level));
		}
		public function tooltiptext(tooltipInfo:Array):void 
		{
			_tooltipInfo=tooltipInfo;
			textTT=(tooltip as DisplayObjectContainer).getChildByName("descr") as TextField;
		}
		private function closeLvlToolTip(me:MouseEvent):void 
		{
			   var currentLvLnumber:int=int((me.target as MovieClip).name.substring(5));
			   currentLvLnumber--;
			   var m:Number=_tooltipInfo[currentLvLnumber][0]-_tooltipInfo[currentLvLnumber][1];
			   var f:String="Need "+m+" points to open this Level!";
			   textTT.text=f;
			   tooltip.x=me.stageX;
			   tooltip.y=me.stageY;
			   tooltip.visible=true;
        }
		private function openLvlToolTip(me:MouseEvent):void 
		{
			var n:String=(me.target as SimpleButton).name.substring(5) as String;
			textTT.text=n;
			tooltip.x=me.stageX;
			tooltip.y=me.stageY;
			tooltip.visible=true;
		}
		private function moveToolTip(me:MouseEvent):void 
		{
			tooltip.x=me.stageX;
			tooltip.y=me.stageY;
		}
	    private function removeToolTip(me:MouseEvent):void 
		{
			tooltip.visible=false;
		}
	}
}