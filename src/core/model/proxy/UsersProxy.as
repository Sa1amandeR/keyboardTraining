package core.model.proxy
{
	import core.config.GeneralNotifications;
	import core.model.dateobj.UsersDO;
	
	import flash.net.SharedObject;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import utils.WH.SharedObjectUtil;
	

	public class UsersProxy extends Proxy
	{
		static public const NAME:String="Users_Proxy";
		private var userName:String;
		private var userPassword:String;
		private var userCurrentScore:int;
		public function UsersProxy(usName:Object)
		{
			super(NAME,usName);		
			userName=usName.data[0].text;
			userPassword=usName.data[1].text;
			var len:int=userPassword.length;
			newPlayerReg();
		}
		override public function onRegister():void
		{
			userCurrentScore = getUserDO.get_us_score;
		}
		public function newPlayerReg():void
		{
			var user_name:String
			var user_score:int
			var new_player_score:int=0;
			var passError:String="User password incorrect";
			
			if(SharedObjectUtil.getInstance().hasUserSOFilter(userName) && SharedObjectUtil.getInstance().hasPassSOFilter(userPassword,userPassword))
			{
				sendNotification(GeneralNotifications.PASS_CORRECT);
			}
				else if(SharedObjectUtil.getInstance().hasUserSOFilter(userName) && !SharedObjectUtil.getInstance().hasPassSOFilter(userPassword,userPassword))
				{
					sendNotification(GeneralNotifications.PASS_ERROR);
				}
				else
				{
					SharedObjectUtil.getInstance().setUserSO(userName,userPassword,new_player_score);
					sendNotification(GeneralNotifications.PASS_CORRECT);
				}
		}
		public function get getUserDO():UsersDO
		{
			return SharedObjectUtil.getInstance().getUserSO();
		}
		public function setLastBestScore(score:int):void
		{
			userCurrentScore=score;
			SharedObjectUtil.getInstance().setLastBestScore(score);
		}
		public function updateUserInfo():void
		{
			var currentUserName:String=getUserDO.get_us_name;
			var currentUserPass:String=userPassword;
			var currentUserScore:int=userCurrentScore;
			SharedObjectUtil.getInstance().setUserSO(currentUserName,currentUserPass,currentUserScore);
		}
		public function get currentLevelScore():int
		{
			return userCurrentScore as int;
		}
		public function resetCurrentLevelScore():void
		{
			userCurrentScore = SharedObjectUtil.getInstance().getCurrentLevelScore();
		}
	}
}