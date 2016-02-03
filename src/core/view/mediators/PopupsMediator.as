package core.view.mediators
{
	import core.config.GeneralNotifications;
	import core.config.SimpleNotifications;
	import core.model.dateobj.DOActionDOPopup;
	import core.view.components.FailPopup;
	import core.view.components.PopupVL;
	import core.view.components.WellcomePopup;
	import core.view.components.WinVLPopup;
	import org.puremvc.as3.interfaces.INotification;
	import utils.event.EventTrans;
	
	public class PopupsMediator extends UIMediator
	{
		private static var _NAME:String;
		private var _do_buttonlist:Array;
		private var _viewComponent:PopupVL;
		public function PopupsMediator(NAME:String, viewComponent:PopupVL, do_buttonlist:Array,namePopup:String=null)
		{
			if (viewComponent == null)
			{
				_viewComponent = new PopupVL(namePopup);
			}else{
				_viewComponent = viewComponent;
			}
			_NAME=NAME;
			super(_NAME,_viewComponent);
			_do_buttonlist=do_buttonlist;
			registerListEvent();
		}
		override public function onRegister():void
		{
			super.onRegister();
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, viewLogic.content);
			registerListEvent();
		}
		override public function listNotificationInterests():Array
		{
			return [GeneralNotifications.PASS_ERROR,
				GeneralNotifications.PASS_CORRECT,
				SimpleNotifications.IS_NEED_NEXTBUTTON_FAILPOPUP,
				SimpleNotifications.IS_NEED_NEXTBUTTON_WINPOPUP
			];
		}
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.PASS_ERROR:
					(viewComponent as WellcomePopup).setErrorPass();
					break;
				case GeneralNotifications.PASS_CORRECT:
					(viewComponent as WellcomePopup).correctPass();
					break;
				case SimpleNotifications.IS_NEED_NEXTBUTTON_FAILPOPUP:
					(viewComponent as FailPopup).isNeedNextButton(notification.getBody());
					break;
				case SimpleNotifications.IS_NEED_NEXTBUTTON_WINPOPUP:
					(viewComponent as WinVLPopup).isNeedNextButton(notification.getBody());
					break;
			}
		}
		public function registerListEvent():void
		{
			_viewComponent.addEventListener(EventTrans.DO_BUTTON_CLICKED, doBtnClicked);
			_viewComponent.addEventListener(EventTrans.CLOSE_BUTTON_CLICKED, closeBtnClicked);
			_viewComponent.addEventListener(EventTrans.TO_INFOPOPUP,tutorialBtnClicked);
		}
		protected function doBtnClicked(event:EventTrans):void
		{
			var button_ind:Number=event.data.getIndex as Number;
			var dadPopup:DOActionDOPopup=_do_buttonlist[button_ind];
			if(event.data.hasOwnProperty("getData"))
			{
				var data:Object=event.data.getData;
				dadPopup.getBody()["data"]=data;
			}
			else
			{
				dadPopup.getBody()["data"]=null;
			}	
			switch(dadPopup.isNeedCloseDialogType)
			{	
				case 0:
					sendNotification(dadPopup.getName(),dadPopup.getBody(),dadPopup.getType());
					break;	
				case 1:
					facade.removeMediator(PopupsMediator._NAME);
					sendNotification(dadPopup.getName(),dadPopup.getBody(),dadPopup.getType());
					break;	
				case 2:
					sendNotification(dadPopup.getName(),dadPopup.getBody(),dadPopup.getType());
					facade.removeMediator(PopupsMediator._NAME);
					break;	
			}
		}
		protected function tutorialBtnClicked(event:EventTrans):void
		{
			sendNotification(GeneralNotifications.LOADING_LEVEL_INFO_COMMAND);
			facade.removeMediator(PopupsMediator._NAME);
		}
		protected function closeBtnClicked(event:EventTrans):void
		{
			sendNotification(GeneralNotifications.CLOSEPOPUP);
			facade.removeMediator(PopupsMediator._NAME);
		}
		override public function onRemove():void
		{
			super.onRemove();
			_viewComponent.removeEventListener(EventTrans.DO_BUTTON_CLICKED, doBtnClicked);
			_viewComponent.removeEventListener(EventTrans.CLOSE_BUTTON_CLICKED, closeBtnClicked);
			_viewComponent.removeEventListener(EventTrans.TO_INFOPOPUP,tutorialBtnClicked);
			sendNotification(GeneralNotifications.REMOVE_CHILD_TO_ROOT, viewLogic.content);
		}
	}
}