#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hImage, $idBtn, $aIdealSize

	GUICreate("Buttons", 400, 400)
	$g_idMemo = GUICtrlCreateEdit("", 119, 10, 276, 374, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")

	$hImage = _GUIImageList_Create(32, 32, 5, 3, 6)
	For $x = 6 To 11
		_GUIImageList_AddIcon($hImage, "shell32.dll", $x, True)
	Next

	$idBtn = GUICtrlCreateButton("Button1", 10, 10, 90, 50)
	_GUICtrlButton_SetImageList($idBtn, $hImage)

	GUISetState(@SW_SHOW)

	$aIdealSize = _GUICtrlButton_GetIdealSize($idBtn)
	MemoWrite("Button1 Ideal width: " & $aIdealSize[0] & " height: " & $aIdealSize[1])

	Sleep(3000)

	MemoWrite(StringFormat("Set Size: %s", _GUICtrlButton_SetSize($idBtn, $aIdealSize[0], $aIdealSize[1])))

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
