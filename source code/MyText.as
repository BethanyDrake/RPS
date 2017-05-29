package 
{
	import flash.display.Sprite;
	import flash.text.*;
	/**
	 * ...
	 * @author 
	 */
	public class MyText extends Sprite 
	{
		//Create the text objects
		public var format:TextFormat = new TextFormat();
		public var output:TextField = new TextField();
		
		
	
		
		public const WIN:int = 1;
		public const LOSE:int = 2;
		public const DRAW:int = 3;
		public const STREAK:int = 4;
		public const LABEL:int = 5;
		public const ERROR:int = 8;
		
		public var n:int = 0; 
		
		
		public function MyText(type:int, aText:String = "", n:int =0, err:int =0) 
		{
			super();
			var text:String;
			
			if (type == ERROR)
			{
				this.x = n;
				this.y = err; 
				
				type = 5;
			}
			
			if (type == 6)
			{
				this.x = n; 
				
				type = 5;
			}
			
			if (type == 7)
			{
				this.x = n; 
				this.y = 10; 
				type = 5;
			}
			
			if (type == WIN)
			{
				text = "WON:";
				format.color = 0x006600;
			}
			if (type == LOSE)
			{
				text = "LOST:";
				format.color = 0x990000;
			}
			if (type == DRAW)
			{
				text = "DRAW:";
				format.color = 0x550055;
			}
			
			if (type == STREAK)
			{
				text = "MASTERY:";
				format.color = 0x00FF00;
				output.background = true;
				output.backgroundColor = 0x000000;
				output.width = 100;
			}
			format.align = TextFormatAlign.LEFT;
			output.defaultTextFormat = format;
			if (type != LABEL)
			{
				format.size = 24;
				output.width = 75;
				output.height = 40;
			}
			else
			{
				format.size = 12;
				output.width = 150;
				output.height = 20;
				text = aText;
				format.color = 0x000000;
				output.background = false;
				
			}
				
			
				
			//set all the generic stuff
			
			
			output.border = false;
			output.wordWrap = false;
			
			output.text = text;
			
			this.addChild(output);
			
		
		}
		
	}
	
	

}