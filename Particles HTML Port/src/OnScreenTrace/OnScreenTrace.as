package OnScreenTrace
{
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * Trace without debug
	 * @author Stephen Birsa
	 */
	public class OnScreenTrace extends Sprite
	{
		//Usage:
		/*
		 * import OnScreenTrace.OnScreenTrace; import the package
		 * 
		 * var _trace:OnScreenTrace = new OnScreenTrace(width, height, colour);
		 *
		 * stage.addChild(_trace); add the trace object to the screen
		 * _trace.trace(...rest); trace anything onto the screen
		 * _trace.multilineTrace(...rest); trace anything onto the screen per line
		 * _trace.clearTrace(); clear the trace from the screen*
		 */
		
		private var bold:Boolean;
		private var glow:GlowFilter;
		private var _trace:TextField;
		
		//Required parameters are the screens width and height
		//Colour of the text field is optional
		public function OnScreenTrace(screenWidth:Number, screenHeight:Number, colour:int = 0x000000, boldOutline:Boolean = false) 
		{
			super();
			createTrace(screenWidth, screenHeight, colour, boldOutline);
		}
		
		//Creates the text field on this sprite object
		private function createTrace(width:Number, height:Number, colour:int, boldOutline:Boolean):void {
			_trace = new TextField();
			_trace.selectable = false;
			_trace.defaultTextFormat = new TextFormat(null, null, colour);
			_trace.width = width;
			_trace.height = height;
			_trace.text = "";
			this.boldOutline = boldOutline;
			this.addChild(_trace);
		}
		
		/**
		 * Trace anything onto the screen.
		 * @param	rest Any object accepted.
		 */
		public function trace(rest:*):void {
			_trace.text = rest;
		}
		
		/**
		 * Clear the trace from the screen.
		 */
		public function clearTrace():void {
			_trace.text = "";
		}
		
		public function set boldOutline(b:Boolean):void {
			bold = b;
			if (bold == true) {
				glow = new GlowFilter(0xFFFFFF, 1, 2, 2, 10, BitmapFilterQuality.MEDIUM);
				_trace.filters = [glow];
			}
			if (bold == false) {
				if (glow != null) {
					_trace.filters = [];
					glow = null;
				}
			}
		}
		
		/**
		 * Enable white bold around the text for better readability.
		 */
		public function get boldOutline():Boolean {
			return bold;
		}
		
		/**
		 * Trace anything onto the screen.
		 * Adds every trace on a new line, otherwise replaces old lines.
		 * @param	rest Any object accepted.
		 */
		public function multilineTrace(rest:*):void {
			_trace.appendText("\n" + rest);
			if (_trace.scrollV < _trace.maxScrollV) {
				_trace.scrollV++;
			}
		}
		
	}

}
