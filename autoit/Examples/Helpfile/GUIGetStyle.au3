#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Example()

Func Example()

	Local $hGUI = GUICreate("Gui Style", 260, 100)
	Local $idBtnStyle = GUICtrlCreateButton("Set Style", 45, 50, 150, 20)

	Local $aGUIStyle = GUIGetStyle($hGUI) ; be careful the style change after opening

	GUISetState(@SW_SHOW)

	Local $bNewStyle = False, $idMsg
	While 1
		$idMsg = GUIGetMsg()
		Switch $idMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idBtnStyle
				If Not $bNewStyle Then
					GUISetStyle(BitOR($WS_POPUPWINDOW, $WS_THICKFRAME), BitOR($WS_EX_CLIENTEDGE, $WS_EX_TOOLWINDOW))
					GUICtrlSetData($idBtnStyle, 'Undo Style')
					$bNewStyle = True
				Else
					GUISetStyle($aGUIStyle[0], $aGUIStyle[1])
					GUICtrlSetData($idBtnStyle, 'Set Style')
					$bNewStyle = False
				EndIf
			Case Else
		EndSwitch
	WEnd

	GUIDelete($hGUI)
EndFunc   ;==>Example
