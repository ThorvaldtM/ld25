package com.prac.ld25;
import com.prac.ld25.system.Character;
import nme.media.SoundChannel;
import nme.media.SoundTransform;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Settings
{
	static public var GAME_SIZE_H:Int = 600;
	static public var GAME_SIZE_W:Int = 800;
	
	static public var VOLUME:Float = 1;
	static public var COLLISION:Bool =  false;
	static public var TRACE:Bool =  false;
	
	static public var STATE:UInt = 0;
	static public var CHARACTER:Character;
	
	static public function applySound(sound:SoundChannel):Void {
		
		if (sound.soundTransform.volume != Settings.VOLUME) {
			var _transform:SoundTransform = sound.soundTransform;
			_transform.volume = Settings.VOLUME;
			sound.soundTransform = _transform;
		}
	}
	
}
