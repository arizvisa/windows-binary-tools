#include <APIMiscConstants.au3>
#include <APIResConstants.au3>
#include <GUIConstantsEx.au3>
#include <Memory.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIMisc.au3>
#include <WinAPIRes.au3>

Local Const $sJpg = @TempDir & '\~Tech.jpg'

; Load Resources.dll to memory
Local $hInstance = _WinAPI_LoadLibraryEx(@ScriptDir & '\Extras\Resources.dll', $LOAD_LIBRARY_AS_DATAFILE)
If Not $hInstance Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', @ScriptDir & '\Extras\Resources.dll not found.')
	Exit
EndIf

; Load JPEG resource from Resources.dll library
Local $hResource = _WinAPI_FindResource($hInstance, 'JPEG', 1)
Local $iSize = _WinAPI_SizeOfResource($hInstance, $hResource)
Local $hData = _WinAPI_LoadResource($hInstance, $hResource)
Local $pData = _WinAPI_LockResource($hData)

; Save resource to .jpg file
Local $hFile = FileOpen($sJpg, 2 + 16)
Local $tData = DllStructCreate('byte[' & $iSize & ']', $pData)
FileWrite($hFile, DllStructGetData($tData, 1))
FileClose($hFile)

; Load FONT resource from Resources.dll library
$hResource = _WinAPI_FindResource($hInstance, $RT_FONT, 'TECHNOVIA_CAPS')
$iSize = _WinAPI_SizeOfResource($hInstance, $hResource)
$hData = _WinAPI_LoadResource($hInstance, $hResource)
$pData = _WinAPI_LockResource($hData)

; Add font from a memory to the system
Local $hFont = _WinAPI_AddFontMemResourceEx($pData, $iSize)

; Load SOUND resource from Resources.dll library
$hResource = _WinAPI_FindResource($hInstance, 'SOUND', 1)
$iSize = _WinAPI_SizeOfResource($hInstance, $hResource)
$hData = _WinAPI_LoadResource($hInstance, $hResource)
$pData = _WinAPI_LockResource($hData)

; Copy WAV to memory for use later
Local $hWave = _MemGlobalAlloc($iSize, $GMEM_MOVEABLE)
Local $pWave = _MemGlobalLock($hWave)
_MemMoveMemory($pData, $pWave, $iSize)
; _MemGlobalUnlock($hWave)

; Load STRING resource from Resources.dll library
Local $sText = _WinAPI_LoadString($hInstance, 1)

; Unload Resources.dll from memory
_WinAPI_FreeLibrary($hInstance)

; Create GUI
GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 350, 350)
GUICtrlCreatePic($sJpg, 0, 0, 350, 350)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel($sText, 10, 18, 330, 36, $SS_CENTER)
GUICtrlSetFont(-1, 30, -1, -1, 'Technovia Caps')
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xF06000)
Local $idButton = GUICtrlCreateButton('Play Sound', 125, 316, 100, 23)
GUISetState(@SW_SHOW)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idButton
			_WinAPI_PlaySound($pWave, BitOR($SND_ASYNC, $SND_MEMORY, $SND_NOWAIT))
	EndSwitch
WEnd

; Free resources
_WinAPI_RemoveFontMemResourceEx($hFont)
FileDelete($sJpg)
