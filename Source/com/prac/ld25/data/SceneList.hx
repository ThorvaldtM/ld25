package com.prac.ld25.data;
import nme.geom.Point;

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
		
		/****** ROOM 664 ******/
		_scene = new SceneData();
		_scene.id = "room664";
		_scene.bg = "LIB/room.png";
		_scene.collision = "col_room.png";
		
		_item = new ItemData();
		_item.exit = "corridor;50;349";
		_item.name = "exit";
		_item.x = 218;
		_item.y = 412;
		_item.width = 163;
		_item.height = 69;
		_item.look = new BehaviorData("The door leading out of the room");
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("Nah.");
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
		_item.use = new BehaviorData("Locked.");
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
		_item.use = new BehaviorData("I could turn it off but it would to be too dark afterward.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData("I rather not.");
		_scene.items.push(_item);
		
		m_scenes.push(_scene);
		
		/****** ROOM 665 ******/
		_scene = new SceneData();
		_scene.id = "room665";
		_scene.bg = "LIB/room.png";
		_scene.collision = "col_room.png";
		
		_item = new ItemData();
		_item.exit = "corridor;345;349";
		_item.name = "exit";
		_item.x = 218;
		_item.y = 412;
		_item.width = 163;
		_item.height = 69;
		_item.look = new BehaviorData("The door leading out of the room");
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("Nah.");
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
		_item.use = new BehaviorData("Locked.");
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
		_item.use = new BehaviorData("That would wake him up.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData("I rather not.");
		_scene.items.push(_item);
		
		m_scenes.push(_scene);
		
		/****** ROOM 666 ******/
		_scene = new SceneData();
		_scene.id = "room666";
		_scene.bg = "LIB/room.png";
		_scene.collision = "col_room.png";
		
		_item = new ItemData();
		_item.exit = "corridor;657;349";
		_item.name = "exit";
		_item.x = 218;
		_item.y = 412;
		_item.width = 163;
		_item.height = 69;
		_item.look = new BehaviorData("The door leading out of the room");
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("Nah.");
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
		_item.dest = new Point(333, 251);
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
		_item.use = new BehaviorData("I could turn it off but it would to be too dark afterward.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData("I rather not.");
		_scene.items.push(_item);
		
		m_scenes.push(_scene);
		
		/****** CORRIDOR ******/
		_scene = new SceneData();
		_scene.id = "corridor";
		_scene.bg = "LIB/couloir.png";
		_scene.collision = "col_corridor.png";
		
		_item = new ItemData();
		_item.id = "groom";
		_item.name = "Groom";
		_item.graph = "groom1.png";
		_item.x = 513;
		_item.y = 111;
		_item.width = 78;
		_item.height = 121;
		_item.textColor = 0xF3FF87;
		_item.shadowColor = 0xA37E02;
		_item.look = new BehaviorData("A big smoker. Maybe I should do something about it.");
		_item.use = new BehaviorData("Can you repeat that ?");
		_item.talk = new BehaviorData();
		_item.talk.success = true;
		_item.talk.dialog = new DialogData("*sigh*");
		_dialogOption = new DataOption('Hi I am Greg, how are you doing ?', 'Greet');
		_dialogOption.followup = new DialogData("*looks up* *sigh*");
		_dialogOption.followup.options[0] = new DataOption('Look a triple headed monkey !','Prank');
		_dialogOption.followup.options[0].followup = new DialogData("*sigh*");
		_dialogOption.followup.options[1] = new DataOption('You know anything about room 665 ?','Ask');
		_dialogOption.followup.options[1].followup = new DialogData("Nah.");
		_dialogOption.followup.options[2] = new DataOption('Goodbye.','Bye');
		_item.talk.dialog.options.push(_dialogOption);
		_dialogOption = new DataOption('I am a demon and I will eat you alive !;character;*makes scary face*', 'Prank');
		_dialogOption.followup = new DialogData("*sigh*;character;(I really need to work on my act.)");
		_item.talk.dialog.options.push(_dialogOption);
		_dialogOption = new DataOption('Goodbye.','Bye');
		_item.talk.dialog.options.push(_dialogOption);
		_item.pick = new BehaviorData("Not my type.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.exit = "room666;238;392";
		_item.name = "Room 666";
		_item.id = "door666";
		_item.x = 645;
		_item.y = 73;
		_item.width = 123;
		_item.height = 235;
		_item.look = new BehaviorData("The door to my room");
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("Nah.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.name = "Room 665";
		_item.id = "door665";
		_item.x = 333;
		_item.y = 73;
		_item.width = 123;
		_item.height = 235;
		_item.look = new BehaviorData("This is where my target reside.");
		_item.use = new BehaviorData("Damn, locked.");
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("Nah.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.name = "Room 664";
		_item.id = "door664";
		_item.x = 38;
		_item.y = 71;
		_item.width = 123;
		_item.height = 235;
		_item.look = new BehaviorData("I wonder who lives there.");
		_item.use = new BehaviorData("Damn, locked.");
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("Nah.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.exit = "reception;495;225";
		_item.name = "Stair";
		_item.id = "stair";
		_item.x = 12;
		_item.y = 410;
		_item.width = 165;
		_item.height = 72;
		_item.look = new BehaviorData("The stairs are going down.");
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("Nah.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "alarm";
		_item.name = "Fire Alarm";
		_item.x = 279;
		_item.y = 20;
		_item.width = 35;
		_item.height = 38;
		_item.look = new BehaviorData("An old fire alarm. I wonder if it works");
		_item.use = new BehaviorData('I can\'t reach it.');
		_item.talk = new BehaviorData("It is not an interphone.");
		_item.pick = new BehaviorData("I can\'t reach it.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "chariot";
		_item.name = "";
		_item.graph = "chariot.png";
		_item.x = 472;
		_item.y = 275;
		_item.width = 156;
		_item.height = 145;
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "book";
		_item.name = "Book";
		_item.x = 482;
		_item.y = 275;
		_item.width = 27;
		_item.height = 24;
		_item.look = new BehaviorData("The title reads : Goats and friends");
		_item.use = new BehaviorData('I don\'t like reading.');
		_item.talk = new BehaviorData("You don't talk to it. You READ it.");
		_item.pick = new BehaviorData("I have no use for that.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "mugs";
		_item.name = "Mugs";
		_item.x = 498;
		_item.y = 332;
		_item.width = 56;
		_item.height = 43;
		_item.look = new BehaviorData("Some empty mugs");
		_item.use = new BehaviorData('They are empty.');
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("I have no use for that right now.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "bottle";
		_item.name = "Bottle";
		_item.graph = "bottle.png";
		_item.x = 593;
		_item.y = 226;
		_item.width = 25;
		_item.height = 69;
		_item.look = new BehaviorData("A bottle of water");
		_item.use = new BehaviorData('Ahh refreshing.');
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData('Hands off.');
		_item.pick.target = "groom";
		_item.defaultUse = "I don't want to waste it";
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "justin";
		_item.name = "Magazine";
		_item.graph = "Justin.png";
		_item.x = 512;
		_item.y = 275;
		_item.width = 27;
		_item.height = 24;
		_item.look = new BehaviorData("Justin Bieber on the cover. Yuck !");
		_item.use = new BehaviorData('I REALLY rather not read it.');
		_item.talk = new BehaviorData("Not even if that was possible.");
		_item.pick = new BehaviorData('Hands off.');
		_item.pick.target = "groom";
		_item.defaultUse = "Nope.";
		_scene.items.push(_item);
		
		m_scenes.push(_scene);
		
		/****** RECEPTION ******/
		_scene = new SceneData();
		_scene.id = "reception";
		_scene.bg = "LIB/reception.png";
		_scene.collision = "col_reception.png";
		
		_item = new ItemData();
		_item.exit = "corridor;30;400";
		_item.name = "Stair";
		_item.x = 469;
		_item.y = 11;
		_item.width = 162;
		_item.height = 213;
		_item.look = new BehaviorData("The stairs are going up.");
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("Nah.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "receptionist";
		_item.name = "Receptionist";
		_item.graph = "marlene.png";
		_item.x = 0;
		_item.y = 160;
		_item.width = 78;
		_item.height = 121;
		_item.textColor = 0xFFCCF5;
		_item.shadowColor = 0x9E027F;
		_item.look = new BehaviorData("Wow she is hot !");
		_item.use = new BehaviorData("I sure would like to use her");
		_item.talk = new BehaviorData();
		_item.talk.success = true;
		_item.talk.dialog = new DialogData("Hi. I am marlene.");
		_dialogOption = new DataOption('Hey hot stuff, how about going out ?', 'Flirt');
		_dialogOption.followup = new DialogData("No way, you stinky goat.");
		_item.talk.dialog.options.push(_dialogOption);
		_dialogOption = new DataOption('Hi I am Greg, how are you doing ?', 'Greet');
		_dialogOption.followup = new DialogData("What do you want ? I am busy.");
		_dialogOption.followup.options[0] = new DataOption('How about giving me your number ?;character;Just kidding !', 'Flirt');
		_dialogOption.followup.options[0].followup = new DialogData("There now leave me alone.;character;(wow she actually gave it to me !)");
		_dialogOption.followup.options[0].followup.special = "gain;number;score;10;remove_option";
		_dialogOption.followup.options[1] = new DataOption('Can I do anything for you ?','Ask');
		_dialogOption.followup.options[1].followup = new DialogData("Bring me a magazine.");
		_dialogOption.followup.options[2] = new DataOption('Goodbye.','Bye');
		_dialogOption.followup.options[2].followup = new DialogData("Hmph.");
		_item.talk.dialog.options.push(_dialogOption);
		_dialogOption = new DataOption('Goodbye.','Bye');
		_dialogOption.followup = new DialogData("Hmph.");
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
		_item.textColor = 0x75FA7E;
		_item.shadowColor = 0x096900;
		_item.look = new BehaviorData("The ideal tool for prank calls !");
		_item.use = new BehaviorData();
		_item.use.success = true;
		_item.use.special = "dialog";
		_item.talk = new BehaviorData();
		_item.talk.dialog = new DialogData();
		_dialogOption = new DataOption('Let\'s see. *6* *6* *6* ...', 'Prank Myself');
		_dialogOption.followup = new DialogData("*bip* *bip* *no answer*;character;Tss. I was looking forward to that prank call !");
		_item.talk.dialog.options.push(_dialogOption);
		//_dialogOption = new DataOption('Let\'s see. *9* *1* *1* ...', 'Call 911');
		//_dialogOption.followup = new DialogData("*bip* *bip* (male voice) 911, How can I help you ?;character;");
		//_item.talk.dialog.options.push(_dialogOption);
		_item.talk.success = true;
		_item.pick = new BehaviorData("It's fixed to the wall.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "thermometer";
		_item.name = "";
		_item.graph = "thermometer.png";
		_item.x = 234;
		_item.y = 56;
		_item.width = 61;
		_item.height = 40;
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "thermostat";
		_item.name = "Thermostat";
		_item.x = 244;
		_item.y = 96;
		_item.width = 61;
		_item.height = 40;
		_item.dest = new Point(329, 222);
		_item.look = new BehaviorData("20 degrees.");
		_item.use = new BehaviorData();
		_item.use.special = "score;10;replace;thermostat_high;event_thermo";
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("Nope.");
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "key142";
		_item.name = "Key";
		_item.graph = "key_blue.png";
		_item.x = 62;
		_item.y = 66;
		_item.width = 14;
		_item.height = 37;
		_item.look = new BehaviorData("Room 142 is marked on it.");
		_item.use = new BehaviorData("I need to pick it up first.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData("Don't touch that !");
		_item.pick.target = "receptionist";
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "key664";
		_item.name = "Key";
		_item.graph = "key_green.png";
		_item.x = 90;
		_item.y = 66;
		_item.width = 14;
		_item.height = 37;
		_item.look = new BehaviorData("Room 664 is marked on it.");
		_item.use = new BehaviorData("I need to pick it up first.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData("Don't touch that !");
		_item.pick.target = "receptionist";
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "key665";
		_item.name = "Key";
		_item.graph = "key_red.png";
		_item.x = 76;
		_item.y = 103;
		_item.width = 14;
		_item.height = 37;
		_item.look = new BehaviorData("Room 665 is marked on it.");
		_item.use = new BehaviorData("I need to pick it up first.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData("Don't touch that !");
		_item.pick.target = "receptionist";
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "key777";
		_item.name = "Key";
		_item.graph = "key_gold.png";
		_item.x = 20;
		_item.y = 103;
		_item.width = 14;
		_item.height = 37;
		_item.look = new BehaviorData("Room 777 is marked on it.");
		_item.use = new BehaviorData("I need to pick it up first.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData("Don't touch that !");
		_item.pick.target = "receptionist";
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "table";
		_item.name = "Table";
		_item.graph = "table.png";
		_item.x = 473;
		_item.y = 290;
		_item.width = 155;
		_item.height = 91;
		_item.look = new BehaviorData("A truly magnificent table !;character;This is the one I was waiting all of my life;character;no, just a plain BORING table.");
		_item.use = new BehaviorData("Huh ?");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData("Too Heavy.");
		_item.collision = true;
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "stool";
		_item.name = "Stool";
		_item.graph = "tabouret.png";
		_item.x = 416;
		_item.y = 370;
		_item.width = 51;
		_item.height = 83;
		_item.look = new BehaviorData("Just a stool.");
		_item.use = new BehaviorData("No time for that now.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData();
		_item.pick.success = true;
		_item.pick.special = "score;10;disable;stool";
		_item.collision = true;
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "stool";
		_item.name = "Stool";
		_item.graph = "tabouret.png";
		_item.x = 525;
		_item.y = 426;
		_item.width = 51;
		_item.height = 83;
		_item.look = new BehaviorData("Just a stool.");
		_item.use = new BehaviorData("No time for that now.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData();
		_item.pick.special = "score;10;disable;stool";
		_item.pick.success = true;
		_item.collision = true;
		_scene.items.push(_item);
		
		_item = new ItemData();
		_item.id = "stool";
		_item.name = "Stool";
		_item.graph = "tabouret.png";
		_item.x = 634;
		_item.y = 370;
		_item.width = 51;
		_item.height = 83;
		_item.look = new BehaviorData("Just a stool.");
		_item.use = new BehaviorData("No time for that now.");
		_item.talk = new BehaviorData("Nah.");
		_item.pick = new BehaviorData();
		_item.pick.success = true;
		_item.pick.special = "score;10;disable;stool";
		_item.collision = true;
		_scene.items.push(_item);
		
		m_scenes.push(_scene);
		
		
		/****** ITEM POOL ****/
		
		
		_item = new ItemData();
		_item.id = "desk_open";
		_item.name = "desk";
		_item.graph = "tiroir.png";
		_item.x = 375;
		_item.y = 134;
		_item.width = 163;
		_item.height = 116;
		_item.look = new BehaviorData("So many stuff inside.");
		_item.use = new BehaviorData();
		_item.use.special = "replace;desk";
		_item.talk = new BehaviorData("Does desk talks ?");
		_item.pick = new BehaviorData("This might come handy");
		_item.pick.special = "gain;lighter;score;10;skip;gain;pills;score;10;replace;desk_open_empty";
		_item.pick.success = true;
		m_items_pool.push(_item);
		
		_item = new ItemData();
		_item.id = "desk_open_empty";
		_item.name = "desk";
		_item.graph = "tiroir.png";
		_item.x = 375;
		_item.y = 134;
		_item.width = 163;
		_item.height = 116;
		_item.look = new BehaviorData("Only junk left.");
		_item.use = new BehaviorData();
		_item.use.special = "replace;desk_empty";
		_item.talk = new BehaviorData("Does desk talks ?");
		_item.pick = new BehaviorData("Only junk left.");
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
		
		_item = new ItemData();
		_item.id = "pills";
		_item.name = "Box of Pills";
		_item.graph = "pills.png";
		_item.look = new BehaviorData("SweetMoon. Makes you dream about the moon. Effect Guaranteed");
		_item.talk = new BehaviorData("No.");
		_item.defaultUse = "I rather not";
		m_items_pool.push(_item);
		
		_item = new ItemData();
		_item.id = "number";
		_item.name = "Piece of Paper";
		_item.graph = "number.png";
		_item.look = new BehaviorData("Marlene's Number. Sweet !");
		_item.talk = new BehaviorData("No Anwser.");
		_item.defaultUse = "Nothing happened";
		m_items_pool.push(_item);
		
		_item = new ItemData();
		_item.id = "number_joe";
		_item.name = "Joe's Number";
		_item.graph = "number.png";
		_item.look = new BehaviorData("Damn it was only Joe's number.");
		_item.talk = new BehaviorData("No Anwser.");
		_item.defaultUse = "Nothing happened";
		m_items_pool.push(_item);
		
		_item = new ItemData();
		_item.id = "thermostat_high";
		_item.name = "Thermostat";
		_item.x = 244;
		_item.y = 96;
		_item.width = 61;
		_item.height = 40;
		_item.look = new BehaviorData("29 degrees.");
		_item.use = new BehaviorData('It\'s broken now.');
		_item.talk = new BehaviorData("Nope.");
		_item.pick = new BehaviorData("Nope.");
		m_items_pool.push(_item);
		
		_item = new ItemData();
		_item.id = "sleep_bottle";
		_item.name = "Special Bottle";
		_item.graph = "bottle.png";
		_item.x = 593;
		_item.y = 226;
		_item.width = 25;
		_item.height = 69;
		_item.look = new BehaviorData("A bottle mixed with SweetMoon pills");
		_item.talk = new BehaviorData("Nope.");
		_item.defaultUse = "I don't want to waste it";
		m_items_pool.push(_item);
		
		
		/*** COMBO LIST ****/
		_combo = new CombineData('lighter', 'receptionist', 'She is already hot');
		m_combines.push(_combo);
		
		_combo = new CombineData('lighter', 'alarm', 'It is out of reach');
		m_combines.push(_combo);
		
		_combo = new CombineData('lighter', 'alarm2', 'Showtime !');
		_combo.special = "remove_item;event_douche;score;10";
		m_combines.push(_combo);
		
		_combo = new CombineData('number', 'receptionist', 'I don\'t want to give it back to her.');
		m_combines.push(_combo);
		
		_combo = new CombineData('number', 'phone', 'Let\'s try that number.');
		_combo.dialog = new DialogData('*bip* *bip*;self;(male voice) Hi, Joe\'s speaking;character;*hangs up* Noooo ...');
		_combo.dialog.special = "remove_item;gain;number_joe";
		m_combines.push(_combo);
		
		_combo = new CombineData('number_joe', 'phone', 'Let\'s prank him !');
		_combo.dialog = new DialogData('*bip* *bip*;self;(male voice) Hi, Joe\'s speaking');
		_dialogOption = new DataOption('*female voice mode*;character;Hey, this is marlene', 'Flirt');
		_dialogOption.followup = new DialogData("*sigh* What is it this time ?");
		_dialogOption.followup.options[0] = new DataOption('Can you please bring me the magazine, sweetie.', 'Flirt');
		_dialogOption.followup.options[0].followup = new DialogData("*sigh* *hangs up*");
		_dialogOption.followup.options[1] = new DataOption('There are some luggage down here.;character;Hurry up to take them upstairs !','Order');
		_dialogOption.followup.options[1].followup = new DialogData("*sigh* *hangs up*");
		_dialogOption.followup.options[2] = new DataOption('(Wait ! I am a demon not a killer !)','Kill');
		_dialogOption.followup.options[2].followup = new DialogData("Hello ? *sigh*");
		_dialogOption.followup.options[2].followup.options[0] = new DataOption('I am so horny for you !', 'Super Flirt');
		_dialogOption.followup.options[2].followup.options[0].followup = new DialogData("*hangs up*");
		_dialogOption.followup.options[2].followup.options[0].followup.special = "event_groom;score;10;remove_option";
		_dialogOption.followup.options[2].followup.options[1] = new DataOption('Let\'s play strip poker.','Mega Flirt');
		_dialogOption.followup.options[2].followup.options[1].followup = new DialogData("*hangs up*");
		_dialogOption.followup.options[2].followup.options[1].followup.special = "event_groom;score;10;remove_option";
		_dialogOption.followup.options[2].followup.options[2] = new DataOption('I want to experience new positions with you !','Ultra Flirt');
		_dialogOption.followup.options[2].followup.options[2].followup = new DialogData("*hangs up*");
		_dialogOption.followup.options[2].followup.options[2].followup.special = "event_groom;score;10;remove_option";
		_combo.dialog.options.push(_dialogOption);
		_dialogOption = new DataOption('I am the devil !', 'Fear');
		_dialogOption.followup = new DialogData("And I am the queen of england ! *hangs up*");
		_combo.dialog.options.push(_dialogOption);
		_dialogOption = new DataOption('*breath* I am your father *breath*','Obi-wan Kenobi');
		_dialogOption.followup = new DialogData("Spoke is that you ?;character;*hangs up* I don't wanna live on this planet anymore.");
		_combo.dialog.options.push(_dialogOption);
		m_combines.push(_combo);
		
		_combo = new CombineData('stool', 'alarm', 'Now I can reach it.');
		_combo.special = 'event_stool';
		m_combines.push(_combo);
		
		_combo = new CombineData('bottle', 'pills', 'Nice. Let\'s find a guiny pig.');
		_combo.special = 'remove_both_item;gain;sleep_bottle';
		_combo.inventory_only = true;
		m_combines.push(_combo);
		
		_combo = new CombineData('sleep_bottle', 'receptionist');
		_combo.special = 'event_receptionist';
		m_combines.push(_combo);
		
		_combo = new CombineData('key664', 'door664', 'The door is unlocked!');
		_combo.special = 'event_room664';
		m_combines.push(_combo);
		
		_combo = new CombineData('key665', 'door665', 'The door is unlocked!');
		_combo.special = 'event_room665';
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
