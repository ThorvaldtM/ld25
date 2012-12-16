package com.prac.ld25.data;

/**
 * ...
 * @author Thorvald ter Meer
 */

class DataOption
{
	public var random:Bool;
	public var label:String;
	public var answer:String;
	public var followup:DialogData;

	public function new(anwser:String = null, label:String = null)
	{
		this.answer = anwser;
		this.label = label;
		random = false;
	}
	
}
