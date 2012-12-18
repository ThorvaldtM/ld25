package com.prac.ld25.system;
import com.prac.ld25.Settings;
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

class Ending extends Sprite
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
		m_text.width = 700;
		m_text.x = 50;
		m_text.height = 50;
		m_text.selectable = false;
		m_text.embedFonts = true;
		m_text.wordWrap = true;
		m_text.multiline = true;
		m_text.textColor = 0xFA9352;
		m_text.filters = [new DropShadowFilter(4,45, 0x732101)];
		m_text.y = 450;
		m_text.text = "*Demon King* You scored " + Settings.SCORE + " out of 1000" ;
		addChild(m_text);
		if (Settings.SCORE >= 1000) {
			m_dialogStack = ['You really impressed me !', 'I was going to reward you with a unique costume\nbut we are running out of time', 'Those humans are lurking nearby, Follow me !'];
		}else if (Settings.SCORE >= 700) {
			m_dialogStack = ['Wow, you are good. Just a little more and I would have given you\n a unique prize', 'Still good job on your mission','I hereby declare you a full fledged demon'];
		}else if (Settings.SCORE >= 300) {
			m_dialogStack = ['Nice job on completing the missions', 'I hereby declare you a full fledged demon'];
		}else{
			m_dialogStack = ['Is that all you can do ?', 'Well at least you completed your missions', 'I hereby declare you a full fledged demon'];
		}
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
