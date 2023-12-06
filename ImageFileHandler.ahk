class ImageFileHandler
{
	getArrayOfImages(folder)
	{
		images := {}
		Loop, Files, %A_WorkingDir%\%folder%\*.png
		{
			SplitPath, A_LoopFileLongPath, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
			
			images[OutNameNoExt] := A_LoopFilePath
		}
		
		return images
	}
}