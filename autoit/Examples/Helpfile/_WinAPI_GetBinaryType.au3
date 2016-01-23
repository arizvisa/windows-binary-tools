#include <APIFilesConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Local $sText, $sPath = @MyDocumentsDir & '\'
While 1
	$sPath = FileOpenDialog('Select File', _WinAPI_PathRemoveFileSpec($sPath), 'All Files (*.*)', 1 + 2)
	If $sPath Then
		If _WinAPI_GetBinaryType($sPath) Then
			Switch @extended
				Case $SCS_32BIT_BINARY
					$sText = '32-bit Windows-based application'
				Case $SCS_64BIT_BINARY
					$sText = '64-bit Windows-based application'
				Case $SCS_DOS_BINARY
					$sText = 'MS-DOS-based application'
				Case $SCS_OS216_BINARY
					$sText = '16-bit OS/2-based application.'
				Case $SCS_PIF_BINARY
					$sText = 'PIF file that executes an MS-DOS-based application'
				Case $SCS_POSIX_BINARY
					$sText = 'POSIX-based application'
				Case $SCS_WOW_BINARY
					$sText = '16-bit Windows-based application'
				Case Else
					$sText = 'unknown executable type'
			EndSwitch
		Else
			$sText = 'not executable file'
		EndIf
		MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), '_WinAPI_GetBinaryType()', '"' & _WinAPI_PathStripPath($sPath) & '" is ' & $sText & ".")
	Else
		ExitLoop
	EndIf
WEnd
