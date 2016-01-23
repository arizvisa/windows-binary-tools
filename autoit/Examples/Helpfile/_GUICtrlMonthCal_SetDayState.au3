#include <GUIConstantsEx.au3>
#include <GuiMonthCal.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $idMonthCal

	; Create GUI
	GUICreate("Month Calendar Set Day State", 400, 300)
	$idMonthCal = GUICtrlCreateMonthCal("", 4, 4, -1, -1, BitOR($WS_BORDER, $MCS_DAYSTATE), 0x00000000)

	; Get the number of months that we must supply masks for.  Normally, this number will be 3.
	Local $aMasks[_GUICtrlMonthCal_GetMonthRangeSpan($idMonthCal, True)]

	; Make the 1st, 8th and the 16th of the current month bolded. This results in a binary mask of 1000 0000 1000 0001 or
	; 0x8081 in hex.
	$aMasks[1] = 0x8081
	_GUICtrlMonthCal_SetDayState($idMonthCal, $aMasks)

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
