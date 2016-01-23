#include <APIShellExConstants.au3>
#include <WinAPIShellEx.au3>

Local Const $sDll = @SystemDir & '\comctl32.dll'

Local $sText
Local $aData = _WinAPI_DllGetVersion($sDll)
Switch @error
	Case 0
		Switch $aData[3]
			Case $DLLVER_PLATFORM_WINDOWS
				$sText = 'Windows 95/98'
			Case $DLLVER_PLATFORM_NT
				$sText = 'NT-based'
			Case Else
				$sText = 'Unknown platform'
		EndSwitch
		ConsoleWrite($sDll & ' => ' & $aData[0] & '.' & $aData[1] & '.' & $aData[2] & ' (' & $sText & ')' & @CRLF)
	Case 3
		ConsoleWrite('DllGetVersion not implemented in ' & $sDll & '.' & @CRLF)
	Case Else
		ConsoleWrite('Unable to retrieve version information.' & @CRLF)
EndSwitch
