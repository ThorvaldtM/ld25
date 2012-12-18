package com.prac.ld25.system;
import com.prac.ld25.tools.AssetLoader;
import flash.events.Event;
import nme.Assets;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.filters.DropShadowFilter;
import nme.Lib;
import nme.text.AntiAliasType;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Intro extends Sprite
{
	private var m_text:TextField;
	private var m_dialogStack:Array<String>;
	private var m_fade:Int;

	public function new()
	{
		super();
		var _bg:Sprite = AssetLoader.loadAsset('LIB/intro.png', 800, 600);
		addChild(_bg);
		
		
		var font:Font = Assets.getFont ("assets/vgafix.ttf");
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.CENTER;
		_textFormat.size = 18;
		_textFormat.font = font.fontName;
		_textFormat.color = 0xFFFFFF;
		m_text = new TextField();
		m_text.antiAliasType = AntiAliasType.ADVANCED;
		m_text.defaultTextFormat = _textFormat;
		m_text.width = 800;
		m_text.height = 50;
		m_text.selectable = false;
		m_text.embedFonts = true;
		m_text.multiline = true;
		m_text.textColor = 0xFA9352;
		m_text.filters = [new DropShadowFilter(4,45, 0x732101)];
		m_text.y = 450;
		m_text.text = "*Demon King* Apprentice Demon, this is your final exam in order to become\na full fledged demon.";
		addChild(m_text);
		m_dialogStack = ['As you know, it is a demon duty to play pranks on humans', 'I will send you in a Hotel where you must show your best skills on\na human living in room 665', 'Good luck and don\'t come back before you have achieved your quest !'];
		m_fade = Lib.getTimer() + 7000;
		addEventListener(MouseEvent.CLICK, skip);
	}
	
	private function skip(e:MouseEvent):Void
	{
		if (m_fade != 999999999) {
			m_fade = 0;
		}
	}
	
	public function update():Void {
		if (Lib.getTimer() > m_fade) {
			if (m_dialogStack.length > 0) {
				m_text.text = m_dialogStack.shift();
				m_fade = Lib.getTimer() + 7000;
			}else {
				m_fade = 999999999;
				dispatchEvent(new Event('go_scene'));
			}
		}
	}
	
}
