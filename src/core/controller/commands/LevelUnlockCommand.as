package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.model.proxy.LevelInfoLoadProxy;
	import core.model.proxy.UsersProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class LevelUnlockCommand extends SimpleCommand
	{
		//private var level_info_proxy:LevelInfoLoadProxy=facade.retrieveProxy(LevelInfoLoadProxy.NAME) as LevelInfoLoadProxy;
		override public function execute(notification:INotification):void
		{
			
			var level_info_proxy:LevelInfoLoadProxy=facade.retrieveProxy(LevelInfoLoadProxy.NAME) as LevelInfoLoadProxy;
			var user_score:int=(facade.retrieveProxy(UsersProxy.NAME) as UsersProxy).getUserDO.get_us_score;
			var number_of_levels:int=level_info_proxy.Lvls.length;
			var lvl_open_id:Array=new Array();
			var tooltip_info:Array=new Array();
			for (var i:int=0; i<number_of_levels; i++)
			{
				var u:int=level_info_proxy.getLevel(i).open_score;
				if (user_score>=u)
				{
					lvl_open_id[i]=level_info_proxy.getLevel(i).id;
				}else{
					tooltip_info[i]=[u,user_score];
				}
			}
		sendNotification(GeneralNotifications.INFO_FOR_TOOLTIP,tooltip_info);
		sendNotification(GeneralNotifications.NUMBER_OF_LEVEL_UNLOCK,lvl_open_id);
		}
	}
}