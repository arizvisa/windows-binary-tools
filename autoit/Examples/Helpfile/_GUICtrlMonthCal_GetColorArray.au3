#include <ColorConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiMonthCal.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $idMonthCal

	; Create GUI
	GUICreate("Month Calendar Get Color Array", 425, 300)
	$idMonthCal = GUICtrlCreateMonthCal("", 4, 4, -1, -1, $WS_BORDER, 0x00000000)

	; Create memo control
	$g_idMemo = GUICtrlCreateEdit("", 4, 168, 417, 128, BitOR($WS_VSCROLL, $ES_MULTILINE))
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUICtrlSendMsg($g_idMemo, $EM_SETREADONLY, True, 0)
	GUICtrlSetBkColor($g_idMemo, 0xFFFFFF)
	GUISetState(@SW_SHOW)

	_GUICtrlMonthCal_SetColor($idMonthCal, $MCSC_MONTHBK, $CLR_MONEYGREEN)

	; Get/Set calendar colors
	MemoWrite(_FormatOutPut("Background color displayed between months:", _GUICtrlMonthCal_GetColorArray($idMonthCal, $MCSC_BACKGROUND)))
	MemoWrite(_FormatOutPut(@CRLF & "Background color displayed within the month:", _GUICtrlMonthCal_GetColorArray($idMonthCal, $MCSC_MONTHBK)))
	MemoWrite(_FormatOutPut(@CRLF & "Color used to display text within a month:", _GUICtrlMonthCal_GetColorArray($idMonthCal, $MCSC_TEXT)))
	MemoWrite(_FormatOutPut(@CRLF & "Background color displayed in the calendar's title:", _GUICtrlMonthCal_GetColorArray($idMonthCal, $MCSC_TITLEBK)))
	MemoWrite(_FormatOutPut(@CRLF & "Color used to display text within the calendar's title:", _GUICtrlMonthCal_GetColorArray($idMonthCal, $MCSC_TITLETEXT)))
	MemoWrite(_FormatOutPut(@CRLF & "Color used to display header day and trailing day text:", _GUICtrlMonthCal_GetColorArray($idMonthCal, $MCSC_TRAILINGTEXT)))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

Func _FormatOutPut($sText, $aColors)
	Return $sText & _
			@CRLF & @TAB & "COLORREF rgbcolor:" & @TAB & $aColors[1] & _
			@CRLF & @TAB & "Hex BGR color:" & @TAB & @TAB & $aColors[2] & _
			@CRLF & @TAB & "Hex RGB color:" & @TAB & @TAB & $aColors[3]
EndFunc   ;==>_FormatOutPut

; Write message to memo
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
