#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUI, $idBtn, $idRdo, $idChk

	$hGUI = GUICreate("Buttons", 400, 400)
	$g_idMemo = GUICtrlCreateEdit("", 119, 10, 276, 374, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")

	$idBtn = _GUICtrlButton_Create($hGUI, "Button1", 10, 10, 90, 50)

	$idRdo = _GUICtrlButton_Create($hGUI, "Radio1", 10, 60, 90, 50, BitOR($BS_AUTORADIOBUTTON, $BS_NOTIFY))

	$idChk = _GUICtrlButton_Create($hGUI, "Check1", 10, 120, 90, 50, BitOR($BS_AUTO3STATE, $BS_NOTIFY))

	GUISetState(@SW_SHOW)

	MemoWrite("$idBtn handle: " & $idBtn)
	MemoWrite("$idRdo handle: " & $idRdo)
	MemoWrite("$idChk handle: " & $idChk & @CRLF)

	MsgBox($MB_SYSTEMMODAL, "Information", "About to Destroy Buttons")

	Send("^{END}")

	MemoWrite("Destroyed $idBtn: " & _GUICtrlButton_Destroy($idBtn))
	MemoWrite("Destroyed $idRdo: " & _GUICtrlButton_Destroy($idRdo))
	MemoWrite("Destroyed $idChk: " & _GUICtrlButton_Destroy($idChk) & @CRLF)

	MemoWrite("$idBtn handle: " & $idBtn)
	MemoWrite("$idRdo handle: " & $idRdo)
	MemoWrite("$idChk handle: " & $idChk & @CRLF)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
