package core.model.dateobj
{
	import org.puremvc.as3.patterns.observer.Notification;
	
	public class DOActionDOPopup extends Notification
	{
		private var _name:String;
		private var _body:Object;
		private var _type:String;
		private var _needCloseDialogType:Number;
		
		public function DOActionDOPopup(name:String, isNeedCloseDialogType:Number, body:Object=null, type:String=null)
		{
			super(name, body, type);
			_name=name;
			_body=body;
			_type=type;
			_needCloseDialogType=isNeedCloseDialogType;
		}
		public function get isNeedCloseDialogType():Number
		{
			return _needCloseDialogType;
		}	
	}
}