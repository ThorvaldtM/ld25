package nme.installer;


import nme.display.BitmapData;
import nme.media.Sound;
import nme.net.URLRequest;
import nme.text.Font;
import nme.utils.ByteArray;
import ApplicationMain;


/**
 * ...
 * @author Joshua Granick
 */

class Assets {

	
	public static var cachedBitmapData:Hash<BitmapData> = new Hash<BitmapData>();
	
	private static var initialized:Bool = false;
	private static var resourceClasses:Hash <Dynamic> = new Hash <Dynamic> ();
	private static var resourceTypes:Hash <String> = new Hash <String> ();
	
	
	private static function initialize ():Void {
		
		if (!initialized) {
			
			resourceClasses.set ("assets/col_corridor.png", NME_assets_col_corridor_png);
			resourceTypes.set ("assets/col_corridor.png", "image");
			resourceClasses.set ("assets/col_reception.png", NME_assets_col_reception_png);
			resourceTypes.set ("assets/col_reception.png", "image");
			resourceClasses.set ("assets/col_room.png", NME_assets_col_room_png);
			resourceTypes.set ("assets/col_room.png", "image");
			resourceClasses.set ("assets/LIB/bitch_theme.mp3", NME_assets_lib_bitch_theme_mp3);
			resourceTypes.set ("assets/LIB/bitch_theme.mp3", "music");
			resourceClasses.set ("assets/LIB/bottle.png", NME_assets_lib_bottle_png);
			resourceTypes.set ("assets/LIB/bottle.png", "image");
			resourceClasses.set ("assets/LIB/couloir.png", NME_assets_lib_couloir_png);
			resourceTypes.set ("assets/LIB/couloir.png", "image");
			resourceClasses.set ("assets/LIB/douche.png", NME_assets_lib_douche_png);
			resourceTypes.set ("assets/LIB/douche.png", "image");
			resourceClasses.set ("assets/LIB/groom1.png", NME_assets_lib_groom1_png);
			resourceTypes.set ("assets/LIB/groom1.png", "image");
			resourceClasses.set ("assets/LIB/groom2.png", NME_assets_lib_groom2_png);
			resourceTypes.set ("assets/LIB/groom2.png", "image");
			resourceClasses.set ("assets/LIB/groom3.png", NME_assets_lib_groom3_png);
			resourceTypes.set ("assets/LIB/groom3.png", "image");
			resourceClasses.set ("assets/LIB/groom4.png", NME_assets_lib_groom4_png);
			resourceTypes.set ("assets/LIB/groom4.png", "image");
			resourceClasses.set ("assets/LIB/heroe.png", NME_assets_lib_heroe_png);
			resourceTypes.set ("assets/LIB/heroe.png", "image");
			resourceClasses.set ("assets/LIB/jump.png", NME_assets_lib_jump_png);
			resourceTypes.set ("assets/LIB/jump.png", "image");
			resourceClasses.set ("assets/LIB/Justin.png", NME_assets_lib_justin_png);
			resourceTypes.set ("assets/LIB/Justin.png", "image");
			resourceClasses.set ("assets/LIB/key_blue.png", NME_assets_lib_key_blue_png);
			resourceTypes.set ("assets/LIB/key_blue.png", "image");
			resourceClasses.set ("assets/LIB/key_gold.png", NME_assets_lib_key_gold_png);
			resourceTypes.set ("assets/LIB/key_gold.png", "image");
			resourceClasses.set ("assets/LIB/key_green.png", NME_assets_lib_key_green_png);
			resourceTypes.set ("assets/LIB/key_green.png", "image");
			resourceClasses.set ("assets/LIB/key_red.png", NME_assets_lib_key_red_png);
			resourceTypes.set ("assets/LIB/key_red.png", "image");
			resourceClasses.set ("assets/LIB/lighter.png", NME_assets_lib_lighter_png);
			resourceTypes.set ("assets/LIB/lighter.png", "image");
			resourceClasses.set ("assets/LIB/marlene.png", NME_assets_lib_marlene_png);
			resourceTypes.set ("assets/LIB/marlene.png", "image");
			resourceClasses.set ("assets/LIB/reception.png", NME_assets_lib_reception_png);
			resourceTypes.set ("assets/LIB/reception.png", "image");
			resourceClasses.set ("assets/LIB/room.png", NME_assets_lib_room_png);
			resourceTypes.set ("assets/LIB/room.png", "image");
			resourceClasses.set ("assets/LIB/tabouret.png", NME_assets_lib_tabouret_png);
			resourceTypes.set ("assets/LIB/tabouret.png", "image");
			resourceClasses.set ("assets/LIB/Title_LD25.mp3", NME_assets_lib_title_ld25_mp3);
			resourceTypes.set ("assets/LIB/Title_LD25.mp3", "music");
			resourceClasses.set ("assets/UI/bg_ui.png", NME_assets_ui_bg_ui_png);
			resourceTypes.set ("assets/UI/bg_ui.png", "image");
			resourceClasses.set ("assets/UI/btn_look.png", NME_assets_ui_btn_look_png);
			resourceTypes.set ("assets/UI/btn_look.png", "image");
			resourceClasses.set ("assets/UI/btn_next.png", NME_assets_ui_btn_next_png);
			resourceTypes.set ("assets/UI/btn_next.png", "image");
			resourceClasses.set ("assets/UI/btn_pick.png", NME_assets_ui_btn_pick_png);
			resourceTypes.set ("assets/UI/btn_pick.png", "image");
			resourceClasses.set ("assets/UI/btn_prev.png", NME_assets_ui_btn_prev_png);
			resourceTypes.set ("assets/UI/btn_prev.png", "image");
			resourceClasses.set ("assets/UI/btn_talk.png", NME_assets_ui_btn_talk_png);
			resourceTypes.set ("assets/UI/btn_talk.png", "image");
			resourceClasses.set ("assets/UI/btn_use.png", NME_assets_ui_btn_use_png);
			resourceTypes.set ("assets/UI/btn_use.png", "image");
			resourceClasses.set ("assets/UI/btn_walk.png", NME_assets_ui_btn_walk_png);
			resourceTypes.set ("assets/UI/btn_walk.png", "image");
			resourceClasses.set ("assets/UI/dialog.png", NME_assets_ui_dialog_png);
			resourceTypes.set ("assets/UI/dialog.png", "image");
			resourceClasses.set ("assets/vgafix.ttf", NME_assets_vgafix_ttf);
			resourceTypes.set ("assets/vgafix.ttf", "font");
			
			initialized = true;
			
		}
		
	}
	
	
	public static function getBitmapData (id:String, useCache:Bool = true):BitmapData {
		
		initialize ();
		
		if (resourceTypes.exists (id) && resourceTypes.get (id) == "image") {
			
			if (useCache && cachedBitmapData.exists (id)) {
				
				return cachedBitmapData.get (id);
				
			} else {
				
				var data = cast (Type.createInstance (resourceClasses.get (id), []), BitmapData);
				
				if (useCache) {
					
					cachedBitmapData.set (id, data);
					
				}
				
				return data;
				
			}
			
		} else {
			
			trace ("[nme.Assets] There is no BitmapData asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getBytes (id:String):ByteArray {
		
		initialize ();
		
		if (resourceClasses.exists (id)) {
			
			return Type.createInstance (resourceClasses.get (id), []);
			
		} else {
			
			trace ("[nme.Assets] There is no ByteArray asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getFont (id:String):Font {
		
		initialize ();
		
		if (resourceTypes.exists (id) && resourceTypes.get (id) == "font") {
			
			return cast (Type.createInstance (resourceClasses.get (id), []), Font);
			
		} else {
			
			trace ("[nme.Assets] There is no Font asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getSound (id:String):Sound {
		
		initialize ();
		
		if (resourceTypes.exists (id)) {
			
			if (resourceTypes.get (id) == "sound" || resourceTypes.get (id) == "music") {
				
				return cast (Type.createInstance (resourceClasses.get (id), []), Sound);
				
			}
			
		}
		
		trace ("[nme.Assets] There is no Sound asset with an ID of \"" + id + "\"");
		
		return null;
		
	}
	
	
	public static function getText (id:String):String {
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
	}
	
	
}