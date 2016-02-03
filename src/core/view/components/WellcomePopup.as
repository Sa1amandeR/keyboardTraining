package core.view.components
{
	import core.model.dateobj.EventPopupDO;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import utils.event.EventTrans;
	
	public class WellcomePopup extends PopupVL
	{
		private var _button:SimpleButton;
		private var _userName:TextField;
		private var _userPass:TextField;
		private var reg_error_message:TextField;
		private var _class_name:String="Wellcome";
		public function WellcomePopup()
		{
			super(_class_name);
			reg_users();
		}
		public function setErrorPass():void
		{
			((_content.getChildByName("InfWellcome") as MovieClip).getChildByName("InfScroll") as MovieClip).getChildByName("ErrorMsg").visible=true;
			_button.addEventListener(MouseEvent.CLICK, doClickOnButton);
			//this.reg_users();
		}
		public function correctPass():void
		{
			((_content.getChildByName("InfWellcome") as MovieClip).getChildByName("InfScroll") as MovieClip).getChildByName("ErrorMsg").visible=false;
			var currentframe:int=(_content.getChildByName("InfWellcome") as MovieClip).currentFrame;
			(_content.getChildByName("InfWellcome") as MovieClip).gotoAndPlay(currentframe+1);
			(_content.getChildByName("InfWellcome") as MovieClip).addEventListener(Event.ENTER_FRAME,secondPartMovieWellcomePopup);
		}
		protected function secondPartMovieWellcomePopup(event:Event):void
		{
			if ((event.currentTarget as MovieClip).currentFrame == ((event.currentTarget as MovieClip).totalFrames))
			{
				(event.currentTarget as MovieClip).stop();
				(event.currentTarget as MovieClip).removeEventListener(Event.ENTER_FRAME, firstPartMovieWellcomePopup);
				dispatchEvent(new EventTrans(EventTrans.TO_INFOPOPUP));
			}
		}
		protected function reg_users():void
		{
			(_content.getChildByName("InfWellcome") as MovieClip).addEventListener(Event.ENTER_FRAME, firstPartMovieWellcomePopup);
		}
		protected function firstPartMovieWellcomePopup(event:Event):void
		{
			if ((event.currentTarget as MovieClip).currentFrame == (((event.currentTarget as MovieClip).totalFrames)/3)*2)
			{
				(event.currentTarget as MovieClip).stop();
				(event.currentTarget as MovieClip).removeEventListener(Event.ENTER_FRAME, firstPartMovieWellcomePopup);
				_button=((_content.getChildByName("InfWellcome") as MovieClip).getChildByName("InfScroll") as MovieClip).getChildByName("doButton_0") as SimpleButton;
				_button.addEventListener(MouseEvent.CLICK, doClickOnButton);	
				_userName=((_content.getChildByName("InfWellcome") as MovieClip).getChildByName("InfScroll") as MovieClip).getChildByName("UserNameInp") as TextField;
				_userName.type=TextFieldType.INPUT;
				_userPass=((_content.getChildByName("InfWellcome") as MovieClip).getChildByName("InfScroll") as MovieClip).getChildByName("PassInp")as TextField;
				_userPass.type=TextFieldType.INPUT;
			}
		}
		override protected function doClickOnButton(event:MouseEvent):void
		{
			(event.target as SimpleButton).removeEventListener(MouseEvent.CLICK, doClickOnButton);
			var index:Number=int((event.target as DisplayObject).name.substring(9)); 
			var data_user:Array=[_userName,_userPass];
			dispatchEvent(new EventTrans(EventTrans.DO_BUTTON_CLICKED, new EventPopupDO(index, data_user)));
		}
	}
}