package control
{
	import anim.DiagramObject;
	import anim.JointLineStatus;
	import anim.Line;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	
	
	public class LineControl
	{
		
		public var templateLine:Line;
		private var currentFromBox:DiagramObject;
        private var currentToBox:DiagramObject;
        private var container:Canvas;
        private var isDrawing:Boolean = false;
        private var lines:ArrayCollection = new ArrayCollection();
        private var items:ArrayCollection = new ArrayCollection();
        
        private var templateLineXArr:Array = [];
        private var templateLineYArr:Array = [];
        
        private var _jointLineStatus:JointLineStatus;
		
		public function LineControl()
		{
			templateLine = new Line();
		    templateLine.name="templateLine";
		    templateLine.visible = false;
		}
		
		public function setCurrentFromBox(value:DiagramObject):void{
	        this.currentFromBox = value;      
	    }
	    
	    public function setCurrentToBox(value:DiagramObject):void{
	        this.currentToBox = value;  
	    }
	    
	    public function setContainer(value:Canvas):void{
	        this.container = value;
	        container.addChildAt(templateLine, 0);      
	        container.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
	        container.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
	        container.addEventListener(MouseEvent.CLICK, mouseClick);
	    }
		
		private function getId(type:String):String{
	        var idString:String  = type + Math.round(Math.random()*10000).toString();
	        return idString;
	    }
	    
	    public function getLineList():ArrayCollection{
	        return lines;
	    }
	    
	    public function getItemList():ArrayCollection{
	        return items;
	    }
	    
	    
	    public function addItems(item:DiagramObject):void
	    {
	    	items.addItem(item);
	    }
	    
	    
	    public function set jointLineStatus(value:JointLineStatus):void
	    {
	    	_jointLineStatus = value;
	    }
	    
	    public function get jointLineStatus():JointLineStatus
	    {
	    	return _jointLineStatus;
	    }
	    
	    
	    
		
		public function prepareDrawing():void{    
	        if(StatusMode.isLine){
	            templateLine.graphics.clear();
	            templateLine.setX1(container.mouseX);
	            templateLine.setY1(container.mouseY);
	            templateLine.visible = true;
	            isDrawing = true;      
	        }  
	        else if(StatusMode.isJointLine)
	        {
	        	//trace("prepareDrawing", container.mouseX, container.mouseY);
	        	templateLine.graphics.clear();
	        	templateLine.setX1(container.mouseX);
                templateLine.setY1(container.mouseY);
	        	templateLine.visible = true;
	        	templateLine.lineStyle = 1;
	        	
	        	// 템플릿 선 그릴때 속성 넣어주기
	        	templateLine.jointLineStatus = jointLineStatus;
                isDrawing = true;    
	        }
	    }
	    
	    
	    private function mouseClick(e:MouseEvent):void
	    {
	    	templateLineXArr.push(container.mouseX);
	    	templateLineYArr.push(container.mouseY);
	    	
	    	templateLine.setX1(templateLineXArr[templateLineXArr.length-1]);
            templateLine.setY1(templateLineYArr[templateLineYArr.length-1]);
            
            
	    }
	    
	    
	    public function mouseMove(event:MouseEvent):void{
	        if(isDrawing){
	            drawLine();  
	        }
	    }
	    
	    public function drawLine():void{   
		    if (isDrawing){
		        templateLine.setX2(container.mouseX);
		        templateLine.setY2(container.mouseY);
		        
		        templateLine.draw();
		    }
	    }
	    
	    
	    public function mouseUp(e:MouseEvent):void{
	    	if(StatusMode.isLine)
	    	{
	    		try {
	    			if(e.currentTarget != null)
	    			{
	    				addLine();
	    			}
	    			
	    		} catch(e:Error)
	    		{
	    			cancelDrawing();
	    		}
	    	}
	    }
	    
	    
	    public function addLine():void{ 
	    	if(isDrawing)
	    	{
	    		if(currentToBox == null)
	    		{
	    			cancelDrawing();
	    			return;
	    		}
	    		if(currentFromBox && currentToBox)
	    		{
	    			trace("선 추가");
	    		}
	    		var newLine:Line = new Line();
	    		newLine.setId(getId("Line"));
	    		newLine.setFromBox(currentFromBox);
	    		newLine.setToBox(currentToBox);
	    		
	    		// 관절라인이면 스타일 변경
	    		if(StatusMode.isJointLine)
	    		{
	    			newLine.lineStyle = 1;
	    			newLine.jointLineStatus = jointLineStatus;
	    		}
	    		
	    		newLine.draw();
	    		
	    		currentFromBox.addFromLine(newLine);
	    		currentToBox.addToLine(newLine);
	    		
	    		lines.addItem(newLine);
	    		
	    		// 선을 안보이게 젤 뒤루..
	    		//container.addChild(newLine);
	    		container.addChildAt(newLine, 0);
	    		
	    		templateLine.visible = false;
	    		isDrawing = false;
	    	}
	    	else
	    	{
	    		cancelDrawing();
	    	}
	    }
	    
	    
	    public function cancelDrawing():void{
	    	trace("선 그리기 취소");
	    	templateLine.visible = false;
	    	isDrawing = false;
	    }      

	}
}