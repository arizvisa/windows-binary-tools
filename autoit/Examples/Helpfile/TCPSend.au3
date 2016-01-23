#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

; Start First clicking on "1. Server"
; Then start a second instance of the script selecting "2. Client"

Example()

Func Example()
	TCPStartup() ; Start the TCP service.

	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")

	; Assign Local variables the loopback IP Address and the Port.
	Local $sIPAddress = "127.0.0.1" ; This IP Address only works for testing on your own computer.
	Local $iPort = 65432 ; Port used for the connection.

	#Region GUI
	Local $sTitle = "TCP Start"
	Local $hGUI = GUICreate($sTitle, 250, 70)

	Local $idBtnServer = GUICtrlCreateButton("1. Server", 65, 10, 130, 22)

	Local $idBtnClient = GUICtrlCreateButton("2. Client", 65, 40, 130, 22)

	GUISetState(@SW_SHOW, $hGUI)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idBtnServer
				WinSetTitle($sTitle, "", "TCP Server started")
				GUICtrlSetState($idBtnClient, $GUI_HIDE)
				GUICtrlSetState($idBtnServer, $GUI_DISABLE)
				If Not MyTCP_Server($sIPAddress, $iPort) Then ExitLoop
			Case $idBtnClient
				WinSetTitle($sTitle, "", "TCP Client started")
				GUICtrlSetState($idBtnServer, $GUI_HIDE)
				GUICtrlSetState($idBtnClient, $GUI_DISABLE)
				If Not MyTCP_Client($sIPAddress, $iPort) Then ExitLoop
		EndSwitch

		Sleep(10)
	WEnd

	#EndRegion GUI
EndFunc   ;==>Example

Func MyTCP_Client($sIPAddress, $iPort)
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

	; Send the string "tata" to the server.
	TCPSend($iSocket, "tata")

	; If an error occurred display the error code and return False.
	If @error Then
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Client:" & @CRLF & "Could not send the data, Error code: " & $iError)
		Return False
	EndIf

	; Close the socket.
	TCPCloseSocket($iSocket)
EndFunc   ;==>MyTCP_Client

Func MyTCP_Server($sIPAddress, $iPort)
	; Assign a Local variable the socket and bind to the IP Address and Port specified with a maximum of 100 pending connexions.
	Local $iListenSocket = TCPListen($sIPAddress, $iPort, 100)
	Local $iError = 0

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

		If GUIGetMsg() = $GUI_EVENT_CLOSE Then Return False
	Until $iSocket <> -1 ;if different from -1 a client is connected.

	; Close the Listening socket to allow afterward binds.
	TCPCloseSocket($iListenSocket)

	; Assign a Local variable the data received.
	Local $sReceived = TCPRecv($iSocket, 4) ;we're waiting for the string "tata" OR "toto" (example script TCPRecv): 4 bytes length.

	; Notes: If you don't know how much length will be the data,
	; use e.g: 2048 for maxlen parameter and call the function until the it returns nothing/error.

	; Display the string received.
	MsgBox($MB_SYSTEMMODAL, "", "Server:" & @CRLF & "Received: " & $sReceived)

	; Close the socket.
	TCPCloseSocket($iSocket)
EndFunc   ;==>MyTCP_Server

Func OnAutoItExit()
	TCPShutdown() ; Close the TCP service.
EndFunc   ;==>OnAutoItExit
