package  
{
	import com.geleca.as3.util.StatsMonitor;
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MediaEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.media.CameraRoll;
	import flash.media.CameraUI;
	import flash.media.MediaType;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Cristiano Caldas
	 */
	//[SWF(frameRate=30, width=320,  height=480)]
	[SWF(frameRate=30, width=640,  height=960)]
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			stage.align 		= StageAlign.TOP_LEFT;
			stage.scaleMode 	= StageScaleMode.NO_SCALE;
			
			init();
		}
		
		private function init():void
		{
			addChild(new PistolaAlternativa());
			
			addChild(new StatsMonitor());
			addChild(new Status()).y = 30;
		}
		
	}
	
}