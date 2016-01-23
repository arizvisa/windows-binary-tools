; I am the server, start me first! (Start in second the example 2 of the TCPRecv function).

#include <FileConstants.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local variable the path of a file chosen through a dialog box.
	Local $sFilePath = FileOpenDialog("Select a file to send", @MyDocumentsDir, "All types (*.*)", BitOR($FD_FILEMUSTEXIST, $FD_PATHMUSTEXIST))
	Local $iError = 0

	; Note: Choose a file bigger than 4 kiB otherwise the first example is enough.

	; If an error occurred display the error code and return False.
	If @error Then
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONEXCLAMATION), "", "Server:" & @CRLF & "Invalid file chosen, Error code: " & $iError)
		Return False
	EndIf

	TCPStartup() ; Start the TCP service.

	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")

	; Assign Local variables the loopback IP Address and the Port.
	Local $sIPAddress = "127.0.0.1" ; This IP Address only works for testing on your own computer.
	Local $iPort = 65432 ; Port used for the connection.

	; Assign a Local variable the socket and bind to the IP Address and Port specified with a maximum of 100 pending connexions.
	Local $iListenSocket = TCPListen($sIPAddress, $iPort, 100)

	; If an error occurred display the error code and return False.
	If @error Then
		; Someone is probably already listening on this IP Address and Port (script already running?).
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Server:" & @CRLF & "Could not listen, Error code: " & $iError)
		Return False
	EndIf

	; Assign a Local variable to be used by the Client socket.
	Local $iSocket = 0

	Do ; Wait for someone to connect (Unlimited).
		; Accept incomming connexions if present (Socket to close when finished; one socket per client).
		$iSocket = TCPAccept($iListenSocket)

		; If an error occurred display the error code and return False.
		If @error Then
			$iError = @error
			MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Server:" & @CRLF & "Could not accept the incoming connection, Error code: " & $iError)
			Return False
		EndIf
	Until $iSocket <> -1 ;if different from -1 a client is connected.

	; Close the Listening socket to allow afterward binds.
	TCPCloseSocket($iListenSocket)

	; Assign a Local variable the size of the file previously chosen.
	Local $iFileSize = FileGetSize($sFilePath)

	; Assign a Local variable the handle of the file opened in binary mode.
	Local $hFile = FileOpen($sFilePath, $FO_BINARY)

	; Assign a Local variable the offset of the file being read.
	Local $iOffset = 0

	; Assign a Local variable the number representing 4 KiB.
	Local Const $i4KiB = 4096

	; Note: The file is send by parts of 4 KiB.

	; Send the binary data of the file to the server.
	Do
		; Set the file position to the current offset.
		FileSetPos($hFile, $iOffset, $FILE_BEGIN)

		; The file is read from the position set to 4 KiB and directly wrapped into the TCPSend function.
		TCPSend($iSocket, FileRead($hFile, $i4KiB))

		; If an error occurred display the error code and return False.
		If @error Then
			$iError = @error
			MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Server:" & @CRLF & "Could not send the data, Error code: " & $iError)

			; Close the socket.
			TCPCloseSocket($iSocket)
			Return False
		EndIf

		; Increment the offset of 4 KiB to send the next 4 KiB data.
		$iOffset += $i4KiB
	Until $iOffset >= $iFileSize

	; Close the file handle.
	FileClose($hFile)

	; Tell the client the file is fully sent with a code.
	TCPSend($iSocket, @CRLF & "{EOF}")

	; Display the successful message.
	MsgBox($MB_SYSTEMMODAL, "", "Server:" & @CRLF & "File sent.")

	; Close the socket.
	TCPCloseSocket($iSocket)
EndFunc   ;==>Example

Func OnAutoItExit()
	TCPShutdown() ; Close the TCP service.
EndFunc   ;==>OnAutoItExit
