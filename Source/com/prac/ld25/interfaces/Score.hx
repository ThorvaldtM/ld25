package com.prac.ld25.interfaces;
import com.prac.ld25.Settings;
import nme.Assets;
import nme.display.Sprite;
import nme.events.TimerEvent;
import nme.Lib;
import nme.text.AntiAliasType;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import nme.utils.Timer;

/**
 * ...
 * @author Thorvald ter Meer
 */

class Score extends Sprite
{
	private var m_text:TextField;
	private var m_score:Int = 0;
	private var m_feedback:Timer;

	public function new()
	{
		super();
		
		var font:Font = Assets.getFont ("assets/vgafix.ttf");
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.LEFT;
		_textFormat.size = 15;
		_textFormat.font = font.fontName;
		_textFormat.color = 0xFFFFFF;
		m_text = new TextField();
		m_text.antiAliasType = AntiAliasType.ADVANCED;
		m_text.defaultTextFormat = _textFormat;
		m_text.width = 120;
		m_text.height = 30;
		m_text.selectable = false;
		m_text.embedFonts = true;
		m_text.text = "Score :    " + m_score;
		addChild(m_text);
	}
	
	private function get_score():Int
	{
		return m_score;
	}
	
	private function set_score(value:Int):Int
	{
		if(value > 999){
			m_text.text = "Score : " + value;
		}else if (value > 99) {
			m_text.text = "Score :  " + value;
		}else if (value > 9) {
			m_text.text = "Score :   " + value;
		}else {
			m_text.text = "Score :    " + value;
		}
		killFeedback();
		m_text.textColor = 0xFF0000;
		m_feedback = new Timer(150, 6);
		m_feedback.addEventListener(TimerEvent.TIMER, updateFeedback);
		m_feedback.addEventListener(TimerEvent.TIMER_COMPLETE, killFeedback);
		m_feedback.start();
		Settings.SCORE += value;
		return m_score = value;
	}
	
	private function killFeedback(e:TimerEvent = null)
	{
		if (m_feedback != null) {
			m_feedback.removeEventListener(TimerEvent.TIMER, updateFeedback);
			m_feedback.removeEventListener(TimerEvent.TIMER_COMPLETE, killFeedback);
			m_feedback.stop();
			m_feedback = null;
		}
		m_text.textColor = 0xFFFFFF;
	}
	
	private function updateFeedback(e:TimerEvent):Void
	{
		m_text.textColor = (m_feedback.currentCount % 2 == 1) ? 0xFFFFFF : 0xFF0000;
	}
	
	public var score(get_score, set_score):Int;
	
}
