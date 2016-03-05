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
	
	private var platform1:Platform;
	private var platform2:Platform;
	private var ball:Ball;
	
	function resize(e)
	{
		if (!inited) init();
	}
	
	function init()
	{
		if (inited) 
			return;
		inited = true; 
		
		//Here we go!
		platform1 = new Platform();
		platform1.x = 5; 
		platform1.y = (this.stage.stageHeight / 2) - (platform1.height/2);
		this.addChild(platform1);
		
		platform2 = new Platform();
		platform2.x = 480; 
		platform2.y = (this.stage.stageHeight / 2) - (platform2.height / 2);
		this.addChild(platform2);
		
		ball = new Ball();
		ball.x = 250;
		ball.y = 250;
		this.addChild(ball);
		
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
