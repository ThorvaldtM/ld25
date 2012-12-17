package com.prac.ld25.interfaces;
import com.prac.ld25.data.ItemData;
import com.prac.ld25.tools.AssetLoader;
import nme.display.Sprite;

/**
 * ...
 * @author Thorvald ter Meer
 */

class InventoryItem extends Sprite
{
	public var data:ItemData;

	public function new(data:ItemData)
	{
		super();
		this.data = data;
		var _bg:Sprite = AssetLoader.loadAsset('LIB/item_' + data.graph, 76, 76);
		addChild(_bg);
	}
	
}
