package anim
{
	public class JointLineBoxManager
	{
		
		private static var _instance:JointLineBoxManager;
		
		public var fromBox:DiagramObject;
		public var toBox:DiagramObject;
		
		public function JointLineBoxManager()
		{
		}
		
		static public function getInstance():JointLineBoxManager
		{
			if(_instance == null)
			{
				_instance = new JointLineBoxManager;
			}
			return _instance;
		}
		
		public function destory():void
		{
			fromBox = null;
			toBox = null;
		}

	}
}