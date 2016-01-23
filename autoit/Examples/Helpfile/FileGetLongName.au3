#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath to retrieve the longname of.
	Local Const $sFilePath = @HomeDrive & "\PROGRA~1" ; Generally this is the same as @ProgramFilesDir.

	; Display the long path+name of the program files directory.
	MsgBox($MB_SYSTEMMODAL, "", FileGetLongName($sFilePath))
EndFunc   ;==>Example
