; I am the client, start me after the server! (Start first the example 2 of the TCPSend function).

#include <AutoItConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	TCPStartup() ; Start the TCP service.

	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")

	; Assign Local variables the loopback IP Address and the Port.
	Local $sIPAddress = "127.0.0.1" ; This IP Address only works for testing on your own computer.
	Local $iPort = 65432 ; Port used for the connection.

	; Assign a Local variable the socket and connect to a listening socket with the IP Address and Port specified.
	Local $iSocket = TCPConnect($sIPAddress, $iPort)
	Local $iError = 0

	; If an error occurred display the error code and return False.
	If @error Then
		; The server is probably offline/port is not opened on the server.
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Client:" & @CRLF & "Could not connect, Error code: " & $iError)
		Return False
	EndIf

	; Assign a Local variable the path of the file which will be received.
	Local $sFilePath = FileSaveDialog("Save as", @MyDocumentsDir, "All types (*.*)", BitOR($FD_PATHMUSTEXIST, $FD_PROMPTOVERWRITE))

	; If an error occurred display the error code and return False.
	If @error Then
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONEXCLAMATION), "", "Client:" & @CRLF & "Invalid file chosen, Error code: " & $iError)
		Return False
	EndIf

	; Assign a Local variable the handle of the file opened in binary overwrite mode.
	Local $hFile = FileOpen($sFilePath, BitOR($FO_BINARY, $FO_OVERWRITE))

	; Assign Locales Constant variables the number representing 4 KiB; the binary code for the end of the file and the length of the binary code.
	Local Const $i4KiB = 4096, $bEOF = Binary(@CRLF & "{EOF}"), $iEOFLen = BinaryLen($bEOF)

	; Assign a Local variable the empty binary data which will contain the binary data of the file.
	Local $bData = Binary("")

	; Assign a Local variable to store the length of the data received.
	Local $iDataLen = 0

	; Assign a Local variable a boolean.
	Local $bEOFReached = False

	Do
		$bData = TCPRecv($iSocket, $i4KiB, $TCP_DATA_BINARY)

		; If an error occurred display the error code and return False.
		If @error Then
			$iError = @error
			MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Client:" & @CRLF & "Connection lost, Error code: " & $iError)
			Return False
		EndIf

		$iDataLen = BinaryLen($bData)

		; If nothing is received, retry for the incoming data.
		If $iDataLen = 0 Then ContinueLoop

		; If the end of the file is reached.
		If BinaryMid($bData, 1 + $iDataLen - $iEOFLen, $iEOFLen) = $bEOF Then
			; Strip the EOF code from the file data.
			$bData = BinaryMid($bData, 1, $iDataLen - $iEOFLen)

			; Set the EOFReached to True.
			$bEOFReached = True
		EndIf

		FileWrite($hFile, $bData)
	Until $bEOFReached

	; Close the file handle.
	FileClose($hFile)

	; Display the successful message.
	MsgBox($MB_SYSTEMMODAL, "", "Client:" & @CRLF & "File received.")

	; Close the socket.
	TCPCloseSocket($iSocket)
EndFunc   ;==>Example

Func OnAutoItExit()
	TCPShutdown() ; Close the TCP service.
EndFunc   ;==>OnAutoItExit
