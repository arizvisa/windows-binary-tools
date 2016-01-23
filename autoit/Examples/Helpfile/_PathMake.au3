#include <File.au3>
#include <MsgBoxConstants.au3>

; Create a path.
Local $sFilePath = _PathMake("C:", "\Temp", "Boot", "ini")
MsgBox($MB_SYSTEMMODAL, "", $sFilePath)
