package com.prac.ld25.data;

/**
 * ...
 * @author Thorvald ter Meer
 */

class BehaviorData
{
	
	public var success:Bool;
	public var desc:String;
	public var target:String; //self/character or an item ID
	public var special:String;
	public var dialog:DialogData;

	public function new(desc:String = null)
	{
		success = false;
		target = "character";
		this.desc = desc;
	}
	
}
