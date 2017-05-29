package 
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Graphics;
	import String;
	
	/**
	 * ...
	 * @author 
	 */
	public class Circle extends Sprite 
	{
		
		public function Circle(colour:int, size:int = 100) 
		{
			super();
			
			var roundObject:Shape = new Shape();
					
			roundObject.graphics.beginFill(colour); 
			roundObject.graphics.moveTo(size / 2, 0); 
			roundObject.graphics.curveTo(size, 0, size, size / 2); 
			roundObject.graphics.curveTo(size, size, size / 2, size); 
			roundObject.graphics.curveTo(0, size, 0, size / 2); 
			roundObject.graphics.curveTo(0, 0, 0 + size / 2, 0); 
 
			this.addChild(roundObject);
			
			
		}
		
		
	}

}