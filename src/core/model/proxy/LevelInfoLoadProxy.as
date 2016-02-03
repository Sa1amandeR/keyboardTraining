package core.model.proxy
{
	import core.config.GeneralNotifications;
	import core.model.dateobj.LevelsDO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class LevelInfoLoadProxy extends Proxy
	{
		static public const NAME:String="Level_info_load_proxy";
		private var _xml:XML;
		private var lvls:Array;
		private var currentLvl:int;
		public function LevelInfoLoadProxy(xml:XML)
		{
			super(NAME, xml);
			_xml=xml;
			parseXMLtoDO(_xml);
		}
		public function parseXMLtoDO(_xml:XML):void
		{
			var numOfLvls:int=(_xml.*.*.length()) as int ;
			lvls=new Array();
			for(var lvlnum:int=0; lvlnum<numOfLvls; lvlnum++)
			{
				var url:String=_xml.*.*[lvlnum].@URL;
				var id:String=_xml.*.*[lvlnum].@ID;
				var open_score:int=_xml.*.*[lvlnum].@open_score;
				var errors:int=_xml.*.*[lvlnum].@errors;
				var text:String=_xml.*.*[lvlnum].@text;
				var numWords:int=_xml.*.*[lvlnum].@numWords;
				var time:int=_xml.*.*[lvlnum].@time;
				lvls.push(new LevelsDO(url,id,open_score,errors,text,numWords,time));
			}
		}
		public function get Lvls():Array
		{
			return lvls as Array;
		}
		public function getLevel(i:int):LevelsDO
		{
			return lvls[i] as LevelsDO;
		}
		public function setCurrentLvl(n:int):void
		{
			currentLvl=n;
		}
		public function getCurrentLvl():int
		{
			return currentLvl;
		}
		override public function onRegister():void
		{
			sendNotification(GeneralNotifications.LEVEL_UNLOCK_COMMAND);
		}
	}
}