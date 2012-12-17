package com.prac.ld25.system;

/**
 * ...
 * @author Thorvald ter Meer
 */

class SpecialText
{
	public var target_id:String;
	public var text_x:Int;
	public var text_y:Int;
	public var time:Int;
	public var desc:String;
	public var special:String;

	public function new(desc:String, target_id:String = 'character', text_x:Int = 0, text_y:Int = 0, timer:Int = 3000, special:String = null )
	{
		this.target_id = target_id;
		this.desc = desc;
		this.text_x = text_x;
		this.text_y = text_y;
		this.special = special;
		this.time = timer;
	}
	
}
