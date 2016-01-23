#include <Extras\WMDebug.au3>
#include <GUIConstantsEx.au3>
#include <WinAPIShellEx.au3>

OnAutoItExitRegister('OnAutoItExit')

; Create GUI
Global $g_hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'))

; Register DLL callback that will be used as window subclass procedure
Global $g_hDll = DllCallbackRegister('_SubclassProc', 'lresult', 'hwnd;uint;wparam;lparam;uint_ptr;dword_ptr')
Global $g_pDll = DllCallbackGetPtr($g_hDll)

; Install window subclass callback
_WinAPI_SetWindowSubclass($g_hForm, $g_pDll, 1000, 0)

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _SubclassProc($hWnd, $iMsg, $wParam, $lParam, $iID, $pData)
	#forceref $iID, $pData
	; Declared in WMDebug.au3
	_WM_Debug($hWnd, $iMsg, $wParam, $lParam)
	Return _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_SubclassProc

Func OnAutoItExit()
	_WinAPI_RemoveWindowSubclass($g_hForm, $g_pDll, 1000)
	DllCallbackFree($g_hDll)
EndFunc   ;==>OnAutoItExit
