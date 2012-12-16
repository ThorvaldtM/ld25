import com.prac.ld25.Main;
import nme.Assets;
import nme.events.Event;


class ApplicationMain {
	
	static var mPreloader:NMEPreloader;

	public static function main () {
		
		var call_real = true;
		
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		
		nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		
		if (loaded < total || true) /* Always wait for event */ {
			
			call_real = false;
			mPreloader = new NMEPreloader();
			nme.Lib.current.addChild(mPreloader);
			mPreloader.onInit();
			mPreloader.onUpdate(loaded,total);
			nme.Lib.current.addEventListener (nme.events.Event.ENTER_FRAME, onEnter);
			
		}
		
		
		
		haxe.Log.trace = flashTrace; // null
		

		if (call_real)
			begin ();
	}

	
	private static function flashTrace( v : Dynamic, ?pos : haxe.PosInfos ) {
		var className = pos.className.substr(pos.className.lastIndexOf('.') + 1);
		var message = className+"::"+pos.methodName+":"+pos.lineNumber+": " + v;

        if (flash.external.ExternalInterface.available)
			flash.external.ExternalInterface.call("console.log", message);
		else untyped flash.Boot.__trace(v, pos);
    }
	
	
	private static function begin () {
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields(com.prac.ld25.Main))
		{
			if (methodName == "main")
			{
				hasMain = true;
				break;
			}
		}
		
		if (hasMain)
		{
			Reflect.callMethod (com.prac.ld25.Main, Reflect.field (com.prac.ld25.Main, "main"), []);
		}
		else
		{
			nme.Lib.current.addChild(cast (Type.createInstance(com.prac.ld25.Main, []), nme.display.DisplayObject));	
		}
		
	}

	static function onEnter (_) {
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		mPreloader.onUpdate(loaded,total);
		
		if (loaded >= total) {
			
			nme.Lib.current.removeEventListener(nme.events.Event.ENTER_FRAME, onEnter);
			mPreloader.addEventListener (Event.COMPLETE, preloader_onComplete);
			mPreloader.onLoaded();
			
		}
		
	}

	public static function getAsset (inName:String):Dynamic {
		
		
		if (inName=="assets/col_corridor.png")
			 
            return Assets.getBitmapData ("assets/col_corridor.png");
         
		
		if (inName=="assets/col_reception.png")
			 
            return Assets.getBitmapData ("assets/col_reception.png");
         
		
		if (inName=="assets/col_room.png")
			 
            return Assets.getBitmapData ("assets/col_room.png");
         
		
		if (inName=="assets/LIB/bitch_theme.mp3")
			 
            return Assets.getSound ("assets/LIB/bitch_theme.mp3");
		 
		
		if (inName=="assets/LIB/bottle.png")
			 
            return Assets.getBitmapData ("assets/LIB/bottle.png");
         
		
		if (inName=="assets/LIB/couloir.png")
			 
            return Assets.getBitmapData ("assets/LIB/couloir.png");
         
		
		if (inName=="assets/LIB/heroe.png")
			 
            return Assets.getBitmapData ("assets/LIB/heroe.png");
         
		
		if (inName=="assets/LIB/Justin.png")
			 
            return Assets.getBitmapData ("assets/LIB/Justin.png");
         
		
		if (inName=="assets/LIB/key_blue.png")
			 
            return Assets.getBitmapData ("assets/LIB/key_blue.png");
         
		
		if (inName=="assets/LIB/key_gold.png")
			 
            return Assets.getBitmapData ("assets/LIB/key_gold.png");
         
		
		if (inName=="assets/LIB/key_green.png")
			 
            return Assets.getBitmapData ("assets/LIB/key_green.png");
         
		
		if (inName=="assets/LIB/key_red.png")
			 
            return Assets.getBitmapData ("assets/LIB/key_red.png");
         
		
		if (inName=="assets/LIB/reception.png")
			 
            return Assets.getBitmapData ("assets/LIB/reception.png");
         
		
		if (inName=="assets/LIB/room.png")
			 
            return Assets.getBitmapData ("assets/LIB/room.png");
         
		
		if (inName=="assets/LIB/tabouret.png")
			 
            return Assets.getBitmapData ("assets/LIB/tabouret.png");
         
		
		if (inName=="assets/LIB/Title_LD25.mp3")
			 
            return Assets.getSound ("assets/LIB/Title_LD25.mp3");
		 
		
		if (inName=="assets/UI/bg_ui.png")
			 
            return Assets.getBitmapData ("assets/UI/bg_ui.png");
         
		
		if (inName=="assets/UI/btn_look.png")
			 
            return Assets.getBitmapData ("assets/UI/btn_look.png");
         
		
		if (inName=="assets/UI/btn_next.png")
			 
            return Assets.getBitmapData ("assets/UI/btn_next.png");
         
		
		if (inName=="assets/UI/btn_pick.png")
			 
            return Assets.getBitmapData ("assets/UI/btn_pick.png");
         
		
		if (inName=="assets/UI/btn_prev.png")
			 
            return Assets.getBitmapData ("assets/UI/btn_prev.png");
         
		
		if (inName=="assets/UI/btn_talk.png")
			 
            return Assets.getBitmapData ("assets/UI/btn_talk.png");
         
		
		if (inName=="assets/UI/btn_use.png")
			 
            return Assets.getBitmapData ("assets/UI/btn_use.png");
         
		
		if (inName=="assets/UI/btn_walk.png")
			 
            return Assets.getBitmapData ("assets/UI/btn_walk.png");
         
		
		if (inName=="assets/UI/dialog.png")
			 
            return Assets.getBitmapData ("assets/UI/dialog.png");
         
		
		if (inName=="assets/vgafix.ttf")
			 
			 return Assets.getFont ("assets/vgafix.ttf");
		 
		
		
		return null;
		
	}
	
	
	private static function preloader_onComplete (event:Event):Void {
		
		mPreloader.removeEventListener (Event.COMPLETE, preloader_onComplete);
		
		nme.Lib.current.removeChild(mPreloader);
		mPreloader = null;
		
		begin ();
		
	}
	
}


class NME_assets_col_corridor_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_col_reception_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_col_room_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_bitch_theme_mp3 extends nme.media.Sound { }
class NME_assets_lib_bottle_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_couloir_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_heroe_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_justin_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_key_blue_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_key_gold_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_key_green_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_key_red_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_reception_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_room_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_tabouret_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_title_ld25_mp3 extends nme.media.Sound { }
class NME_assets_ui_bg_ui_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_btn_look_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_btn_next_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_btn_pick_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_btn_prev_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_btn_talk_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_btn_use_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_btn_walk_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_dialog_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_vgafix_ttf extends nme.text.Font { }

