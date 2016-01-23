#include <Array.au3>
#include <File.au3>
#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>

Example()

Func Example()
	Local $sFileList = _FileListToArray(_WinAPI_ShellGetSpecialFolderPath($CSIDL_FONTS), '*.ttf', 1)
	Local $aFontList[UBound($sFileList) - 1][2]

	For $i = 1 To $sFileList[0]
		$aFontList[$i - 1][0] = $sFileList[$i]
		$aFontList[$i - 1][1] = _WinAPI_GetFontResourceInfo($sFileList[$i], 1)
	Next

	_ArrayDisplay($aFontList, '_WinAPI_GetFontResourceInfo')

EndFunc   ;==>Example
