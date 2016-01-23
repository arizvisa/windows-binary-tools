#include <APIFilesConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Local $sDevice = 'Z:'
Local Const $sPath = @ScriptDir

If _WinAPI_DefineDosDevice($sDevice, $DDD_RAW_TARGET_PATH, '\DosDevices\' & $sPath) Then
	MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), '', 'The drive "' & $sDevice & '" has been created.' & @CRLF & @CRLF & 'Press OK to release drive.')
EndIf
_WinAPI_DefineDosDevice($sDevice, BitOR($DDD_EXACT_MATCH_ON_REMOVE, $DDD_RAW_TARGET_PATH, $DDD_REMOVE_DEFINITION), '\DosDevices\' & $sPath)
