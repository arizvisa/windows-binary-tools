#NoTrayIcon

#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPIFiles.au3>

Opt('WinWaitDelay', 0)

Global Const $g_sTitle = '_WinAPI_MapViewOfFile' & ChrW(160)

If Not $CmdLine[0] Then
	If WinExists($g_sTitle) Then
		Exit
	EndIf
	For $i = 1 To 2
		If Not @Compiled Then
			Run(@AutoItExe & ' "' & @ScriptFullPath & '" /' & $i)
		Else
			Run(@AutoItExe & ' /' & $i)
		EndIf
		Sleep(500)
	Next
	Exit
EndIf

Opt('TrayIconHide', 0)

Switch $CmdLine[1]
	Case '/1'
		_Sender()
	Case '/2'
		_Receiver()
	Case Else
		Exit
EndSwitch

Func _Receiver()
	Local $hMapping = _WinAPI_OpenFileMapping('MyFileMapping')
	If Not $hMapping Then Return

	Local $pAddress = _WinAPI_MapViewOfFile($hMapping)
	Local $tData = DllStructCreate('wchar[1024]', $pAddress)
	Local $sText
	While WinWait($g_sTitle, '', 1)
		Sleep(200)
		$sText = DllStructGetData($tData, 1)
		DllStructSetData($tData, 1, '')
		If $sText Then MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), $g_sTitle & " (receiver)", "                                               " & @CRLF & $sText)
	WEnd
	_WinAPI_UnmapViewOfFile($pAddress)
	_WinAPI_CloseHandle($hMapping)
EndFunc   ;==>_Receiver

Func _Sender()
	Local $hMapping = _WinAPI_CreateFileMapping(-1, 2048, 'MyFileMapping')
	If Not $hMapping Or @extended Then
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to create file mapping (@extended=' & @extended & ').')
		Return
	EndIf

	Local $pAddress = _WinAPI_MapViewOfFile($hMapping)
	Local $tData = DllStructCreate('wchar[1024]', $pAddress)
	Local $sText
	While WinWaitClose($g_sTitle)
		$sText = StringStripWS(InputBox($g_sTitle & " (sender)", 'Type some text message.', '', '', -1, 171), 3)
		If Not $sText Then
			ExitLoop
		EndIf
		DllStructSetData($tData, 1, $sText)
		If Not WinWait($g_sTitle, '', 1) Then
			ExitLoop
		EndIf
	WEnd
	_WinAPI_UnmapViewOfFile($pAddress)
	_WinAPI_CloseHandle($hMapping)
EndFunc   ;==>_Sender
