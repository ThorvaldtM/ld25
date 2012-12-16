package com.prac.ld25.data;

/**
 * ...
 * @author Thorvald ter Meer
 */

class CombineData
{
	public var id1:String;
	public var id2:String;
	public var desc:String;
	public var special:String;
	public var dialog:DialogData;
	public var target:String = "character";

	public function new(id1:String = null, id2:String = null, desc:String = null, special:String = null)
	{
		this.id1 = id1;
		this.id2 = id2;
		this.desc = desc;
		this.special = special;
	}
	
}
