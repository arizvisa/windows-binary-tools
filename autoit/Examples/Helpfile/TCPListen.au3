#include <MsgBoxConstants.au3>

Example()

Func Example()
	TCPStartup() ; Start the TCP service.

	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")

	; Assign Local variables the loopback IP Address and the Port.
	Local $sIPAddress = "127.0.0.1" ; This IP Address only works for testing on your own computer.
	Local $iPort = 65432 ; Port used for the connection.

	; Assign a Local variable the Listening socket and bind to the IP Address and Port specified with a maximum of 100 pending connexions.
	Local $iListenSocket = TCPListen($sIPAddress, $iPort, 100)

	; Notes: You can only listen on private IPs, such as the one used here;
	; or on the range of 192 to 223 (generally 192.168.X.X, use @IPAddress1 to test on your local IP [you will need another computer]).
	; The Listen socket identifier is only used for the TCP Accept function.

	; If an error occurred display the error code and return False.
	If @error Then
		; Someone is probably already listening on this IP Address and Port (script already running?).
		Local $iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Could not listen, Error code: " & $iError)
		Return False
	Else
		MsgBox($MB_SYSTEMMODAL, "", "Listen successful.")
	EndIf

	; Close the Listening socket to allow afterward binds.
	; While not closed, any other program can NOT bind to the same IP Address and Port.
	TCPCloseSocket($iListenSocket)
EndFunc   ;==>Example

Func OnAutoItExit()
	TCPShutdown() ; Close the TCP service.
EndFunc   ;==>OnAutoItExit
