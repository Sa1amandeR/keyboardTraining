package core.controller.commands
{
	import core.config.GeneralNotifications;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import utils.WH.XMLWareHouse;
	
	public class MainInfoLoadCommand extends SimpleCommand
	{
		override public function execute(notifacation:INotification):void
		{
			Security.allowDomain("*");
			var xml_url:String=notifacation.getBody() as String;
			var main_xml_url:URLRequest = new URLRequest(xml_url); 
			var info_loader:URLLoader = new URLLoader(main_xml_url); 
			info_loader.addEventListener(Event.COMPLETE, xmlLoad); 	
		}
		public function xmlLoad(event:Event):void 
		{ 
			var xml_pars:XML = new XML(event.target.data);				
			var xml_pars_levels:XMLList=xml_pars["LEVELS"][0].child("path");
			for(var i:int=0; i<xml_pars_levels.length(); i++)
			{
				var url:String=xml_pars_levels[i].attribute('URL');
				var id:String=xml_pars_levels[i].attribute('ID');
				var type:String=xml_pars_levels[i].attribute('TYPE');
				XMLWareHouse.getInstance().addXMLasset(id,url);
			}
			var xml_pars_library:XMLList=xml_pars["LIBRARY"][0].child("path");
			sendNotification(GeneralNotifications.START_WAREHOUSE_LOADING, xml_pars_library);
		}	
	}
}