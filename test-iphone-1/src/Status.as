package  
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Cristiano Caldas
	 */
	public class Status extends Sprite 
	{
		
		public function Status() 
		{
			var txt:TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.LEFT;
			addChild(txt);
			txt.text = "player:" + Capabilities.version + ", " + "player-type:" + Capabilities.playerType + ", " + "AIR-version:" + NativeApplication.nativeApplication.runtimeVersion;
		}
		
	}

}