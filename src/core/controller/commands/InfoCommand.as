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

	public class InfoCommand extends SimpleCommand
	{
		override public function execute(notifacation:INotification):void
		{
			var tutorial:DOActionDOPopup=new DOActionDOPopup(GeneralNotifications.TUTORIALPOPUP, 1, {data:Object}, null);
			var closetutorial:DOActionDOPopup=new DOActionDOPopup(GeneralNotifications.LOADING_LEVEL_INFO_COMMAND, 1, {data:Object}, null);
			var cuurent_user_score:int=(facade.retrieveProxy(UsersProxy.NAME) as UsersProxy).getUserDO.get_us_score;
			if(cuurent_user_score==0)
			{
				var do_buttonlist:Array=new Array(tutorial);
				facade.registerMediator(new PopupsMediator(PopupsName.MEDIATOR_FOR_INFOPOPUP,new WellcomeInfoPopup(),do_buttonlist));
			}else{
				var do_buttonlist:Array=new Array(tutorial,closetutorial);
				facade.registerMediator(new PopupsMediator(PopupsName.MEDIATOR_FOR_INFOPOPUP,new WellcomeInfoPopup(),do_buttonlist));
			}
		}
	}
}