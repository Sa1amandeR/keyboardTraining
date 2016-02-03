package core.model.dateobj
{
	public class FlashVarsDO
	{
		public var _parameters:Object; 
		public function FlashVarsDO(parameters:Object)
		{
			this._parameters=parameters;
		}
		public function get assetPath():String
		{
			return String(_parameters["assetPath"]);
		}
		public function get XML_Url():String
		{
			return String(_parameters["XML_Url"]);
		}
	}
}