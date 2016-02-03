package core.view.mediators
{
	import core.config.GeneralNotifications;
	import core.view.components.IconsVL;
	import org.puremvc.as3.interfaces.INotification;
	import utils.event.LevelOpenEvent;
	
	public class IconsMediator extends UIMediator  
	{
		static public const NAME:String = "Icons_mediator";
		private var _viewComponent:IconsVL;
		public function IconsMediator(viewComponent:IconsVL)
		{
			super(NAME,viewComponent);
		}
		override public function onRegister():void
		{
			super.onRegister();
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, viewLogic.content);
			registerListEvent();
		}
		override public function listNotificationInterests():Array
		{
			return[GeneralNotifications.INFO_FOR_TOOLTIP,
				GeneralNotifications.NUMBER_OF_LEVEL_UNLOCK];
		}
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.NUMBER_OF_LEVEL_UNLOCK:
				(viewComponent as IconsVL).unlock_lvls(notification.getBody() as Array);
				break;
				case GeneralNotifications.INFO_FOR_TOOLTIP:
				(viewComponent as IconsVL).tooltiptext(notification.getBody() as Array);
				break;
			}
		}
		public function registerListEvent():void
		{
			(viewComponent as IconsVL).addEventListener(LevelOpenEvent.OPEN_LVL, openLevel);
		}
		protected function openLevel(event:LevelOpenEvent):void
		{
			var lvl:int=int((event as LevelOpenEvent).data);
			sendNotification(GeneralNotifications.OPEN_LEVEL_COMMAND,lvl);
		}
		override public function onRemove():void
		{
			super.onRemove();
			sendNotification(GeneralNotifications.REMOVE_CHILD_TO_ROOT, viewLogic.content);
		}
	}
}