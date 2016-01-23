; == TCPConnect with timeout

#include <MsgBoxConstants.au3>

; I am the client, start me after the server no more than 10sec ! (The server script is the TCPAccept example script).

Example()

Func Example()
	TCPStartup() ; Start the TCP service.

	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")

	; Assign Local variables the loopback IP Address and the Port.
	Local $sIPAddress = "127.0.0.1" ; This IP Address only works for testing on your own computer.
	Local $iPort = 65432 ; Port used for the connection.

	Opt("TCPTimeout", 1000)
	Local $nMaxTimeout = 10 ; script will abort if no server available after 10 secondes

	Local $iSocket, $iError

	While 1
		; Assign a Local variable the socket and connect to a Listening socket with the IP Address and Port specified.
		$iSocket = TCPConnect($sIPAddress, $iPort)

		; If an error occurred display the error code and return False.
		If @error = 10060 Then
			; Timeout occurs try again
			$nMaxTimeout -= 1
			If $nMaxTimeout < 0 Then
				MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Could not connect, after " & 10 - $nMaxTimeout & " TimeOut")
				Return False
			EndIf
			ContinueLoop
		ElseIf @error Then
			$iError = @error
			; The server is probably offline/port is not opened on the server.
			MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Could not connect, Error code: " & $iError)
			Return False
		Else
			MsgBox($MB_SYSTEMMODAL, "", "Connection successful after " & 10 - $nMaxTimeout & " TimeOut")
			ExitLoop
		EndIf

	WEnd

	; Close the socket.
	TCPCloseSocket($iSocket)
EndFunc   ;==>Example

Func OnAutoItExit()
	TCPShutdown() ; Close the TCP service.
EndFunc   ;==>OnAutoItExit
