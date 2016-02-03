package core.model.dateobj
{
	import flash.net.SharedObject;
	
	
	public class UsersDO
	{
		private var _user_name:String;
		private var _user_score:int;
		private var _user_password:String;
		private var _user_temp_score:int;
		
		public function UsersDO()
		{	
		}	
		public function set set_us_name(userDO_name:String):void
		{
			_user_name=userDO_name;
			
		}
		public function set set_us_score(userDO_score:int):void
		{
			_user_score=userDO_score;
		}
		public function set set_us_password(userDO_password:String):void
		{
			_user_password=userDO_password;
		}
		public function get get_us_name():String
		{
			return _user_name;
		}
		public function get get_us_score():int
		{
			return _user_score as int;
		}
		public function get get_us_password():String
		{
			return _user_password as String;
		}
		public function set set_best_us_score(userDO_temp_score:int):void
		{
			_user_temp_score=userDO_temp_score;
		}
		public function get get_best_us_score():int
		{
			return _user_temp_score as int;
		}
	}
}