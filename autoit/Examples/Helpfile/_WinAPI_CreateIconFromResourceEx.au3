#include <APIResConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <WinAPIRes.au3>

; Load Resources.dll to memory
Local $hInstance = _WinAPI_LoadLibraryEx(@ScriptDir & '\Extras\Resources.dll', $LOAD_LIBRARY_AS_DATAFILE)
If Not $hInstance Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', @ScriptDir & '\Extras\Resources.dll not found.')
	Exit
EndIf

; Load RT_GROUP_ICON resource from Resources.dll library
Local $hResource = _WinAPI_FindResource($hInstance, $RT_GROUP_ICON, 1)
Local $hData = _WinAPI_LoadResource($hInstance, $hResource)
Local $pData = _WinAPI_LockResource($hData)

; Search an integer resource name for the icon that best fits the specified size (48x48)
Local $iIcon = _WinAPI_LookupIconIdFromDirectoryEx($pData, 1, 48, 48)

; Load RT_ICON resource from Resources.dll library
$hResource = _WinAPI_FindResource($hInstance, $RT_ICON, $iIcon)
Local $iSize = _WinAPI_SizeOfResource($hInstance, $hResource)
$hData = _WinAPI_LoadResource($hInstance, $hResource)
$pData = _WinAPI_LockResource($hData)

; Create icon from resource
Local $hIcon = _WinAPI_CreateIconFromResourceEx($pData, $iSize)

; Unload Resources.dll from memory
_WinAPI_FreeLibrary($hInstance)

; Create GUI
GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 128, 128)
GUICtrlCreateIcon('', 0, 40, 40, 48, 48)
GUICtrlSendMsg(-1, $STM_SETIMAGE, 1, $hIcon)
GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
