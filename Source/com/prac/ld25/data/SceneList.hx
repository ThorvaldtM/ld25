package com.prac.ld25.data;

/**
 * ...
 * @author Thorvald ter Meer
 */

class SceneList
{
	static private var m_instance:SceneList;
	
	private var m_scenes:Array<SceneData>;

	public function new()
	{
		m_scenes = new Array<SceneData>();
		
		var _scene:SceneData;
		var _item:ItemData;
		var _dialogOption:DataOption;
		
		/****** ROOM 666 ******/
		_scene = new SceneData();
		_scene.id = "room666";
		_scene.bg = "bg_room.png";
		_scene.collision = "col_room.png";
		
		_item = new ItemData();
		_item.exit = "corridor;500;300";
		_item.name = "exit";
		_item.graph = "empty.png";
		_item.x = 500;
		_item.y = 400;
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.name = "desk";
		_item.graph = "desk.png";
		_item.x = 100;
		_item.y = 400;
		_item.look = new BehaviorData("Just a normal desk");
		_item.use = new BehaviorData("It won't open");
		_item.talk = new BehaviorData("Does desk talks ?");
		_item.pick = new BehaviorData("Hmm you never know when you might need a desk !");
		_item.pick.success = true;
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.name = "Receptionist";
		_item.graph = "receptionist.png";
		_item.x = 300;
		_item.y = 100;
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
		
		m_scenes.push(_scene);
		
		/****** CORRIDOR ******/
		_scene = new SceneData();
		_scene.id = "corridor";
		_scene.bg = "bg_corridor.png";
		_scene.collision = "col_room.png";
		
		_item = new ItemData();
		_item.exit = "room666;500;260";
		_item.name = "Room 666";
		_item.graph = "door.png";
		_item.x = 500;
		_item.y = 200;
		_scene.items.push(_item);
		
		m_scenes.push(_scene);
		
		
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
	
}
