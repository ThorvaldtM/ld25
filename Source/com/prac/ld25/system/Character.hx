package com.prac.ld25.system;
import com.prac.ld25.Settings;
import com.prac.ld25.tools.AssetLoader;
import flash.geom.Rectangle;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Tilesheet;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Character extends SceneObject
{
	
	public var speed_y:Int = 5;
	public var speed_x:Int = 8;
	private var m_current:Int = 0;
	private var m_tileSheet:Tilesheet;
	
	public var moving:Bool;

	public function new()
	{
		box_width = 100;
		box_height = 100;
		moving = false;
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
		box_height = 100;
		m_text.y += box_height - 247;
	}
	
	override public function update():Void
	{
		super.update();
		if(moving){
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
		}
		this.m_text.scaleX = this.scaleX;
		this.m_text.x = (1530 / 9 - m_text.width) / 2 + ( m_text.width) * (1 - this.scaleX ) / 4; //correct scaling position
	}
	
}
