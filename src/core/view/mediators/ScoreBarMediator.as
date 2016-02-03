package core.view.mediators
{
	import core.config.GeneralNotifications;
	import core.config.SimpleNotifications;
	import core.view.components.ScoreBarVL;
	import flash.events.Event;
	import org.puremvc.as3.interfaces.INotification;
	import utils.event.EventTrans;
	
	public class ScoreBarMediator extends UIMediator
	{
		static public const NAME:String = "Scorebar_mediator";
		public function ScoreBarMediator(viewComponent:ScoreBarVL)
		{
			super(NAME,viewComponent);
		}
		override public function onRegister():void
		{
			super.onRegister();
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, viewLogic.content);
		}
		override public function listNotificationInterests():Array
		{
			return[GeneralNotifications.NAME_SCOREBAR,
				   GeneralNotifications.SCORE_SCOREBAR,
				   GeneralNotifications.SCORE_BAR_RESET,
				   GeneralNotifications.WRONG_WORD,
				   GeneralNotifications.CURRENT_LVL_TIME,
				   GeneralNotifications.TIME_UPDATE,
				   SimpleNotifications.RESET_TIME
			];
		}
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.NAME_SCOREBAR:
					(viewComponent as ScoreBarVL).setUserName(notification.getBody().toString());
				break;
				case GeneralNotifications.SCORE_SCOREBAR:
					(viewComponent as ScoreBarVL).setUserScore(notification.getBody().toString());
				break;
				case GeneralNotifications.WRONG_WORD:
					(viewComponent as ScoreBarVL).setUserErrors(notification.getBody().toString());
				break;
				case GeneralNotifications.CURRENT_LVL_TIME:
					(viewComponent as ScoreBarVL).setTime(notification.getBody().toString());
				break;
				case SimpleNotifications.RESET_TIME:
					(viewComponent as ScoreBarVL).setTime(notification.getBody().toString());
				break;
				case GeneralNotifications.SCORE_BAR_RESET:
					(viewComponent as ScoreBarVL).removeUserErrors();
					(viewComponent as ScoreBarVL).removeUserTime();
					(viewComponent as ScoreBarVL).resetScoreBar(notification.getBody().toString());
					registerListEvent();
				break;
				case GeneralNotifications.TIME_UPDATE:
					(viewComponent as ScoreBarVL).updateTimer(notification.getBody().toString());
				break;
			}
		}	
		public function registerListEvent():void
		{
			(viewComponent as ScoreBarVL).addEventListener(ScoreBarVL.BUTTON_BACK_TO_LOBBY, backToLobby);
			(viewComponent as ScoreBarVL).addEventListener(EventTrans.TIME_IS_OVER, stopGame);
		}
		protected function backToLobby(event:Event):void
		{
			sendNotification(GeneralNotifications.BACK_TO_LOBBY_COMMAND,SimpleNotifications.BACK_TO_LOBBY_FROM_SCOREBAR);
		}
		private function stopGame(event:EventTrans):void
		{
			(event.target as ScoreBarVL).removeEventListener(EventTrans.TIME_IS_OVER, stopGame);
			sendNotification(GeneralNotifications.LEVEL_STOPPED_COMMAND,SimpleNotifications.GAME_OVER);
		}
		override public function onRemove():void
		{
			super.onRemove();
			sendNotification(GeneralNotifications.REMOVE_CHILD_TO_ROOT, viewLogic.content);
		}
	}
}