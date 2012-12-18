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
         
		
		if (inName=="assets/col_room664.png")
			 
            return Assets.getBitmapData ("assets/col_room664.png");
         
		
		if (inName=="assets/LIB/apuyer.png")
			 
            return Assets.getBitmapData ("assets/LIB/apuyer.png");
         
		
		if (inName=="assets/LIB/bitch_theme.mp3")
			 
            return Assets.getSound ("assets/LIB/bitch_theme.mp3");
		 
		
		if (inName=="assets/LIB/bottle.png")
			 
            return Assets.getBitmapData ("assets/LIB/bottle.png");
         
		
		if (inName=="assets/LIB/chariot.png")
			 
            return Assets.getBitmapData ("assets/LIB/chariot.png");
         
		
		if (inName=="assets/LIB/chickdodospritesheet.png")
			 
            return Assets.getBitmapData ("assets/LIB/chickdodospritesheet.png");
         
		
		if (inName=="assets/LIB/couloir.png")
			 
            return Assets.getBitmapData ("assets/LIB/couloir.png");
         
		
		if (inName=="assets/LIB/dark_guest.png")
			 
            return Assets.getBitmapData ("assets/LIB/dark_guest.png");
         
		
		if (inName=="assets/LIB/douche.png")
			 
            return Assets.getBitmapData ("assets/LIB/douche.png");
         
		
		if (inName=="assets/LIB/groom1.png")
			 
            return Assets.getBitmapData ("assets/LIB/groom1.png");
         
		
		if (inName=="assets/LIB/groom2.png")
			 
            return Assets.getBitmapData ("assets/LIB/groom2.png");
         
		
		if (inName=="assets/LIB/groom3.png")
			 
            return Assets.getBitmapData ("assets/LIB/groom3.png");
         
		
		if (inName=="assets/LIB/groom4.png")
			 
            return Assets.getBitmapData ("assets/LIB/groom4.png");
         
		
		if (inName=="assets/LIB/heroe.png")
			 
            return Assets.getBitmapData ("assets/LIB/heroe.png");
         
		
		if (inName=="assets/LIB/intro.png")
			 
            return Assets.getBitmapData ("assets/LIB/intro.png");
         
		
		if (inName=="assets/LIB/item_bottle.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_bottle.png");
         
		
		if (inName=="assets/LIB/item_Justin.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_Justin.png");
         
		
		if (inName=="assets/LIB/item_key_blue.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_key_blue.png");
         
		
		if (inName=="assets/LIB/item_key_gold.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_key_gold.png");
         
		
		if (inName=="assets/LIB/item_key_green.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_key_green.png");
         
		
		if (inName=="assets/LIB/item_key_red.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_key_red.png");
         
		
		if (inName=="assets/LIB/item_lighter.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_lighter.png");
         
		
		if (inName=="assets/LIB/item_number.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_number.png");
         
		
		if (inName=="assets/LIB/item_tabouret.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_tabouret.png");
         
		
		if (inName=="assets/LIB/item_valium.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_valium.png");
         
		
		if (inName=="assets/LIB/item_water_valium.png")
			 
            return Assets.getBitmapData ("assets/LIB/item_water_valium.png");
         
		
		if (inName=="assets/LIB/jump.png")
			 
            return Assets.getBitmapData ("assets/LIB/jump.png");
         
		
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
         
		
		if (inName=="assets/LIB/lighter.png")
			 
            return Assets.getBitmapData ("assets/LIB/lighter.png");
         
		
		if (inName=="assets/LIB/marlene.png")
			 
            return Assets.getBitmapData ("assets/LIB/marlene.png");
         
		
		if (inName=="assets/LIB/reception.png")
			 
            return Assets.getBitmapData ("assets/LIB/reception.png");
         
		
		if (inName=="assets/LIB/room.png")
			 
            return Assets.getBitmapData ("assets/LIB/room.png");
         
		
		if (inName=="assets/LIB/room664.png")
			 
            return Assets.getBitmapData ("assets/LIB/room664.png");
         
		
		if (inName=="assets/LIB/table.png")
			 
            return Assets.getBitmapData ("assets/LIB/table.png");
         
		
		if (inName=="assets/LIB/tabouret.png")
			 
            return Assets.getBitmapData ("assets/LIB/tabouret.png");
         
		
		if (inName=="assets/LIB/thermometer.png")
			 
            return Assets.getBitmapData ("assets/LIB/thermometer.png");
         
		
		if (inName=="assets/LIB/tiroir.png")
			 
            return Assets.getBitmapData ("assets/LIB/tiroir.png");
         
		
		if (inName=="assets/LIB/title.png")
			 
            return Assets.getBitmapData ("assets/LIB/title.png");
         
		
		if (inName=="assets/LIB/Title_LD25.mp3")
			 
            return Assets.getSound ("assets/LIB/Title_LD25.mp3");
		 
		
		if (inName=="assets/UI/arrow_left.png")
			 
            return Assets.getBitmapData ("assets/UI/arrow_left.png");
         
		
		if (inName=="assets/UI/arrow_left_hover.png")
			 
            return Assets.getBitmapData ("assets/UI/arrow_left_hover.png");
         
		
		if (inName=="assets/UI/arrow_right.png")
			 
            return Assets.getBitmapData ("assets/UI/arrow_right.png");
         
		
		if (inName=="assets/UI/arrow_right_hover.png")
			 
            return Assets.getBitmapData ("assets/UI/arrow_right_hover.png");
         
		
		if (inName=="assets/UI/background_interface.png")
			 
            return Assets.getBitmapData ("assets/UI/background_interface.png");
         
		
		if (inName=="assets/UI/button.png")
			 
            return Assets.getBitmapData ("assets/UI/button.png");
         
		
		if (inName=="assets/UI/button_hover.png")
			 
            return Assets.getBitmapData ("assets/UI/button_hover.png");
         
		
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
class NME_assets_col_room664_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_apuyer_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_bitch_theme_mp3 extends nme.media.Sound { }
class NME_assets_lib_bottle_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_chariot_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_chickdodospritesheet_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_couloir_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_dark_guest_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_douche_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_groom1_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_groom2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_groom3_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_groom4_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_heroe_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_intro_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_bottle_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_justin_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_key_blue_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_key_gold_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_key_green_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_key_red_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_lighter_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_number_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_tabouret_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_valium_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_item_water_valium_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_jump_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_justin_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_key_blue_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_key_gold_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_key_green_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_key_red_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_lighter_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_marlene_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_reception_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_room_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_room664_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_table_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_tabouret_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_thermometer_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_tiroir_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_title_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_title_ld25_mp3 extends nme.media.Sound { }
class NME_assets_ui_arrow_left_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_arrow_left_hover_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_arrow_right_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_arrow_right_hover_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_background_interface_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_button_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_button_hover_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ui_dialog_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_vgafix_ttf extends nme.text.Font { }

