package utils.event
{
	import core.model.dateobj.EventPopupDO;
	import flash.events.Event;
	
	public class EventTrans extends Event
	{
		public static const DO_BUTTON_CLICKED:String="do_button_clicked";
		public static const CLOSE_BUTTON_CLICKED:String="close_button_clicked";
		public static const LVL1_BTN_CLICKED:String="lvl1_btn_clicked";
		public static const SONIC_MOVE_FINISHED:String="sonic_move_finished";
		public static const TIME_IS_OVER:String="time_is_over";
		public static const TO_INFOPOPUP:String="From_infopopup_to_tutorial";
		private var _data:EventPopupDO;
		public function EventTrans(type:String, data:EventPopupDO=null)
		{
			super(type);
			_data=data;
		}
		public function get data():EventPopupDO
		{
			return _data;
		}
	}
}