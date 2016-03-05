package;

import flash.text.TextField;
import flash.text.TextFormat;
import haxe.Timer;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.text.TextField;
import openfl.text.TextFormatAlign;
import openfl.Lib;

/**
 * ...
 * @author Ebrewe
 */

enum GameState {
	Paused;
	Playing;
}

class Main extends Sprite 
{	

	var inited: Bool = false; 
	
	private var platform1:Platform;
	private var platform2:Platform;
	private var ball:Ball;
	
	private var currentGameState:GameState; 
	
	private var scorePlayer:Int;
	private var scoreAI:Int;
	
	
	//text fields
	private var scoreField:TextField;
	private var messageField:TextField;
	
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
		
		
	
		var scoreFormat = new TextFormat("Verdana", 24, 0xd9d9d9, true);
		scoreFormat.align = TextFormatAlign.CENTER;
		
		scoreField = new TextField();
		addChild(scoreField);
		scoreField.width = 500;
		scoreField.y = 30;
		scoreField.defaultTextFormat = scoreFormat;
		scoreField.selectable = false; 
		
		var messageFormat = new TextFormat("Verdana", 18, 0xd9d9d9, true);
		messageFormat.align = TextFormatAlign.CENTER;
		
		messageField = new TextField();
		addChild(messageField);
		messageField.width = 500;
		messageField.y = 450;
		messageField.defaultTextFormat = messageFormat;
		messageField.selectable = false; 
		
		messageField.text = "Press Spacebar to begin\nUse Arrow Keys to move your Platform";
		
		//set starting scores"
		scorePlayer = 0;
		scoreAI = 0;
		
		//default to paused 
		setGameState(GameState.Paused);
		
		//add keyboard listeners
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
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
	
	private function updateScore(){
		scoreField.text = scorePlayer + ":" + scoreAI;
	}
	
	private function setGameState(state:GameState):Void{
		currentGameState = state;
		updateScore();
		if (state == GameState.Paused)
		{
			messageField.alpha = 1;
		}else {
			messageField.alpha = 0;
		}
	}
	
	private function keyDown(e:KeyboardEvent):Void
	{
		if ( e.keyCode == 32)
		{
			var newState = currentGameState == (GameState.Paused) ? GameState.Playing : GameState.Paused;
			setGameState(newState);
		}
	}

}
