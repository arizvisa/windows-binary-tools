#include <MsgBoxConstants.au3>

; COM Test file
;
; Tests the SearchFiles() function of Microsoft Excel

; Example usage:

Local $sResult = SearchFiles("*.ini", 0)

MsgBox($MB_SYSTEMMODAL, "FileSearch Object test", "SearchFiles on '" & @WindowsDir & "\*.ini' resulted in:" & @CRLF & @CRLF & $sResult)

Func SearchFiles($sFileSpec, $iSubdirs = 0)
	Local $sFileList = ""

	Local $oXlApp = ObjCreate("Excel.Application")

	Local $oFileSearch = $oXlApp.FileSearch

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "SearchFiles", "Error opening FileSearch Object")
	Else
		With $oFileSearch
			.NewSearch
			.LookIn = @WindowsDir
			.FileName = $sFileSpec
			.SearchSubFolders = $iSubdirs

			Local $iNumber = .Execute()
			If $iNumber > 0 Then
				For $i = 1 To .FoundFiles.Count
					$sFileList = $sFileList & .FoundFiles($i) & @CRLF
				Next
			EndIf
		EndWith
	EndIf

	; CleanUp - destroying object
	$oFileSearch = ""

	; CleanUp - exiting and destroying object
	$oXlApp.quit
	$oXlApp = ""

	Return $sFileList
EndFunc   ;==>SearchFiles
