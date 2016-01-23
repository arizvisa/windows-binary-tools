#include <Clipboard.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400, 10, 10, BitOR($GUI_SS_DEFAULT_GUI, $WS_MAXIMIZEBOX, $WS_SIZEBOX), $WS_EX_TOPMOST)
Global $g_idEdit = GUICtrlCreateEdit('', 0, 0, 400, 400, BitOR($GUI_SS_DEFAULT_EDIT, $ES_READONLY))
GUIRegisterMsg($WM_CLIPBOARDUPDATE, 'WM_CLIPBOARDUPDATE')
GUISetState(@SW_SHOW)

_WinAPI_AddClipboardFormatListener($hForm)
_SendMessage($hForm, $WM_CLIPBOARDUPDATE)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_CLIPBOARDUPDATE($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam, $lParam

	_ClipBoard_Open(0)
	GUICtrlSetData($g_idEdit, _ClipBoard_GetData($CF_TEXT))
	_ClipBoard_Close()
	Return 0
EndFunc   ;==>WM_CLIPBOARDUPDATE
