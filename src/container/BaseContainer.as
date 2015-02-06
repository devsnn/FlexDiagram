package container
{
	import anim.DiagramObject;
	import anim.DiagramShape;
	import anim.JointLineBoxManager;
	import anim.JointLineStatus;
	
	import control.StatusMode;
	import control.LineControl;
	
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.managers.DragManager;

	public class BaseContainer extends Canvas
	{
		
		private var lineControl:LineControl;
		
		public function BaseContainer()
		{
			super();
			
			this.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
			this.addEventListener(DragEvent.DRAG_DROP, dragDropHandler);
			this.addEventListener(MouseEvent.CLICK, mouseClickHandler);
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, create);
		}
		
		
		
		private function create(e:FlexEvent):void
		{
			this.setStyle("backgroundColor", "#ffffff");
		}
		
		public function setLineControl(value:LineControl):void
		{
			lineControl = value;
		}
		
		
		public function setChangeIndex(value:DiagramObject):void
		{
			this.setChildIndex(value, this.getChildren().length-1);
		}
		
		private function dragEnterHandler(e:DragEvent):void
        {
            if (e.dragSource.hasFormat("shape"))
            {
                DragManager.acceptDragDrop(e.currentTarget as BaseContainer);
            }
        }
        
        
        private function dragDropHandler(e:DragEvent):void
        {
        	var wid2:int = e.dragInitiator.width/2;
            var hei2:int = e.dragInitiator.height/2
            
            var shapeName:String = (e.dragInitiator as DiagramShape).shapeName;
            
        	var obj:DiagramObject = new DiagramObject(shapeName);
        	
        	
        	obj.width = 100;
        	obj.height = 100;
        	obj.x = (e.currentTarget as BaseContainer).mouseX-wid2;
        	obj.y = (e.currentTarget as BaseContainer).mouseY-hei2;
        	obj.lineControl = lineControl;
        	lineControl.addItems(obj);
        	this.addChild(obj);
        	
        }
        
        private var jointLineStatus:JointLineStatus;
        
        private function mouseClickHandler(e:MouseEvent):void
        {
        	if(StatusMode.isJointLine)
        	{
        		if(JointLineBoxManager.getInstance().toBox)
        		{
        			trace("toBox가 잇음");
        			lineControl.templateLine.graphics.clear();
        			
        			lineControl.setCurrentToBox(JointLineBoxManager.getInstance().toBox);
                    lineControl.addLine();
                    
        			JointLineBoxManager.getInstance().destory();
        			jointLineStatus = null;
        			return;
        		}
        		if(jointLineStatus == null)
        		{
    				if(JointLineBoxManager.getInstance().fromBox == null)
    				{
    					return;
    				}
    				trace("첫 출발!");
    				jointLineStatus = new JointLineStatus();
    				jointLineStatus.fromBox = JointLineBoxManager.getInstance().fromBox;
    				jointLineStatus.toBox = JointLineBoxManager.getInstance().toBox;
    				
    				// line 에 관절라인 속성객체를 넣어줌..
                    lineControl.jointLineStatus = jointLineStatus;
                    
                    lineControl.prepareDrawing(); 
                    lineControl.setCurrentFromBox(JointLineBoxManager.getInstance().fromBox);
    				
    				jointLineStatus.isStart = true;
    				
    				
        			
        		}
        		else if(jointLineStatus != null && jointLineStatus.isStart == true)
        		{
        			trace("fromBox가 잇음! 관절 추가!");
        			trace("x:", e.stageX, " y:", e.stageY);
        			jointLineStatus.jointArrX.push(e.stageX);
        			jointLineStatus.jointArrY.push(e.stageY);
        			
        		}
        		
        	}
        }
		
	}
}