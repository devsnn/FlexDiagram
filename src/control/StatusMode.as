package control
{
	public class StatusMode
	{
		private static var _isLine:Boolean = false; // 라인 그리기 인지 상태 
		private static var _isScale:Boolean = false; // 스케일 모드 
		private static var _isMove:Boolean = true; // 이동모드
		private static var _isJointLine:Boolean = false; // 관절 라인 
		
		
		static public function onLineMode():void
		{
			_isLine = true;
			_isScale = false;
			_isMove = false;
			_isJointLine = false;
		}
		
		static public function get isLine():Boolean
		{
			return _isLine;
		}
		
		
		static public function onScaleMode():void
		{
			_isScale = true;
			_isLine = false;
			_isMove = false;
			_isJointLine = false;
		}
		
		static public function get isScale():Boolean
		{
			return _isScale;
		}
		
		
		static public function onMoveMode():void
		{
            _isMove = true;
			_isScale = false;
            _isLine = false;
            _isJointLine = false;
		}
		
		static public function get isMove():Boolean
		{
			return _isMove;
		}
		
		
		static public function onJointLineMode():void
		{
            _isJointLine = true;
			_isMove = false;
            _isScale = false;
            _isLine = false;
		}
		
		static public function get isJointLine():Boolean
		{
			return _isJointLine;
		}

	}
}