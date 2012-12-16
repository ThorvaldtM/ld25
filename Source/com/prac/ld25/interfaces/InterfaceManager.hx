package com.prac.ld25.interfaces;
import com.prac.ld25.data.DataOption;
import com.prac.ld25.data.ItemData;
import com.prac.ld25.interfaces.ActionDesc;
import com.prac.ld25.interfaces.DialogBox;
import com.prac.ld25.interfaces.InventoryItem;
import com.prac.ld25.Settings;
import com.prac.ld25.system.DataEvent;
import com.prac.ld25.tools.AssetLoader;
import flash.events.Event;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.Lib;
import nme.ui.Mouse;

/**
 * ...
 * @author Thorvald ter Meer
 */

class InterfaceManager extends Sprite
{
	static public inline var MODE_WALK = 0;
	static public  inline var MODE_LOOK = 1;
	static  public inline var MODE_TALK = 2;
	static public  inline var MODE_PICK = 3;
	static  public inline var MODE_USE = 4;
	static  public inline var MODE_DIALOG = 5;
	static  public inline var MODE_USE_ITEM = 6;
	
	private var m_cursor:Sprite;
	
	private var m_score:Score;
	private var m_walk:Sprite;
	private var m_talk:Sprite;
	private var m_pick:Sprite;
	private var m_use:Sprite;
	private var m_look:Sprite;
	private var m_inv:Inventory;
	private var m_dialog:DialogBox;
	private var m_current_item:InventoryItem;
	private var m_desc:ActionDesc;
	private var m_ui_bg:Sprite;

	public function new()
	{
		super();
		
		this.mouseEnabled = false;
		
		m_ui_bg = AssetLoader.loadAsset('UI/bg_ui.png', 800, 120);
		m_ui_bg.y = Settings.GAME_SIZE_H - m_ui_bg.height;
		addChild(m_ui_bg);
		
		m_walk = AssetLoader.loadAsset('UI/btn_walk.png', 75, 75);
		m_walk.mouseEnabled = true;
		m_walk.addEventListener(MouseEvent.CLICK, m_walk_click);
		m_walk.x = 5;
		m_walk.y = Settings.GAME_SIZE_H - m_walk.height - 5;
		addChild(m_walk);
		
		m_look = AssetLoader.loadAsset('UI/btn_look.png', 75, 75);
		m_look.mouseEnabled = true;
		m_look.addEventListener(MouseEvent.CLICK, m_look_click);
		m_look.x = m_walk.x + m_walk.width + 5;
		m_look.y = Settings.GAME_SIZE_H - m_look.height - 5;
		addChild(m_look);
		
		m_talk = AssetLoader.loadAsset('UI/btn_talk.png', 75, 75);
		m_talk.mouseEnabled = true;
		m_talk.addEventListener(MouseEvent.CLICK, m_talk_click);
		m_talk.x = m_look.x + m_look.width + 5;
		m_talk.y = Settings.GAME_SIZE_H - m_talk.height - 5;
		addChild(m_talk);
		
		m_pick = AssetLoader.loadAsset('UI/btn_pick.png', 75, 75);
		m_pick.mouseEnabled = true;
		m_pick.addEventListener(MouseEvent.CLICK, m_pick_click);
		m_pick.x = m_talk.x + m_talk.width + 5;
		m_pick.y = Settings.GAME_SIZE_H - m_pick.height - 5;
		addChild(m_pick);
		
		m_use = AssetLoader.loadAsset('UI/btn_use.png', 75, 75);
		m_use.mouseEnabled = true;
		m_use.addEventListener(MouseEvent.CLICK, m_use_click);
		m_use.x = m_pick.x + m_pick.width + 5;
		m_use.y = Settings.GAME_SIZE_H - m_use.height - 5;
		addChild(m_use);
		
		m_inv = new Inventory(Std.int(Settings.GAME_SIZE_W - m_use.x - m_use.width - 5));
		m_inv.x = 414;
		m_inv.y = 480 + 47;
		addChild(m_inv);
		
		m_desc = new ActionDesc();
		m_desc.y = m_walk.y - m_desc.height;
		addChild(m_desc);
		
		m_score = new Score();
		m_score.x = Settings.GAME_SIZE_W - m_score.width;
		m_score.y = m_desc.y;
		addChild(m_score);
		
		updateCursor();
	}
	
	public function addScore(score:Int): Void {
		m_score.score += score;
	}
	
	public function addItem(data:ItemData):Void {
		m_inv.addItem(data);
	}
	
	public function popDialog(options:Array<DataOption>):Void {
		removeDialog();
		m_dialog = new DialogBox(options);
		m_dialog.x = Settings.GAME_SIZE_W - m_dialog.width - 5;
		m_dialog.y = m_ui_bg.y - m_dialog.height;
		m_dialog.addEventListener('dialog_choice', dispatchDialog);
		addChild(m_dialog);
		Settings.STATE = MODE_DIALOG;
		updateCursor();
	}
	
	private function removeDialog()
	{
		Settings.STATE = 0;
		updateCursor();
		if (m_dialog != null) {
			removeChild(m_dialog);
			m_dialog.removeEventListener('dialog_choice', dispatchDialog);
			m_dialog = null;
		}
	}
	
	private function dispatchDialog(e:DataEvent):Void
	{
		removeDialog();
		dispatchEvent(new DataEvent('dialog_choice', false, false, e.data));
	}
	
	private function updateCursor()
	{
		if (m_cursor != null) {
			m_cursor.stopDrag();
			removeChild(m_cursor);
		}
		if (Settings.STATE != MODE_USE_ITEM && m_current_item != null) {
			m_inv.addItem(m_current_item.data);
			m_current_item = null;
		}
		
		switch(Settings.STATE) {
			case MODE_LOOK :
				transformCursor('csr_look.png');
				m_desc.setDesc('Look');
			case MODE_WALK :
				transformCursor('csr_walk.png');
				m_desc.setDesc('Walk To');
			case MODE_PICK :
				transformCursor('csr_pick.png');
				m_desc.setDesc('Pick');
			case MODE_USE :
				transformCursor('csr_use.png');
				m_desc.setDesc('Use');
			case MODE_TALK :
				transformCursor('csr_talk.png');
				m_desc.setDesc('Talk To');
			case MODE_DIALOG :
				transformCursor('csr_select.png');
				m_desc.setDesc('');
			case MODE_USE_ITEM :
				transformCursor('inv_' + m_current_item.data.graph);
				m_desc.setDesc('Use ' + m_current_item.data.name + ' On');
			default:
				Mouse.show();
		}
	}
	
	public function setTarget(text:String):Void {
		
		switch(Settings.STATE) {
			case MODE_LOOK :
				m_desc.setDesc('Look ' + text);
			case MODE_WALK :
				m_desc.setDesc('Walk To ' + text);
			case MODE_PICK :
				m_desc.setDesc('Pick ' + text);
			case MODE_USE :
				m_desc.setDesc('Use ' + text);
			case MODE_TALK :
				m_desc.setDesc('Talk To ' + text);
			case MODE_USE_ITEM :
				m_desc.setDesc('Use ' + m_current_item.data.name + ' On ' + text);
		}
	}
	
	private function transformCursor(file:String):Void
	{
		Mouse.hide();
		m_cursor = AssetLoader.loadAsset(file, 20, 20);
		m_cursor.mouseEnabled = false;
		addChild(m_cursor);
		m_cursor.startDrag(true);
	}
	
	private function m_look_click(e:MouseEvent):Void
	{
		if (Settings.STATE == MODE_DIALOG) {
			return;
		}
		Settings.STATE = MODE_LOOK;
		updateCursor();
	}

	
	private function m_use_click(e:MouseEvent):Void
	{
		if (Settings.STATE == MODE_DIALOG) {
			return;
		}
		Settings.STATE = MODE_USE;
		updateCursor();
	}

	
	private function m_pick_click(e:MouseEvent):Void
	{
		if (Settings.STATE == MODE_DIALOG) {
			return;
		}
		Settings.STATE = MODE_PICK;
		updateCursor();
	}

	
	private function m_talk_click(e:MouseEvent):Void
	{
		if (Settings.STATE == MODE_DIALOG) {
			return;
		}
		Settings.STATE = MODE_TALK;
		updateCursor();
	}

	
	private function m_walk_click(e:Event):Void
	{
		if (Settings.STATE == MODE_DIALOG) {
			return;
		}
		Settings.STATE = MODE_WALK;
		updateCursor();
	}
	
	private function get_state():UInt
	{
		return Settings.STATE;
	}
	
	public var state(get_state, null):UInt;
	
	private function get_current_item():InventoryItem
	{
		return m_current_item;
	}
	
	public var current_item(get_current_item, null):InventoryItem;
	
	public function useItem(object:InventoryItem):Void {
		m_current_item = object;
		Settings.STATE = MODE_USE_ITEM;
		updateCursor();
	}
	
}