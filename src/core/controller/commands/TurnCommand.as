package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.model.proxy.KeyboardProxy;
	
	import flash.utils.Proxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class TurnCommand extends SimpleCommand
	{
		private var pressedKey:Array;
		private var keyboardProxyInstance:KeyboardProxy;
		override public function execute(notification:INotification):void
		{
			instancesOfProxys();
			keyboardProxyInstance.rewritePressKeyArray();
			pressedKey=keyboardProxyInstance.getpressedKeys();
			if(pressedKey.length>0)
			{
				var nextKeyIndex:int=pressedKey[0];
				sendNotification(GeneralNotifications.CORRECTLY_WORD,nextKeyIndex);
			}else{
				keyboardProxyInstance.lastIndex();
			}
		}
		private function instancesOfProxys():void
		{
			keyboardProxyInstance=facade.retrieveProxy(KeyboardProxy.NAME) as KeyboardProxy;
		}	
	}
}