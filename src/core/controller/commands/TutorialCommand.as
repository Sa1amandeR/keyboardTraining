package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupsName;
	import core.model.dateobj.DOActionDOPopup;
	import core.model.proxy.UsersProxy;
	import core.view.components.TutorialPopupViewLogic;
	import core.view.mediators.PopupsMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class TutorialCommand extends SimpleCommand
	{
		override public function execute(notifacation:INotification):void
		{
			var closetutorial:DOActionDOPopup=new DOActionDOPopup(GeneralNotifications.LOADING_LEVEL_INFO_COMMAND, 1, {data:Object}, null);
			var cuurentUserScore:int=(facade.retrieveProxy(UsersProxy.NAME) as UsersProxy).getUserDO.get_us_score;
			var doButtonList:Array=new Array(closetutorial);
			facade.registerMediator(new PopupsMediator(PopupsName.MEDIATOR_FOR_TUTORIALPOPUP,new TutorialPopupViewLogic(),doButtonList));
		}
	}
}