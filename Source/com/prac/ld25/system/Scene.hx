package com.prac.ld25.system;
import com.prac.ld25.data.DialogData;
import com.prac.ld25.data.ItemData;
import com.prac.ld25.data.SceneData;
import com.prac.ld25.data.SceneList;
import com.prac.ld25.interfaces.InterfaceManager;
import com.prac.ld25.Settings;
import com.prac.ld25.tools.AssetLoader;
import flash.events.Event;
import nme.Assets;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.geom.Point;
import nme.installer.Assets;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Scene extends Sprite
{
	public var data:SceneData;
	private var m_character:Character;
	private var m_dest:Point;
	private var m_exits:Array<SceneObject>;
	private var m_collision_map:BitmapData;
	private var m_interface:InterfaceManager;
	private var m_dest_action:UInt;
	private var m_dest_target:SceneObject;
	private var m_items:Array<SceneObject>;
	private var m_dir:Bool;

	public function new(data:SceneData, spawn_x:Int, spawn_y:Int, _interface:InterfaceManager)
	{
		super();
		this.data = data;
		m_exits = new Array<SceneObject> ();
		m_items = new Array<SceneObject>();
		m_interface = _interface;
		m_interface.addEventListener('dialog_choice', dialogResponse);
		m_dir = false;
		
		var _bg:Sprite = AssetLoader.loadAsset(data.bg, 800, 600);
		addChild(_bg);
		if(Settings.COLLISION){
			var _bgCol:Sprite = AssetLoader.loadAsset(data.collision, 800, 600);
			_bgCol.alpha = 0.5;
			addChild(_bgCol);
		}
		
		for (_item in data.items) {
			var _itemObject:SceneObject = new SceneObject(_item);
			addChild(_itemObject);
			m_items.push(_itemObject);
			if (_item.exit != null) {
				m_exits.push(_itemObject);
			}
		}
		
		m_character = new Character();
		m_character.x = spawn_x;
		m_character.y = spawn_y;
		addChild(m_character);
		
		m_collision_map = Assets.getBitmapData('assets/' + data.collision);
		
		this.addEventListener(MouseEvent.CLICK, moveCharacter);
	}
	
	private function moveCharacter(e:MouseEvent):Void
	{
		if (m_interface.state == InterfaceManager.MODE_DIALOG) {
			return;
		}
		m_dest_action = m_interface.state;
		if (Std.is(e.target,SceneObject)) {
			m_dest_target = cast(e.target, SceneObject);
		}
		if (m_interface.state != InterfaceManager.MODE_LOOK) {
			m_dest = new Point(e.stageX - m_character.box_width / 2 , e.stageY - m_character.box_height / 2 );
			m_dir = false;
		}else {
			executeAction();
		}
	}
	
	private function dispatchExit(data:String):Void
	{
		dispatchEvent(new DataEvent('scene_change',false,false,data));
	}
	
	public function update():Void {
		if (m_dest != null) {
			m_character.moving = true;
			var _reel_x:Float = m_character.x - m_character.box_width * (1 - m_character.scaleX ) / 2;
			
			if (m_dest.x == _reel_x && m_dest.y == m_character.y) {
				m_dest = null;
				executeAction();
			}else {
				var _next_x:Float;
				var _next_y:Float;
				if (m_dest.x > _reel_x) {
					_next_x = Math.min(m_dest.x, _reel_x + m_character.speed_x);
				}else {
					_next_x = Math.max(m_dest.x, _reel_x - m_character.speed_x);
				}
				if (m_dest.y > m_character.y) {
					_next_y = Math.min(m_dest.y, m_character.y + m_character.speed_y);
				}else {
					_next_y = Math.max(m_dest.y, m_character.y - m_character.speed_y);
				}
				
				/*** COLLISION ***/
				var _isSafe:Bool = true;
				var _min_x:Int =  Std.int(Math.min(_reel_x, _next_x));
				var _max_x:Int =  Std.int(Math.max(_reel_x, _next_x) + m_character.box_width);
				var _min_y:Int =  Std.int(Math.min(m_character.y, _next_y));
				var _max_y:Int =  Std.int(Math.max(m_character.y, _next_y) + m_character.box_height);
				for (x in _min_x..._max_x) {
					for (y in _min_y..._max_y) {
						if (m_collision_map.getPixel(x, y) == 0x000000) {
							_isSafe = false;
							m_dest = null;
							executeAction();
						}
					}
				}
				if (_isSafe) {
					if(!m_dir){
						if (_next_x > _reel_x) {
							if(m_character.scaleX != -1){
								m_character.scaleX = -1;
							}
						}else if(_next_x != _reel_x) {
							if(m_character.scaleX != 1){
								m_character.scaleX = 1;
							}
						}
						m_dir = true;
					}
					m_character.x = _next_x + m_character.box_width * (1 - m_character.scaleX ) / 2;
					m_character.y = _next_y;
				}
				
				/*** ITEM COLLISION ***/
				for (_sceneObject in m_exits) {
					if (_next_x + m_character.box_width >= _sceneObject.x && _next_x < _sceneObject.x + _sceneObject.box_width
						&& m_character.y < _sceneObject.y  + _sceneObject.box_height && m_character.y + m_character.box_height > _sceneObject.y ) {
							dispatchExit(_sceneObject.data.exit);
						}
				}
			}
		}else{
			m_character.moving = false;
		}
		
		m_character.update();
		for (_sceneObject in m_items) {
			_sceneObject.update();
		}
	}
	
	private function executeAction()
	{
		if(m_dest_target != null && m_dest_target.data != null){
			switch(m_dest_action) {
				case InterfaceManager.MODE_LOOK :
					if (m_dest_target.data.look != null) {
						m_character.speak(m_dest_target.data.look.desc);
						if (m_dest_target.data.look.special != null) {
							executeSpecial(m_dest_target.data.look.special, m_dest_target);
						}
					}
				case InterfaceManager.MODE_PICK :
					if (m_dest_target.data.pick != null) {
						if(m_dest_target.data.pick.desc != null){
							m_character.speak(m_dest_target.data.pick.desc);
						}
						if (m_dest_target.data.pick.success) {
							m_interface.addItem(m_dest_target.data);
							removeChild(m_dest_target);
							data.items.remove(m_dest_target.data);
						}
						if (m_dest_target.data.pick.special != null) {
							executeSpecial(m_dest_target.data.pick.special, m_dest_target);
						}
					}
				case InterfaceManager.MODE_TALK :
					if (m_dest_target.data.talk != null) {
						if(m_dest_target.data.talk.desc != null){
							m_character.speak(m_dest_target.data.talk.desc);
						}
						if (m_dest_target.data.talk.success) {
							if (m_dest_target.data.talk.dialog.options.length > 0) {
								m_dest_target.speak(m_dest_target.data.talk.dialog.question,-1);
								m_interface.popDialog(m_dest_target.data.talk.dialog.options);
							}else {
								m_dest_target.speak(m_dest_target.data.talk.dialog.question);
							}
						}
						if (m_dest_target.data.talk.special != null) {
							executeSpecial(m_dest_target.data.talk.special, m_dest_target);
						}
					}
				case InterfaceManager.MODE_USE :
					if (m_dest_target.data.use != null) {
						if(m_dest_target.data.use.desc != null){
							m_character.speak(m_dest_target.data.use.desc);
						}
						if (m_dest_target.data.use.special != null) {
							executeSpecial(m_dest_target.data.use.special, m_dest_target);
						}
					}
			}
		}
		m_dest_target = null;
		m_dest_action = 0;
	}
	
	private function executeSpecial(special:String, object:SceneObject)
	{
		var _cmd:Array<String> = special.split(';');
		var _item:ItemData;
		var _object:SceneObject;
		while (_cmd.length > 0) {
			switch(_cmd.shift()) {
				case 'replace' :
					removeChild(m_dest_target);
					data.items.remove(m_dest_target.data);
					SceneList.poolItem(m_dest_target.data);
					_item = SceneList.getItem(_cmd.shift());
					_object = new SceneObject(_item);
					addChild(_object);
					m_items.push(_object);
					if (_item.exit != null) {
						m_exits.push(_object);
					}
				case 'gain' :
					m_interface.addItem(SceneList.getItem(_cmd.shift()));
				case 'score':
					m_interface.addScore(Std.parseInt(_cmd.shift()));
			}
		}
	}
	
	private function dialogResponse(e:DataEvent):Void
	{
		var _followUp:DialogData = cast(e.data, DialogData);
		if (_followUp != null) {
			if (_followUp.options.length > 0) {
				m_dest_target.speak(_followUp.question,-1);
				m_interface.popDialog(_followUp.options);
			}else {
				m_dest_target.speak(_followUp.question);
			}
		}
	}
	
}
