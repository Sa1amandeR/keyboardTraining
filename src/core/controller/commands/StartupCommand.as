package core.controller.commands
{	
	import core.config.GeneralNotifications;
	import core.model.dateobj.FlashVarsDO;
	import core.model.proxy.FlashVarsProxy;
	import core.view.mediators.RootMediator;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var root:Sprite = notification.getBody() as Sprite;
			var flashvarsDO:FlashVarsDO = new FlashVarsDO(root.loaderInfo.parameters);

			facade.registerProxy(new FlashVarsProxy(flashvarsDO));
			
			facade.registerCommand(GeneralNotifications.MAIN_XML_INFO_LOAD_COMMAND, MainInfoLoadCommand);
			facade.registerCommand(GeneralNotifications.START_WAREHOUSE_LOADING, WareHouseLoadingCommand);
			facade.registerCommand(GeneralNotifications.USER_REGISTRATION_COMMAND, UserRegistrationCommand);
			facade.registerCommand(GeneralNotifications.LOADING_LEVEL_INFO_COMMAND, LoadingLevelInfoCommand);
			facade.registerCommand(GeneralNotifications.LEVEL_UNLOCK_COMMAND, LevelUnlockCommand);
			facade.registerCommand(GeneralNotifications.OPEN_LEVEL_COMMAND,OpenLevelCommand);
			facade.registerCommand(GeneralNotifications.BACK_TO_LOBBY_COMMAND, BackToLobbyCommand);			
			facade.registerCommand(GeneralNotifications.KEYBOARD_PRESS_COMMAND, KeyboardPressCommand);
			facade.registerCommand(GeneralNotifications.LEVEL_STOPPED_COMMAND, LevelStoppedCommand);
			facade.registerCommand(GeneralNotifications.TURN_COMMAND, TurnCommand);
			facade.registerCommand(GeneralNotifications.RETRY_LEVEL_PLAY_COMMAND, RetryLevelPlayCommand);
			facade.registerCommand(GeneralNotifications.NEXT_LEVEL_PLAY_COMMAND, NextLevelPlayCommand);
			
			facade.registerMediator(new RootMediator(root));
			
			sendNotification(GeneralNotifications.MAIN_XML_INFO_LOAD_COMMAND, (facade.retrieveProxy(FlashVarsProxy.NAME) as FlashVarsProxy).flashVars.XML_Url);
		}
	}
}