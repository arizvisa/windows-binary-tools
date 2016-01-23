#include <MsgBoxConstants.au3>
#include <String.au3>

Local $sString = "This is a sample string"
Local $sHex = _StringToHex($sString) ; Convert the string to a hex string.
MsgBox($MB_SYSTEMMODAL, "", "Original String: " & $sString & @CRLF & " Hex: " & $sHex)

$sString = _HexToString($sHex) ; Convert the hex string back to the original string.
MsgBox($MB_SYSTEMMODAL, "", "Original Hex: " & $sHex & @CRLF & "String: " & $sString)
