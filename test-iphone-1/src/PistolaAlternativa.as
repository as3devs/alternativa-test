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
	
	//[SWF(width="320",height="480",backgroundColor="#cccccc")]
	
	public class PistolaAlternativa extends Sprite
	{
		
		/**
		 * 
		 * PUBLIC
		 * 
		 * */

		public function PistolaAlternativa(){
			
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			//this.init();
			//this.anim();
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
		
		private var box:Box;
		private var boxContainer:Object3DContainer;
		private var containerPai:Object3DContainer;
		private var points:int=10;
		private var teta:Number=0;
		private var fi:Number=0;
		
		private var controller:SimpleObjectController;
		
		//methods
		
		private function anim():void{
		
			var k:Number = 500;
			
			var bezier:Array = [{x:Math.random()*k,y:Math.random()*k,z:Math.random()*k},
								{x:Math.random()*k,y:Math.random()*k,z:Math.random()*k},
								{x:Math.random()*k,y:Math.random()*k,z:Math.random()*k}];
			
			
			TweenMax.to(box,3,{bezier:bezier,x:0,y:0,z:0});
		}
		
		private function positionBox():void{
			this.box.x = -100 + Math.random() * 200;
			this.box.y = -100 + Math.random() * 200;
			this.box.z = -100 + Math.random() * 200;
		}
		
		private function init(e:Event=null):void{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var container:ConflictContainer = new ConflictContainer;

			camera = new Camera3D;
			camera.z = 500;
			camera.view = new View(640, 960);
			//camera.debug = false;
			
			container.addChild(camera);
			
			controller = new SimpleObjectController(stage,camera,200);
			controller.lookAtXYZ(0, 0, 0);
			

			addChild(camera.view);
			
			boxContainer = new Object3DContainer();
			containerPai = new Object3DContainer();
			
			box = new Box(150,80, 80);
			
			//this.positionBox();
			
			var bitmapData:BitmapData = (new imageAlternativa as Bitmap).bitmapData;
			
			var material:TextureMaterial = new TextureMaterial(bitmapData,false,true,MipMapping.OBJECT_DISTANCE, 0.39);
			box.setMaterialToAllFaces(material);
			box.useHandCursor = true;
			box.x = 75;
			
			boxContainer.addChild(box);
			containerPai.addChild(boxContainer);
			
			container.addChild(containerPai);
			
			rootContainer.addChild(container);
			
			//box.addEventListener(MouseEvent3D.MOUSE_OVER,this.onMouseOver);
			//box.addEventListener(MouseEvent3D.MOUSE_OUT,this.onMouseOut);
			//box.addEventListener(MouseEvent3D.CLICK,this.onClick);
			
			stage.addEventListener(Event.ENTER_FRAME,renderLoop);
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
		
		private function onMouseOver(e:MouseEvent3D):void{
			
			var object:Object3D = e.target as Object3D;
			
			TweenMax.to(object,.5,{scaleX:1.5,scaleY:1.5,scaleZ:1.5});
			
		}
		
		private function onMouseOut(e:MouseEvent3D):void{
			
			var object:Object3D = e.target as Object3D;
			
			TweenMax.to(object,.5,{scaleX:1,scaleY:1,scaleZ:1});
			
		}
		
		
		private function onClick(e:MouseEvent3D):void{
			
			var object:Object3D = e.target as Object3D;
			
			this.positionBox();
			
			this.anim();
			
		}
		
		private function renderLoop(e:Event):void{
			controller.stopMouseLook();
			controller.update();
			
			camera.view.width = 640;
			camera.view.height = 960;
			
			var x:Number = mouseX-(stage.stageWidth/2);
			var y:Number = mouseY-(stage.stageHeight/2);
			var z:Number=-50;
			
			var M:Number = Math.sqrt( Math.pow(x,2) + Math.pow(y,2) + Math.pow(z,2));	
			
			this.fi = -Math.asin(y/M);
			
			this.teta =Math.acos(x/(M*Math.cos(this.fi)));
			
			//boxContainer.rotationZ+=Math.PI/50;
			boxContainer.rotationZ = fi;
			
			containerPai.rotationY = teta;
			//boxContainer.rotationY +=Math.PI/50;
			//box.x++;

			camera.render();
		}
	}
}