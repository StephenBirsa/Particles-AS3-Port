package FPSMeter
{
	import flash.text.TextField;
	import flash.utils.getTimer;
	/**
	 * A simple fps code that calculates the frame rate.
	 * @author Stephen Birsa
	 */
	public class FPS_Meter 
	{
		/*
		 * Usage:
		 * var fps:FPS_Meter = new FPS_Meter();
		 * some text field = fps.getFPS();
		 * trace(fps.getFPS());
		 * 
		 * for accurate usage, use the trace inside an enterFrame event
		 * */
		private var framecount:int;
		private var fps:String;
		
		public function FPS_Meter() 
		{
			framecount = 0;
			fps = "";
		}
		
		/**
		 * Calculates the frame rate.
		 * @return The frame rate calculated.
		 */
		public function getFPS():String {
			framecount++;
			fps = Math.round(1000 * framecount / getTimer()) + " fps";
			return fps;
		}
		
	}

}