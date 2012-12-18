package com.prac.ld25.system;
import com.prac.ld25.data.CombineData;
import com.prac.ld25.data.DataOption;
import com.prac.ld25.data.DialogData;
import com.prac.ld25.data.ItemData;
import com.prac.ld25.data.SceneData;
import com.prac.ld25.data.SceneList;
import com.prac.ld25.interfaces.InterfaceManager;
import com.prac.ld25.Settings;
import com.prac.ld25.system.SceneObject;
import com.prac.ld25.system.SpecialEvent;
import com.prac.ld25.tools.AssetLoader;
import flash.events.Event;
import nme.Assets;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.geom.Point;
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
	private var m_collisions:Array<SceneObject>;
	private var m_collision_map:BitmapData;
	private var m_interface:InterfaceManager;
	private var m_dest_action:Int;
	private var m_dest_target:SceneObject;
	private var m_items:Array<SceneObject>;
	private var m_dialog_stack:Array<Dialog>;
	private var m_dir:Bool;
	private var m_dialog_timer:Int = 0;
	private var m_dialog_prev:SceneObject;
	private var m_groom:Bool = true;
	private var m_event:SpecialEvent;
	private var m_special_anim:SceneObject;

	public function new(data:SceneData, spawn_x:Int, spawn_y:Int, _interface:InterfaceManager, firstStart:Bool = false)
	{
		super();
		this.data = data;
		m_collisions = new Array<SceneObject> ();
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
		
		m_collision_map = Assets.getBitmapData('assets/' + data.collision);
		m_groom = Settings.GROOM;
		var _child:Int = -1;
		var _isEvent:Bool = !m_groom;
		var _eventID:String = "";
		for (_item in data.items) {
			if (_item.id == "groom") {
				_eventID = _item.graph;
				if (!Settings.GROOM) {
					Settings.GROOM = true;
					continue;
				}else if (_item.graph == "groom4.png") {
					m_groom = false;
					_isEvent = false;
				}
			}
			if (_item.pick != null && _item.pick.target == "groom") {
				_item.pick.success = !m_groom;
			}
			var _itemObject:SceneObject = new SceneObject(_item);
			_itemObject.addEventListener(MouseEvent.ROLL_OUT, rollOut);
			_itemObject.addEventListener(MouseEvent.ROLL_OVER, rollOver);
			addChild(_itemObject);
			m_items.push(_itemObject);
			if (_item.collision) {
				var _offset:Int = (_item.id == "table") ? 80 : 0;
				for (x in _item.x..._item.x + _item.width) {
					for (y in _item.y..._item.y + _item.height) {
						m_collision_map.setPixel(x, y+_offset, 0x000000);
					}
				}
			}
			if (_item.id == 'table') {
				_child = this.getChildIndex(_itemObject);
			}
		}
		if (_child == -1) {
			_child = numChildren;
		}
		m_character = new Character();
		m_character.x = spawn_x;
		m_character.y = spawn_y;
		if(data.id != "room665"){
			addChildAt(m_character, _child);
		}
		Settings.CHARACTER = m_character;
		
		for (_item in m_items) {
			_item.text.x += _item.x;
			_item.text.y += _item.y;
			addChild(_item.text);
		}
		
		this.addEventListener(MouseEvent.CLICK, moveCharacter);
		
		
		if (_isEvent && data.id == "corridor") {
			switch(_eventID) {
				case "groom4.png":
					m_event = new SpecialEvent([new SpecialText('I still forgiv...', 'joe_special'), new SpecialText('You bastard ! *BAM*', 'marlene_special'),  new SpecialText('*BIM* *BAM*', 'marlene_special'), new SpecialText('Someone helll...', 'joe_special'), new SpecialText('*CRUSH* *BAM* *BAM*', 'marlene_special')], [SceneList.getItem('marlene_special',false), SceneList.getItem('joe_special',false)]);
				case "groom3.png":
					m_event = new SpecialEvent([new SpecialText('Marlene I knew it was a misunderstanding !', 'joe_special'),new SpecialText('*zip* Let\'s dot it !', 'joe_special'), new SpecialText('What the !', 'marlene_special'), new SpecialText('*BIM* *CRUSH*', 'marlene_special') ], [SceneList.getItem('marlene_special',false), SceneList.getItem('joe_special',false)]);
				case "groom2.png":
					m_event = new SpecialEvent([new SpecialText('Oh Marlene !', 'joe_special'), new SpecialText('What the !', 'marlene_special'), new SpecialText('Come here Sweet..', 'joe_special'), new SpecialText('*BAM*', 'marlene_special') ], [SceneList.getItem('marlene_special',false), SceneList.getItem('joe_special',false)]);
					
			}
			if (m_event != null) {
				m_event.x = 29;
				m_event.y = 431;
				addChild(m_event);
				m_event.start();
			}
		}
		//if (firstStart) {
			//parseDialog(';character;Sweet, I can finally exert my skill on those humans;character;I better start checking that room 665 and perform some pranks', m_character);
		//}
		if (data.id == "room665") {
			m_interface.addScore(40);
			parseDialog(";prey;Wtf are you doing in my room ?;greg;Oops, looks I have been found out *shrug*;prey;Get out now !;greg;That's not very nice mister;prey;I'll get you f**king thief *PAN*;greg;Missed me, ahah !;greg;Well play's time over now;greg;*MORPH*;prey;What the hell are you ?!;prey; Please spare me;greg;*demonic voice* I shall rip you heart;prey;nooooooo *feint*;greg;bah that was too easy;greg;I bet those lazy developer cut off the budget for that scene;character;go_end",m_character);
		}
	}
	
	public function destroy():Void {
		m_interface.removeEventListener('dialog_choice', dialogResponse);
	}
	
	private function rollOver(e:MouseEvent):Void
	{
		var _secnObj:SceneObject = cast(e.currentTarget, SceneObject);
		if(_secnObj.data != null){
			m_interface.setTarget(_secnObj.data.name);
		}
	}
	
	private function rollOut(e:MouseEvent):Void
	{
		m_interface.setTarget('');
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
			m_dialog_timer = 0;
			return;
		}
		m_dest_action = m_interface.state;
		if (Std.is(e.target,SceneObject)) {
			m_dest_target = cast(e.target, SceneObject);
		}else {
			m_dest_target = null;
		}
		if (true) {
			if (m_dest_target != null) {
				if(m_dest_target.data.dest != null) {
					m_dest = m_dest_target.data.dest.clone();
				}else{
					m_dest = new Point(Math.round(m_dest_target.x + m_dest_target.box_width / 2 - m_character.box_width / 2) , Math.round(m_dest_target.y + m_dest_target.box_height / 2 - m_character.box_height / 2) );
					normaliseDestination();
				}
			}else {
				m_dest = new Point(e.stageX - m_character.box_width / 2 , e.stageY - m_character.box_height / 2 );
			}
			m_dir = false;
		}else {
			executeAction();
		}
	}
	
	private function normaliseDestination():Void {
		
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
							break;
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
					if(Settings.COLLISION){
						m_character.speak(_next_x + ':' + _next_y, -1);
					}
				}
			}
		}else{
			m_character.moving = false;
		}
		
		if (m_dialog_stack.length > 0 && m_dialog_timer < Lib.getTimer()) {
			if (m_dialog_prev == m_dialog_stack[0].target) {
				m_dialog_prev = null;
				m_dialog_timer = Lib.getTimer() + 2000;
			}else{
				var _dialog:Dialog = m_dialog_stack.shift();
				m_dialog_prev = _dialog.target;
				if(_dialog.text != null && _dialog.text != ''){
					m_dialog_timer = Lib.getTimer() + 2000;
					_dialog.target.speak(_dialog.text, _dialog.fade);
					if (_dialog.text  == "nooooooo *feint*") {
						_dialog.target.visible = false;
					}
					if (_dialog.text  == "go_end") {
						dispatchEvent(new Event('go_final'));
					}
				}
				if (_dialog.special != null) {
					executeSpecial(_dialog.special.special, _dialog.target, _dialog.special);
				}
				if (_dialog.options != null) {
					if(_dialog.options.length > 0){
						m_interface.popDialog(_dialog.options);
					}else {
						Settings.STATE = InterfaceManager.MODE_WALK;
						m_interface.updateCursor();
					}
				}
			}
		}
		
		m_character.update();
		for (_sceneObject in m_items) {
			_sceneObject.update();
			if (_sceneObject.data.id == "stool" && m_character.douche) {
				removeChild(_sceneObject);
				m_items.remove(_sceneObject);
				data.items.remove(_sceneObject.data);
			}
		}
		if (m_character.push) {
			m_character.push = false;
			for (_dest in m_items) {
				if (_dest.data.id == "receptionist") {
					_dest.current_max = 15;
					_dest.speak("So hot in here ...");
					_dest.data.talk.dialog.question = "I am so thirsty ...";
				}else if(_dest.data.id == "thermometer") {
					_dest.current_max = 23;
				}
			}
		}
		if (m_event != null) {
			m_event.update();
		}
		if (m_special_anim != null) {
			m_special_anim.update();
			if (m_special_anim.text.text.length < 5) {
				m_special_anim = null;
			}
		}
	}
	
	private function executeAction()
	{
		if(m_dest_target != null && m_dest_target.data != null){
			switch(m_dest_action) {
				case InterfaceManager.MODE_LOOK :
					if (m_dest_target.data.look != null) {
						killDialogQueue();
						parseDialog(m_dest_target.data.look.desc, m_character);
						if (m_dest_target.data.look.special != null) {
							executeSpecial(m_dest_target.data.look.special, m_dest_target, m_dest_target.data.look);
						}
					}
					m_dest_target = null;
					Settings.STATE = InterfaceManager.MODE_WALK;
				case InterfaceManager.MODE_PICK :
					if (m_dest_target.data.pick != null) {
						if (m_dest_target.data.pick.desc != null) {
							if(m_dest_target.data.pick.target == "character"){
								killDialogQueue();
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
							if(m_dest_target.data.id != "desk_open"){
								m_interface.addItem(m_dest_target.data);
								removeChild(m_dest_target);
								data.items.remove(m_dest_target.data);
							}
							if (m_dest_target.data.pick.special != null) {
								executeSpecial(m_dest_target.data.pick.special, m_dest_target, m_dest_target.data.pick);
							}
						}
					}
					m_dest_target = null;
					Settings.STATE = InterfaceManager.MODE_WALK;
				case InterfaceManager.MODE_TALK :
					if (m_dest_target.data.talk != null) {
						if(m_dest_target.data.talk.desc != null){
							killDialogQueue();
							m_character.speak(m_dest_target.data.talk.desc);
						}
						if (m_dest_target.data.talk.success) {
							if (m_dest_target.data.talk.dialog.options.length > 0) {
								if(m_dest_target.data.talk.desc == null){
									killDialogQueue();
								}
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
							killDialogQueue();
							m_character.speak(m_dest_target.data.use.desc);
						}
						if (m_dest_target.data.use.special != null) {
							executeSpecial(m_dest_target.data.use.special, m_dest_target, m_dest_target.data.use);
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
					if (_combo != null && !_combo.inventory_only) {
						if (_combo.desc != null) {
							killDialogQueue();
							parseDialog(_combo.desc,m_character);
						}
						if (_combo.dialog != null) {
							parseDialog(_combo.dialog.question, m_dest_target, _combo.dialog.options, _combo.dialog);
						}else if(_combo.special != null){
							executeSpecial(_combo.special, m_dest_target, _combo);
							m_dest_target = null;
						}
					}else {
						if (m_interface.current_item.data.defaultUse != null) {
							killDialogQueue();
							m_character.speak(m_interface.current_item.data.defaultUse);
						}
						m_dest_target = null;
					}
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
	
	private function killDialogQueue()
	{
		while (m_dialog_stack.length > 0) {
			m_dialog_stack.shift();
		}
		m_dialog_prev = null;
		m_dialog_timer = 0;
	}
	
	private function executeSpecial(special:String, object:SceneObject, source:Dynamic = null)
	{
		if (special == null) {
			return;
		}
		var _cmd:Array<String> = special.split(';');
		var _item:ItemData;
		var _object:SceneObject;
		var _targetId:String;
		while (_cmd.length > 0) {
			switch(_cmd.shift()) {
				case 'replace' :
					if (object == null) {
						return;
					}
					m_dest_target.speak('');
					var _index :Int = getChildIndex(m_dest_target);
					removeChild(m_dest_target);
					m_items.remove(m_dest_target);
					data.items.remove(m_dest_target.data);
					SceneList.poolItem(m_dest_target.data);
					_item = SceneList.getItem(_cmd.shift());
					_object = new SceneObject(_item);
					_object.addEventListener(MouseEvent.ROLL_OUT, rollOut);
					_object.addEventListener(MouseEvent.ROLL_OVER, rollOver);
					addChildAt(_object, _index);
					this.data.items.push(_item);
					m_items.push(_object);
					if (_item.collision) {
						for (x in _item.x..._item.x + _item.width) {
							for (y in _item.y..._item.y + _item.height) {
								m_collision_map.setPixel(x, y, 0x000000);
							}
						}
					}
				case 'remove_item' :
					m_interface.consumeItem();
				case 'gain' :
					m_interface.addItem(SceneList.getItem(_cmd.shift()));
				case 'score':
					m_interface.addScore(Std.parseInt(_cmd.shift()));
				case 'dialog':
					m_dest_action = InterfaceManager.MODE_TALK;
					executeAction();
				case 'event_thermo':
					Settings.THERMO = true;
					m_character.playPush();
					Settings.STATE = InterfaceManager.MODE_DIALOG;
					m_interface.updateCursor();
				case 'event_stool':
					for (_dest in m_items) {
						if (_dest.data.id == "alarm") {
							_dest.data.id = "alarm2";
							_dest.data.use.desc = "Nothing Happened.";
							_dest.data.pick.desc = "It's fixed to the wall.";
							break;
						}
					}
					_item = m_interface.current_item.data;
					_item.x = 210;
					_item.y = 296;
					_item.dest = new Point(124,328);
					_item.pick.success = false;
					_item.pick.desc = "It's fine as it is.";
					_item.pick.special = null;
					_object = new SceneObject(_item);
					_object.addEventListener(MouseEvent.ROLL_OUT, rollOut);
					_object.addEventListener(MouseEvent.ROLL_OVER, rollOver);
					addChildAt(_object, getChildIndex(m_character) - 1);
					m_items.push(_object);
					m_interface.consumeItem();
					data.items.push(_item);
				case 'event_douche':
					m_character.playDouche();
					Settings.STATE = InterfaceManager.MODE_DIALOG;
					m_interface.updateCursor();
				case 'event_groom':
					Settings.GROOM = false;
					var _itemsList:Array<ItemData> = SceneList.getScene('corridor').items;
					for (_item in _itemsList) {
						if (_item.id == "groom") {
							switch(_item.graph) {
								case "groom1.png" :
									_item.graph = "groom2.png";
								case "groom2.png" :
									_item.graph = "groom3.png";
								case "groom3.png" :
									_item.graph = "groom4.png";
							}
						}
					}
				case 'event_receptionist' :
					if (Settings.THERMO) {
						m_interface.consumeItem();
						var _receptionist:SceneObject = null;
						for (_dest in m_items) {
							if (_dest.data.pick != null &&  _dest.data.pick.target == 'receptionist') {
								_dest.data.pick.desc = null;
								_dest.data.pick.target = null;
								_dest.data.pick.success = true;
							}
							if (_dest.data.id == 'receptionist') {
								_receptionist = _dest;
							}
						
						}
						executeSpecial('replace;receptionist_sleep', _receptionist);
					}
				case 'event_room664' :
					object.data.exit = "room664;438;392";
					object.data.use = null;
				case 'event_room665' :
					object.data.use.desc = "";
					object.data.use.special = "event_room665_open";
					object.data.dest = new Point(340, 370);
				case 'event_room665_open':
					if (m_special_anim != null) {
						return; //event in progress
					}
					Settings.STATE = InterfaceManager.MODE_DIALOG;
					m_special_anim = new SceneObject(SceneList.getItem('door665_anim', false));
					addChildAt(m_special_anim, getChildIndex(m_character) - 1);
					m_special_anim.text.x += m_special_anim.x;
					m_special_anim.text.y += m_special_anim.y;
					addChild(m_special_anim.text);
					parseDialog('What do you think you are doing ?;self;Stop bothering me *vlam*', m_special_anim, null, m_special_anim.data.use);
				case 'event_room665_close':
					if (m_special_anim != null && m_special_anim.parent != null) {
						m_special_anim.speak('Stop bothering me *vlam*', 2000);
						removeChild(m_special_anim);
					}
				case 'skip':
					source.special = _cmd.join(';');
					return;
				case 'disable':
					_targetId = _cmd.shift();
					for (_dest in m_items) {
						if (_dest.data.id == _targetId) {
							_dest.data.pick.desc = "I don't need more.";
							_dest.data.pick.success = false;
							_dest.data.pick.special = null;
						}
					}
				case 'enable':
					_targetId = _cmd.shift();
					for (_dest in m_items) {
						if (_dest.data.id == _targetId) {
							_dest.data.pick.desc = "This might come handy.";
							_dest.data.pick.target = "character";
							_dest.data.pick.success = false;
							_dest.data.pick.special = "score;80";
						}
					}
					
			}
		}
	}
	
	private function parseDialog(text:String, current:SceneObject, options:Array<DataOption> = null, special:Dynamic = null):Void {
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
			parseDialog(_dialog.followup.question, m_dest_target,_dialog.followup.options,_dialog.followup);
		}
	}
	
}
