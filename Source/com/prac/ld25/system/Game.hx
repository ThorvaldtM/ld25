package com.prac.ld25.system;
import com.prac.ld25.data.SceneList;
import com.prac.ld25.interfaces.InterfaceManager;
import com.prac.ld25.Settings;
import com.prac.ld25.system.Ending;
import com.prac.ld25.system.Intro;
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
	private var m_title:Title;
	private var m_loop:Timer;
	private var m_channel:SoundChannel;
	private var m_intro:Intro;
	private var m_ending:Ending;

	public function new()
	{
		super();
		
		m_loop = new Timer(28);
		m_loop.addEventListener(TimerEvent.TIMER, update);
		m_loop.start();
	}
	
	public function setInterface(interfaceInst:InterfaceManager):Void {
		m_interface = interfaceInst;
	}
	
	public function start(e:Event = null):Void {
		var _main:Main = cast( parent, Main);
		_main.resetInterface();
		
		if (m_channel != null) {
			m_channel.stop();
		}
		
		var sound:Sound = Assets.getSound ("assets/LIB/Title_LD25.mp3");
		m_channel = sound.play(0, 99999);
		Settings.applySound(m_channel);
		
		m_interface.visible = false;
		
		m_title = new Title();
		m_title.addEventListener('go_intro', startIntro);
		addChild(m_title);
		
	}
	
	private function startIntro(e:Event):Void
	{
		removeChild(m_title);
		m_title.removeEventListener('go_intro', startIntro);
		m_title = null;
		m_interface.visible = false;
		
		m_intro = new Intro();
		m_intro.addEventListener('go_scene', startScene);
		addChild(m_intro);
	}
	
	public function startScene(e:Event):Void {
		removeChild(m_intro);
		m_intro.removeEventListener('go_scene', startScene);
		m_intro = null;
		m_interface.visible = true;
		
		m_scene = new Scene(SceneList.getScene('room666'),220,283, m_interface, true);
		m_scene.addEventListener("scene_change", changeScene);
		m_scene.addEventListener("go_final", startEnding);
		addChild(m_scene);
	}
	
	private function startEnding(e:Event):Void
	{
		m_scene.removeEventListener("scene_change", changeScene);
		m_scene.removeEventListener("go_final", startEnding);
		removeChild(m_scene);
		m_scene.destroy();
		m_scene = null;
		m_interface.visible = false;
	
		m_ending = new Ending();
		m_ending.addEventListener('go_start', start);
		addChild(m_ending);
	}
	
	private function update(e:TimerEvent):Void
	{
		if(m_intro != null){
			m_intro.update();
		}
		if(m_title != null){
			m_title.update();
		}
		if(m_scene != null){
			m_scene.update();
		}
		if(m_ending != null){
			m_ending.update();
		}
	}
	
	private function changeScene(e:DataEvent):Void
	{
		SceneList.saveScene(m_scene.data);
		m_scene.removeEventListener("scene_change", changeScene);
		m_scene.removeEventListener("go_final", startEnding);
		removeChild(m_scene);
		m_scene.destroy();
		var _data:Array<String> = e.data.split(';');
		var sound:Sound;
		if (m_scene.data.id == 'reception') {
			m_channel.stop();
			var sound:Sound = Assets.getSound ("assets/LIB/Title_LD25.mp3");
			m_channel = sound.play(0, 99999);
			Settings.applySound(m_channel);
		}else if (_data[0] == 'reception') {
			m_channel.stop();
			var sound:Sound = Assets.getSound ("assets/LIB/bitch_theme.mp3");
			m_channel = sound.play(0, 99999);
			Settings.applySound(m_channel);
		}
		
		m_scene = new Scene(SceneList.getScene(_data[0]), Std.parseInt(_data[1]), Std.parseInt(_data[2]), m_interface);
		m_scene.addEventListener("scene_change", changeScene);
		addChild(m_scene);
		
	}
	
	
	
}
