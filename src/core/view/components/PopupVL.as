package core.view.components
{
	import core.model.dateobj.EventPopupDO;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import utils.event.EventTrans;

	public class PopupVL extends ViewLogic
	{
		private var _doButton:SimpleButton;
		private var _closeButton:SimpleButton;
		//private var class_name:String="Wellcome";	
		private var _userName:TextField;
		private var _userPass:TextField;
		private var regErrorMessage:TextField;
		private var _class_Name:String="MainPopup";
		public function PopupVL(class_name:String)
		{
			super(class_name,null);
			initButtonProp();
		}

		public function initButtonProp():void
			
		{
			for(var i:int=0; i<_content.numChildren; i++)
			{
				switch(_content.getChildAt(i).name.substring(0,9))
				{
					case "clButton_":
						_closeButton=_content.getChildAt(i) as SimpleButton;
						_closeButton.addEventListener(MouseEvent.CLICK, closeClickOnButton);
					break;
					case "doButton_":
						_doButton=_content.getChildAt(i) as SimpleButton;
						_doButton.addEventListener(MouseEvent.CLICK, doClickOnButton);
					break;
				}
			}
		}
		protected function closeClickOnButton(event:MouseEvent):void
		{
			var index:Number=int((event.target as DisplayObject).name.substring(9)); 
			dispatchEvent(new EventTrans(EventTrans.CLOSE_BUTTON_CLICKED, new EventPopupDO(index, null)));
			(event.target as SimpleButton).removeEventListener(MouseEvent.CLICK, closeClickOnButton);
		}
		protected function doClickOnButton(event:MouseEvent):void
		{
			var index:Number=int((event.target as DisplayObject).name.substring(9)); 
			var dataUser:Array=[_userName,_userPass];
			
			dispatchEvent(new EventTrans(EventTrans.DO_BUTTON_CLICKED, new EventPopupDO(index, dataUser)));
			(event.target as SimpleButton).removeEventListener(MouseEvent.CLICK, doClickOnButton);
		}
	}
}