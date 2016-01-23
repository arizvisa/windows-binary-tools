#include <Color.au3>
#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>

Global $g_idLblMsg, $g_hRichEdit

Example()

Func Example()
	Local $hGui, $idBtnNext, $iStep = 0
	$hGui = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 420, 350, -1, -1)
	$g_hRichEdit = _GUICtrlRichEdit_Create($hGui, 'This is a test.', 10, 10, 400, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$g_idLblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$idBtnNext = GUICtrlCreateButton("Next", 270, 310, 60, 30)
	GUISetState(@SW_SHOW)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($g_hRichEdit) ; needed unless script crashes
				GUIDelete()
				Exit
			Case $idBtnNext
				$iStep += 1
				Switch $iStep
					Case 1
						Report("1. Initial setting")
					Case 2
						_GUICtrlRichEdit_SetCharBkColor($g_hRichEdit, Dec('00FF00'))
						Report("2. Setting is now")
					Case 3
						_GUICtrlRichEdit_SetSel($g_hRichEdit, 1, 5)
						_GUICtrlRichEdit_SetCharBkColor($g_hRichEdit, Dec('8888FF'))
						Report("3. Background of a few characters changed")
					Case 4
						; Stream all text to the Desktop so you can look at settings in Word
						_GUICtrlRichEdit_StreamToFile($g_hRichEdit, @DesktopDir & "\gcre.rtf")
						GUICtrlSetState($idBtnNext, $GUI_DISABLE)
						GUICtrlSetData($g_idLblMsg, "4. Saved to a file on the desktop gcre.rtf")
				EndSwitch
		EndSwitch
	WEnd
EndFunc   ;==>Example

Func Report($sMsg)
	Local $iColor = _GUICtrlRichEdit_GetCharBkColor($g_hRichEdit)
	Local $aRet = _ColorGetRGB($iColor)
	$sMsg &= @CRLF & @CRLF & $aRet[0] & ";" & $aRet[1] & ";" & $aRet[2] & " BkColor=0x" & Hex($iColor)
	GUICtrlSetData($g_idLblMsg, $sMsg)
EndFunc   ;==>Report
