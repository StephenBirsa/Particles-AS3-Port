package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import OnScreenTrace.OnScreenTrace;
	import FPSMeter.FPS_Meter;
	
	/**
	 * ...
	 * @author Stephen Birsa
	 */
	[SWF(width = 800, height = 600, frameRate = 60, backgroundColor = 0x000000)]
	public class Main extends Sprite 
	{
		private const _DAMPING:Number = 0.999;
		private var _particles:Vector.<Particle> = new Vector.<Particle>();
		private const _width:uint = stage.stageWidth;
		private const _height:uint = stage.stageHeight;
		private var _data:BitmapData = new BitmapData(_width, _height, false, 0x000000);
		private var _canvas:Bitmap = new Bitmap(_data);
		private var _customSize:uint = 2;
		private var _colour:uint = 0xFFFFFF;
		private var _FPS:FPS_Meter = new FPS_Meter();
		private var _trace:OnScreenTrace = new OnScreenTrace(_width, _height, 0x000000, true);
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addChild(_canvas);
			stage.addChild(_trace);
			for (var i:int = 0; i < 200; i++) {
				_particles[i] = new Particle();
				_particles[i].setUp(Math.random() * _width, Math.random() * _height);
			}
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void {
			_data.lock();
			_data.fillRect(_data.rect, 0x000000);
			for (var i:int = 0; i < _particles.length; i++) {
				_particles[i].attract(mouseX, mouseY);
				_particles[i].integrate(_DAMPING);
				_particles[i].draw(_customSize, _colour);
				draw(_particles[i]);
			}
			_data.unlock();
			_trace.trace(_FPS.getFPS());
		}
		
		private function draw(src:Particle):void {
			_data.draw(src);
		}
		
	}
	
}
