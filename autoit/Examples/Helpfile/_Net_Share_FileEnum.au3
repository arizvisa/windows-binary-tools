#include <GUIConstantsEx.au3>
#include <NetShare.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $sServer, $aInfo

	; Create GUI
	GUICreate("NetShare", 400, 300)

	; Create memo control
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Get server and share information
	$sServer = InputBox("NetWork Demo", "Enter Server Name:", "\\MyServer", "", 200, 130)
	If @error Then Exit

	; Enumerate open files on the server
	$aInfo = _Net_Share_FileEnum($sServer)
	MemoWrite("Error ...................: " & @error)
	MemoWrite("Entries read ............: " & $aInfo[0][0])
	For $iI = 1 To $aInfo[0][0]
		MemoWrite("Resource ID .............: " & $aInfo[$iI][0])
		MemoWrite("Resource permissions ....: " & _Net_Share_PermStr($aInfo[$iI][1]))
		MemoWrite("Resource locks ..........: " & $aInfo[$iI][2])
		MemoWrite("Resource path ...........: " & $aInfo[$iI][3])
		MemoWrite("Resource user ...........: " & $aInfo[$iI][4])
		MemoWrite()
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
