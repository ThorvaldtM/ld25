package com.prac.ld25.system;
import com.prac.ld25.data.DataOption;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Dialog
{
	public var text:String;
	public var target:SceneObject;
	public var fade:Int;
	public var options:Array<DataOption>;
	public var special:Dynamic;
	public var sound:String;

	public function new(text:String = null, target:SceneObject = null, fade:Int = 5000, options:Array<DataOption> = null, special:Dynamic = null, sound:String = null)
	{
		this.text = text;
		this.target = target;
		this.fade = fade;
		this.options = options;
		this.special = special;
		this.sound = sound;
	}
	
}
