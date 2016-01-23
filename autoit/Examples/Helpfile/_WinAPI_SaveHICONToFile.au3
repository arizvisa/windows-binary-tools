#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>

Local $aIcon[3] = [48, 32, 16]

For $i = 0 To UBound($aIcon) - 1
	$aIcon[$i] = _WinAPI_Create32BitHICON(_WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 32, $aIcon[$i], $aIcon[$i]), 1)
Next
_WinAPI_SaveHICONToFile(@TempDir & '\MyIcon.ico', $aIcon)
For $i = 0 To UBound($aIcon) - 1
	_WinAPI_DestroyIcon($aIcon[$i])
Next

ShellExecute('mspaint', '"' & @TempDir & '\MyIcon.ico' & '"')
