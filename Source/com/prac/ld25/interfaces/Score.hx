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

class Score extends Sprite
{
	private var m_text:TextField;
	private var m_score:Int = 0;

	public function new()
	{
		super();
		
		var font:Font = Assets.getFont ("assets/vgafix.ttf");
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.LEFT;
		_textFormat.size = 15;
		_textFormat.font = font.fontName;
		_textFormat.color = 0xFFFFFF;
		m_text = new TextField();
		m_text.antiAliasType = AntiAliasType.ADVANCED;
		m_text.defaultTextFormat = _textFormat;
		m_text.width = 175;
		m_text.height = 60;
		m_text.selectable = false;
		m_text.embedFonts = true;
		m_text.text = "Score : " + m_score;
		addChild(m_text);
	}
	
	private function get_score():Int
	{
		return m_score;
	}
	
	private function set_score(value:Int):Int
	{
		m_text.text = "Score : " + value;
		return m_score = value;
	}
	
	public var score(get_score, set_score):Int;
	
}
