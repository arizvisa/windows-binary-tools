#include <MsgBoxConstants.au3>

; Note: Check the Example 1 to get the useful comments, this example only demonstrates the SocketToIP user-defined function.

; I am the server, start me first! (Start in second the TCPConnect example script).

Example()

Func Example()
	TCPStartup()

	OnAutoItExitRegister("OnAutoItExit")

	Local $sIPAddress = "127.0.0.1"
	Local $iPort = 65432

	Local $iListenSocket = TCPListen($sIPAddress, $iPort, 100)
	Local $iError = 0

	If @error Then
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Could not listen, Error code: " & $iError)
		Return False
	EndIf

	Local $iSocket = 0
	Do
		$iSocket = TCPAccept($iListenSocket)

		If @error Then
			$iError = @error
			MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Could not accept the incoming connection, Error code: " & $iError)
			Return False
		EndIf
	Until $iSocket <> -1

	TCPCloseSocket($iListenSocket)

	; Retrieve the IP Address associated with the accepted socket and assign it to a Local variable.
	Local $sClientIPAddress = SocketToIP($iSocket)

	; Note: The above function does NOT work with the Listen socket, you can also use it with the socket returned by the TCPConnect function.

	; Display the sucessful message with the client IP Address.
	MsgBox($MB_SYSTEMMODAL, "", "Client Connected, IP Address: " & $sClientIPAddress)

	TCPCloseSocket($iSocket)
EndFunc   ;==>Example

Func SocketToIP($iSocket)
	Local $tSockAddr = 0, $aRet = 0
	$tSockAddr = DllStructCreate("short;ushort;uint;char[8]")
	$aRet = DllCall("Ws2_32.dll", "int", "getpeername", "int", $iSocket, "struct*", $tSockAddr, "int*", DllStructGetSize($tSockAddr))
	If Not @error And $aRet[0] = 0 Then
		$aRet = DllCall("Ws2_32.dll", "str", "inet_ntoa", "int", DllStructGetData($tSockAddr, 3))
		If Not @error Then Return $aRet[0]
	EndIf
	Return 0
EndFunc   ;==>SocketToIP

Func OnAutoItExit()
	TCPShutdown() ; Close the TCP service.
EndFunc   ;==>OnAutoItExit
