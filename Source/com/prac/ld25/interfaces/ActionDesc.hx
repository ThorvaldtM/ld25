package com.prac.ld25.interfaces;
import nme.Assets;
import nme.display.Sprite;
import nme.text.AntiAliasType;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

/**
 * ...
 * @author Thorvald ter Meer
 */

class ActionDesc extends Sprite
{
	private var m_text:TextField;

	public function new()
	{
		super();
		
		var font:Font = Assets.getFont ("assets/vgafix.ttf");
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.CENTER;
		_textFormat.size = 15;
		_textFormat.font = font.fontName;
		_textFormat.color = 0xFFFFFF;
		m_text = new TextField();
		m_text.antiAliasType = AntiAliasType.ADVANCED;
		m_text.defaultTextFormat = _textFormat;
		m_text.width = 800;
		m_text.height = 30;
		m_text.selectable = false;
		m_text.embedFonts = true;
		m_text.text = "Walk To";
		addChild(m_text);
	}
	
	public function setDesc(text:String):Void {
		m_text.text = text;
	}
	
}
