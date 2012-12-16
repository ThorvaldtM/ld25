package com.prac.ld25.system;
import com.prac.ld25.Settings;
import com.prac.ld25.tools.AssetLoader;
import flash.geom.Rectangle;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Tilesheet;
import nme.filters.DropShadowFilter;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Character extends SceneObject
{
	
	public var speed_y:Int = 3;
	public var speed_x:Int = 6;
	private var m_current:Int = 0;
	private var m_tileSheet:Tilesheet;
	private var m_skip:Bool = false;
	
	private var _moving:Bool;

	public function new()
	{
		box_width = 100;
		box_height = 50;
		_moving = false;
		m_tileSheet = new Tilesheet(Assets.getBitmapData('assets/LIB/heroe.png'));
		for (i in 0...9) {
			m_tileSheet.addTileRect(new Rectangle(i * 1530 / 9, 0, 1530 / 9, 247));
		}
		m_tileSheet.drawTiles(this.graphics, [-25, box_height - 247, 0]);
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
		// 324*463
	}
	
	override public function update():Void
	{
		super.update();
		if(moving && !m_skip){
			this.graphics.clear();
			m_tileSheet.drawTiles(this.graphics, [-25, box_height - 247, m_current]);
			m_current++;
			if (m_current >= 9) {
				m_current = 0;
			}
			if(Settings.COLLISION){
				/*** hitbox **/
				this.graphics.beginFill(0x00FF00, 0.5);
				this.graphics.drawRect(0, 0, box_width, box_height);
				this.graphics.endFill();
			}
			m_skip = true;
		}else {
			m_skip = false;
		}
		this.m_text.scaleX = this.scaleX;
		this.m_text.x = (1530 / 9 - m_text.width  - 50) / 2 + ( m_text.width + 100) * (1 - this.scaleX ) / 4; //correct scaling position
		m_text.y = -20 + box_height - 247;
		if (m_text.y + this.y < 0) {
			m_text.y = Settings.GAME_SIZE_H;
		}
	}
	
	private function get_moving():Bool
	{
		return _moving;
	}
	
	private function set_moving(value:Bool):Bool
	{
		if (!value) {
			this.graphics.clear();
			m_tileSheet.drawTiles(this.graphics, [-25, box_height - 247, m_current]);
			m_current = 3;
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
