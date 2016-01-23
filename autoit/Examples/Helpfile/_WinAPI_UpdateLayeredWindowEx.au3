#include <GDIPlus.au3>
#include <Misc.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

_GDIPlus_Startup()
Local $hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & '\Extras\Exclamation.png')
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), _GDIPlus_ImageGetWidth($hImage), _GDIPlus_ImageGetHeight($hImage), -1, -1, $WS_POPUPWINDOW, BitOR($WS_EX_LAYERED, $WS_EX_TOPMOST))
Local $hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
_GDIPlus_ImageDispose($hImage)
_GDIPlus_Shutdown()
GUISetState(@SW_SHOW)

Local $iOpacity = 0, $iStep = 3
Do
	_WinAPI_UpdateLayeredWindowEx($hForm, -1, -1, $hBitmap, $iOpacity)
	$iOpacity += $iStep
	If ($iOpacity = 0) Or ($iOpacity = 255) Then
		$iStep = -$iStep
		Sleep(500)
	EndIf
	Sleep(10)
Until _IsPressed('1B')

_WinAPI_DeleteObject($hBitmap)
