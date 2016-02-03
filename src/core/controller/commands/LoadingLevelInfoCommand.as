package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.model.proxy.LevelInfoLoadProxy;
	import core.model.proxy.UsersProxy;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import utils.WH.XMLWareHouse;
	
	public class LoadingLevelInfoCommand extends SimpleCommand
	{
		private var c:int;
		private var level_info_loader:URLLoader;
		override public function execute(notification:INotification):void
		{
			var user_proxy:UsersProxy=facade.retrieveProxy(UsersProxy.NAME) as UsersProxy;
			var user_name:String=user_proxy.getUserDO.get_us_name;
			var user_score:int=user_proxy.getUserDO.get_us_score;
			sendNotification(GeneralNotifications.NAME_SCOREBAR,user_name);
			sendNotification(GeneralNotifications.SCORE_SCOREBAR,user_score);
			var xml_level_url:String=XMLWareHouse.getInstance().getXMLasset("Levels");
			var xml_url:URLRequest = new URLRequest(xml_level_url); 
			var level_info_loader:URLLoader = new URLLoader(xml_url); 
			level_info_loader.addEventListener(Event.COMPLETE, levelsInfoLoad);
		}
		public function levelsInfoLoad(event:Event):void 
		{ 
			var _level_info_loader:URLLoader=event.target as URLLoader;	
			var xml_lvl:XML = new XML(event.target.data);
			_level_info_loader.removeEventListener(Event.COMPLETE,levelsInfoLoad);
			facade.registerProxy(new LevelInfoLoadProxy(xml_lvl));
			//sendNotification(GeneralNotifications.LEVEL_UNLOCK_COMMAND);  	
		}
	}
}