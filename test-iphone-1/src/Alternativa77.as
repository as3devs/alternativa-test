package
{
	import alternativa.engine3d.containers.ConflictContainer;
	import alternativa.engine3d.containers.DistanceSortContainer;
	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.MipMapping;
	import alternativa.engine3d.core.MouseEvent3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Object3DContainer;
	import alternativa.engine3d.core.Vertex;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.primitives.Box;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.BezierPlugin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	//[SWF(backgroundColor="#cccccc",frameRate="30")]
	public class Alternativa77 extends Sprite
	{
		
		/**
		 * 
		 * PUBLIC
		 * 
		 * */

		public function Alternativa77(){
			
			super();
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
			
			
		}
	
		
		/**
		 * 
		 * PRIVATE
		 * 
		 * */
		
		[Embed(source='../asset/alternativa3d_big.png')]
		private var imageAlternativa:Class;
		
		private var rootContainer:Object3DContainer = new Object3DContainer;
		private var camera:Camera3D;
		
		private var points:int=3;
		 
		private var controller:SimpleObjectController;
		
		private var caixas:Array;
		
		//methods
		
		private function anim(box:Box,i:int):void{
		
			var k:Number = 500;
			
			var bezier:Array = [{x:Math.random()*k,y:Math.random()*k,z:Math.random()*k},
								{x:Math.random()*k,y:Math.random()*k,z:Math.random()*k},
								{x:Math.random()*k,y:Math.random()*k,z:Math.random()*k}];
			
			
			TweenMax.to(box,3,{bezier:bezier,x:-(350/2) + i*90,y:0,z:0});
		}
		
		private function positionBox(box:Box):void{
			box.x = -100 + Math.random() * 200;
			box.y = -100 + Math.random() * 200;
			box.z = -100 + Math.random() * 200;
		}
		
		private function init(e:Event=null):void{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var container:ConflictContainer = new ConflictContainer;
			

			camera = new Camera3D;
			camera.z = 500;
			camera.view = new View(stage.stageWidth, stage.stageHeight);
			
			
			container.addChild(camera);
			
			controller = new SimpleObjectController(stage,camera,200);
			controller.lookAtXYZ(0, 0, 0);
			

			addChild(camera.view);
			
			var bitmapData:BitmapData = (new imageAlternativa as Bitmap).bitmapData;
			
			var material:TextureMaterial = new TextureMaterial(bitmapData,false,true,MipMapping.OBJECT_DISTANCE, 0.39);
			var box:Box;
			
			var numeroCaixas:int = 4;
			caixas = [];
			
			for (var i:int = 0; i < numeroCaixas; i++ ) {
				
				box = new Box(80, 80, 80);
				box.setMaterialToAllFaces(material);
				box.useHandCursor = true;

				caixas.push(box);
				
				container.addChild(box);
				
				this.positionBox(box);
				this.anim(box,i);
			}

			rootContainer.addChild(container);
			
			stage.addEventListener(Event.ENTER_FRAME, renderLoop);
			
			
			
		}
		
		private function createPoints():Vector.<Vertex>{
		
			var vector:Vector.<Vertex> = new Vector.<Vertex>;
			
			var DX:Number = 200;
			var DY:Number = 200;
			var DZ:Number = 200;
			
			var vertex:Vertex;
			
			for(var i:int=0;i<points;i++){
			
				vertex = new Vertex;
				
				vertex.x = DX*Math.random();
				vertex.y = DY*Math.random();
				vertex.z = DZ*Math.random();
				
				vector.push(vertex);
			}
			
			return vector;
			
		}
		
		//handlers
		
		private function renderLoop(e:Event):void{
			controller.stopMouseLook();
			controller.update();
			
			for (var i:int = 0; i < caixas.length; i++) 
			{
				var item:Box = caixas[i];
				
				item.rotationY += (Math.PI / 50);
			}

			camera.view.width = stage.stageWidth;
			camera.view.height = stage.stageHeight;

			camera.render();
		}
	}
}