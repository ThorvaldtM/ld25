package com.prac.ld25.system;
import nme.events.Event;

/**
 * ...
 * @author Thorvald ter Meer
 */

class DataEvent extends Event
{
	public var data:Dynamic;

	public function new(type : String, bubbles : Bool = false, cancelable : Bool = false, data : Dynamic = null)
	{
		super(type, bubbles, cancelable);
		this.data = data;
	}
	
}
