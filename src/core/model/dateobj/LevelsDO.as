package core.model.dateobj
{
	
	public class LevelsDO
	{
		private var _url:String;
		private var _id:String;
		private var _open_score:int;
		private var _errors:int;
		private var _text:String;
		private var _numWords:int;
		private var _time:int;
		public function LevelsDO(url:String,id:String,open_score:int,errors:int,text:String,numWords:int,time:int)
		{
			_url=url;
			_id=id;
			_open_score=open_score;
			_errors=errors;
			_text=text;
			_numWords=numWords;
			_time=time;
		}
		
		public function get url():String
		{
			return _url as String;
		}
		public function get id():String
		{
			return _id as String;
		}
		public function get open_score():int
		{
			return _open_score as int;
		}
		public function get errors():int
		{
			return _errors as int;
		}
		public function get text():String
		{
			return _text as String;
		}
		public function get numWords():int
		{
			return _numWords as int;
		}
		public function get time():int
		{
			return _time as int;
		}
	}
}