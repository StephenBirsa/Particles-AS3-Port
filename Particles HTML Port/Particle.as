package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Stephen Birsa
	 */
	public class Particle extends Sprite
	{
		private var oldX:Number = 0;
		private var oldY:Number = 0;
		
		public function Particle() {
			
		}
		
		public function setUp(x:Number, y:Number):void {
			this.x = this.oldX = x;
			this.y = this.oldY = y;
		}
		
		public function integrate(DAMPING:Number):void {
			var velocityX:Number = (this.x - this.oldX) * DAMPING;
			var velocityY:Number = (this.y - this.oldY) * DAMPING;
			this.oldX = this.x;
			this.oldY = this.y;
			this.x += velocityX;
			this.y += velocityY;
		}
		
		public function attract(x:Number, y:Number):void {
			var dx:Number = x - this.x;
			var dy:Number = y - this.y;
			var distance:Number = Math.sqrt(dx * dx + dy * dy);
			this.x += dx / distance;
			this.y += dy / distance;
		}
		
		public function draw(size:uint=2, colour:uint=0xFFFFFF):void {
			if (this.width > 1 || this.height > 1) {
				this.graphics.clear();
			}
			this.graphics.lineStyle(size, colour);
			this.graphics.moveTo(this.oldX, this.oldY);
			this.graphics.lineTo(this.x, this.y);
		}
		
	}

}