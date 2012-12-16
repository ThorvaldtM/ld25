package com.prac.ld25.system;
import com.prac.ld25.data.SceneList;
import com.prac.ld25.interfaces.InterfaceManager;
import com.prac.ld25.Settings;
import flash.events.Event;
import nme.Assets;
import nme.display.Sprite;
import nme.events.TimerEvent;
import nme.media.Sound;
import nme.media.SoundChannel;
import nme.utils.Timer;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Game extends Sprite
{
	private var m_interface:InterfaceManager;
	
	private var m_scene:Scene;
	private var m_loop:Timer;
	private var m_channel:SoundChannel;

	public function new()
	{
		super();
	}
	
	public function setInterface(interfaceInst:InterfaceManager):Void {
		m_interface = interfaceInst;
	}
	
	public function start():Void {
		m_scene = new Scene(SceneList.getScene('reception'),300,300, m_interface);
		m_scene.addEventListener("scene_change", changeScene);
		addChild(m_scene);
		
		m_loop = new Timer(40);
		m_loop.addEventListener(TimerEvent.TIMER, update);
		m_loop.start();
		
		var sound:Sound = Assets.getSound ("assets/LIB/Title_LD25.mp3");
		m_channel = sound.play(0, 99999);
		Settings.applySound(m_channel);
	}
	
	private function update(e:TimerEvent):Void
	{
		m_scene.update();
	}
	
	private function changeScene(e:DataEvent):Void
	{
		SceneList.saveScene(m_scene.data);
		m_scene.removeEventListener("scene_change", changeScene);
		removeChild(m_scene);
		var _data:Array<String> = e.data.split(';');
		
		m_scene = new Scene(SceneList.getScene(_data[0]), Std.parseInt(_data[1]), Std.parseInt(_data[2]), m_interface);
		m_scene.addEventListener("scene_change", changeScene);
		addChild(m_scene);
		
	}
	
	
	
}
