#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>
#include <WinAPISys.au3>

; Create icon with overlay mask (48x48)
Local $hIcon = _WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 1, 32, 32)
Local $hOverlay
If _WinAPI_GetVersion() >= '6.0' Then
	$hOverlay = _WinAPI_ShellExtractIcon(@SystemDir & '\imageres.dll', 154, 32, 32)
Else
	$hOverlay = _WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 29, 32, 32)
EndIf
Local $hResult = _WinAPI_AddIconOverlay($hIcon, $hOverlay)
_WinAPI_DestroyIcon($hIcon)
_WinAPI_DestroyIcon($hOverlay)

; Create GUI
GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 128, 128)
GUICtrlCreateIcon('', 0, 48, 48, 32, 32)
GUICtrlSendMsg(-1, $STM_SETIMAGE, 1, $hResult)
GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
