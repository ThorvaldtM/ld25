package com.prac.ld25.data;
import nme.geom.Point;

/**
 * ...
 * @author Thorvald ter Meer
 */

class ItemData
{
	public var graph:String;
	public var id:String;
	public var name:String;
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	public var exit:String;
	public var look:BehaviorData;
	public var use:BehaviorData;
	public var pick:BehaviorData;
	public var talk:BehaviorData;
	public var defaultUse:String;
	public var collision:Bool;
	public var shadowColor:Int = 0x000000;
	public var textColor:Int = 0xFFFFFF;
	public var dest:Point;

	public function new()
	{
		width = 50;
		height = 50;
	}
	
}
