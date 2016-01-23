#include <MsgBoxConstants.au3>
#include <WinAPIDiag.au3>
#include <WinAPIFiles.au3>
#include <WinAPISys.au3>

Local Const $sTempFile = @TempDir & '\Test.txt'

; Check NTFS file system
If StringCompare(DriveGetFileSystem(_WinAPI_PathStripToRoot($sTempFile)), 'NTFS') Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'The file must be on an NTFS file system volume.')
	Exit
EndIf

Local $sName, $iBytes, $pData, $hFile
; Create text file with three alternative streams named AS1, AS2, and AS3 respectively
For $i = 0 To 3
	If $i Then
		$pData = _WinAPI_CreateString('Alternative stream ' & $i)
		$sName = ':AS' & $i
	Else
		$pData = _WinAPI_CreateString('Main stream')
		$sName = ''
	EndIf
	$hFile = _WinAPI_CreateFile($sTempFile & $sName, 1, 4)
	_WinAPI_WriteFile($hFile, $pData, _WinAPI_GetMemorySize($pData) - 2, $iBytes)
	_WinAPI_CloseHandle($hFile)
	_WinAPI_FreeMemory($pData)
Next

; Enumerate all existing streams in the file and read text data from each stream
$pData = _WinAPI_CreateBuffer(1024)

Local $tFSD = DllStructCreate($tagWIN32_FIND_STREAM_DATA)

Local $hSearch = _WinAPI_FindFirstStream($sTempFile, $tFSD)
Local $iSize
While Not @error
	$sName = DllStructGetData($tFSD, 'StreamName')
	$iSize = DllStructGetData($tFSD, 'StreamSize')
	$hFile = _WinAPI_CreateFile($sTempFile & $sName, 2, 2, 6)
	_WinAPI_ReadFile($hFile, $pData, $iSize, $iBytes)
	_WinAPI_CloseHandle($hFile)
	ConsoleWrite(StringFormat('%10s (%s bytes) - %s', $sName, $iSize, _WinAPI_GetString($pData)) & @CRLF)
	_WinAPI_FindNextStream($hSearch, $tFSD)
WEnd

Switch @extended
	Case 38 ; ERROR_HANDLE_EOF

	Case Else
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), @extended, _WinAPI_GetErrorMessage(@extended))
EndSwitch

_WinAPI_FindClose($hSearch)

_WinAPI_FreeMemory($pData)

FileDelete($sTempFile)
