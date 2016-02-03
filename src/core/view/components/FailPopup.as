package core.view.components
{
	import core.config.GeneralNotifications;
	import core.config.SimpleNotifications;
	import core.model.dateobj.EventPopupDO;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import utils.event.EventTrans;

	public class FailPopup extends PopupVL
	{
		private var backButton:SimpleButton;
		private var retrylvlButton:SimpleButton;
		private var nextlvlButton:SimpleButton;
		private var _class_name:String="Failgame";
		public function FailPopup()
		{
			super(_class_name);
			initButtons();
		}
		protected function initButtons():void
		{
			backButton=_content.getChildByName("doButton_0") as SimpleButton;
			retrylvlButton=_content.getChildByName("doButton_1") as SimpleButton;
			nextlvlButton=_content.getChildByName("doButton_2") as SimpleButton;
		}
		override protected function doClickOnButton(event:MouseEvent):void
		{
			(event.target as SimpleButton).removeEventListener(MouseEvent.CLICK, doClickOnButton);
			var index:Number=int((event.target as DisplayObject).name.substring(9)); 
			dispatchEvent(new EventTrans(EventTrans.DO_BUTTON_CLICKED, new EventPopupDO(index, SimpleNotifications.BACK_TO_LOBBY_FROM_POPUP)));
		}
		public function isNeedNextButton(isNeedButton:Boolean):void
		{
			if(isNeedButton==true)
			{
				nextlvlButton.visible=true;
			}else{
				nextlvlButton.visible=false;
			}
		}
	}
}