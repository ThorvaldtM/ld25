package com.prac.ld25.interfaces;
import com.prac.ld25.data.ItemData;
import com.prac.ld25.tools.AssetLoader;
import flash.events.Event;
import nme.display.Sprite;
import nme.events.MouseEvent;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Inventory extends Sprite
{
	private var m_prev:Sprite;
	private var m_next:Sprite;
	
	private var m_index:Int = 0;
	private var m_items:Array<InventoryItem>;

	public function new(width:Int)
	{
		super();
		
		m_prev = AssetLoader.loadAsset('btn_inv_prev.png', 20, 60);
		m_prev.mouseEnabled = true;
		m_prev.addEventListener(MouseEvent.CLICK, m_prev_click);
		m_prev.x = 0;
		m_prev.y = 5;
		addChild(m_prev);
		
		m_next = AssetLoader.loadAsset('btn_inv_next.png', 20, 60);
		m_next.mouseEnabled = true;
		m_next.addEventListener(MouseEvent.CLICK, m_next_click);
		m_next.x = width - m_next.width - 5;
		m_next.y = 5;
		addChild(m_next);
		
		m_prev.visible = false;
		m_next.visible = false;
		
		
		m_items = new Array<InventoryItem>();
	}
	
	private function m_next_click(e:Event):Void
	{
		m_index++;
		if (m_index >= m_items.length) {
			m_index = 0;
		}
		update();
	}
	
	private function m_prev_click(e:Event):Void
	{
		m_index--;
		if (m_index < 0) {
			m_index = m_items.length;
		}
		update();
	}
	
	private function update()
	{
		for (i in 0...m_items.length) {
			if (i >= m_index && i < m_index + 5) {
				m_items[i].visible = true;
				m_items[i].x = m_prev.x + m_prev.width + 5 + (i - m_index) * 65;
			}else {
				m_items[i].visible = false;
			}
		}
		if (m_items.length > 5) {
			m_prev.visible = (m_index != 0);
			m_next.visible = (m_index +5 < m_items.length);
		}
	}
	
	public function addItem(data:ItemData):Void {
		var _item:InventoryItem = new InventoryItem(data);
		_item.visible = false;
		_item.y = 5;
		addChild(_item);
		m_items.push(_item);
		update();
	}
	
}
