package core
{
	import core.config.GeneralNotifications;
	import flash.display.Sprite;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class GameFacade extends Facade
	{
		public static function getInstance():GameFacade
		{
			if(instance==null)
			{
				instance=new GameFacade();
			}
			return instance as GameFacade;
		}
	public function startup(StartupCommand:Class,root:Sprite):void
		{
		registerCommand(GeneralNotifications.STARTUP,StartupCommand);
		sendNotification(GeneralNotifications.STARTUP,root);
		}
	}
}