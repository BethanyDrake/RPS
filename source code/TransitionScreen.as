package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.*;
	//import flash.events.KeyboardEvent;
	//import flash.ui.Keyboard;
	/**
	 * ...
	 * @author 
	 */
	public class TransitionScreen extends Sprite
	{
		[Embed(source = "../img/blue40.png")]
		public var Blue:Class;
		[Embed(source = "../img/pink40.png")]
		public var Pink:Class;
		[Embed(source = "../img/orange40.png")]
		public var Orange:Class;
		[Embed(source = "../img/cyan40.png")]
		public var Cyan:Class;
		[Embed(source = "../img/purple40.png")]
		public var Purple:Class;
		[Embed(source = "../img/bg.png")]
		public var Black:Class;
		[Embed(source = "../img/ball.png")]
		public var Green:Class;
		
		//fonts
		[Embed(source = "../fonts/Chunkfive.ttf",
			fontName = "chunky",  embedAsCFF = "false")]
		private var fontFontSample:Class;
		
		
		
		public var type:int;
		public var closed:Boolean = false;
		public var opened:Boolean = false;
		public var closing:Boolean = false;
		public var opening:Boolean = true;
		public var names:Array = ["", "Doug", "Katterina", "Betterina", "Johno Smitho", "Patty", "Squint", "The Oracle", "Beep Boop"];
		public var colourList:Array = new Array();
		public var level:int;
		public var timer:Timer = new Timer(100);
		public function TransitionScreen(level_:int, type_:int = 1) 
		{	
			type = type_;
			level = level_;
			setColourList();
			timer.addEventListener(TimerEvent.TIMER, expandColours);
			timer.start();
			//addEventListener(KeyboardEvent.KEY_DOWN, close);
		}
		
		public function setColourList():void
		{
			colourList[0] = new Pink();
			colourList[1] = new Black();
			colourList[2] = new Orange();
			colourList[3] = new Black();
			colourList[4] = new Pink();
			colourList[5] = new Pink();
		}
		public var currColour:int = 0;
		public function expandColours(e:Event):void
		{
			
			if (currColour <= 5)
			{
			colourList[currColour].width = 0;
			colourList[currColour].height = 0;
			this.addChild(colourList[currColour]);
			}
			
			for (var i:int = currColour; i >= 0; i--)
			{
				if (colourList[0].width < stage.stageWidth)
				{colourList[i].width += 50;
				}
				if (colourList[0].height < stage.stageHeight)
				{colourList[i].height += 50;
				}
				colourList[i].x = stage.stageWidth / 2 - colourList[i].width / 2;
				colourList[i].y = stage.stageHeight / 2 - colourList[i].height / 2;
			}
			
			if (colourList[0].height >= stage.stageHeight)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, expandColours);
				displayText();
			}
			if (currColour < 5) currColour++;
			
			
		}
		
		public function displayText():void
		{
			setGameOverText();
			setPointsText();
			//setBestText();
			opened = true;
			opening = false;
			//addEventListener(Ke, close);
			//addEventListener(KeyboardEvent.KEY_DOWN, close, false,1);
			
		}
		
		public var gameOverText:TextField;
		public function setGameOverText():void
		{
			gameOverText = new TextField();
			var format:TextFormat = new TextFormat();
			format.size = 50;
			format.color = 0x000000;
			format.align = TextFormatAlign.CENTER;
			format.font = "chunky";
			
			gameOverText.embedFonts = true;
			gameOverText.defaultTextFormat = format;
			gameOverText.width = stage.stageWidth;
			gameOverText.y = 100;
			gameOverText.text = "NEXT LEVEL";
			
			addChild(gameOverText);
		}
		
		public var pointsText:TextField;
		public function setPointsText():void
		{
			pointsText = new TextField();
			var format:TextFormat = new TextFormat();
			format.size = 50;
			format.color = 0x000000;
			format.align = TextFormatAlign.CENTER;
			format.font = "chunky";
			
			pointsText.embedFonts = true;
			pointsText.defaultTextFormat = format;
			pointsText.width = stage.stageWidth;
			pointsText.y = gameOverText.y + gameOverText.height + 10;;
			
			if (level >= names.length) pointsText.text = "";//String(level);
			else pointsText.text = names[level];
			
			addChild(pointsText);
		}
		/*
		public var bestScore:int = 0;
		public var bestText:TextField;
		public function setBestText():void
		{
			bestText = new TextField();
			var format:TextFormat = new TextFormat();
			format.size = 20;
			format.color = 0x000000;
			format.align = TextFormatAlign.CENTER;
			format.font = "chunky";
			
			bestText.embedFonts = true;
			bestText.defaultTextFormat = format;
			bestText.width = stage.stageWidth;
			bestText.y = pointsText.y + pointsText.height/2 + 5;;
			bestText.text = "Best: " + bestScore_a;
			if (begin) bestText.text = "Left or right arrow key to begin.\n Score by collecting red squares.";
			addChild(bestText);
		}
		*/
		
		public function close():void
		{
			closing = true;
			removeChild(gameOverText);
			removeChild(pointsText);
			//removeChild(bestText);
			timer.addEventListener(TimerEvent.TIMER, collapse);
			timer.start();
		}
		
		public var numLeft:int = 5;
		public function collapse(e:Event):void
		{
			for (var i:int = 0; i <= numLeft; i++)
			{
				colourList[i].width -= 50;
				colourList[i].height -= 50;
				colourList[i].x = stage.stageWidth / 2 - colourList[i].width / 2;
				colourList[i].y = stage.stageHeight / 2 - colourList[i].height / 2;
				if (colourList[i].width <= 0) 
				{
					colourList[i].visible = false;
					numLeft--;
				}
			}
			if (numLeft == 0)
			{
				timer.stop();
				closed = true;
				stage.removeChild(this);
			}
			
			
		}
		
	}

}