; == Close the UDP service

Example()

Func Example()
	UDPStartup() ; Start the UDP service.

	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")
EndFunc   ;==>Example

Func OnAutoItExit()
	UDPShutdown() ; Close the UDP service.
EndFunc   ;==>OnAutoItExit
