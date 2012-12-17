package com.prac.ld25.system;
import com.prac.ld25.data.ItemData;
import nme.Assets;
import nme.display.Sprite;
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

class SpecialEvent extends Sprite
{
	private var m_script:Array<SpecialText>;
	private var m_chars:Array<ItemData>;
	private var m_text:TextField;
	private var m_time:Int = -1;

	public function new(script:Array<SpecialText>,chars:Array<ItemData>)
	{
		super();
		this.mouseChildren = false;
		this.mouseEnabled = false;
		m_script = script;
		m_chars = chars;
		
			
		var font:Font = Assets.getFont ("assets/vgafix.ttf");
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.CENTER;
		_textFormat.size = 15;
		_textFormat.font = font.fontName;
		_textFormat.color = 0xFFFFFF;
		m_text = new TextField();
		m_text.antiAliasType = AntiAliasType.ADVANCED;
		m_text.defaultTextFormat = _textFormat;
		m_text.width = 200;
		m_text.height = 60;
		m_text.selectable = false;
		m_text.embedFonts = true;
		m_text.wordWrap = true;
		m_text.multiline = true;
		m_text.mouseEnabled = false;
		m_text.text = " ";
		m_text.filters = [new DropShadowFilter()];
		addChild(m_text);
	}
	
	public function start():Void {
		execute(m_script.shift());
	}
	public function ended():Bool {
		return (m_script.length == 0);
	}
	
	private function execute(shift:SpecialText)
	{
		var _char:ItemData = null;
		for (_aChar in m_chars) {
			if (_aChar.id == shift.target_id) {
				_char = _aChar;
				break;
			}
		}
		m_text.textColor = _char.textColor;
		m_text.filters = [new DropShadowFilter(4, 45, _char.shadowColor)];
		m_time = Lib.getTimer() + shift.time;
		m_text.text = shift.desc;
		m_text.x = shift.text_x;
		m_text.y = shift.text_y;
	}
	
	public function update():Void {
		if (m_time != -1 && m_time < Lib.getTimer()) {
			m_text.text = ' ';
			if ( m_script.length > 0) {
				execute(m_script.shift());
			}
		}
	}
	
}
