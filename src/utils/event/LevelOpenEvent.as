package utils.event
{
	import flash.events.Event;
	
	public class LevelOpenEvent extends Event
	{
		private var _data:Object;
		public static const OPEN_LVL:String="Open_lvl";
		public function LevelOpenEvent(type:String,data:Object=null)
		{
			super(type);
			_data = data;
		}
		public function get data():Object
		{
			return _data;
		}
	}
}
