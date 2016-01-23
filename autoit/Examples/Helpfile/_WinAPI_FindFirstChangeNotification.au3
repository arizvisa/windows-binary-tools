#include <APIFilesConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPIFiles.au3>

Opt('TrayAutoPause', 0)

Global Const $g_sPath = @TempDir & '\~TEST~'

DirCreate($g_sPath)
If Not FileExists($g_sPath) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to create folder.')
	Exit
EndIf
ShellExecute($g_sPath) ; to ease a file creation in this folder

OnAutoItExitRegister('OnAutoItExit')

Global $g_ahObj[2]
$g_ahObj[0] = _WinAPI_FindFirstChangeNotification($g_sPath, $FILE_NOTIFY_CHANGE_FILE_NAME)
$g_ahObj[1] = _WinAPI_FindFirstChangeNotification($g_sPath, $FILE_NOTIFY_CHANGE_DIR_NAME)

If (Not $g_ahObj[0]) Or (Not $g_ahObj[1]) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to create change notification.')
	Exit
EndIf

Local $tObjs = DllStructCreate('ptr;ptr')
Local $paObj = DllStructGetPtr($tObjs)
For $i = 0 To 1
	DllStructSetData($tObjs, $i + 1, $g_ahObj[$i])
Next

Local $iID
While 1
	Sleep(100)
	$iID = _WinAPI_WaitForMultipleObjects(2, $paObj, 0, 0)
	Switch $iID
		Case 0 ; WAIT_OBJECT_0
			ConsoleWrite('A file was created, renamed, or deleted in the directory.' & @CRLF)
		Case 1 ; WAIT_OBJECT_0 + 1
			ConsoleWrite('A directory was created, renamed, or deleted.' & @CRLF)
		Case Else
			ContinueLoop
	EndSwitch
	If Not _WinAPI_FindNextChangeNotification($g_ahObj[$iID]) Then
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unexpected error.')
		Exit
	EndIf
WEnd

Func OnAutoItExit()
	For $i = 0 To 1
		If $g_ahObj[$i] Then
			_WinAPI_FindCloseChangeNotification($g_ahObj[$i])
		EndIf
	Next
	DirRemove($g_sPath, 1)
EndFunc   ;==>OnAutoItExit
