#include <MsgBoxConstants.au3>

Local $sSubKey = ""
For $i = 1 To 10
	$sSubKey = RegEnumKey("HKEY_LOCAL_MACHINE\SOFTWARE", $i)
	If @error Then ExitLoop
	MsgBox($MB_SYSTEMMODAL, "SubKey #" & $i & " under HKLM\SOFTWARE: ", $sSubKey)
Next
