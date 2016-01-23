#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Local $hGui = GUICreate("trans", 300, 400, -1, -1, -1, $WS_EX_LAYERED)
GUICtrlCreateLabel("This is text on a transparent Layered GUI", 10, 10, 200, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetTip(-1, "Click label to drag layered window")
Local $idLayButt = GUICtrlCreateButton("Button", 10, 40, 40)
GUISetBkColor(0xABCDEF)
_WinAPI_SetLayeredWindowAttributes($hGui, 0x010101)
GUISetState(@SW_SHOW)

Local $hGuicontrol = GUICreate("ControlGUI", 300, 400, 100, 100)
Local $idCheckTrans = GUICtrlCreateCheckbox("Transparent color 0xABCDEF (Checked) Or 0x010101", 10, 10)
Local $idCheckBorder = GUICtrlCreateCheckbox("POPUP-Style", 10, 30)
GUICtrlCreateLabel("Transparency for Layered GUI", 10, 50)
Local $idSlTrans = GUICtrlCreateSlider(10, 70, 200, 30)
GUICtrlSetLimit($idSlTrans, 255, 0)
GUICtrlSetData(-1, 255)
GUISetState(@SW_SHOW)

While 1
	Local $aExtMsg = GUIGetMsg(1)
	Local $iMsg = $aExtMsg[0]
	Switch $aExtMsg[1]
		Case $hGuicontrol
			Select
				Case $iMsg = $GUI_EVENT_CLOSE
					Exit
				Case $iMsg = $idCheckTrans Or $iMsg = $idSlTrans

					; Change Attributes of Trans-Color and Window Transparency

					If BitAND(GUICtrlRead($idCheckTrans), $GUI_CHECKED) = $GUI_CHECKED Then
						_WinAPI_SetLayeredWindowAttributes($hGui, 0xABCDEF, GUICtrlRead($idSlTrans))
					Else
						_WinAPI_SetLayeredWindowAttributes($hGui, 0x010101, GUICtrlRead($idSlTrans))
					EndIf

				Case $iMsg = $idCheckBorder
					If BitAND(GUICtrlRead($idCheckBorder), $GUI_CHECKED) = $GUI_CHECKED Then
						GUISetStyle($WS_POPUP, -1, $hGui)
					Else
						GUISetStyle($GUI_SS_DEFAULT_GUI, -1, $hGui)
					EndIf
			EndSelect
		Case $hGui
			Select
				Case $iMsg = $idLayButt
					Local $iTransColor, $iAlpha
					Local $iInfo = _WinAPI_GetLayeredWindowAttributes($hGui, $iTransColor, $iAlpha)
					MsgBox($MB_SYSTEMMODAL, 'Layered GUI', "Button on layered Window Clicked" & @CRLF & "Information about this window: " & @CRLF & _
							"Transparent Color: " & $iTransColor & @CRLF & _
							"Alpha Value: " & $iAlpha & @CRLF & _
							"LWA_COLORKEY: " & (BitAND($iInfo, $LWA_COLORKEY) = $LWA_COLORKEY) & @CRLF & _
							"LWA_ALPHA: " & (BitAND($iInfo, $LWA_ALPHA) = $LWA_ALPHA))
				Case $iMsg = $GUI_EVENT_CLOSE
					Exit MsgBox($MB_SYSTEMMODAL, '', "Close from Layered GUI")
			EndSelect
	EndSwitch
WEnd
