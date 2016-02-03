package
{
	import core.GameFacade;
	import core.controller.commands.StartupCommand;
	import flash.display.Sprite;
	import flash.events.Event;

	public class Main extends Sprite
	{
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);	
		}
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			GameFacade.getInstance().startup(StartupCommand, this);
		}
	}
}