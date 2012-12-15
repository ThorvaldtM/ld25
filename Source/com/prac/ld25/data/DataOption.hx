package com.prac.ld25.data;

/**
 * ...
 * @author Thorvald ter Meer
 */

class DataOption
{
	public var random:Bool;
	public var answer:String;
	public var followup:DialogData;

	public function new(anwser:String = null)
	{
		this.answer = anwser;
		random = false;
	}
	
}
