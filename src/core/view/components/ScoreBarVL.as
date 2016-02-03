package core.view.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import utils.event.EventTrans;
	
	public class ScoreBarVL extends ViewLogic
	{
		private var reg_user_name:TextField;	
		private var reg_user_score:TextField;
		private var reg_user_errors:TextField;
		private var reg_user_time:TextField;
		private var current_lvl_time:int;
		private var button_back_to_lobby:DisplayObject;
		private var _class_name:String="ScoreBar";	
		public static const BUTTON_BACK_TO_LOBBY:String="ButtonBackToLobby";
		
		public function ScoreBarVL()
		{
			super(_class_name,null);
			button_back_to_lobby=_content.getChildByName("Back_Button");
			reg_user_name=_content.getChildByName("UserNameSB") as TextField;
			reg_user_score=_content.getChildByName("UserScoreSB") as TextField;
			reg_user_errors=_content.getChildByName("UserErrorSB") as TextField;
			reg_user_time=_content.getChildByName("Timer") as TextField;
			
			button_back_to_lobby.visible=false;
			button_back_to_lobby.addEventListener(MouseEvent.CLICK, buttomBackToLobbyClicked);
		}
		
		protected function buttomBackToLobbyClicked(event:Event):void
		{
			button_back_to_lobby.visible=false;
			dispatchEvent(new MouseEvent(ScoreBarVL.BUTTON_BACK_TO_LOBBY));
		}
		public function setUserName(user_reg_name:String):void
		{
			var _user_name:String;
			_user_name=user_reg_name;
			reg_user_name.text=_user_name;
		}
		public function setUserScore(user_reg_score:Number):void
		{
			var _user_score:Number;
			_user_score=user_reg_score;
			reg_user_score.text=_user_score.toString();
		}
		public function setUserErrors(user_errors:Number):void
		{
			var _user_errors:Number;
			_user_errors=user_errors;
			reg_user_errors.text=_user_errors.toString();
		}
		public function removeUserErrors():void
		{		
			reg_user_errors.text="";
		}
		public function removeUserTime():void
		{
			button_back_to_lobby.visible=false;
			reg_user_time.text="";
		}
		public function resetScoreBar(user_score:Number):void
		{
			var _user_Score:Number;
			_user_Score=user_score;
			reg_user_score.text=_user_Score.toString();
			_content.parent.addChildAt(_content,_content.parent.numChildren); 
		}
		public function setTime(time:int):void
		{
			button_back_to_lobby.visible=true;
			current_lvl_time=time;
			reg_user_time.text=current_lvl_time.toString();
		}
		public function updateTimer(user_time:int):void
		{
			var updated_lvl_time:int=current_lvl_time - user_time;
			reg_user_time.text=updated_lvl_time.toString();
			if(updated_lvl_time == 0)
			{
				dispatchEvent(new EventTrans(EventTrans.TIME_IS_OVER));
			}
		}
	}
}