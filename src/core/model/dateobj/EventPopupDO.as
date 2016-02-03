package core.model.dateobj
{
	public class EventPopupDO
	{
		private var button_ind:Number;
		private var button_data:Object;
		public function EventPopupDO(btn_id:Number, data:Object)
		{
			button_ind=btn_id;
			button_data=data;			
		}
		public function get getIndex():Number
		{
			return button_ind as Number;
		}
		public function get getData():Object
		{
			return button_data as Object;
		}
	}
}