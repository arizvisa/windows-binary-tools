#include <GuiAVI.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hAVI

	; Create GUI
	$hGUI = GUICreate("(External) AVI OpenEx", 300, 100)
	$hAVI = _GUICtrlAVI_Create($hGUI, "", -1, 10, 10)
	GUISetState(@SW_SHOW)

	; Play the sample AutoIt AVI
	_GUICtrlAVI_OpenEx($hAVI, @SystemDir & "\Shell32.dll", 150)

	; Play the sample AutoIt AVI
	_GUICtrlAVI_Play($hAVI)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Close AVI clip
	_GUICtrlAVI_Close($hAVI)

	GUIDelete()
EndFunc   ;==>Example
