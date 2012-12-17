package com.prac.ld25.system;
import com.prac.ld25.data.ItemData;
import com.prac.ld25.Settings;
import com.prac.ld25.tools.AssetLoader;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Tilesheet;
import nme.events.MouseEvent;
import nme.filters.DropShadowFilter;
import nme.geom.Point;
import nme.geom.Rectangle;
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
	private var m_current:Int = 0;
	private var m_tileSheet:Tilesheet;
	private var m_skip:Int = 0;
	private var m_current_sheet:Tilesheet;
	private var m_current_max:Int;
	private var m_current_point:Point;
	private var m_current_pause:Int = -99999;
	
	
	public var box_width:Float;
	public var box_height:Float;

	public function new(data:ItemData)
	{
		super();
		m_fade = -1;
		this.mouseChildren = false;
		if(data != null){
			
			box_width = data.width;
			box_height = data.height;
			switch(data.id) {
				case 'receptionist_sleep' :
					m_tileSheet = new Tilesheet(Assets.getBitmapData('assets/LIB/chickdodospritesheet.png'));
					for (i in 0...4) {
						m_tileSheet.addTileRect(new Rectangle(i * 456 / 4, 0, 456 / 4, 140));
					}
					m_tileSheet.drawTiles(this.graphics, [ 0, 0, 0]);
					m_current_max = 4;
					m_current_sheet = m_tileSheet;
					m_current_point = new Point( 0, 0);
					m_current_pause = -99999;
				case 'receptionist' :
					m_tileSheet = new Tilesheet(Assets.getBitmapData('assets/LIB/marlene.png'));
					for (i in 0...15) {
						m_tileSheet.addTileRect(new Rectangle(i * 1710 / 15, 0, 1710 / 15, 140));
					}
					m_tileSheet.drawTiles(this.graphics, [ 0, 0, 0]);
					m_current_max = (Settings.THERMO) ? 15 : 1;
					m_current_sheet = m_tileSheet;
					m_current_point = new Point( 0, 0);
					m_current_pause = (Settings.THERMO) ? Std.int(Math.random() * 36 * 10) : -99999;
				case 'thermometer' :
					m_tileSheet = new Tilesheet(Assets.getBitmapData('assets/LIB/thermometer.png'));
					for (i in 0...23) {
						m_tileSheet.addTileRect(new Rectangle(i * 759 / 23, 0, 759 / 23, 78));
					}
					m_tileSheet.drawTiles(this.graphics, [ 0, 0, 0]);
					m_current = (Settings.THERMO) ? 21 : 0;
					m_current_max = -1;
					m_current_sheet = m_tileSheet;
					m_current_point = new Point( 0, 0);
				default:
					var _bg:Sprite = AssetLoader.loadAsset('LIB/' + data.graph, data.width, data.height);
					addChild(_bg);
					box_width = _bg.width;
					box_height = _bg.height;
			}
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
		m_text.width = 200;
		m_text.height = 60;
		m_text.selectable = false;
		m_text.embedFonts = true;
		m_text.wordWrap = true;
		m_text.multiline = true;
		m_text.mouseEnabled = false;
		m_text.y = - 20;
		m_text.x = (this.width - m_text.width) / 2;
		if (data != null) {
			m_text.filters = [new DropShadowFilter(4, 45, data.shadowColor)];
			m_text.textColor = data.textColor;
			if(data.id == "phone"){
				m_text.x += 60;
			}
		}
		m_text.text = " ";
		
		if (this.x + m_text.x < 0) {
			m_text.x = - this.x;
		}
		
		addChild(m_text);
		
	}
	
	public function speak(text:String, fade:Int = 5000):Void {
		if (text == null) {
			return;
		}
		m_text.htmlText = text;
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
		if (data != null) {
			m_current_pause--;
			if(m_current_sheet != null && m_skip <= 0 && m_current_pause <= 0){
				this.graphics.clear();
				m_current_sheet.drawTiles(this.graphics, [m_current_point.x, m_current_point.y, m_current]);
				if (m_current_max != -1){
					m_current++;
				}
				if(m_current == 1 && m_current_pause > -99999){
					m_current_pause = Std.int(Math.random() * 36 * 10);
				}
				if (m_current == 2 && m_current_pause < -99999){
					m_current_pause = 0;
				}
				if (m_current_max != -1 && m_current >= m_current_max) {
					if (data.id == 'thermometer') {
						m_current = m_current_max -2;
					}else if (data.id == 'receptionist_sleep') {
						m_current = m_current_max -1;
						if(m_fade <= 0){
							speak('zzZzZ', 3000);
							m_current_pause = 300;
						}
					} else	{
						m_current = 0;
					}
				}
				m_skip = 2;
			}else {
				m_skip--;
			}
		}
	}
	
	private function get_text():TextField
	{
		return m_text;
	}
	
	public var text(get_text, null):TextField;
	
	private function get_current_max():Int
	{
		return m_current_max;
	}
	
	private function set_current_max(value:Int):Int
	{
		return m_current_max = value;
	}
	
	public var current_max(get_current_max, set_current_max):Int;
	
}
