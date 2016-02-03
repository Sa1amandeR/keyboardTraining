package utils.WH
{
	import flash.utils.Dictionary;

	public class XMLWareHouse
	{
		private var _XMLwh:Dictionary = new Dictionary(true);
		private static var _instance:XMLWareHouse;
		public static function  getInstance():XMLWareHouse
		{
			if (_instance==null)
			{
				_instance= new XMLWareHouse();
			}
			return _instance as XMLWareHouse;
		}
		public function addXMLasset(it_name:String, asset:String):void 
		{
			_XMLwh[it_name] = asset;	
		}
		public function hasXMLAsset(it_name:String):Boolean 
		{
			return (it_name in _XMLwh);
		}
		public function removeXMLAsset(it_name:String):void 
		{
			delete _XMLwh[it_name];
		}
		public function getXMLasset(it_name:String):String
		{
			var XMLurl:String;
			return XMLurl=_XMLwh[it_name];
		}
	}
}