#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve the size of the file. The option of 'get the file from the local cache' has been selected.
	Local $iSize = InetGetSize("http://www.autoitscript.com/autoit3/files/beta/update.dat")
	MsgBox($MB_SYSTEMMODAL, "", "The size of the file: " & $iSize)
EndFunc   ;==>Example
