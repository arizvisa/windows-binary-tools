#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPILangConstants.au3>

Example()

Func Example()
	Local $iLocale, $idListBox

	; Create GUI
	GUICreate("List Box Set Locale", 400, 296)
	$idListBox = GUICtrlCreateList("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	$iLocale = _WinAPI_MAKELCID(_WinAPI_MAKELANGID($LANG_DUTCH, $SUBLANG_DUTCH), $SORT_DEFAULT)

	MsgBox($MB_SYSTEMMODAL, "Information", "Previous Locale: " & _GUICtrlListBox_SetLocale($idListBox, $iLocale))

	$iLocale = _WinAPI_MAKELCID(_WinAPI_MAKELANGID($LANG_ENGLISH, $SUBLANG_ENGLISH_US), $SORT_DEFAULT)

	MsgBox($MB_SYSTEMMODAL, "Information", "Previous Locale: " & _GUICtrlListBox_SetLocale($idListBox, $iLocale))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
