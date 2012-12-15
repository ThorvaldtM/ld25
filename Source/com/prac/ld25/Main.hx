package com.prac.ld25;


import com.prac.ld25.system.Game;
import haxe.PosInfos;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import com.prac.ld25.interfaces.InterfaceManager;


/**
 * @author Thorvald ter Meer
 */
class Main extends Sprite {
	private var m_interface:InterfaceManager;
	private var m_game:Game;
	
	
	public function new () {
		
		super ();
		
		initialize ();
		
		
		
	}
	
	
	private function initialize ():Void {
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		this.graphics.beginFill(0x000000);
		this.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		this.graphics.endFill();
		
		//disable trace
		haxe.Log.trace = this.trace;
		
		m_game = new Game();
		addChild( m_game);
		
		m_interface = new InterfaceManager();
		addChild( m_interface);
		
		m_game.setInterface(m_interface);
		m_game.start();
		
	}
	
	private function trace(v : Dynamic, ?infos : PosInfos ):Void
	{
		
	}
	
	
	
	
	// Entry point
	
	
	
	
	public static function main () {
		
		Lib.current.addChild (new Main ());
		
	}
	
	
}
