package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.system.fscommand;
	
	/**
	 * ...
	 * @author Jacob
	 */
	public class Main extends Sprite 
	{
		private var player:Player = new Player();
		
		private var paused:Boolean = false;
		
		private var moveRight:Boolean = false;
		private var moveLeft:Boolean = false;
		private var moveUp:Boolean = false;
		private var moveDown:Boolean = false;
		
		private var speedHorizontal:int = 0;
		private var speedVertical:int = 0;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.addChild(player);
			player.x = 200;
			player.y = 200;
			
			
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		
		private function onKeyDown(Event:KeyboardEvent):void 
		{
			var keyDown:uint = Event.keyCode;
			
			switch (keyDown) 
			{
				case Keyboard.ESCAPE:
					fscommand("quit");
				break;
				
				case Keyboard.TAB:
					paused = !paused;
				break;
				
				case Keyboard.RIGHT:
					moveRight = true;
				break;
				case Keyboard.D:
					moveRight = true;
				break;
				
				case Keyboard.LEFT:
					moveLeft = true;
				break;
				case Keyboard.A:
					moveLeft = true;
				break;
				
				
			}
		}
		
		private function onKeyUp(Event:KeyboardEvent):void 
		{
			var keyUp:uint = Event.keyCode;
			
			switch (keyUp) 
			{
				
				case Keyboard.RIGHT:
					moveRight = false;
				break;
				case Keyboard.D:
					moveRight = false;
				break;
				
				case Keyboard.LEFT:
					moveLeft = false;
				break;
				case Keyboard.A:
					moveLeft = false;
				break;
				
			}
		}
		
		private function gameLoop(e:Event):void
		{
			if (!paused) 
			{
				
				{//Movement
					if (moveRight) 
					{
						speedHorizontal ++;
					}
					else 
					{
						if (speedHorizontal>0) 
						{
							speedHorizontal --;
						}
					}
					if (moveLeft) 
					{
						speedHorizontal --;
					}
					else 
					{
						if (speedHorizontal<0) 
						{
							speedHorizontal ++;
						}
					}
				}
				{//Bounding box
					if (player.x<0) 
					{
						player.x = 0;
						speedHorizontal *= -1;
					}
					if (player.x > 800 - player.width) 
					{
						player.x = 800 - player.width;
						speedHorizontal *= -1;
					}
				}
				
				
				player.x += speedHorizontal;
				player.y += speedVertical;
			}
		}
		
	}
	
}