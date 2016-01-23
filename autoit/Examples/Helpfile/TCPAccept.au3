#include <MsgBoxConstants.au3>

; I am the server, start me first! (Start in second the TCPConnect example script).

Example()

Func Example()
	TCPStartup() ; Start the TCP service.

	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")

	; Assign Local variables the loopback IP Address and the Port.
	Local $sIPAddress = "127.0.0.1" ; This IP Address only works for testing on your own computer.
	Local $iPort = 65432 ; Port used for the connection.

	; Bind to the IP Address and Port specified with a maximum of 100 pending connexions
	;(Take a look at the example of this function for further details).
	Local $iListenSocket = TCPListen($sIPAddress, $iPort, 100)
	Local $iError = 0

	; If an error occurred display the error code and return False.
	If @error Then
		; Someone is probably already listening on this IP Address and Port (script already running?).
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Could not listen, Error code: " & $iError)
		Return False
	EndIf

	; Assign Local variable to be used by Listening and Client sockets.
	Local $iSocket = 0
	Do ; Wait for someone to connect (Unlimited).
		; Accept incomming connexions if present (Socket to close when finished; one socket per client).
		$iSocket = TCPAccept($iListenSocket)

		; If an error occurred display the error code and return False.
		If @error Then
			$iError = @error
			MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Could not accept the incoming connection, Error code: " & $iError)
			Return False
		EndIf
	Until $iSocket <> -1 ;if different from -1 a client is connected.

	; Close the Listening socket to allow afterward binds.
	TCPCloseSocket($iListenSocket)

	MsgBox($MB_SYSTEMMODAL, "", "Client Connected.")

	; Close the socket.
	TCPCloseSocket($iSocket)
EndFunc   ;==>Example

Func OnAutoItExit()
	TCPShutdown() ; Close the TCP service.
EndFunc   ;==>OnAutoItExit
