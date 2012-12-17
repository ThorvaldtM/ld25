package com.prac.ld25.interfaces;
import com.prac.ld25.tools.AssetLoader;
import nme.Assets;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.filters.DropShadowFilter;
import nme.text.AntiAliasType;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Button extends Sprite
{
	private var m_normal:Sprite;
	private var m_over:Sprite;
	private var m_text:TextField;
	private var m_pushed:Bool = false;

	public function new(graph:String, text:String = null)
	{
		super();
		mouseChildren = false;
		m_normal = AssetLoader.loadAsset('UI/' + graph + '.png', 1, 1);
		m_over = AssetLoader.loadAsset('UI/' + graph +'_hover.png', 1, 1);
		addChild(m_normal);
		addChild(m_over);
		m_over.visible = false;
		this.addEventListener(MouseEvent.MOUSE_OVER, rollOver);
		this.addEventListener(MouseEvent.MOUSE_OUT, rollOut);
		
		if (text != null) {
			
			var font:Font = Assets.getFont ("assets/vgafix.ttf");
			
			var _textFormat:TextFormat = new TextFormat();
			_textFormat.align = TextFormatAlign.CENTER;
			_textFormat.size = 15;
			_textFormat.font = font.fontName;
			_textFormat.color = 0xFFFFFF;
			m_text = new TextField();
			m_text.antiAliasType = AntiAliasType.ADVANCED;
			m_text.defaultTextFormat = _textFormat;
			m_text.width = 194;
			m_text.height = 20;
			m_text.selectable = false;
			m_text.embedFonts = true;
			m_text.filters = [new DropShadowFilter(2)];
			m_text.text = text;
			m_text.y = 8;
			addChild(m_text);
		}
		
		
	}
	
	private function rollOver(e:MouseEvent):Void
	{
		if (m_pushed) {
			return;
		}
		m_over.visible = true;
		m_normal.visible = false;
	}
	
	private function rollOut(e:MouseEvent):Void
	{
		if (m_pushed) {
			return;
		}
		m_normal.visible = true;
		m_over.visible = false;
	}
	
	private function get_pushed():Bool
	{
		return m_pushed;
	}
	
	private function set_pushed(value:Bool):Bool
	{
		m_normal.visible = !value;
		m_over.visible = value;
		return m_pushed = value;
	}
	
	public var pushed(get_pushed, set_pushed):Bool;
	
}
