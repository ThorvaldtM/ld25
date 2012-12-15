package com.prac.ld25.system;
import com.prac.ld25.data.ItemData;
import com.prac.ld25.tools.AssetLoader;
import nme.Assets;
import nme.display.Sprite;
import nme.events.MouseEvent;
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

class SceneObject extends Sprite
{
	private var m_text:TextField;
	private var m_fade:Int;
	public var data:ItemData;

	public function new(data:ItemData)
	{
		super();
		m_fade = -1;
		this.mouseChildren = false;
		if(data != null){
			var _bg:Sprite = AssetLoader.loadAsset(data.graph, data.width, data.height);
			addChild(_bg);
			this.x = data.x;
			this.y = data.y;
			this.data = data;
		}
			
		var font:Font = Assets.getFont ("assets/vgafix.ttf");
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.CENTER;
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
		m_text.wordWrap = true;
		m_text.multiline = true;
		m_text.mouseEnabled = false;
		m_text.text = " ";
		m_text.y = - 60;
		m_text.x = (this.width - m_text.width) / 2;
		addChild(m_text);
		
	}
	
	public function speak(text:String, fade:Int = 5000):Void {
		m_text.text = text;
		if (fade != -1) {
			m_fade = Lib.getTimer() + fade;
		}else {
			m_fade = -1;
		}
	}
	
	public function update():Void {
		if (m_fade != -1 && Lib.getTimer() > m_fade) {
			m_text.text = " ";
			m_fade = -1;
		}
	}
	
}
