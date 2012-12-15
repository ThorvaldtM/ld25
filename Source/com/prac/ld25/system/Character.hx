package com.prac.ld25.system;
import com.prac.ld25.tools.AssetLoader;
import nme.display.Sprite;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Character extends SceneObject
{
	public var speed:Int = 5;

	public function new()
	{
		var _bg:Sprite = AssetLoader.loadAsset('character.png', 100, 100);
		addChild(_bg);
		super(null);
	}
	
}
