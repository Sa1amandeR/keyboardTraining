package utils.WH
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.utils.Dictionary;
	
	public class WareHouse   
	{
		private var _wh:Dictionary = new Dictionary(true);
		private static var _instance:WareHouse;
		public static function  getInstance():WareHouse
		{
			if (_instance==null)
			{
				_instance= new WareHouse();
			}
			return _instance as WareHouse;
		}
	
		public function addAsset(it_name:String, asset:DisplayObject):void 
		{
       		if (it_name in _wh) throw new ArgumentError("Ассет с URI '"+it_name+"' уже зарегистрирован!");
			_wh[it_name] = asset;
		}
	
		public function hasAsset(it_name:String):Boolean 
		{
			return (it_name in _wh);
		}
	
		public function removeAsset(it_name:String):void 
		{
			if (!(it_name in _wh)) throw new ArgumentError("Ассет с таким URI не зарегистрирован!");
			delete _wh[it_name];
		}
		
		public function getAsset(it_name_class:String):Class 
		{
			//if (!(it_name_class in _wh)) throw new ArgumentError("Ассет с таким URI ("+it_name_class+") не зарегистрирован!");
			var ItClass:Class;
			for each(var assetClass:Loader in _wh)
			if (assetClass.contentLoaderInfo.applicationDomain.hasDefinition(it_name_class))
			{
				ItClass=assetClass.contentLoaderInfo.applicationDomain.getDefinition(it_name_class) as Class;
				break;
			}
			return ItClass;
		}
	}
}