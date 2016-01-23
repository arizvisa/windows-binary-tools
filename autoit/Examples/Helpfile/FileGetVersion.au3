#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve the file version of the AutoIt executable.
	Local $sFileVersion = FileGetVersion(@AutoItExe)

	; Display the file version. This should be equal to @AutoItVersion.
	MsgBox($MB_SYSTEMMODAL, "", $sFileVersion)
EndFunc   ;==>Example
