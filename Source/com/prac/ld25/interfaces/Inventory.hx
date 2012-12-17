package com.prac.ld25.interfaces;
import com.prac.ld25.data.CombineData;
import com.prac.ld25.data.ItemData;
import com.prac.ld25.data.SceneList;
import com.prac.ld25.interfaces.InventoryItem;
import com.prac.ld25.Settings;
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
		
		m_prev = AssetLoader.loadAsset('UI/btn_prev.png', 20, 60);
		m_prev.mouseEnabled = true;
		m_prev.addEventListener(MouseEvent.CLICK, m_prev_click);
		addChild(m_prev);
		
		m_next = AssetLoader.loadAsset('UI/btn_next.png', 20, 60);
		m_next.mouseEnabled = true;
		m_next.addEventListener(MouseEvent.CLICK, m_next_click);
		m_next.x = m_prev.width + 65 * 5 +5;
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
		if (m_items.length < 5) {
			m_index = 0;
		}
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
		_item.addEventListener(MouseEvent.CLICK, clickHandler);
		_item.addEventListener(MouseEvent.ROLL_OVER, rollOver);
		_item.addEventListener(MouseEvent.ROLL_OUT, rollOut);
		addChild(_item);
		m_items.push(_item);
		m_index = Std.int(Math.max(m_items.length - 5,0));
		update();
	}
	
	private function rollOut(e:MouseEvent):Void
	{
		var _ui:InterfaceManager = cast(parent, InterfaceManager);
		_ui.setTarget('');
	}
	
	private function rollOver(e:MouseEvent):Void
	{
		var _ui:InterfaceManager = cast(parent, InterfaceManager);
		var _item:InventoryItem = cast(e.currentTarget, InventoryItem);
		if(Settings.STATE != InterfaceManager.MODE_WALK){
			_ui.setTarget(_item.data.name);
		}
	}
	
	private function clickHandler(e:MouseEvent):Void
	{
		var _item:InventoryItem = cast(e.currentTarget, InventoryItem);
		switch(Settings.STATE) {
				case InterfaceManager.MODE_LOOK :
					if (_item.data.look != null) {
						Settings.CHARACTER.speak(_item.data.look.desc);
					}
				case InterfaceManager.MODE_PICK :
					use(_item);
				case InterfaceManager.MODE_TALK :
					if (_item.data.talk != null) {
						if(_item.data.talk.desc != null){
							Settings.CHARACTER.speak(_item.data.talk.desc);
						}
					}
				case InterfaceManager.MODE_USE :
					use(_item);
				case InterfaceManager.MODE_USE_ITEM :
					var _ui:InterfaceManager = cast(parent, InterfaceManager);
					var _combo:CombineData = SceneList.combine(_ui.current_item.data.id, _item.data.id);
					if (_combo != null) {
						if (_combo.desc != null) {
							Settings.CHARACTER.speak(_combo.desc);
						}
						if(_combo.special != null){
							executeSpecial(_combo.special, _item,_combo);
						}
					}else {
						if (_ui.current_item.data.defaultUse != null) {
							Settings.CHARACTER.speak(_ui.current_item.data.defaultUse);
						}
					}
					
		}
	}
	
	private function executeSpecial(special:String, item:InventoryItem, source:CombineData)
	{
		if (special == null) {
			return;
		}
		var _cmd:Array<String> = special.split(';');
		var _ui:InterfaceManager = cast(parent, InterfaceManager);
		var _item:ItemData;
		var _targetId:String;
		while (_cmd.length > 0) {
			
			switch(_cmd.shift()) {
				case 'remove_both_item' :
					_ui.consumeItem();
					this.m_items.remove(item);
					removeChild(item);
					update();
				case 'remove_item' :
					_ui.consumeItem();
				case 'gain' :
					_ui.addItem(SceneList.getItem(_cmd.shift()));
				case 'score':
					_ui.addScore(Std.parseInt(_cmd.shift()));
				case 'skip':
					source.special = _cmd.join(';');
					return;
			}
		}
		
	}
	
	private function use(object:InventoryItem)
	{
		if (Settings.STATE == InterfaceManager.MODE_DIALOG) {
			return;
		}
		this.m_items.remove(object);
		removeChild(object);
		update();
		var _ui:InterfaceManager = cast(parent, InterfaceManager);
		_ui.useItem(object);
	}
	
}
