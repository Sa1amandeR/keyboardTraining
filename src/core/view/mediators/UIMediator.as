package core.view.mediators
{
	import core.view.components.ViewLogic;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class UIMediator extends Mediator
	{
		private var _viewComponent:ViewLogic;
		public function UIMediator(NAME:String, viewComponent:ViewLogic)
		{
			super(NAME,viewComponent);
			_viewComponent=viewComponent;
		}
		protected function get viewLogic():ViewLogic
		{
			return viewComponent as ViewLogic;
		}
		override public function onRegister():void
		{
			super.onRegister();
		}	
		override public function onRemove():void
		{
			super.onRemove();
		}
	}
}