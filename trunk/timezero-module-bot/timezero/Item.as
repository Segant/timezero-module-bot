class timezero.Item
{	
	public static function combineAll(box : Array)
	{
		var success : Array = new Array();
		for(var i = 1; i < box.length; i++)
		{
			for(var k = 0; k < i; k++)
			{
				if(!success[k])
				{
					if(_root.CanInsertItemToItem(box[k], box[i]))
					{
						_root.InsertItemToItem(box[k], box[i]);
						success[i] = true;
						break;
					}
				}
			}
		}		
		_root.UpdateBOX();
	}
}