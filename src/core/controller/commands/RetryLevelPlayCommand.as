package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.config.SimpleNotifications;
	import core.model.proxy.KeyboardProxy;
	import core.model.proxy.LevelInfoLoadProxy;
	import core.model.proxy.UsersProxy;
	import core.view.components.LevelViewLogic;
	import core.view.mediators.LevelMediator;
	import flash.display.DisplayObjectContainer;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class RetryLevelPlayCommand extends SimpleCommand
	{
		private var level_info_proxy:LevelInfoLoadProxy;
		override public function execute(notification:INotification):void
		{
			level_info_proxy=facade.retrieveProxy(LevelInfoLoadProxy.NAME) as LevelInfoLoadProxy;
			var lvl_num:int=(level_info_proxy.getCurrentLvl())-1;
			var text_array:Array=new Array();
			var text_in_xml:String=level_info_proxy.getLevel(lvl_num).text;
			var text_split:Array=text_in_xml.split("");
			var number:String; 
			var index:int=0;
			var time:int=level_info_proxy.getLevel(lvl_num).time;
			var errors:int=level_info_proxy.getLevel(lvl_num).errors;
			var num_character:int=level_info_proxy.getLevel(lvl_num).numWords;
			for(var n:int = 0; n<num_character; n++)
			{
				var rand:int = int(Math.random()*text_split.length);
				number = text_split[rand];
				text_array.push(number); 
			}
			var current_user_score:int=(facade.retrieveProxy(UsersProxy.NAME) as UsersProxy).getUserDO.get_us_score;
			(facade.retrieveProxy(UsersProxy.NAME) as UsersProxy).resetCurrentLevelScore();
			sendNotification(GeneralNotifications.SCORE_BAR_RESET, current_user_score);
			sendNotification(GeneralNotifications.WRONG_WORD,errors);
			sendNotification(SimpleNotifications.RESET_TIME,time);
			sendNotification(SimpleNotifications.RESET_TEXT,{textArr:text_array,numWords:num_character});
			var lvl_viewComponent:DisplayObjectContainer=(((facade.retrieveMediator(LevelMediator.NAME) as LevelMediator).getViewComponent() as LevelViewLogic).content as DisplayObjectContainer);
			
			facade.registerProxy(new KeyboardProxy(lvl_viewComponent,text_array,index,errors,time));
			(facade.retrieveProxy(KeyboardProxy.NAME) as KeyboardProxy).timerStart();
		}
	}
}