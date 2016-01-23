#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Start the TCP service.
	TCPStartup()

	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")

	; Assign a Local variable the IP address of www.autoitscript.com.
	Local $sIPAddress = TCPNameToIP("www.autoitscript.com")

	; If an error occurred display the error code and return False.
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Error code: " & @error)
		Return False
	Else
		; Display the IP address.
		MsgBox($MB_SYSTEMMODAL, "", "Domain name to IP :" & $sIPAddress)
	EndIf
EndFunc   ;==>Example

Func OnAutoItExit()
	TCPShutdown() ; Close the TCP service.
EndFunc   ;==>OnAutoItExit
