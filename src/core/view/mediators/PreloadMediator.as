package core.view.mediators
{
	import core.config.GeneralNotifications;
	import core.view.components.PreloaderVL;
	
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PreloadMediator extends Mediator
	{
		static public const NAME:String = "PreloadMediator";
		private var _viewComponent:PreloaderVL;
		public function PreloadMediator(viewComponent:PreloaderVL)
		{
			_viewComponent=viewComponent;
			super(NAME, viewComponent);
		}
		override public function onRegister():void
		{
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, viewComponent.getLoadPer as DisplayObject);
		}
		override public function listNotificationInterests():Array
		{
			return[GeneralNotifications.PRELOADER_PROGRESS];
		}
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.PRELOADER_PROGRESS:
				_viewComponent.LoadPer=notification.getBody() as Number;
			}	
		}
		override public function onRemove():void
		{
			sendNotification(GeneralNotifications.REMOVE_CHILD_TO_ROOT, viewComponent.getLoadPer as DisplayObject);
		}
		
	}
}