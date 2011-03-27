package  
{
	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.sensors.Accelerometer;
	
	/**
	 * ...
	 * @author Cristiano Caldas
	 */
	public class AcelerometerTest extends Sprite 
	{
		private var _acc					:Accelerometer;
		private var _asset					:AlternativaLogo;
		
		public function AcelerometerTest() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			_acc = new Accelerometer();
			_acc.addEventListener(AccelerometerEvent.UPDATE, acc_update);
			
			_asset = new AlternativaLogo();
			addChild(_asset);
			
		}
		
		private function acc_update(e:AccelerometerEvent):void 
		{
			_asset.x -= e.accelerationX * 10;
			_asset.y += e.accelerationY * 10;
		}
		
	}

}