#include <MsgBoxConstants.au3>

; COM Test File
;
; Scripting.FileSystemObject example

; This example returns file information for AutoIt.exe

Local $oFS = ObjCreate("Scripting.FileSystemObject")

Local $sPath = @AutoItExe

Local $oFile = $oFS.GetFile($sPath)

With $oFile

	MsgBox($MB_SYSTEMMODAL, $sPath, _
			@AutoItExe & " " & @CRLF & _
			"File Version: " & $oFS.GetFileVersion($sPath) & @CRLF & _
			"File Size: " & Round((.Size / 1024), 2) & " KB" & @CRLF & _
			"Date Created: " & .DateCreated & @CRLF & _
			"Date Last Modified: " & .DateLastModified)

EndWith
