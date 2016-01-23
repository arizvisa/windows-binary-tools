#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPIDiag.au3>
#include <WinAPIFiles.au3>

Local $aList[101][2] = [[0]]

Local $tData = DllStructCreate($tagWIN32_FIND_DATA)

Local $sFile
Local $hSearch = _WinAPI_FindFirstFile(@ScriptDir & '\*', $tData)
While Not @error
	$sFile = DllStructGetData($tData, 'cFileName')
	Switch $sFile
		Case '.', '..'

		Case Else
			If Not BitAND(DllStructGetData($tData, 'dwFileAttributes'), $FILE_ATTRIBUTE_DIRECTORY) Then
				$aList[0][0] += 1
				If $aList[0][0] > UBound($aList) - 1 Then
					ReDim $aList[UBound($aList) + 100][2]
				EndIf
				$aList[$aList[0][0]][0] = $sFile
				$aList[$aList[0][0]][1] = _WinAPI_MakeQWord(DllStructGetData($tData, 'nFileSizeLow'), DllStructGetData($tData, 'nFileSizeHigh'))
			EndIf
	EndSwitch
	_WinAPI_FindNextFile($hSearch, $tData)
WEnd

Switch @extended
	Case 18 ; ERROR_NO_MORE_FILES

	Case Else
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), @extended, _WinAPI_GetErrorMessage(@extended))
		Exit
EndSwitch

_WinAPI_FindClose($hSearch)

_ArrayDisplay($aList, '_WinAPI_Find...', $aList[0][0])
