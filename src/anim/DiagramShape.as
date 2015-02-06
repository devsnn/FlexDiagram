package anim
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	public class DiagramShape extends UIComponent
	{
		
		private var loader:Loader;
		private var _shapeName:String;
		
		public function DiagramShape()
		{
			super();
			loader = new Loader();
			this.addEventListener(FlexEvent.INITIALIZE, init);
		}
		
		
		private function init(e:FlexEvent):void
        {
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeLoader);
            
        }
        
        public function get shapeName():String
        {
        	if(_shapeName == null)
        	{
        		return "rect";
        	}
        	return _shapeName;
        }
        
        
        public function set shapeName(value:String):void
        {
        	_shapeName = value;
        	
        	if(value == "circle")
            {
                loader.load(new URLRequest("assets/shape/Circle.swf"));
            }
            else if(value == "diamond")
            {
                loader.load(new URLRequest("assets/shape/Diamond.swf"));
            }
            else {
                loader.load(new URLRequest("assets/shape/Rect.swf"));
            }
            
            this.addChild(loader);
        }
        
        
        private function completeLoader(e:Event):void
        {
            // 기본 크기 
            
            loader.content.width = 20;
            loader.content.height = 20;
        }
		
	}
}