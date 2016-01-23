#include <GUIConstantsEx.au3>
#include <GuiHeader.au3>
#include <GuiImageList.au3>
#include <WinAPI.au3>

Global $g_idMemo
Example()

Func Example()
	Local $hGUI, $hHeader, $hImage, $iMsg, $aSize, $tPos, $tRECT, $hDC

	; Create GUI
	$hGUI = GUICreate("Header", 400, 300)
	$hHeader = _GUICtrlHeader_Create($hGUI)
	_GUICtrlHeader_SetUnicodeFormat($hHeader, True)
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlHeader_AddItem($hHeader, "Column 1", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 2", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 3", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 4", 100)

	; Create a drag image
	$hImage = _GUICtrlHeader_CreateDragImage($hHeader, 1)
	$aSize = _GUIImageList_GetIconSize($hImage)
	$hDC = _WinAPI_GetDC($hGUI)

	MemoWrite("Image drag Handle: " & "0x" & Hex($hImage))
	MemoWrite("IsPtr  = " & IsPtr($hImage) & " IsHWnd  = " & IsHWnd($hImage))

	; Show drag image at cursor position until user exits
	Do
		$iMsg = GUIGetMsg()
		If $iMsg = $GUI_EVENT_MOUSEMOVE Then
			If $tPos <> 0 Then
				$tRECT = DllStructCreate($tagRECT)
				DllStructSetData($tRECT, "Left", DllStructGetData($tPos, "X"))
				DllStructSetData($tRECT, "Top", DllStructGetData($tPos, "Y"))
				DllStructSetData($tRECT, "Right", DllStructGetData($tPos, "X") + $aSize[0])
				DllStructSetData($tRECT, "Bottom", DllStructGetData($tPos, "Y") + $aSize[1])
				_WinAPI_InvalidateRect($hGUI, $tRECT)
			EndIf
			$tRECT = _WinAPI_GetClientRect($hGUI)
			$tPos = _WinAPI_GetMousePos(True, $hGUI)
			If _WinAPI_PtInRect($tRECT, $tPos) Then
				_GUIImageList_Draw($hImage, 0, $hDC, DllStructGetData($tPos, "X"), DllStructGetData($tPos, "Y"))
			EndIf
		EndIf
	Until $iMsg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
