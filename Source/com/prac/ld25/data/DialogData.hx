package com.prac.ld25.data;

/**
 * ...
 * @author Thorvald ter Meer
 */

class DialogData
{
	public var question:String;
	public var special:String;
	public var options:Array<DataOption>;

	public function new(question:String = null)
	{
		this.question = question;
		options = new Array<DataOption>();
	}
	
}
