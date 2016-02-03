package utils.WH
{
	import core.model.dateobj.UsersDO;
	
	import flash.net.SharedObject;
	
	public class SharedObjectUtil
	{
		private static var _instance:SharedObjectUtil;
		private var _usNameText:String;
		private var _password:String;
		private var _score:int;
		private var _tempScore:int;
		private var userDO:UsersDO;
		private var userTempDO:UsersDO;
		private var nameSO:SharedObject = SharedObject.getLocal("SO_Name");
		
		public static function  getInstance():SharedObjectUtil
		{	
			if (_instance==null)
			{
				_instance= new SharedObjectUtil();
			}
			return _instance as SharedObjectUtil;
		}
		public function setUserSO(usNameText:String,password:String,score:int):void
		{
			_score=score;
			_usNameText=usNameText;
			_password=password;
			var usInfoToSO:Array=new Array();
			//nameSO.clear();
			usInfoToSO.push(usNameText,password, score);
			nameSO.data[usNameText]=usInfoToSO;	
		}
		public function getUserSO():UsersDO
		{
			var userDO:UsersDO=new UsersDO();
			
			userDO.set_us_name=_usNameText;
			userDO.set_us_score=_score;
			userDO.set_us_password=_password;
			userDO.set_best_us_score=_tempScore;
			return userDO;	
		}
		public function hasUserSOFilter(usNameText:String):Boolean
		{
			var usInfoFromSO:Array=new Array();
			
			//nameSO.clear();
			for (var Obj:Object in nameSO.data)
			{
				usInfoFromSO.push(nameSO.data[Obj]);
			}
			
			var nameInSO:Boolean=false;
			var len:int=usInfoFromSO.length;
			for (var i:int=0; i<len; i++)
			{
				if (usInfoFromSO[i][0]==usNameText)
				{
					nameInSO=true;
					_usNameText=usInfoFromSO[i][0];
					_score=usInfoFromSO[i][2];
					break;
				}
				else 
				{
					nameInSO;
				}
			}
			return nameInSO;
		}
		public function hasPassSOFilter(usNameText:String,usPassName:String):Boolean
		{
			var groupName_pass:Array=new Array();
			
			for (var Obj:Object in nameSO.data)
			{
				groupName_pass.push(nameSO.data[Obj]);
			}
			var name_passInSO:Boolean=false;
			var len:int=groupName_pass.length;
			for (var i:int=0; i<len; i++)
			{
				if (groupName_pass[i][0]==usNameText&&groupName_pass[i][1]==usPassName)
				{
					name_passInSO=true;
					break;
				}
				else
				{
					name_passInSO;
				}
			}
			return name_passInSO;
		}
		public function setLastBestScore(tempScore:int):void
		{
			_tempScore=tempScore;
		}
		public function getCurrentLevelScore():int
		{
			return _score as int;
		}
	}
}