package com.prac.ld25.system;
import com.prac.ld25.interfaces.InterfaceManager;
import com.prac.ld25.Settings;
import com.prac.ld25.tools.AssetLoader;
import flash.geom.Rectangle;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Tilesheet;
import nme.filters.DropShadowFilter;
import nme.geom.Point;
import nme.Lib;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Character extends SceneObject
{
	
	public var speed_y:Int = 3;
	public var speed_x:Int = 5;
	public var douche:Bool = false;
	private var m_tileSheet_douche:Tilesheet;
	
	private var _moving:Bool;
	private var m_tileSheet_jump:Tilesheet;
	private var m_tileSheet_light:Tilesheet;

	public function new()
	{
		box_width = 100;
		box_height = 50;
		_moving = false;
		m_tileSheet_jump = new Tilesheet(Assets.getBitmapData('assets/LIB/jump.png'));
		for (i in 1...12) {
			m_tileSheet_jump.addTileRect(new Rectangle(i * 324, 0, 324, 463));
		}
		m_tileSheet_light = new Tilesheet(Assets.getBitmapData('assets/LIB/lighter.png'));
		for (i in 0...16) {
			m_tileSheet_light.addTileRect(new Rectangle(i * 324, 0, 324, 463));
		}
		m_tileSheet_douche = new Tilesheet(Assets.getBitmapData('assets/LIB/douche.png'));
		for (i in 0...8) {
			m_tileSheet_douche.addTileRect(new Rectangle(i * 324, 0, 324, 463));
		}
		m_tileSheet = new Tilesheet(Assets.getBitmapData('assets/LIB/heroe.png'));
		for (i in 0...9) {
			m_tileSheet.addTileRect(new Rectangle(i * 1530 / 9, 0, 1530 / 9, 247));
		}
		m_tileSheet.drawTiles(this.graphics, [ -25, box_height - 247, 0]);
		m_current_max = 9;
		m_current_sheet = m_tileSheet;
		m_current_point = new Point( -25, box_height - 247);
		if(Settings.COLLISION){
			/*** hitbox **/
			this.graphics.beginFill(0x00FF00,0.5);
			this.graphics.drawRect(0, 0, box_width, box_height);
			this.graphics.endFill();
		}
		super(null);
		box_width = 100;
		box_height = 50;
		m_text.y += box_height - 247;
		this.mouseChildren = false;
		this.mouseEnabled = false;
		this.m_text.filters = [new DropShadowFilter(4, 45, 0x0A0069)];
	}
	
	override public function update():Void
	{
		super.update();
		if (m_current_sheet != m_tileSheet) {
			Settings.STATE = InterfaceManager.MODE_DIALOG;
		}
		if((moving || (m_current_sheet != m_tileSheet && m_fade == -1) ) && m_skip <= 0 ){
			this.graphics.clear();
			if(m_current_sheet != m_tileSheet ){
				this.x = 217;
				this.y = 281;
				this.scaleX = 1;
				this.x -= this.scaleX * box_width;
				this.douche = true;
			}
			m_current_sheet.drawTiles(this.graphics, [m_current_point.x, m_current_point.y, m_current]);
			m_current++;
			if (m_current >= m_current_max) {
				m_current = 0;
				switch(m_current_sheet) {
					case m_tileSheet_douche :
						m_current_max = 9;
						m_current_sheet = m_tileSheet;
						m_current_point = new Point( -25, box_height - 247);
						Settings.STATE = InterfaceManager.MODE_WALK;
						this.scaleX = - this.scaleX;
						this.x -= this.scaleX * box_width - 80;
					case m_tileSheet_jump :
						m_current_max = 16;
						m_current_sheet = m_tileSheet_light;
					case m_tileSheet_light :
						m_current_max = 8;
						m_current_sheet = m_tileSheet_douche;
				}
			}
			if(Settings.COLLISION){
				/*** hitbox **/
				this.graphics.beginFill(0x00FF00, 0.5);
				this.graphics.drawRect(0, 0, box_width, box_height);
				this.graphics.endFill();
			}
			m_skip = 2;
		}else {
			m_skip--;
		}
		this.m_text.scaleX = this.scaleX;
		this.m_text.x = (1530 / 9 - m_text.width  - 50) / 2 + ( m_text.width + 100) * (1 - this.scaleX ) / 4; //correct scaling position
		m_text.y = -20 + box_height - 247;
		if (m_text.y + this.y < 0) {
			m_text.y = Settings.GAME_SIZE_H;
		}
	}
	
	public function playDouche():Void {
		moving = false;
		m_fade = Lib.getTimer() + 99999999;
		m_current = 0;
		m_current_max = 11;
		m_current_sheet = m_tileSheet_jump;
		m_current_point = new Point( -25, -380);
	}
	
	private function get_moving():Bool
	{
		return _moving;
	}
	
	private function set_moving(value:Bool):Bool
	{
		if (!value && m_current_sheet == m_tileSheet) {
			this.graphics.clear();
			m_current = 3;
			m_tileSheet.drawTiles(this.graphics, [-25, box_height - 247, m_current]);
			if(Settings.COLLISION){
				/*** hitbox **/
				this.graphics.beginFill(0x00FF00, 0.5);
				this.graphics.drawRect(0, 0, box_width, box_height);
				this.graphics.endFill();
			}
		}
		return _moving = value;
	}
	
	public var moving(get_moving, set_moving):Bool;
	
}
