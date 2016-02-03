package core.view.components
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class PreloaderVL extends EventDispatcher
	{
		private var background:Shape;
		private var fill:Shape;          
		private var textField:TextField; 
		private var preloadsObj:Sprite=new Sprite;
		public function PreloaderVL()
		{
			background = new Shape();
			background.graphics.beginFill(0xEEEEEE, 1);
			background.graphics.drawRect(30, 50, 300, 40);
			background.graphics.endFill();
			preloadsObj.addChild(background);

			fill = new Shape();
			fill.graphics.beginFill(0x000000, 1);
			fill.graphics.drawRect(30, 50, 300, 40);
			fill.graphics.endFill();
			fill.scaleX = 0;
			preloadsObj.addChild(fill);
		
			textField = new TextField();
			var format:TextFormat = new TextFormat('Tahoma', 30);
			format.align = TextFormatAlign.CENTER;
			textField.defaultTextFormat = format;
			textField.width = 300;
			textField.height = 60;
			textField.mouseEnabled = false;
			preloadsObj.addChild(textField);
		}
		public function set LoadPer(value:Number):void
		{
			if (value < 0) value = 0;
			if (value > 100) value = 100;
			fill.scaleX = value;
			textField.text = Math.floor(value)+'%';
		}
		
		public function get getLoadPer():DisplayObject
		{
			return preloadsObj as DisplayObject;
		}
	}
}