package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.model.proxy.KeyboardProxy;
	import core.model.proxy.LevelInfoLoadProxy;
	import core.model.proxy.UsersProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class KeyboardPressCommand extends SimpleCommand
	{
		private var key_data:Object;
		private var nextLvl_open_score:int;
		private var lastLvl_open_score:int;
		private var updated_score:int;
		private var currentLvl_open_score:int;
		private var user_proxy:UsersProxy;
		private var level_info_proxy:LevelInfoLoadProxy;
		private var keyboard_proxy:KeyboardProxy;
		override public function execute(notification:INotification):void
		{
			user_proxy=facade.retrieveProxy(UsersProxy.NAME) as UsersProxy;
			level_info_proxy=facade.retrieveProxy(LevelInfoLoadProxy.NAME) as LevelInfoLoadProxy;
			keyboard_proxy=facade.retrieveProxy(KeyboardProxy.NAME) as KeyboardProxy;
			key_data=notification.getBody();
			var key_click:int=key_data.keyClickCode;
			var key_in_lvl:Array=key_data.keyInLvl;
			var index:int=key_data.index;
			var errors:int=key_data.errors;
			var score:int=user_proxy.getUserDO.get_us_score;
			var lvl_num:int=level_info_proxy.getCurrentLvl();
			var max_lvl_in_game:int=level_info_proxy.Lvls.length;
			var current_level_score:int=user_proxy.currentLevelScore;
			currentLvl_open_score=level_info_proxy.getLevel(lvl_num-1).open_score;
			if(lvl_num!=max_lvl_in_game)
			{
				nextLvl_open_score=level_info_proxy.getLevel(lvl_num).open_score;
			}else{
				nextLvl_open_score=currentLvl_open_score+100;
			}
			//lastLvl_open_score=level_info_proxy.getLevel(max_lvl_in_game-1).open_score;
			if(key_click==key_in_lvl[index])
			{
				keyboard_proxy.setpressedKeys(index);
				updated_score=current_level_score+10;
				keyboard_proxy.updateIndexLetter();
				plusScore(updated_score);
			}else{
				errors--;
				sendNotification(GeneralNotifications.WRONG_WORD,errors);
				keyboard_proxy.errorsUpdate(errors);
			}
		}
		public function plusScore(updated_score:int):void
		{
			if(updated_score<=nextLvl_open_score+1)
			{
				user_proxy.setLastBestScore(updated_score);
				sendNotification(GeneralNotifications.SCORE_SCOREBAR,updated_score);
			}
		}
		public function minusScore(updated_score:int):void
		{
			if(updated_score>currentLvl_open_score)
			{
				user_proxy.setLastBestScore(updated_score);
				sendNotification(GeneralNotifications.SCORE_SCOREBAR,updated_score);
			}
		}
	}
}