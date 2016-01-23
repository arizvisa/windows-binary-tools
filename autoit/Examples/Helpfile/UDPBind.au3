#include <MsgBoxConstants.au3>

Example()

Func Example()
	UDPStartup() ; Start the UDP service.

	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")

	; Assign Local variables the loopback IP Address and the Port.
	Local $sIPAddress = "127.0.0.1" ; This IP Address only works for testing on your own computer.
	Local $iPort = 65532 ; Port used for the connection.

	; Assign a Local variable the socket and bind to the IP Address and Port specified.
	Local $aSocket = UDPBind($sIPAddress, $iPort)

	; If an error occurred display the error code and return False.
	If @error Then
		; Someone is probably already binded on this IP Address and Port (script already running?).
		Local $iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Could not bind, Error code: " & $iError)
		Return False
	Else
		MsgBox($MB_SYSTEMMODAL, "", "Bind successful.")
	EndIf

	; Close the Listening socket to allow afterward binds.
	; While not closed, any other program can NOT bind to the same IP Address and Port.
	UDPCloseSocket($aSocket)
EndFunc   ;==>Example

Func OnAutoItExit()
	UDPShutdown() ; Close the UDP service.
EndFunc   ;==>OnAutoItExit
