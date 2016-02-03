package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupsName;
	import core.config.SimpleNotifications;
	import core.model.dateobj.DOActionDOPopup;
	import core.model.proxy.KeyboardProxy;
	import core.model.proxy.LevelInfoLoadProxy;
	import core.model.proxy.UsersProxy;
	import core.view.components.FailPopup;
	import core.view.components.WinVLPopup;
	import core.view.mediators.PopupsMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class LevelStoppedCommand extends SimpleCommand
	{
		private var user_proxy:UsersProxy;
		private var level_info_proxy:LevelInfoLoadProxy;
		private var keyboard_proxy:KeyboardProxy;
		private var current_level_open_score:int;
		private var last_level_open_score:int;
		override public function execute(notification:INotification):void
		{
			user_proxy=facade.retrieveProxy(UsersProxy.NAME) as UsersProxy;
			level_info_proxy=facade.retrieveProxy(LevelInfoLoadProxy.NAME) as LevelInfoLoadProxy;
			keyboard_proxy=facade.retrieveProxy(KeyboardProxy.NAME) as KeyboardProxy;
			var back:DOActionDOPopup=new DOActionDOPopup(GeneralNotifications.BACK_TO_LOBBY_COMMAND, 1, {data:Object}, null);
			var reset:DOActionDOPopup=new DOActionDOPopup(GeneralNotifications.RETRY_LEVEL_PLAY_COMMAND, 1, {data:Object}, null);
			var next:DOActionDOPopup=new DOActionDOPopup(GeneralNotifications.NEXT_LEVEL_PLAY_COMMAND, 1, {data:Object}, null);
			var do_buttonlist:Array;
			var is_need_next_button:Boolean;
			var score:int=user_proxy.currentLevelScore;
			var lvl_num:int=level_info_proxy.getCurrentLvl();
			var max_lvl_in_game:int=level_info_proxy.Lvls.length;
			last_level_open_score=level_info_proxy.getLevel(max_lvl_in_game-1).open_score;
			if(lvl_num!=max_lvl_in_game)
			{
				current_level_open_score=level_info_proxy.getLevel(lvl_num).open_score;
			}else{
				current_level_open_score=last_level_open_score;
			}
			if(score>current_level_open_score && lvl_num!=max_lvl_in_game)
			{
				do_buttonlist=new Array(back,reset,next);
				is_need_next_button=true;
			}
			else
			{
				do_buttonlist=new Array(back,reset);
				is_need_next_button=false;
			}
			switch(notification.getBody().toString())
			{
				case SimpleNotifications.LEVEL_COMPLETE:
					user_proxy.updateUserInfo();
					user_proxy.resetCurrentLevelScore();
					sendNotification(SimpleNotifications.STOP_SONIC_MOVIE);
					keyboard_proxy.timerStop();
					//facade.removeProxy(KeyboardProxy.NAME);
					facade.registerMediator(new PopupsMediator(PopupsName.MEDIATOR_FOR_WINPOPUP,new WinVLPopup(),do_buttonlist));
					sendNotification(SimpleNotifications.IS_NEED_NEXTBUTTON_WINPOPUP,is_need_next_button);
					sendNotification(SimpleNotifications.CLEAN_SCENE);
				break;
				case SimpleNotifications.GAME_OVER:
					sendNotification(SimpleNotifications.STOP_SONIC_MOVIE);
					keyboard_proxy.timerStop();
					facade.registerMediator(new PopupsMediator(PopupsName.MEDIATOR_FOR_FAILPOPUP,new FailPopup(),do_buttonlist));
					sendNotification(SimpleNotifications.IS_NEED_NEXTBUTTON_FAILPOPUP,is_need_next_button);
					//facade.removeProxy(KeyboardProxy.NAME);
				break;
			}
			facade.removeProxy(KeyboardProxy.NAME);
		}
	}
}