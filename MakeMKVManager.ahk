#Include ImageFileHandler.ahk
#Include StateHandler.ahk

class MakeMKVManager
{
	__New()
	{
		this.actionbuttons	:= ImageFileHandler.getArrayOfImages("buttonImages")
		this.stateHandler	:= new StateHandler()
		this.counter		:= 1
	}
		
	takeActionBasedOnCurrentState()
	{
		currentStatus := this.stateHandler.getCurrentState()
		;MsgBox % "Current Status: " currentStatus
		try {
			return this[currentStatus]()
		} catch e {
			MsgBox % "Error: " currentStatus " is not a callable method | " e
		}
		
		return 0
	}
	
	NONE()
	{
		; MsgBox % "Error: Unable to determine currect state"
		
		return 0
	}
	
	EJECTED()
	{
		SoundBeep, 500, 1000
		Sleep 10
		SoundBeep, 500, 1000
		Sleep 10
		SoundBeep, 500, 1000
		Sleep 10
		Sleep 1 * 1000 ; ms
		return 1
	}
	
	SPINNING()
	{
		Sleep 1000 ; ms
		return 1
	}
	
	READY_TO_LOAD()
	{
		return this.clickButton("LOAD")
	}
	
	LOADING()
	{
		Sleep 1000 ; ms
		return 1
	}
	
	READY()
	{
		;MsgBox % "About to click RIP"
		
		if(this.clickButton("SELECT_TITLE_FIELD")){
			suffix := this.counter
			Send, {End}_%suffix%
			this.counter := this.counter + 1
		}
		
		if(this.clickButton("RIP")){
			Send, {Space}
			return 1
		}
		
		MsgBox % "Error: In READY state but unable to click button to Rip disc"
		
		return 0
	}
	
	RIPPING()
	{
		Sleep 1000 ; ms
		return 1
	}
		
	COMPLETE()
	{
		Send, {Space}
		Drive, Eject
		return 1
	}
	
	clickButton(buttonName) {
		WinGetActiveStats, Title, Width, Height, X, Y
		
		imageLocation := this.actionbuttons[buttonName]
		
		;MsgBox % imageLocation
		
		try {
			ImageSearch, FoundX, FoundY, 0, 0, %Width%, %Height%,*130 %imageLocation%
		} catch e {
			MsgBox, ERROR: %ErrorLevel%, %FoundX%, %FoundY%, %Width%, %Height%, %e%
		}

		if (ErrorLevel = 0) {
			Click, %FoundX% %FoundY%
			return 1
		} else {
			MsgBox, Not Found: %ErrorLevel%, this.actionbuttons[%buttonName%]
			return 0
		}
	}
}