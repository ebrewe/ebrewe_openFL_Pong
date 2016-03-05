package;

import haxe.Timer;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

/**
 * ...
 * @author Ebrewe
 */
class Main extends Sprite 
{

	var inited: Bool = false; 
	
	function resize(e)
	{
		if (!inited) init();
	}
	
	function init()
	{
		if (inited) 
			return;
		inited = true; 
	}
	
	public function new() 
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, added); 
	}
	
	function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		
		//conditionals
		#if ios
		Timer.delay(init, 100);
		#else
		init();
		#end
	}
	
	public static function main()
	{
		//static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main()); 
	}

}
