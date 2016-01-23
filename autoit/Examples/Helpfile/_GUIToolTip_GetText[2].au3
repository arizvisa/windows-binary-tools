#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Global $g_iPID

; Hover over one of the characters in the Charmap app to get a tooltip to display, then press 'g' to
; retrieve its text information.
HotKeySet('g', "_Read_Tip")

Example()

Func Example()
	; Run character map program
	$g_iPID = Run("charmap.exe")
	; Wait for it to become the active window
	WinWaitActive("Character Map", "", 10)
	While ProcessExists($g_iPID)
		Sleep(100)
	WEnd
EndFunc   ;==>Example

Func _Read_Tip()
	; Get list of tooltips
	Local $aTipList = WinList("[CLASS:tooltips_class32]")
	Local $aRet
	; See which belong to your app
	For $i = 1 To $aTipList[0][0]
		If WinGetProcess($aTipList[$i][1]) = $g_iPID Then
			; See which one is active
			$aRet = _GUIToolTip_GetCurrentTool($aTipList[$i][1])
			; If one is active then display it
			If $aRet[8] <> "" Then MsgBox(0, "Visible Tip", $aRet[8])
		EndIf
	Next
EndFunc   ;==>_Read_Tip
