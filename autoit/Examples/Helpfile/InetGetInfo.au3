#include <InetConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Save the downloaded file to the temporary folder.
	Local $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Download the file in the background with the selected option of 'force a reload from the remote site.'
	Local $hDownload = InetGet("http://www.autoitscript.com/autoit3/files/beta/update.dat", $sFilePath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)

	; Wait for the download to complete by monitoring when the 2nd index value of InetGetInfo returns True.
	Do
		Sleep(250)
	Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE)

	; Retrieve details about the download file.
	Local $aData = InetGetInfo($hDownload)
	If @error Then
		FileDelete($sFilePath)
		Return False ; If an error occurred then return from the function and delete the file.
	EndIf

	; Close the handle returned by InetGet.
	InetClose($hDownload)

	; Display details about the downloaded file.
	MsgBox($MB_SYSTEMMODAL, "", "Bytes read: " & $aData[$INET_DOWNLOADREAD] & @CRLF & _
			"Size: " & $aData[$INET_DOWNLOADSIZE] & @CRLF & _
			"Complete: " & $aData[$INET_DOWNLOADCOMPLETE] & @CRLF & _
			"successful: " & $aData[$INET_DOWNLOADSUCCESS] & @CRLF & _
			"@error: " & $aData[$INET_DOWNLOADERROR] & @CRLF & _
			"@extended: " & $aData[$INET_DOWNLOADEXTENDED] & @CRLF)

	; Delete the file.
	FileDelete($sFilePath)
EndFunc   ;==>Example
