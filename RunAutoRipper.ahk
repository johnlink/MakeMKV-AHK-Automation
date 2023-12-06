#SingleInstance Force
#Include StateHandler.ahk
#Include MakeMKVManager.ahk

mkvManager := new MakeMKVManager()

autoRip := 0
errorCount := 0

Loop
If autoRip 
{
	IfWinExist ahk_exe makemkv.exe
		winactivate ahk_exe makemkv.exe
	else
		run, "C:\Program Files (x86)\MakeMKV\makemkv.exe"
		
	autoRip := mkvManager.takeActionBasedOnCurrentState()
	
	; Allow multiple attempts in a row before erroring out
	if(autoRip = 0 && errorCount < 10){
		autoRip := 1
		errorCount := errorCount + 1
	} else {
		errorCount := 0
	}
	
	sleep 500
} else {
	if(errorCount >= 10){
		MsgBox % "AutoRipping Stopped due to ERRORS. Click OK to try again."
	} else {
		MsgBox % "Click Ok to start AutoRipping."
	}
	
	errorCount := 0
	autoRip = 1
}
return


^#k::
{
	autoRip := 0

	return
}