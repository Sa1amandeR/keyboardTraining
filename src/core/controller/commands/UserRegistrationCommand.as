package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupsName;
	import core.model.dateobj.DOActionDOPopup;
	import core.model.proxy.UsersProxy;
	import core.view.components.WellcomeInfoPopup;
	import core.view.mediators.PopupsMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class UserRegistrationCommand extends SimpleCommand
	{	
		override public function execute(notifacation:INotification):void
		{
			var _users_data:Object=notifacation.getBody();
			var user_name:String=_users_data.data[0].text;
			var user_password:String=_users_data.data[1].text;
			
			if(user_name.length>3 && user_password.length>3)
			{
				facade.registerProxy(new UsersProxy(_users_data));
			}else{
				sendNotification(GeneralNotifications.PASS_ERROR);
			}
		}
	}
}