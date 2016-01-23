#include <MsgBoxConstants.au3>

; I am the client, start me after the server! (Start first the TCPAccept example script).

Example()

Func Example()
	TCPStartup() ; Start the TCP service.

	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")

	; Assign Local variables the loopback IP Address and the Port.
	Local $sIPAddress = "127.0.0.1" ; This IP Address only works for testing on your own computer.
	Local $iPort = 65432 ; Port used for the connection.

	; Assign a Local variable the socket and connect to a Listening socket with the IP Address and Port specified.
	Local $iSocket = TCPConnect($sIPAddress, $iPort)

	; If an error occurred display the error code and return False.
	If @error Then
		; The server is probably offline/port is not opened on the server.
		Local $iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Could not connect, Error code: " & $iError)
		Return False
	Else
		MsgBox($MB_SYSTEMMODAL, "", "Connection successful")
	EndIf

	; Close the socket.
	TCPCloseSocket($iSocket)
EndFunc   ;==>Example

Func OnAutoItExit()
	TCPShutdown() ; Close the TCP service.
EndFunc   ;==>OnAutoItExit
