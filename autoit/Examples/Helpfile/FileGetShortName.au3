#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath to retrieve the shortname of.
	Local Const $sFilePath = @ProgramFilesDir

	; Display the short path+name of the program files directory.
	MsgBox($MB_SYSTEMMODAL, "", FileGetShortName($sFilePath))
EndFunc   ;==>Example
