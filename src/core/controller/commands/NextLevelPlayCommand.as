package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.model.proxy.LevelInfoLoadProxy;
	import core.view.mediators.LevelMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class NextLevelPlayCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(LevelMediator.NAME);
			var currentLvl:int=(facade.retrieveProxy(LevelInfoLoadProxy.NAME) as LevelInfoLoadProxy).getCurrentLvl();
			var nextLvl:int=currentLvl + 1;
			sendNotification(GeneralNotifications.OPEN_LEVEL_COMMAND,nextLvl);
		}
	}
}