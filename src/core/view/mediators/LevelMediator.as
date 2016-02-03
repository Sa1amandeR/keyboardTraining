package core.view.mediators
{
	import core.config.GeneralNotifications;
	import core.config.SimpleNotifications;
	import core.view.components.LevelViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.event.EventTrans;
	
	public class LevelMediator extends UIMediator
	{
		static public const NAME:String = "LevelMediator";
		public function LevelMediator(viewComponent:LevelViewLogic)
		{
			super(NAME,viewComponent);
		}
		override public function onRegister():void
		{
			super.onRegister();
			registerListEvent();
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, viewLogic.content);
		}
		override public function listNotificationInterests():Array
		{
			return[GeneralNotifications.TEXT_TO_LVL,
			GeneralNotifications.CORRECTLY_WORD,
			SimpleNotifications.RESET_TEXT,
			SimpleNotifications.STOP_SONIC_MOVIE
			];
		}
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.TEXT_TO_LVL:
				(viewComponent as LevelViewLogic).textInRing(notification.getBody().textArr as Array);
				break;
				case GeneralNotifications.CORRECTLY_WORD:
				(viewComponent as LevelViewLogic).removeRing(notification.getBody() as int);
				//registerListEvent();
				break;
				case SimpleNotifications.RESET_TEXT:
				(viewComponent as LevelViewLogic).replaceRing(notification.getBody().textArr as Array);
				break;
				case SimpleNotifications.STOP_SONIC_MOVIE:
				(viewComponent as LevelViewLogic).stopSonicMovie();
				//(viewComponent as LevelViewLogic).removeEventListener(EventTrans.SONIC_MOVE_FINISHED, stopSonicMove);
				break;
			}
		}
		public function registerListEvent():void
		{
			viewComponent.addEventListener(EventTrans.SONIC_MOVE_FINISHED, stopSonicMove);
		}
		private function stopSonicMove(event:EventTrans):void
		{
			//(event.target as LevelViewLogic).removeEventListener(EventTrans.SONIC_MOVE_FINISHED, stopSonicMove);
			sendNotification(GeneralNotifications.TURN_COMMAND);
		}
		override public function onRemove():void
		{
			super.onRemove();
			sendNotification(GeneralNotifications.REMOVE_CHILD_TO_ROOT, viewLogic.content);
		}
		
	}	
}