#include <MsgBoxConstants.au3>

; X64 running support
Local $sWow64 = ""
If @AutoItX64 Then $sWow64 = "\Wow6432Node"

Local $sVar = ""

For $i = 1 To 100
	$sVar = RegEnumVal("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", $i)
	If @error <> 0 Then ExitLoop
	MsgBox($MB_SYSTEMMODAL, "Value Name  #" & $i & " under in AutoIt3 key", $sVar)
Next
