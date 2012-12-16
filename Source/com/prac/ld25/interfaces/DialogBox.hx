package com.prac.ld25.interfaces;
import com.prac.ld25.data.DataOption;
import com.prac.ld25.data.DialogData;
import com.prac.ld25.system.DataEvent;
import com.prac.ld25.tools.AssetLoader;
import nme.display.Sprite;
import nme.Assets;
import nme.events.MouseEvent;
import nme.text.AntiAliasType;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

/**
 * ...
 * @author Thorvald ter Meer
 */

class DialogBox extends Sprite
{
	private var m_text_1:TextField;
	private var m_text_2:TextField;
	private var m_text_3:TextField;
	private var m_options:Array<DataOption>;

	public function new(option:Array<DataOption>)
	{
		super();
		this.m_options = option;
		
		var _bg:Sprite = AssetLoader.loadAsset('UI/dialog.png', 390, 140);
		addChild(_bg);
		
		var font:Font = Assets.getFont ("assets/vgafix.ttf");
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.LEFT;
		_textFormat.size = 15;
		_textFormat.font = font.fontName;
		_textFormat.color = 0xFFFFFF;
		m_text_1 = new TextField();
		m_text_1.antiAliasType = AntiAliasType.ADVANCED;
		m_text_1.defaultTextFormat = _textFormat;
		m_text_1.width = 380;
		m_text_1.height = 40;
		m_text_1.selectable = false;
		m_text_1.embedFonts = true;
		m_text_1.wordWrap = true;
		m_text_1.multiline = true;
		m_text_1.backgroundColor = 0x575757;
		if(option.length > 0){
			m_text_1.text = "1. " + option[0].label;
			m_text_1.addEventListener(MouseEvent.ROLL_OVER, highlightOption);
			m_text_1.addEventListener(MouseEvent.ROLL_OUT, unhiglightOption);
			m_text_1.addEventListener(MouseEvent.CLICK, clickOption1);
		}
		m_text_1.y = 5;
		m_text_1.x = 5;
		addChild(m_text_1);
		
		m_text_2 = new TextField();
		m_text_2.antiAliasType = AntiAliasType.ADVANCED;
		m_text_2.defaultTextFormat = _textFormat;
		m_text_2.width = 380;
		m_text_2.height = 40;
		m_text_2.selectable = false;
		m_text_2.embedFonts = true;
		m_text_2.wordWrap = true;
		m_text_2.multiline = true;
		m_text_2.backgroundColor = 0x575757;
		if(option.length > 1){
			m_text_2.text = "2. " + option[1].label;
			m_text_2.addEventListener(MouseEvent.ROLL_OVER, highlightOption);
			m_text_2.addEventListener(MouseEvent.ROLL_OUT, unhiglightOption);
			m_text_2.addEventListener(MouseEvent.CLICK, clickOption2);
		}
		m_text_2.y = 5 + m_text_1.y + m_text_1.height;
		m_text_2.x = 5;
		addChild(m_text_2);
		
		m_text_3 = new TextField();
		m_text_3.antiAliasType = AntiAliasType.ADVANCED;
		m_text_3.defaultTextFormat = _textFormat;
		m_text_3.width = 380;
		m_text_3.height = 40;
		m_text_3.selectable = false;
		m_text_3.embedFonts = true;
		m_text_3.wordWrap = true;
		m_text_3.multiline = true;
		m_text_3.backgroundColor = 0x575757;
		if(option.length > 2){
			m_text_3.text = "3. " + option[2].label;
			m_text_3.addEventListener(MouseEvent.ROLL_OVER, highlightOption);
			m_text_3.addEventListener(MouseEvent.ROLL_OUT, unhiglightOption);
			m_text_3.addEventListener(MouseEvent.CLICK, clickOption3);
		}
		m_text_3.y = 5 + m_text_2.y + m_text_2.height;
		m_text_3.x = 5;
		addChild(m_text_3);
	}
	
	private function clickOption3(e:MouseEvent):Void
	{
		dispatchDialog(2);
	}
	
	private function clickOption2(e:MouseEvent):Void
	{
		dispatchDialog(1);
	}
	
	private function clickOption1(e:MouseEvent):Void
	{
		dispatchDialog(0);
	}
	
	private function highlightOption(e:MouseEvent):Void
	{
		unhiglightOption(null);
		var _target:TextField = cast(e.currentTarget, TextField);
		_target.background = true;
	}
	
	private function unhiglightOption(e:MouseEvent):Void
	{
		m_text_1.background = false;
		m_text_2.background = false;
		m_text_3.background = false;
	}
	
	private function dispatchDialog(index:Int):Void
	{
		var option:DataOption = m_options[index];
		var followUp:DialogData = option.followup;
		if (followUp != null && followUp.special != null && followUp.special.indexOf('remove_option') > -1) {
			m_options.splice(index, 1);
		}
		dispatchEvent(new DataEvent('dialog_choice', false, false, option));
	}
	
}
