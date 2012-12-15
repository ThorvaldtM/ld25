package com.prac.ld25.data;

/**
 * ...
 * @author Thorvald ter Meer
 */

class SceneData
{
	public var id:String;
	public var bg:String;
	public var items:Array<ItemData>;
	public var collision:String;

	public function new()
	{
		items = new Array<ItemData>();
	}
	
}
