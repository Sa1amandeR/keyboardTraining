package core.view.components
{
	import core.config.SimpleNotifications;
	import core.model.dateobj.EventPopupDO;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import utils.event.EventTrans;

	public class WellcomeInfoPopup extends PopupVL
	{
		private var tuttorial_button:SimpleButton;
		private var close_button:SimpleButton;
		private var _class_name:String="InfoPopup";
		public function WellcomeInfoPopup()
		{
			super(_class_name);
			initButtons();
		}
		protected function initButtons():void
		{
			tuttorial_button=_content.getChildByName("doButton_0") as SimpleButton;
			close_button=_content.getChildByName("clButton_1") as SimpleButton;
		}
		override protected function doClickOnButton(event:MouseEvent):void
		{
			(event.target as SimpleButton).removeEventListener(MouseEvent.CLICK, doClickOnButton);
			var index:Number=int((event.target as DisplayObject).name.substring(9)); 
			dispatchEvent(new EventTrans(EventTrans.DO_BUTTON_CLICKED, new EventPopupDO(index,null)));
		}
	}
}