package com.prac.ld25.tools;
import haxe.Md5;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.DisplayObject;
import nme.display.Sprite;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

/**
 * ...
 * @author Thorvald ter Meer
 */

class AssetLoader
{

	static public function loadAsset(id:String, width:Int, height:Int):Sprite {
		
		var _data:BitmapData = Assets.getBitmapData('assets/' + id);
			var _display:Sprite = new Sprite();
		if (_data == null) {
			var _textFormat:TextFormat = new TextFormat();
			_textFormat.align = TextFormatAlign.CENTER;
			
			var _text:TextField = new TextField();
			_text.defaultTextFormat = _textFormat;
			_text.text = id;
			_text.width = width;
			_text.selectable = false;
			_text.mouseEnabled = false;
			_text.height = (30 < height ) ? 30 : height;
			
			//transform string into color
			var _hash:String = Md5.encode(id);
			var _color:Int = Std.parseInt('0x' + _hash.substr(0, 6));
			_display.graphics.beginFill(_color);
			_display.graphics.drawRect(0, 0, width, height);
			_display.graphics.endFill();
			
			_text.y = (height - _text.height) / 2;
			_display.addChild(_text);
		}else {
			_display.addChild(new Bitmap(_data));
			_display.mouseEnabled = false;
		}
		return _display;
	}
	
}
