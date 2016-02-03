package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.config.SimpleNotifications;
	import core.model.proxy.KeyboardProxy;
	import core.model.proxy.LevelInfoLoadProxy;
	import core.model.proxy.UsersProxy;
	import core.view.components.IconsVL;
	import core.view.mediators.IconsMediator;
	import core.view.mediators.LevelMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class BackToLobbyCommand extends SimpleCommand
	{
		private var level_info_proxy:LevelInfoLoadProxy;
		override public function execute(notification:INotification):void
		{
			level_info_proxy=facade.retrieveProxy(LevelInfoLoadProxy.NAME) as LevelInfoLoadProxy;
			sendNotification(SimpleNotifications.STOP_SONIC_MOVIE);
			switch(notification.getBody().toString())
			{
				case SimpleNotifications.BACK_TO_LOBBY_FROM_SCOREBAR:
					(facade.retrieveProxy(KeyboardProxy.NAME) as KeyboardProxy).timerStop();
				break;
			}
			facade.registerMediator(new IconsMediator(new IconsVL()));
			facade.removeMediator(LevelMediator.NAME);
			facade.removeProxy(KeyboardProxy.NAME);
			var user_score:int=(facade.retrieveProxy(UsersProxy.NAME) as UsersProxy).getUserDO.get_us_score;
			var number_of_levels:int=level_info_proxy.Lvls.length;
			var lvl_open:Array=new Array();
			var tooltip_info:Array=new Array();
			(facade.retrieveProxy(UsersProxy.NAME) as UsersProxy).resetCurrentLevelScore();
			for (var i:int=0; i<number_of_levels; i++)
			{
				var u:int=level_info_proxy.getLevel(i).open_score;
				if (user_score>=u)
				{
					lvl_open[i]=level_info_proxy.getLevel(i).id;
				}else{
					tooltip_info[i]=[u,user_score];
				}
			}
			sendNotification(GeneralNotifications.INFO_FOR_TOOLTIP,tooltip_info);
			sendNotification(GeneralNotifications.NUMBER_OF_LEVEL_UNLOCK,lvl_open);
			sendNotification(GeneralNotifications.SCORE_BAR_RESET,user_score);
			//sendNotification(GeneralNotifications.HIDE_BACKBUTTON);
		}
	}
}