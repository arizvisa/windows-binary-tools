#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Example()

Func Example()

	GUICreate("Gui Style", 260, 100)
	Local $idButton = GUICtrlCreateButton("Set Style", 45, 50, 150, 20)
	GUISetState(@SW_SHOW)

	Local $bNewStyle = False, $idMsg
	While 1
		$idMsg = GUIGetMsg()
		Switch $idMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idButton
				If Not $bNewStyle Then
					GUISetStyle(BitOR($WS_POPUPWINDOW, $WS_THICKFRAME), BitOR($WS_EX_CLIENTEDGE, $WS_EX_TOOLWINDOW))
					GUICtrlSetData($idButton, 'Undo Style')
					$bNewStyle = True
				Else
					GUISetStyle(BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU), 0)
					GUICtrlSetData($idButton, 'Set Style')
					$bNewStyle = False
				EndIf
		EndSwitch
	WEnd

	GUIDelete()
EndFunc   ;==>Example
