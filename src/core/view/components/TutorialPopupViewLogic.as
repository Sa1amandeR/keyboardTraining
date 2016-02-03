package core.view.components
{
	import core.config.PopupsName;
	import core.model.dateobj.EventPopupDO;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import utils.event.EventTrans;

	public class TutorialPopupViewLogic extends PopupVL
	{
		private var tuttorial_button:SimpleButton;
		private var _class_name:String="TutorialPopup";
		public function WellcomeInfoPopup()
		{
			super(_class_name);
			initButtons();
		}
		protected function initButtons():void
		{
			tuttorial_button=_content.getChildByName("clButton_0") as SimpleButton;
		}
	}
}