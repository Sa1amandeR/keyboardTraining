package core.view.mediators
{
	import core.config.GeneralNotifications;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class RootMediator extends Mediator
	{
		public static const Name:String = "RootMediator";
		public function RootMediator(viewComponent:Sprite)
		{
			super(Name,viewComponent);
		}
		override public function listNotificationInterests():Array 
		{
			return [GeneralNotifications.ADD_CHILD_TO_ROOT,
				GeneralNotifications.REMOVE_CHILD_TO_ROOT];
		}
		override public function handleNotification(notification:INotification):void
		{	
		switch (notification.getName()){
			case GeneralNotifications.ADD_CHILD_TO_ROOT:
				(viewComponent as Sprite).addChild(notification.getBody() as DisplayObject);
			break;
			case GeneralNotifications.REMOVE_CHILD_TO_ROOT:
				(viewComponent as Sprite).removeChild(notification.getBody() as DisplayObject);
			break;
		}
		}
	}
}