#include <Array.au3>
#include <File.au3>
#include <WinAPIShPath.au3>

Local $sFileList = _FileListToArray(@SystemDir, '*.dll', 1)
Local $aSortList[UBound($sFileList) - 1]
Local $iCount = 0

For $i = 1 To $sFileList[0]
	If _WinAPI_PathMatchSpec($sFileList[$i], 'net*.dll') Then
		$aSortList[$iCount] = $sFileList[$i]
		$iCount += 1
	EndIf
Next
If $iCount Then
	ReDim $aSortList[$iCount]
Else
	Exit
EndIf

_ArrayDisplay($aSortList, '_WinAPI_PathMatchSpec')
