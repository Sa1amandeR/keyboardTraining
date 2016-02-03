package core.view.components
{
	import core.model.dateobj.EventPopupDO;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import utils.event.EventTrans;

	public class WinVLPopup extends PopupVL
	{
		private var _button:SimpleButton;
		private var retrylvl_button:SimpleButton;
		private var nextlvl_button:SimpleButton;
		private var _class_name:String="Wingame";
		public function WinVLPopup()
		{
			super(_class_name);
			initButtons();
		}
		protected function initButtons():void
		{
			_button=_content.getChildByName("doButton_0") as SimpleButton;
			retrylvl_button=_content.getChildByName("doButton_1") as SimpleButton;
			nextlvl_button=_content.getChildByName("doButton_2") as SimpleButton;
		}
		override protected function doClickOnButton(event:MouseEvent):void
		{
			(event.target as SimpleButton).removeEventListener(MouseEvent.CLICK, doClickOnButton);
			var index:Number=int((event.target as DisplayObject).name.substring(9)); 
			dispatchEvent(new EventTrans(EventTrans.DO_BUTTON_CLICKED, new EventPopupDO(index, null)));
		}
		public function isNeedNextButton(isNeedButton:Boolean):void
		{
			if(isNeedButton==true)
			{
				nextlvl_button.visible=true;
			}else{
				nextlvl_button.visible=false;
			}
		}
	}
}