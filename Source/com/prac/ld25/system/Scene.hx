package com.prac.ld25.system;
import com.prac.ld25.data.CombineData;
import com.prac.ld25.data.DataOption;
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
import nme.Lib;

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
	private var m_dialog_stack:Array<Dialog>;
	private var m_dir:Bool;
	private var m_dialog_timer:Int = 0;

	public function new(data:SceneData, spawn_x:Int, spawn_y:Int, _interface:InterfaceManager)
	{
		super();
		this.data = data;
		m_exits = new Array<SceneObject> ();
		m_items = new Array<SceneObject>();
		m_dialog_stack = new Array<Dialog>();
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
		Settings.CHARACTER = m_character;
		
		for (_item in m_items) {
			_item.text.x += _item.x;
			_item.text.y += _item.y;
			addChild(_item.text);
		}
		
		m_collision_map = Assets.getBitmapData('assets/' + data.collision);
		
		this.addEventListener(MouseEvent.CLICK, moveCharacter);
		this.addEventListener(MouseEvent.MOUSE_OVER, overScene);
		
		
		
	}
	
	private function overScene(e:MouseEvent):Void
	{
		if (Std.is(e.target, SceneObject)) {
			var _secnObj:SceneObject = cast(e.target, SceneObject);
			if(_secnObj.data != null){
				m_interface.setTarget(_secnObj.data.name);
			}
		}else if (Std.is(e.target, Character)) {
			m_interface.setTarget('My Self');
		}else {
			m_interface.setTarget('');
		}
	}
	
	private function moveCharacter(e:MouseEvent):Void
	{
		if (m_interface.state == InterfaceManager.MODE_DIALOG) {
			return;
		}
		m_dest_action = m_interface.state;
		if (Std.is(e.target,SceneObject)) {
			m_dest_target = cast(e.target, SceneObject);
		}else {
			m_dest_target = null;
		}
		if (m_interface.state == InterfaceManager.MODE_WALK  || (m_interface.state != InterfaceManager.MODE_LOOK && m_dest_target != null)) {
			if(m_dest_target != null){
				m_dest = new Point(m_dest_target.x + m_dest_target.box_width /2 - m_character.box_width / 2 , m_dest_target.y + m_dest_target.box_height /2 + m_character.box_height * 2 );
			}else {
				m_dest = new Point(e.stageX - m_character.box_width / 2 , e.stageY - m_character.box_height / 2 );
			}
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
			var _reel_x:Float = m_character.x - (m_character.box_width)  * (1 - m_character.scaleX ) / 2;
			
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
				//for (_sceneObject in m_exits) {
					//if (_next_x + m_character.box_width >= _sceneObject.x && _next_x < _sceneObject.x + _sceneObject.box_width
						//&& m_character.y < _sceneObject.y  + _sceneObject.box_height && m_character.y + m_character.box_height > _sceneObject.y ) {
							//dispatchExit(_sceneObject.data.exit);
						//}
				//}
			}
		}else{
			m_character.moving = false;
		}
		
		if (m_dialog_stack.length > 0 && m_dialog_timer < Lib.getTimer()) {
			var _dialog:Dialog = m_dialog_stack.shift();
			if(_dialog.text != null && _dialog.text != ''){
				m_dialog_timer = Lib.getTimer() + 2000;
				_dialog.target.speak(_dialog.text, _dialog.fade);
			}
			if (_dialog.options != null) {
				if(_dialog.options.length > 0){
					m_interface.popDialog(_dialog.options);
				}else {
					Settings.STATE = InterfaceManager.MODE_WALK;
					m_interface.updateCursor();
				}
			}
			if (_dialog.special != null) {
				executeSpecial(_dialog.special, _dialog.target);
			}
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
					m_dest_target = null;
					Settings.STATE = InterfaceManager.MODE_WALK;
				case InterfaceManager.MODE_PICK :
					if (m_dest_target.data.pick != null) {
						if (m_dest_target.data.pick.desc != null) {
							if(m_dest_target.data.pick.target == null){
								m_character.speak(m_dest_target.data.pick.desc);
							}else {
								for (_dest in m_items) {
									if (_dest.data.id == m_dest_target.data.pick.target) {
										_dest.speak(m_dest_target.data.pick.desc);
										break;
									}
								}
							}
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
					m_dest_target = null;
					Settings.STATE = InterfaceManager.MODE_WALK;
				case InterfaceManager.MODE_TALK :
					if (m_dest_target.data.talk != null) {
						if(m_dest_target.data.talk.desc != null){
							m_character.speak(m_dest_target.data.talk.desc);
						}
						if (m_dest_target.data.talk.success) {
							if (m_dest_target.data.talk.dialog.options.length > 0) {
								parseDialog(m_dest_target.data.talk.dialog.question, m_dest_target);
								m_interface.popDialog(m_dest_target.data.talk.dialog.options);
							}else {
								parseDialog(m_dest_target.data.talk.dialog.question, m_dest_target);
								m_dest_target = null;
								Settings.STATE = InterfaceManager.MODE_WALK;
							}
						}else {
							m_dest_target = null;
							Settings.STATE = InterfaceManager.MODE_WALK;
						}
					}else {
						m_dest_target = null;
						Settings.STATE = InterfaceManager.MODE_WALK;
					}
				case InterfaceManager.MODE_USE :
					if (m_dest_target.data.exit != null) {
						dispatchExit(m_dest_target.data.exit);
					}
					if (m_dest_target.data.use != null) {
						if(m_dest_target.data.use.desc != null){
							m_character.speak(m_dest_target.data.use.desc);
						}
						if (m_dest_target.data.use.special != null) {
							executeSpecial(m_dest_target.data.use.special, m_dest_target);
							if (m_dest_target.data.use.special.indexOf('dialog') == -1) {
								m_dest_target = null;
								Settings.STATE = InterfaceManager.MODE_WALK;
							}
						}else {
							m_dest_target = null;
							Settings.STATE = InterfaceManager.MODE_WALK;
						}
					}else {
						m_dest_target = null;
						Settings.STATE = InterfaceManager.MODE_WALK;
					}
				case InterfaceManager.MODE_USE_ITEM :
					var _combo:CombineData = SceneList.combine(m_interface.current_item.data.id, m_dest_target.data.id);
					if (_combo != null) {
						if (_combo.desc != null) {
							m_character.speak(_combo.desc);
						}
						if(_combo.special != null){
							executeSpecial(_combo.special, m_dest_target);
						}
					}else {
						if (m_interface.current_item.data.defaultUse != null) {
							m_character.speak(m_interface.current_item.data.defaultUse);
						}
					}
					m_dest_target = null;
				case InterfaceManager.MODE_WALK :
					if (m_dest_target.data.exit != null) {
						dispatchExit(m_dest_target.data.exit);
						m_dest_target = null;
					}
			}
		}
		m_dest_action = 0;
		m_interface.updateCursor();
	}
	
	private function executeSpecial(special:String, object:SceneObject)
	{
		var _cmd:Array<String> = special.split(';');
		var _item:ItemData;
		var _object:SceneObject;
		while (_cmd.length > 0) {
			switch(_cmd.shift()) {
				case 'replace' :
					var _index :Int = getChildIndex(m_dest_target);
					removeChild(m_dest_target);
					data.items.remove(m_dest_target.data);
					SceneList.poolItem(m_dest_target.data);
					_item = SceneList.getItem(_cmd.shift());
					_object = new SceneObject(_item);
					addChildAt(_object, _index);
					m_items.push(_object);
					if (_item.exit != null) {
						m_exits.push(_object);
					}
				case 'gain' :
					m_interface.addItem(SceneList.getItem(_cmd.shift()));
				case 'score':
					m_interface.addScore(Std.parseInt(_cmd.shift()));
				case 'dialog':
					m_dest_action = InterfaceManager.MODE_TALK;
					executeAction();
				case 'event_thermo':
					for (_dest in m_items) {
						if (_dest.data.id == "receptionist") {
							_dest.speak("I am so thirsty ...");
							_dest.data.talk.dialog.question = "I am so thirsty ...";
							break;
						}
					}
					
			}
		}
	}
	
	private function parseDialog(text:String, current:SceneObject, options:Array<DataOption> = null, special:String = null):Void {
		if (text == null) {
			return;
		}
		if (text.indexOf(';') == -1) {
			m_dialog_stack.push(new Dialog(text, current, 5000, options, special));
			return;
		}
		
		var _textData:Array<String> = text.split(';');
		m_dialog_stack.push(new Dialog(_textData.shift(), current));
		var _target:String;
		while (_textData.length > 0) {
			_target = _textData.shift();
			var _text:String = _textData.shift();
			var _targetObject:SceneObject = current;
			if (_target == 'character') {
				_targetObject = m_character;
			}else if (_target != 'self') {
				for (_dest in m_items) {
					if (_dest.data.id == _target) {
						_targetObject = _dest;
						break;
					}
				}
			}
			
			if (_textData.length == 0) {
				m_dialog_stack.push(new Dialog(_text, _targetObject, 5000, options, special));
			}else {
				m_dialog_stack.push(new Dialog(_text, _targetObject));
			}
		}
	}
	
	private function dialogResponse(e:DataEvent):Void
	{
		var _dialog:DataOption = cast(e.data, DataOption);
		parseDialog(_dialog.answer, m_character);
		if (_dialog.followup != null && m_dest_target != null) {
			parseDialog(_dialog.followup.question, m_dest_target,_dialog.followup.options,_dialog.followup.special);
		}
	}
	
}
