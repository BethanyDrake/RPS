package 
{
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class Tally extends Sprite 
	{
		public const WIN:int = 1;
		public const LOSE:int = 2;
		public const DRAW:int = 3;
		public const STREAK:int = 4;
		public var x1:int = 0;
		public var y1:int = 28;
		public var gap:int = 2;
		
		public var colour:int;
		
		public function Tally(type:int) 
		{
			super();
			
			
			//var colour:Array = [50, 50, 100];
			
			var text:MyText = new MyText(type);
			this.addChild(text);
			
			if (type == WIN)
			{
				colour = 0x00CC00;
			}
			if (type == LOSE)
			{
				colour = 0xFF0000;
			}
			if (type == DRAW)
			{
				colour = 0xCC66FF;
			}
			
			
			if (type == STREAK)
			{
				colour = 0x66e0ff;
				gap = 4;
				x1 = 2;
			}
			
			
			
		}
		
		public function addDot():void
		{
			var circle:Circle = new Circle(colour, 10);
			circle.x = x1;
			circle.y = y1;
			this.addChild(circle);
			
			x1 += circle.width + gap;
			if (x1 >= (circle.width + gap) * 5)
			{
				x1 = 0;
				y1 += circle.height + gap*2;
			}
		}
		
		
		
		
		
	}

}