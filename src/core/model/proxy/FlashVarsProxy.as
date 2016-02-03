package core.model.proxy
{
	import core.model.dateobj.FlashVarsDO;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class FlashVarsProxy extends Proxy
	{
		static public const NAME:String="FlashVarsProxy";
		public function FlashVarsProxy(flashVars:FlashVarsDO)
		{
			super(NAME, flashVars);
		}
		public function get flashVars():FlashVarsDO
		{
			return getData() as FlashVarsDO;
		}
	}
}