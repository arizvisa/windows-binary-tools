#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Read the file without downloading to a folder. The option of 'get the file from the local cache' has been selected.
	Local $dData = InetRead("http://www.autoitscript.com/autoit3/files/beta/update.dat")

	; The number of bytes read is returned using the @extended macro.
	Local $iBytesRead = @extended

	; Convert the ANSI compatible binary string back into a string.
	Local $sData = BinaryToString($dData)

	; Display the results.
	MsgBox($MB_SYSTEMMODAL, "", "The number of bytes read: " & $iBytesRead & @CRLF & @CRLF & $sData)
EndFunc   ;==>Example
