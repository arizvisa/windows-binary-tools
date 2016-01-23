#include <File.au3>
#include <MsgBoxConstants.au3>

; Generate a unique filename in @TempDir
Local $sTempFile_1 = _TempFile()

; Generate a unique filename in the @HomeDrive directory and starting with the "prefix" labelled prefix_
Local $sTempFile_2 = _TempFile(@HomeDrive & "\", "prefix_", ".txt", Default) ; Use the Default keyword to use the default parameters

MsgBox($MB_SYSTEMMODAL, "", "Names suitable for temporary file usage: " & @CRLF & @CRLF & _
		"File 1: " & $sTempFile_1 & @CRLF & _
		"File 2: " & $sTempFile_2)
