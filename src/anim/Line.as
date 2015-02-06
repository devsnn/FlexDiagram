package anim
{
    
    import flash.events.MouseEvent;
    
    import mx.core.UIComponent;
  
    public class Line extends UIComponent
    {
	    private var thicknessNumber:uint = 2;
	    private var alphaNumber:uint = 1;
	    private var arrowWidth:int = 4;
	    private var arrowHeight:int = 8;
	 // x1,y1,x2,y2 this points are coordinate of line first point x,y and second 
	 // poind x,y  positions on the screen
	    private var x1:int;
	    private var y1:int;
	    private var x2:int;
	    private var y2:int;
	    private var color:uint = 0x9f9f9f;
	//  this box referance for find line distance
	    private var fromBox:DiagramObject;
	    private var toBox:DiagramObject;
	//  this boolean variable understand selection on,off    
	    private var isSelect:Boolean=false;
	    private var _lineStyle:int = 0; // 0: 90도 직선, 그외:직선
	    private var _jointLineStatus:JointLineStatus;
	    
	    
	    public function Line(){
	      super();
	      this.addEventListener(MouseEvent.CLICK, mouseClick);
	      this.addEventListener(MouseEvent.ROLL_OVER, rollOver);
	      this.addEventListener(MouseEvent.ROLL_OUT, rollOut);
	      this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
	      this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
	    }
	    
	    public function setFromBox(value:DiagramObject):void{
	      this.fromBox = value;
	    }
	    
	    public function setToBox(value:DiagramObject):void{
	      this.toBox = value;
	    }
	    
	  	public function getX1():int{
	  	  return this.x1;
	  	}
	  	
	  	public function setX1(value:int):void{
	  	  this.x1 = value;
	  	}
	  	
	  	public function getY1():int{
	  	  return this.y1;
	  	}
	  	
	  	public function setY1(value:int):void{
	  	  this.y1 = value;
	  	}
	  	
	  	public function getX2():int{
	  	  return this.x2;
	  	}
	  	
	  	public function setX2(value:int):void{		
	  	  this.x2 = value;
	  	}
	  	
	  	public function getY2():int{
	  	  return this.y2;
	  	}
	  	
	  	public function setY2(value:int):void{
	  	  this.y2 = value;
	  	}
	  	
	  	public function setId(value:String):void{
	  	  this.id = value;
	  	}
	  	
	  	public function getId():String{
	  	  return this.id;
	  	}
	  	
	    public function clear():void{
	      graphics.clear();
	    }
	    
	    public function get lineStyle():int
	    {
	    	return _lineStyle;
	    }
	    
	    public function set lineStyle(value:int):void
	    {
	    	_lineStyle = value;
	    }
	    
	    
	    public function set jointLineStatus(value:JointLineStatus):void
        {
            _jointLineStatus = value;
        }
        
        public function get jointLineStatus():JointLineStatus
        {
            return _jointLineStatus;
        }
        
	    
	    public function mouseClick(event:MouseEvent):void{
	     // select();
	    }
	    
	    
	    private function rollOver(e:MouseEvent):void
	    {
	    	this.color = 0x5CB3FF;
            this.isSelect = true;
            draw();
	    }
	    
	    
	    private function rollOut(e:MouseEvent):void
	    {
	    	this.color = 0x9f9f9f;
            this.isSelect = false;
            draw();
	    }
	    
	    private var isMove:Boolean = false;
	    
	    private function mouseDown(e:MouseEvent):void
	    {
	    	isMove = true;
	    }
	    
	    
	    private function mouseMove(e:MouseEvent):void
	    {
	    	if(fromBox && toBox)
	    	{
	    	}
	    }
	    
	    
	    

	    // 선 그림.. (템플릿 라인과 함께 사용합니다..)
	    public function draw():void{
	      if(name != "templateLine"){
	        calculateCoordinate();
	      }
	      
	  	  graphics.clear();
	  	  
	  	  
	  	  if(lineStyle == 0)
	  	  {
	  	  	  // 90도 선 
	  	  	  if(fromBox)
	  	  	  {
	  	  	  	  if(getDrawDirection() == null)
	  	  	  	  {
	  	  	  	  	return;
	  	  	  	  }
	  	  	  	  
	  	  	  	  // x 축을 기준으로 그림..
			  	  graphics.lineStyle(thicknessNumber,color,alphaNumber);
			  	  
			  	  graphics.moveTo(fromBox.x+(fromBox.width/2), fromBox.y+(fromBox.height/2));
			  	  
			  	  var line_center_width:Number = 0;
			  	  if(getDrawDirection() == "LEFT")
			  	  {
			  	  	line_center_width = toBox.x - (fromBox.x+fromBox.width);
			  	  	line_center_width = line_center_width/2;
			  	  	
			  	  	graphics.lineTo(fromBox.x+fromBox.width+line_center_width, fromBox.y+(fromBox.height/2));
			  	  	graphics.lineTo(fromBox.x+fromBox.width+line_center_width, toBox.y+(toBox.height/2));
			  	  	graphics.lineTo(toBox.x, toBox.y+(toBox.height/2));
			  	  }
			  	  else if(getDrawDirection() == "RIGHT")
			  	  {
			  	  	line_center_width = fromBox.x - (toBox.x+toBox.width);
			  	  	line_center_width = line_center_width/2;
			  	  	
			  	  	graphics.lineTo(fromBox.x-line_center_width, fromBox.y+(fromBox.height/2));
			  	  	graphics.lineTo(fromBox.x-line_center_width, toBox.y+(toBox.height/2));
			  	  	graphics.lineTo(toBox.x+toBox.width, toBox.y+(toBox.height/2));
			  	  }
			  	  else
			  	  {
				  	  graphics.lineTo(toBox.x+(toBox.width/2), fromBox.y+(fromBox.height/2));
				  	  graphics.lineTo(toBox.x+(toBox.width/2), toBox.y+(toBox.height/2));
			  	  }
	  	  	  }
	  	  	  else
	  	  	  {
	  	  	      graphics.lineStyle(thicknessNumber,color,alphaNumber);
                  graphics.moveTo(getX1(),getY1());
                  graphics.lineTo(getX2(),getY2());
	  	  	  }
		  	  
	  	  }
	  	  else if(lineStyle == 1)
	  	  {
	  	      // 관절라인
	  	      /* trace("from:", fromBox);
	  	      trace("to:", toBox);
	  	      trace("join:", jointLineStatus);
	  	      trace("frommm:", jointLineStatus.fromBox); */
	  	      
	  	      
	  	      if(fromBox == toBox && jointLineStatus.fromBox == null)
	  	      {
	  	      	return;
	  	      }
	  	      
	  	      var fromBoxObj:DiagramObject = fromBox;
	  	      if(fromBoxObj == null)
	  	      {
	  	      	fromBoxObj = jointLineStatus.fromBox;
	  	      }
	  	      
	  	      if(jointLineStatus == null)
	  	      {
	  	      	//trace("jointLineStatus  null return");
	  	        return;
	  	      }
	  	      
	  	      graphics.lineStyle(thicknessNumber,color,alphaNumber);
	  	      graphics.moveTo(fromBoxObj.x+(fromBoxObj.width/2), fromBoxObj.y+(fromBoxObj.height/2));
	  	      
	  	      //trace("jointLen:", jointLineStatus.jointArrX.length);
	  	      for(var i:int=0; i<jointLineStatus.jointArrX.length; i++)
	  	      {
		  	      //trace("draw", jointLineStatus.jointArrX[i], jointLineStatus.jointArrY[i]);
		  	      graphics.lineTo(jointLineStatus.jointArrX[i], jointLineStatus.jointArrY[i]);
	  	      }
	  	      
	  	      if(toBox)
	  	      {
		  	      graphics.lineTo(toBox.x+(toBox.width/2), toBox.y+(toBox.height/2));
	  	      }
	  	      
	  	      if(name == "templateLine")
	  	      {
	  	      	  graphics.lineStyle(thicknessNumber,color,alphaNumber);
                  graphics.moveTo(getX1(),getY1());
                  graphics.lineTo(getX2(),getY2());
	  	      }
	  	      
	  	  }
	  	  else
	  	  {
		  	  // 투명선.. 쉬운선택을 위하여..
		  	  graphics.lineStyle(8,color,0.0);
		  	  graphics.moveTo(getX1(),getY1());
		  	  graphics.lineTo(getX2(),getY2());
		  	  
		  	  // 보이는 선..
		  	  graphics.lineStyle(thicknessNumber,color,alphaNumber);
		  	  graphics.moveTo(getX1(),getY1());
		  	  graphics.lineTo(getX2(),getY2());
	  	  }
	  	  
	  	  createArrow();
	    }
	    
	    
	 	// 화살표 그리기 
	  	public function createArrow():void{
	  		var a_x:Number; // 화살표 왼쪽 x
            var a_y:Number; // 화살표 왼쪽 y
            
            var b_x:Number; // 화살표 우측 x
            var b_y:Number; // 화살표 우측 y
            
	  		if(lineStyle == 0)
	  		{
                if(toBox)
                {
                	/* trace("direction:", getDrawDirection());
                	trace("x1:", getX1(), "x2:", getX2());
                	trace("y1:", getY1(), "y2:", getY2());
                	trace("from:", fromBox.x, fromBox.y);
                	trace("to:", toBox.x, toBox.y); */
                    
                    // 값 보정
                    y1 = fromBox.y + (fromBox.height/2); // from 에서 출발하는 y좌표 
                	
                	
                	// from 의 위치를 기준으로 합니다...
                	if(getDrawDirection() == "LEFT_TOP" || getDrawDirection() == "RIGHT_TOP")
                	{
	                	// 값 보정 
	                	x2 = toBox.x + (toBox.width/2); // to에서 받는 x좌표
	                	y2 = toBox.y; // to에서 받는 y좌표 
	                	
	                	a_x = getX2() - arrowWidth;
	                	a_y = getY2() - arrowHeight;
	                	b_x = getX2() + arrowWidth;
	                	b_y = getY2() - arrowHeight;
                	}
                	else if(getDrawDirection() == "LEFT_BOTTOM" || getDrawDirection() == "RIGHT_BOTTOM")
                	{
                		x2 = toBox.x + (toBox.width/2);
                		y2 = toBox.y + toBox.height;
                		
                		a_x = getX2() - arrowWidth;
                		a_y = getY2() + arrowHeight;
                		b_x = getX2() + arrowWidth;
                		b_y = getY2() + arrowHeight;
                	}
                	else if(getDrawDirection() == "LEFT")
                	{
                		x2 = toBox.x;
                		y2 = toBox.y+(toBox.height/2);
                		
                		a_x = getX2() - arrowHeight;
                		a_y = getY2() - arrowWidth;
                		b_x = getX2() - arrowHeight;
                		b_y = getY2() + arrowWidth;
                	}
                	else if(getDrawDirection() == "RIGHT")
                	{
                		x2 = toBox.x + toBox.width;
                		y2 = toBox.y+(toBox.height/2);
                		
                		a_x = getX2() + arrowHeight;
                		a_y = getY2() - arrowWidth;
                		b_x = getX2() + arrowHeight;
                		b_y = getY2() + arrowWidth;
                	}
                	else if(getDrawDirection() == "BOTTOM")
                	{
                		x2 = toBox.x + (toBox.width/2);
                		y2 = toBox.y + toBox.height;
                		
                		a_x  = getX2() - arrowWidth;
                		a_y = getY2() + arrowHeight;
                		b_x = getX2() + arrowWidth;
                		b_y = getY2() + arrowHeight;
                	}
                	else if(getDrawDirection() == "TOP")
                	{
                		x2 = toBox.x + (toBox.width/2);
                		y2 = toBox.y;
                		
                		a_x = getX2() - arrowWidth;
                		a_y = getY2() - arrowHeight;
                		b_x = getX2() + arrowWidth;
                		b_y = getY2() - arrowHeight;
                	}
                	graphics.moveTo(a_x, a_y);
                    graphics.lineTo(getX2(), getY2());
                    graphics.lineTo(b_x, b_y);
                }
	  		}
	  		else if(lineStyle == 1)
	  		{
	  			
	  			var lastPointX:Number = jointLineStatus.jointArrX[jointLineStatus.jointArrX.length-1];
	  			var lastPointY:Number = jointLineStatus.jointArrY[jointLineStatus.jointArrY.length-1];
	  			
	  			var angle:Number = Math.atan2(getY2()-lastPointY, getX2()-lastPointX);
	  			
	  			trace("dic:", getJointLineLastPointDrawDirection());
	  			
	  			
	  		}
	  		else
	  		{
	  	        var angle:Number = Math.atan2(getY2()-getY1(), getX2()-getX1());
	  	        graphics.lineTo(getX2()-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
	  									getY2()-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
	  	        graphics.lineTo(getX2(), getY2());
	  	        graphics.lineTo(getX2()-arrowHeight*Math.cos(angle)+arrowWidth*Math.sin(angle),	
	  									getY2()-arrowHeight*Math.sin(angle)-arrowWidth*Math.cos(angle));										
	  		}
	  	}
	  	
	  	
	  	public function getDrawDirection():String{
	  		
	  	  var drawDirection :String;
	  	  
	  	  var boxFromX2:int;
          var boxFromY2:int;
          var boxToX2:int;
          var boxToY2:int;
          
	  	  if(lineStyle == 0)
	  	  {
	  	      boxFromX2 = fromBox.x+(fromBox.width/2);
              boxFromY2 = fromBox.y+(fromBox.height/2);
              boxToX2 = toBox.x+(toBox.width/2);
              boxToY2 = toBox.y+(toBox.height/2);
	  	  }
	  	  else
	  	  {
	  	  	  boxFromX2 = fromBox.x+fromBox.width;
              boxFromY2 = fromBox.y+fromBox.height;
              boxToX2 = toBox.x+toBox.width;
              boxToY2 = toBox.y+toBox.height;
	  	  }
	  	  
	  		
	  	  if (fromBox.x>boxToX2 && boxFromY2<toBox.y){
	  		  drawDirection = "RIGHT_TOP";
	  	  }
	  	  else if (fromBox.x>boxToX2 && fromBox.y>boxToY2){
	  	    drawDirection  = "RIGHT_BOTTOM";
	  	  }
	  	  else if (boxFromX2<toBox.x && fromBox.y>boxToY2){
	  	    drawDirection  = "LEFT_BOTTOM";
	  	  }
	  	  else if (boxFromX2<toBox.x && boxFromY2<toBox.y){
	  	    drawDirection  = "LEFT_TOP";
	  	  }
	  	  else if (fromBox.x>boxToX2){
	  	    drawDirection  = "RIGHT";
	  	  }
	  	  else if (boxFromY2<toBox.y){
	  	    drawDirection  = "TOP";
	  	  }
	  	  else if (fromBox.y>boxToY2){
	  	    drawDirection  = "BOTTOM";
	  	  }
	  	  else if (boxFromX2<toBox.x){
	  	    drawDirection  = "LEFT";
	  	  }
	  	  return drawDirection;
	  	}
	  	
	  	
	  	
	  	public function getJointLineLastPointDrawDirection():String{
            
          var drawDirection :String;
          
          var boxFromX2:int; // 마지막 포인트 x
          var boxFromY2:int; // 마지막 포인트 y
          var boxToX2:int; // 대상 객체 x
          var boxToY2:int; // 대상 객체 y
          
          if(lineStyle == 1)
          {
              boxFromX2 = jointLineStatus.jointArrX[jointLineStatus.jointArrX.length-1];
              boxFromY2 = jointLineStatus.jointArrY[jointLineStatus.jointArrY.length-1];
              boxToX2 = toBox.x+(toBox.width/2);
              boxToY2 = toBox.y+(toBox.height/2);
          }
          else
          {
              boxFromX2 = fromBox.x+fromBox.width;
              boxFromY2 = fromBox.y+fromBox.height;
              boxToX2 = toBox.x+toBox.width;
              boxToY2 = toBox.y+toBox.height;
          }
          
            
          if (fromBox.x>boxToX2 && boxFromY2<toBox.y){
              drawDirection = "RIGHT_TOP";
          }
          else if (fromBox.x>boxToX2 && fromBox.y>boxToY2){
            drawDirection  = "RIGHT_BOTTOM";
          }
          else if (boxFromX2<toBox.x && fromBox.y>boxToY2){
            drawDirection  = "LEFT_BOTTOM";
          }
          else if (boxFromX2<toBox.x && boxFromY2<toBox.y){
            drawDirection  = "LEFT_TOP";
          }
          else if (fromBox.x>boxToX2){
            drawDirection  = "RIGHT";
          }
          else if (boxFromY2<toBox.y){
            drawDirection  = "TOP";
          }
          else if (fromBox.y>boxToY2){
            drawDirection  = "BOTTOM";
          }
          else if (boxFromX2<toBox.x){
            drawDirection  = "LEFT";
          }
          return drawDirection;
        }
	  	
	  	
	  	
	  	
	  	//this methos calculate coordinate for draw line. it use two side of box distance
	  	private function calculateCoordinate():void{
	  	  var drawDirection:String = getDrawDirection();
	  	  var boxFromX2:int = fromBox.x+fromBox.width;
	  	  var boxFromY2:int = fromBox.y+fromBox.height;
	  	  var boxToX2:int = toBox.x+toBox.width;
	  	  var boxToY2:int = toBox.y+toBox.height;
	  	  var diffY:int = 0;
	  	  var diffX:int = 0;
	  	  
	  	  if (drawDirection =="BOTTOM" || drawDirection =="TOP")
	  	  {
	    		if (fromBox.x<=toBox.x && boxFromX2>=boxToX2){					
	    		  diffX =(toBox.width)/2;
	    		  diffX = toBox.x + diffX;				
	    		}
	    		else if (fromBox.x>toBox.x && boxFromX2>boxToX2){					
	    		  diffX =(boxToX2 - fromBox.x)/2;
	    		  diffX = fromBox.x + diffX;				
	    	  }
	    	  else if (fromBox.x<toBox.x && boxFromX2<boxToX2){					
	    		  diffX =(boxFromX2 - toBox.x)/2;
	    		  diffX = toBox.x + diffX;				
	    		}
	    		else if (fromBox.x>toBox.x && boxFromX2<boxToX2){					
	    		  diffX =(fromBox.width)/2;
	    		  diffX = fromBox.x + diffX;
	    		}
	    	  if (diffX == 0){
	    		  diffX = fromBox.x + (fromBox.width/2);
	    		}
	  	  }
	  	
	  	  if (drawDirection =="RIGHT" || drawDirection =="LEFT" ){				
	    		if (fromBox.y<=toBox.y && boxFromY2>=boxToY2){				
	    		  diffY =(boxToY2 - toBox.y)/2;					
	    		  diffY = toBox.y + diffY;						
	    		}
	    		else if (fromBox.y>toBox.y && boxFromY2>boxToY2){					
	    		  diffY =(boxToY2 - fromBox.y)/2;
	    		  diffY = fromBox.y + diffY;
	    		}
	    		else if (fromBox.y<toBox.y && boxFromY2<boxToY2){					
	    	      diffY =(boxFromY2 - toBox.y)/2;
	    		  diffY = toBox.y + diffY;								
	    		}
	    		else if (fromBox.y>toBox.y && boxFromY2<boxToY2){					
	    		  diffY =(fromBox.height)/2;
	    		  diffY = fromBox.y + diffY;															
	    		}				
	  	  }
	  	
	  	  switch (drawDirection ){
	  	    case "RIGHT_BOTTOM":
	  		  this.x1 = fromBox.x+diffX;
	  		  this.y1 = fromBox.y;
	  		  this.x2 = boxToX2;
	  		  this.y2 = boxToY2-diffY;				
	  		break;
	  		case "RIGHT_TOP":
	  		  this.x1 = fromBox.x;
	  		  this.y1 = boxFromY2-diffY;
	  		  this.x2 = boxToX2-diffX;
	  		  this.y2 = toBox.y;				
	  		break;
	  		case "LEFT_BOTTOM":
	  		  this.x1 = boxFromX2-diffX;
	  		  this.y1 = fromBox.y ;
	  		  this.x2 = toBox.x;
	  		  this.y2 = boxToY2-diffY;				
	  		break;					
	  		case "LEFT_TOP":
	  		  this.x1 = boxFromX2;
	  		  this.y1 = boxFromY2-diffY;
	  		  this.x2 = toBox.x+diffX;
	  		  this.y2 = toBox.y;				
	  		break;					
	  		case "RIGHT":
	  		  this.x1 = fromBox.x;
	  		  this.y1 = diffY;
	  		  this.x2 = boxToX2;
	  		  this.y2 = diffY;			
	  		break;
	  		case "TOP":
	  		  this.x1 = diffX;
	  		  this.y1 = boxFromY2;
	  		  this.x2 = diffX;
	  		  this.y2 = toBox.y;				
	  		break;
	  		case "BOTTOM":
	  		  this.x1= diffX;
	  		  this.y1= fromBox.y;
	  		  this.x2= diffX;
	  		  this.y2= boxToY2;				
	  		break;
	  		case "LEFT":
	  		  this.x1= boxFromX2;
	  		  this.y1= diffY;
	  		  this.x2= toBox.x;
	  		  this.y2= diffY;	
	  		break;
	  	  }
	  	}
	  }
}