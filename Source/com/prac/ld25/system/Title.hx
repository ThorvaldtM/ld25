package com.prac.ld25.system;
import com.prac.ld25.tools.AssetLoader;
import flash.events.Event;
import nme.Assets;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.text.AntiAliasType;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Title extends Sprite
{
	private var m_fade:Int = 1;
	private var m_text:TextField;

	public function new()
	{
		super();
		this.mouseChildren = false;
		
		var _bg:Sprite = AssetLoader.loadAsset('LIB/intro.png', 800, 600);
		addChild(_bg);
		var _title:Sprite = AssetLoader.loadAsset('LIB/title.png', 494, 88);
		_title.x = (800 - _title.width) / 2;
		_title.y = 430;
		addChild(_title);
		
		var font:Font = Assets.getFont ("assets/vgafix.ttf");
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.CENTER;
		_textFormat.size = 22;
		_textFormat.font = font.fontName;
		_textFormat.color = 0xFFFFFF;
		m_text = new TextField();
		m_text.antiAliasType = AntiAliasType.ADVANCED;
		m_text.defaultTextFormat = _textFormat;
		m_text.width = 800;
		m_text.height = 30;
		m_text.selectable = false;
		m_text.embedFonts = true;
		m_text.y = 530;
		m_text.text = "Click to Start the game";
		addChild(m_text);
		
		this.addEventListener(MouseEvent.CLICK, goNext);
	}
	
	private function goNext(e:MouseEvent):Void
	{
		dispatchEvent(new Event('go_intro'));
	}
	
	public function update():Void {
		if (m_fade == 1){
			if (m_text.alpha > 0.1) {
				m_text.alpha -= 0.05;
			}else {
				m_fade = -1;
			}
		}else {
			if (m_text.alpha < 1) {
				m_text.alpha += 0.05;
			}else {
				m_fade = 1;
			}
		}
	}
}
