package anim
{
	import mx.core.UIComponent;

	public class DiagramProxy extends UIComponent
	{
		public function DiagramProxy()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
                
            graphics.clear();                               
            graphics.lineStyle(1, 0xcccccc);
            graphics.beginFill(0xcccccc, 0.4);
            graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
        }
		
	}
}