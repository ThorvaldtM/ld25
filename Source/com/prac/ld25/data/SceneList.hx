package com.prac.ld25.data;

/**
 * ...
 * @author Thorvald ter Meer
 */

class SceneList
{
	static private var m_instance:SceneList;
	
	private var m_scenes:Array<SceneData>;
	private var m_items_pool:Array<ItemData>;
	private var m_combines:Array<CombineData>;

	public function new()
	{
		m_scenes = new Array<SceneData>();
		m_items_pool =  new Array<ItemData>();
		m_combines =  new Array<CombineData>();
		
		var _scene:SceneData;
		var _item:ItemData;
		var _dialogOption:DataOption;
		var _combo:CombineData;
		
		/****** ROOM 666 ******/
		_scene = new SceneData();
		_scene.id = "room666";
		_scene.bg = "LIB/room.png";
		_scene.collision = "col_room.png";
		
		_item = new ItemData();
		_item.exit = "corridor;500;300";
		_item.name = "exit";
		_item.x = 218;
		_item.y = 412;
		_item.width = 163;
		_item.height = 69;
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "bed";
		_item.name = "Bed";
		_item.x = 540;
		_item.y = 100;
		_item.width = 211;
		_item.height = 275;
		_item.look = new BehaviorData("Looks like a bed to me.");
		_item.use = new BehaviorData("No time to sleep. I need to prank that businessman.");
		_item.talk = new BehaviorData("Only when I am asleep.");
		_item.pick = new BehaviorData("Doesn't look like a portable bed.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "window";
		_item.name = "Window";
		_item.x = 143;
		_item.y = 5;
		_item.width = 105;
		_item.height = 160;
		_item.look = new BehaviorData("It's quite dark outside.");
		_item.use = new BehaviorData("Don't want to catch a cold.");
		_item.talk = new BehaviorData("Really ?");
		_item.pick = new BehaviorData("Nope.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "desk";
		_item.name = "desk";
		_item.x = 375;
		_item.y = 134;
		_item.width = 163;
		_item.height = 116;
		_item.look = new BehaviorData("A Desk.");
		_item.use = new BehaviorData();
		_item.use.special = "replace;desk_open";
		_item.talk = new BehaviorData("Does desk talks ?");
		_item.pick = new BehaviorData("And what you gonna do with a desk ?");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "lamp";
		_item.name = "Lamp";
		_item.x = 454;
		_item.y = 72;
		_item.width = 66;
		_item.height = 95;
		_item.look = new BehaviorData("A Lamp.");
		_item.use = new BehaviorData("I could turn it off but it would to be dark afterward.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData("I rather not.");
		_scene.items.push(_item);
		
		m_scenes.push(_scene);
		
		/****** CORRIDOR ******/
		_scene = new SceneData();
		_scene.id = "corridor";
		_scene.bg = "bg_corridor.png";
		_scene.collision = "col_corridor.png";
		
		_item = new ItemData();
		_item.exit = "room666;238;392";
		_item.name = "Room 666";
		_item.graph = "door.png";
		_item.x = 500;
		_item.y = 100;
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.exit = "reception;495;225";
		_item.name = "Stair";
		_item.graph = "stair.png";
		_item.x = 0;
		_item.y = 100;
		_scene.items.push(_item);
		
		m_scenes.push(_scene);
		
		/****** RECEPTION ******/
		_scene = new SceneData();
		_scene.id = "reception";
		_scene.bg = "LIB/reception.png";
		_scene.collision = "col_reception.png";
		
		_item = new ItemData();
		_item.exit = "corridor;200;150";
		_item.name = "Stair";
		_item.x = 469;
		_item.y = 11;
		_item.width = 162;
		_item.height = 213;
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "receptionist";
		_item.name = "Receptionist";
		_item.x = 0;
		_item.y = 180;
		_item.width = 78;
		_item.height = 121;
		_item.look = new BehaviorData("Wow she is hot !");
		_item.use = new BehaviorData("I sure would like to use her");
		_item.talk = new BehaviorData();
		_item.talk.success = true;
		_item.talk.dialog = new DialogData("Hi. I am marlene.");
		_dialogOption = new DataOption('Hi hot stuff, let\'s dot it !');
		_dialogOption.followup = new DialogData("No way, you stinky goat.");
		_item.talk.dialog.options.push(_dialogOption);
		_item.pick = new BehaviorData("Hummm");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "phone";
		_item.name = "Phone";
		_item.x = 356;
		_item.y = 90;
		_item.width = 66;
		_item.height = 95;
		_item.look = new BehaviorData("The ideal tool for prank calls !");
		_item.use = new BehaviorData();
		_item.use.success = true;
		_item.use.special = "dialog";
		_item.talk = new BehaviorData();
		_item.talk.dialog = new DialogData();
		_dialogOption = new DataOption('Call Me.');
		_dialogOption.followup = new DialogData("This is crazy.");
		_item.talk.dialog.options.push(_dialogOption);
		_item.talk.success = true;
		_item.pick = new BehaviorData("It's fixed to the wall.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "key665";
		_item.name = "Key";
		_item.x = 48;
		_item.y = 66;
		_item.width = 14;
		_item.height = 37;
		_item.look = new BehaviorData("Room 665 is marked on it.");
		_item.use = new BehaviorData("I need to pick it up first.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData("Don't touch that !");
		_item.pick.target = "receptionist";
		_scene.items.push(_item);
		
		m_scenes.push(_scene);
		
		
		/****** ITEM POOL ****/
		
		
		_item = new ItemData();
		_item.id = "desk_open";
		_item.name = "desk";
		_item.x = 375;
		_item.y = 134;
		_item.width = 163;
		_item.height = 116;
		_item.look = new BehaviorData("There is a lighter inside.");
		_item.use = new BehaviorData();
		_item.use.special = "replace;desk";
		_item.talk = new BehaviorData("Does desk talks ?");
		_item.pick = new BehaviorData("This lighter might come handy");
		_item.pick.special = "gain;lighter;score;10;replace;desk_open_empty";
		m_items_pool.push(_item);
		
		_item = new ItemData();
		_item.id = "desk_open_empty";
		_item.name = "desk";
		_item.x = 375;
		_item.y = 134;
		_item.width = 163;
		_item.height = 116;
		_item.look = new BehaviorData("Nothing left.");
		_item.use = new BehaviorData();
		_item.use.special = "replace;desk_empty";
		_item.talk = new BehaviorData("Does desk talks ?");
		_item.pick = new BehaviorData("Nothing left.");
		m_items_pool.push(_item);
		
		_item = new ItemData();
		_item.id = "desk_empty";
		_item.name = "desk";
		_item.x = 375;
		_item.y = 134;
		_item.width = 163;
		_item.height = 116;
		_item.look = new BehaviorData("Just a normal desk");
		_item.use = new BehaviorData();
		_item.use.special = "replace;desk_open_empty";
		_item.talk = new BehaviorData("Does desk talks ?");
		_item.pick = new BehaviorData("And what you gonna do with a desk ?");
		m_items_pool.push(_item);
		
		_item = new ItemData();
		_item.id = "lighter";
		_item.name = "lighter";
		_item.graph = "lighter.png";
		_item.look = new BehaviorData("I love fire");
		_item.talk = new BehaviorData("No genie inside.");
		_item.defaultUse = "I rather not";
		m_items_pool.push(_item);
		
		
		/*** COMBO LIST ****/
		_combo = new CombineData('lighter', 'receptionist', 'She is already hot');
		m_combines.push(_combo);
		
	}
	
	static public function getScene(id:String):SceneData {
		if (m_instance == null) {
			m_instance = new SceneList();
		}
		for (_scene in m_instance.m_scenes) {
			if (_scene.id == id) {
				return _scene;
			}
		}
		
		return null;
	}
	
	static public function saveScene(data:SceneData):Void {
		if (m_instance == null) {
			m_instance = new SceneList();
		}
		for (i in 0...m_instance.m_scenes.length) {
			if (m_instance.m_scenes[i].id == data.id) {
				m_instance.m_scenes[i] = data;
				return;
			}
		}
	}
	
	static public function getItem(id:String):ItemData {
		if (m_instance == null) {
			m_instance = new SceneList();
		}
		for (_item in m_instance.m_items_pool) {
			if (_item.id == id) {
				m_instance.m_items_pool.remove(_item);
				return _item;
			}
		}
		return null;
	}
	
	static public function poolItem(data:ItemData):Void {
		if (m_instance == null) {
			m_instance = new SceneList();
		}
		m_instance.m_items_pool.push(data);
	}
	
	static public function combine(id1:String, id2:String):CombineData {
		if (m_instance == null) {
			m_instance = new SceneList();
		}
		
		for (_combine in m_instance.m_combines) {
			if ((_combine.id1 == id1 && _combine.id2 == id2 ) || (_combine.id1 == id2 && _combine.id2 == id1 )) {
				return _combine;
			}
		}
		return null;
	}
	
}
