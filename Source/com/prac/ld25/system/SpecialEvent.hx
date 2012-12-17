package com.prac.ld25.system;
import com.prac.ld25.data.ItemData;
import nme.display.Sprite;

/**
 * ...
 * @author Thorvald ter Meer
 */

class SpecialEvent extends Sprite
{
	private var m_script:Array<SpecialText>;
	private var m_chars:Array<ItemData>;

	public function new(script:Array<SpecialText>,chars:Array<ItemData>)
	{
		m_script = script;
		m_chars = chars;
	}
	
	public function start():Void {
		execute(m_script.shift());
	}
	
}
