#Include ImageFileHandler.ahk

class StateHandler
{
	__New()
	{
		this.previousState	:= "NONE"
		this.currentState	:= "NONE"
		this.stateImages	:= ImageFileHandler.getArrayOfImages("stateImages")
	}
	
	getPreviousState()
	{
		return this.previousState
	}
	
	getCurrentState()
	{
		tempCurrentState := "NONE"
		
		For state, imageLocation in this.stateImages {
			;MsgBox % "About to search for: " state " using image " imageLocation
	
			;Gui, Add, Picture,, %imageLocation%
			;Gui, Color, FFFFFF
			;Gui, +LastFound -Caption -AlwaysOnTop +ToolWindow +Border
			;Gui, Show, x100 y100
		
			if(this.isImageVisible(imageLocation)) {
				;MsgBox % "FOUND!"
				tempCurrentState := state
				break
			}
			
			;Gui, Destroy
		}
		
		if(tempCurrentState != this.currentState) {
			this.previousState := this.currentState
			this.currentState := tempCurrentState
		}
		
		return this.currentState
	}
	
	isImageVisible(imageFileLocation)
	{
		;MsgBox % "Searching for: " imageFileLocation
		winactivate ahk_exe makemkv.exe
		WinGetActiveStats, Title, Width, Height, X, Y
		ImageSearch, FoundX, FoundY, 0, 0, %Width%, %Height%,*25 %imageFileLocation%
		
		if(ErrorLevel = 0){
			;Click, %FoundX% %FoundY%
			return 1
		}	

		return 0
	}
}