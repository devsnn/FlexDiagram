package anim
{
	import control.StatusMode;
	import control.LineControl;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Button;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	public class DiagramObject extends UIComponent
	{
		
		private var loader:Loader;
		private var shapeName:String;
		private var _lineControl:LineControl;
		private var fromLines:ArrayCollection = new ArrayCollection();
        private var toLines:ArrayCollection = new ArrayCollection();
		
		private var scaleBtn:Button; // 스케일 버튼 
		private var isScale:Boolean = false; // 현재 객체가 스케일모드인지
		
		private var diagramProxy:DiagramProxy;
		
		public function DiagramObject(_shapeName:String="rect")
		{
			super();
			shapeName = _shapeName;
			
			loader = new Loader();
			
			this.addEventListener(FlexEvent.INITIALIZE, init);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, create);
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			this.addEventListener(MouseEvent.CLICK, mouseClickhandler);
			
		}
		
		
		private function init(e:FlexEvent):void
		{
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeLoader);
            
            // 모양..
            if(shapeName == "circle")
            {
	            loader.load(new URLRequest("assets/shape/Circle.swf"));
            }
            else if(shapeName == "diamond")
            {
            	loader.load(new URLRequest("assets/shape/Diamond.swf"));
            }
            else {
	            loader.load(new URLRequest("assets/shape/Rect.swf"));
            }
            
            this.addChild(loader);
		}
		
		
		private function create(e:FlexEvent):void
		{
			
		}
		
		
		public function getShapeName():String
		{
			return shapeName;
		}
		
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			createScaleBtn();
		}
		
		
		// 스케일 조절 버튼 생성 
		private function createScaleBtn():void
		{
			if(scaleBtn == null)
            {
                scaleBtn = new Button();
                scaleBtn.width = 10;
                scaleBtn.height = 10;
                scaleBtn.addEventListener(MouseEvent.MOUSE_DOWN, scaleBtnMouseDownHandler);
                scaleBtn.addEventListener(MouseEvent.MOUSE_UP, scaleBtnMouseUpHandler);
                this.addChild(scaleBtn);
            }
            
            var wid:Number = loader.width;
            var hei:Number = loader.height;
            
            if(wid == 0 && hei == 0)
            {
            	wid = 100;
            	hei = 100;
            }
            
            scaleBtn.x = wid - 5;
            scaleBtn.y = hei - 5;
		}
		
		
		private function scaleBtnMouseDownHandler(e:MouseEvent):void
		{
			StatusMode.onScaleMode();
			isScale = true;
			
			scaleControl(e);

            systemManager.addEventListener(MouseEvent.MOUSE_MOVE, systemMouseMoveHandler, true);
            systemManager.addEventListener(MouseEvent.MOUSE_UP, systemMouseUpHandler, true);
		}
		
		
		private function scaleBtnMouseUpHandler(e:MouseEvent):void
		{
			scaleComplete();
		}
		
		
		
		
		public function get lineControl():LineControl
		{
			return _lineControl;
		}
		
		public function set lineControl(value:LineControl):void
		{
			_lineControl = value;
		}
		
		
		public function addFromLine(fromLine:Line):void
		{
			fromLines.addItem(fromLine);
		}
		
		
		public function addToLine(toLine:Line):void
		{
			toLines.addItem(toLine);
		}
		
		public function getFromLines():ArrayCollection
		{
			return fromLines;
		}
		
		public function getToLines():ArrayCollection
		{
			return toLines;
		}
		
		
		private function completeLoader(e:Event):void
		{
			// 기본 크기 
			
			loader.content.width = 100;
			loader.content.height = 100;
		}
		
		
		
		
		private function mouseMoveHandler(e:MouseEvent):void
		{
			if(StatusMode.isMove)
			{
				if (fromLines.length>0){
	                drawFromLines();  
	            }
	            if (toLines.length>0){
	                drawToLines();  
	            }
			}
			else if(StatusMode.isScale)
			{
				
			}
		}
		
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			if(StatusMode.isLine)
			{
				if(lineControl)
				{
					lineControl.prepareDrawing(); 
	                lineControl.setCurrentFromBox(this);
				}
			}
			else if(StatusMode.isMove)
			{
				this.startDrag();
			}
			Application.application.baseContainer.setChangeIndex(this);
		}
		
		
		private function mouseUpHandler(e:MouseEvent):void
		{
			if(StatusMode.isLine)
			{
				lineControl.setCurrentToBox(this);
                lineControl.addLine();
			}
			else if(StatusMode.isMove)
			{
				this.stopDrag();
			}
			else if(StatusMode.isScale)
			{
				StatusMode.onMoveMode();
			}
		}
		
		
		private function mouseClickhandler(e:MouseEvent):void
		{
			// 관절 라인 추가 
			if(StatusMode.isJointLine)
			{
				if(JointLineBoxManager.getInstance().fromBox == null)
				{
					JointLineBoxManager.getInstance().fromBox = this;
					/* lineControl.prepareDrawing(); 
                    lineControl.setCurrentFromBox(this); */
					
				}
				else if(JointLineBoxManager.getInstance().toBox == null)
				{
					trace("1 set tobox");
					JointLineBoxManager.getInstance().toBox = this;
					/* lineControl.setCurrentToBox(this);
                    lineControl.addLine(); */
				}
                /* if(FromToBox.fromBox == null)
                {
                	FromToBox.fromBox = this;
	                lineControl.prepareDrawing(); 
	                lineControl.setCurrentFromBox(this);
                }
                else if(FromToBox.toBox == null)
                {
                	FromToBox.toBox = this;
                	lineControl.setCurrentToBox(this);
                	lineControl.addLine();
                } */
			}
		}
		
		
		
		public function drawFromLines():void{
			for(var i:int=0; i<fromLines.length; i++)
			{
				Line(fromLines[i]).draw();
			}
	    }
	    
	    
	    public function drawToLines():void{
	    	for(var i:int=0; i<toLines.length; i++)
	    	{
	    		Line(toLines[i]).draw();
	    	}
	    }
		
		
		private var initX:Number;
		private var initY:Number;
		
		private function scaleControl(e:MouseEvent):void
		{
			if(diagramProxy == null && isScale)
			{
				diagramProxy = new DiagramProxy();
				diagramProxy.x = loader.content.x;
				diagramProxy.y = loader.content.y;
				diagramProxy.width = loader.width;
				diagramProxy.height = loader.height;
				this.addChild(diagramProxy);
				
				initX = e.stageX;
                initY = e.stageY;
				
				Application.application.baseContainer.setChangeIndex(this);
			}
			else if(diagramProxy != null && isScale)
			{
				diagramProxy.width = loader.width;
				diagramProxy.height = loader.height;
				diagramProxy.visible = true;
				
				initX = e.stageX;
                initY = e.stageY;
				
			}
			
		}
		
		
		
		private function systemMouseMoveHandler(e:MouseEvent):void
		{
			if(StatusMode.isScale && isScale)
			{
				//e.stopImmediatePropagation();       
				scaleStart(e);
			}
		}
		
		
		private function scaleStart(e:MouseEvent):void
		{
			diagramProxy.width = diagramProxy.width + e.stageX - initX;
            diagramProxy.height = diagramProxy.height + e.stageY - initY; 
            
            if(diagramProxy.width < 30)
            {
                diagramProxy.width = 30;
            }
            if(diagramProxy.height < 30)
            {
                diagramProxy.height = 30;
            }
            
            initX = e.stageX;
            initY = e.stageY;
		}
		
		
		
		private function systemMouseUpHandler(e:MouseEvent):void
		{
			//e.stopImmediatePropagation();    
			if(StatusMode.isScale && isScale)
			{
				scaleComplete();
			}
		}
		
		
		
		private function scaleComplete():void
		{
			isScale = false;
            StatusMode.onMoveMode();
            
            diagramProxy.visible = false;
            
            
            loader.width = Math.floor(diagramProxy.width);
            loader.height = Math.floor(diagramProxy.height);
            this.width = loader.width;
            this.height = loader.height;
            
            // 스케일 버튼 위치 재조정 
            createScaleBtn();
            
            
            systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, systemMouseMoveHandler);
            systemManager.removeEventListener(MouseEvent.MOUSE_UP, systemMouseUpHandler);
		}
		
		
		
	}
}