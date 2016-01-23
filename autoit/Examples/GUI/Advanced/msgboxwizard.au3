; ===============================================================================
;
; Program Name:     MsgBoxWizard()
; Description:      Generate the MessageBox function code according to the user
;                   choices
; Requirement(s):   None
; Return Value(s):  None
; Author(s):        Giuseppe Criaco <gcriaco@quipo.it>
;
; ===============================================================================
;
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_idOptWarning, $g_idOptInfo, $g_idOptCritical, $g_idOptQuestion
Global $g_idOptSysModal, $g_idOptTaskModal
Global $g_idOptOkCancel, $g_idOptYesNo, $g_idOptYesNoCancel, $g_idOptAbortRetryIgnore
Global $g_idOptRetryCancel, $g_idOptCancelRetryContinue, $g_idOptTopMost
Global $g_idOptRightJust, $g_idOptSecond, $g_idOptThird

_Main()

Func _Main()
	Local $iFlag, $idButton, $sMsgBox, $asMsgText
	Local $idTITLE, $idTEXT, $idTimeout, $idOptOK
	Local $idBTNCOPY, $idBTNEXIT, $idBTNPREVIEW, $iMSG, $sText

	GUICreate("MsgBox Wizard v.1.0", 440, 540, 100, 100) ; will create a dialog box

	GUICtrlCreateLabel("Title", 10, 5, 30)
	$idTITLE = GUICtrlCreateInput("", 10, 20, 420, 20)
	GUICtrlSetState(-1, $GUI_FOCUS)
	GUICtrlSetTip(-1, "The title of the message box.")
	GUICtrlCreateLabel("Text", 10, 50, 30)
	$idTEXT = GUICtrlCreateEdit("", 10, 65, 420, 100, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_MULTILINE + $ES_WANTRETURN)
	GUICtrlSetTip(-1, "The text of the message box.")

	GUICtrlCreateGroup("Icons", 10, 170, 200, 130)
	$g_idOptWarning = GUICtrlCreateRadio("Warning", 20, 190, 100, 20)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$g_idOptInfo = GUICtrlCreateRadio("Informational", 20, 210, 100, 20)
	$g_idOptCritical = GUICtrlCreateRadio("Critical", 20, 230, 100, 20)
	$g_idOptQuestion = GUICtrlCreateRadio("Question", 20, 250, 100, 20)
	GUICtrlCreateRadio("None", 20, 270, 100, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group

	GUICtrlCreateGroup("Modality", 10, 310, 200, 90)
	GUICtrlCreateRadio("Application", 20, 330, 100, 20)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$g_idOptSysModal = GUICtrlCreateRadio("System Modal", 20, 350, 100, 20)
	$g_idOptTaskModal = GUICtrlCreateRadio("Task Modal", 20, 370, 100, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group

	GUICtrlCreateGroup("Buttons", 230, 170, 200, 170)
	$idOptOK = GUICtrlCreateRadio("OK", 240, 190, 100, 20)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$g_idOptOkCancel = GUICtrlCreateRadio("OK, Cancel", 240, 210, 100, 20)
	$g_idOptYesNo = GUICtrlCreateRadio("Yes, No", 240, 230, 100, 20)
	$g_idOptYesNoCancel = GUICtrlCreateRadio("Yes, No, Cancel", 240, 250, 100, 20)
	$g_idOptAbortRetryIgnore = GUICtrlCreateRadio("Abort, Retry, Ignore", 240, 270, 120, 20)
	$g_idOptRetryCancel = GUICtrlCreateRadio("Retry, Cancel", 240, 290, 100, 20)
	$g_idOptCancelRetryContinue = GUICtrlCreateRadio("Cancel, Retry, Continue", 240, 310, 130, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group

	GUICtrlCreateGroup("Miscellaneous", 10, 410, 200, 90)
	GUICtrlCreateRadio("Nothing", 20, 430, 100, 20)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$g_idOptTopMost = GUICtrlCreateRadio("Top-most attribute set", 20, 450, 130, 20)
	$g_idOptRightJust = GUICtrlCreateRadio("Right-justified title/text", 20, 470, 150, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group

	GUICtrlCreateGroup("Default Buttons", 230, 350, 200, 90)
	Local $idOptFirst = GUICtrlCreateRadio("First Button", 240, 370, 130, 20)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$g_idOptSecond = GUICtrlCreateRadio("Second Button", 240, 390, 130, 20)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$g_idOptThird = GUICtrlCreateRadio("Third Button", 240, 410, 130, 20)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group

	GUICtrlCreateGroup("Timeout", 230, 450, 200, 50)
	$idTimeout = GUICtrlCreateInput("", 240, 470, 100, 20, $ES_NUMBER)
	GUICtrlSetTip(-1, "Optional Timeout in seconds. After the timeout has elapsed the message box will be automatically closed.")
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group

	$idBTNPREVIEW = GUICtrlCreateButton("&Preview", 10, 510, 100)
	GUICtrlSetTip(-1, "Show the MessageBox")
	$idBTNCOPY = GUICtrlCreateButton("&Copy", 120, 510, 100)
	GUICtrlSetTip(-1, "Copy the generated AutoIt code to the Clipboard")
	$idBTNEXIT = GUICtrlCreateButton("&Exit", 230, 510, 100)
	GUICtrlSetTip(-1, "Quit the program")

	$idButton = $idOptOK

	GUISetState() ; will display an empty dialog box

	; Run the GUI until the dialog is closed
	While 1
		$iMSG = GUIGetMsg()
		Select
			Case $iMSG = $GUI_EVENT_CLOSE Or $iMSG = $idBTNEXIT
				Exit

			Case $iMSG = $idOptOK
				$idButton = $idOptOK
				GUICtrlSetState($idOptFirst, $GUI_CHECKED)
				GUICtrlSetState($idOptFirst, $GUI_ENABLE)
				GUICtrlSetState($g_idOptSecond, $GUI_DISABLE)
				GUICtrlSetState($g_idOptThird, $GUI_DISABLE)

			Case $iMSG = $g_idOptOkCancel
				$idButton = $g_idOptOkCancel
				GUICtrlSetState($idOptFirst, $GUI_CHECKED)
				GUICtrlSetState($idOptFirst, $GUI_ENABLE)
				GUICtrlSetState($g_idOptSecond, $GUI_ENABLE)
				GUICtrlSetState($g_idOptThird, $GUI_DISABLE)

			Case $iMSG = $g_idOptYesNo
				$idButton = $g_idOptYesNo
				GUICtrlSetState($idOptFirst, $GUI_CHECKED)
				GUICtrlSetState($idOptFirst, $GUI_ENABLE)
				GUICtrlSetState($g_idOptSecond, $GUI_ENABLE)
				GUICtrlSetState($g_idOptThird, $GUI_DISABLE)

			Case $iMSG = $g_idOptYesNoCancel
				$idButton = $g_idOptYesNoCancel
				GUICtrlSetState($idOptFirst, $GUI_CHECKED)
				GUICtrlSetState($idOptFirst, $GUI_ENABLE)
				GUICtrlSetState($g_idOptSecond, $GUI_ENABLE)
				GUICtrlSetState($g_idOptThird, $GUI_ENABLE)

			Case $iMSG = $g_idOptAbortRetryIgnore
				$idButton = $g_idOptAbortRetryIgnore
				GUICtrlSetState($idOptFirst, $GUI_CHECKED)
				GUICtrlSetState($idOptFirst, $GUI_ENABLE)
				GUICtrlSetState($g_idOptSecond, $GUI_ENABLE)
				GUICtrlSetState($g_idOptThird, $GUI_ENABLE)

			Case $iMSG = $g_idOptRetryCancel
				$idButton = $g_idOptRetryCancel
				GUICtrlSetState($idOptFirst, $GUI_CHECKED)
				GUICtrlSetState($idOptFirst, $GUI_ENABLE)
				GUICtrlSetState($g_idOptSecond, $GUI_ENABLE)
				GUICtrlSetState($g_idOptThird, $GUI_DISABLE)

			Case $iMSG = $g_idOptCancelRetryContinue
				$idButton = $g_idOptCancelRetryContinue
				GUICtrlSetState($idOptFirst, $GUI_CHECKED)
				GUICtrlSetState($idOptFirst, $GUI_ENABLE)
				GUICtrlSetState($g_idOptSecond, $GUI_ENABLE)
				GUICtrlSetState($g_idOptThird, $GUI_ENABLE)

			Case $iMSG = $idBTNPREVIEW
				MsgBox(_SetFlag($iFlag), GUICtrlRead($idTITLE), GUICtrlRead($idTEXT), GUICtrlRead($idTimeout))

			Case $iMSG = $idBTNCOPY
				$asMsgText = StringSplit(GUICtrlRead($idTEXT), @CRLF, 1)
				If $asMsgText[0] = 1 Then
					$sText = GUICtrlRead($idTEXT)
				Else
					$sText = $asMsgText[1]

					For $iCtr = 2 To $asMsgText[0]
						$sText = $sText & Chr(34) & " & @CRLF & " & Chr(34) & $asMsgText[$iCtr]
					Next

				EndIf

				Select
					Case $idButton = $idOptOK
						If GUICtrlRead($idTimeout) = "" Then
							$sMsgBox = "MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & ")"
						Else
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & "," & GUICtrlRead($idTimeout) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = -1 ;Timeout" & @CRLF & @CRLF & _
									"   Case Else                ;OK" & @CRLF & @CRLF & _
									"EndSelect"
						EndIf

					Case $idButton = $g_idOptOkCancel
						If GUICtrlRead($idTimeout) = "" Then
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 1 ;OK" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 2 ;Cancel" & @CRLF & @CRLF & _
									"EndSelect"
						Else
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & "," & GUICtrlRead($idTimeout) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 1  ;OK" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 2  ;Cancel" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = -1 ;Timeout" & @CRLF & @CRLF & _
									"EndSelect"
						EndIf

					Case $idButton = $g_idOptYesNo
						If GUICtrlRead($idTimeout) = "" Then
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 6 ;Yes" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 7 ;No" & @CRLF & @CRLF & _
									"EndSelect"
						Else
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & "," & GUICtrlRead($idTimeout) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 6  ;Yes" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 7  ;No" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = -1 ;Timeout" & @CRLF & @CRLF & _
									"EndSelect"
						EndIf

					Case $idButton = $g_idOptYesNoCancel
						If GUICtrlRead($idTimeout) = "" Then
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 6 ;Yes" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 7 ;No" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 2 ;Cancel" & @CRLF & @CRLF & _
									"EndSelect"
						Else
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & "," & GUICtrlRead($idTimeout) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 6  ;Yes" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 7  ;No" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 2  ;Cancel" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = -1 ;Timeout" & @CRLF & @CRLF & _
									"EndSelect"
						EndIf

					Case $idButton = $g_idOptAbortRetryIgnore
						If GUICtrlRead($idTimeout) = "" Then
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 3 ;Abort" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 4 ;Retry" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 5 ;Ignore" & @CRLF & @CRLF & _
									"EndSelect"
						Else
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & "," & GUICtrlRead($idTimeout) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 3  ;Abort" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 4  ;Retry" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 5  ;Ignore" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = -1 ;Timeout" & @CRLF & @CRLF & _
									"EndSelect"
						EndIf

					Case $idButton = $g_idOptRetryCancel
						If GUICtrlRead($idTimeout) = "" Then
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 4 ;Retry" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 2 ;Cancel" & @CRLF & @CRLF & _
									"EndSelect"
						Else
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & "," & GUICtrlRead($idTimeout) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 4  ;Retry" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 2  ;Cancel" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = -1 ;Timeout" & @CRLF & @CRLF & _
									"EndSelect"
						EndIf

					Case $idButton = $g_idOptCancelRetryContinue
						If GUICtrlRead($idTimeout) = "" Then
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 2 ;Cancel" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 10 ;Try Again" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 11 ;Continue" & @CRLF & @CRLF & _
									"EndSelect"
						Else
							$sMsgBox = "Dim $iMsgBoxAnswer" & @CRLF & _
									"$iMsgBoxAnswer = MsgBox(" & _SetFlag($iFlag) & "," & Chr(34) & GUICtrlRead($idTITLE) & Chr(34) & "," _
									 & Chr(34) & $sText & Chr(34) & "," & GUICtrlRead($idTimeout) & ")" & @CRLF & _
									"Select" & @CRLF & _
									"   Case $iMsgBoxAnswer = 2  ;Cancel" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 10 ;Try Again" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = 11 ;Continue" & @CRLF & @CRLF & _
									"   Case $iMsgBoxAnswer = -1 ;Timeout" & @CRLF & @CRLF & _
									"EndSelect"
						EndIf
				EndSelect

				ClipPut($sMsgBox)
		EndSelect

	WEnd
EndFunc   ;==>_Main

; ===============================================================================
;
; Function Name:    _SetFlag()
; Description:      Set the flag that indicates the type of message box and the
;                   possible button combinations.
; Parameter(s):     $iFlag        - Flag
; Requirement(s):   None
; Return Value(s):  On Success - Returns the message box flag
;                   None
; Author(s):        Giuseppe Criaco <gcriaco@quipo.it>
;
; ===============================================================================
;

Func _SetFlag($iFlag)
	$iFlag = 0

	;Icons
	Select
		Case GUICtrlRead($g_idOptWarning) = $GUI_CHECKED
			$iFlag = $iFlag + 48
		Case GUICtrlRead($g_idOptInfo) = $GUI_CHECKED
			$iFlag = $iFlag + 64
		Case GUICtrlRead($g_idOptCritical) = $GUI_CHECKED
			$iFlag = $iFlag + 16
		Case GUICtrlRead($g_idOptQuestion) = $GUI_CHECKED
			$iFlag = $iFlag + 32
	EndSelect

	;Modality
	Select
		Case GUICtrlRead($g_idOptSysModal) = $GUI_CHECKED
			$iFlag = $iFlag + 4096
		Case GUICtrlRead($g_idOptTaskModal) = $GUI_CHECKED
			$iFlag = $iFlag + 8192
	EndSelect

	;Buttons
	Select
		Case GUICtrlRead($g_idOptOkCancel) = $GUI_CHECKED
			$iFlag = $iFlag + 1
		Case GUICtrlRead($g_idOptYesNo) = $GUI_CHECKED
			$iFlag = $iFlag + 4
		Case GUICtrlRead($g_idOptYesNoCancel) = $GUI_CHECKED
			$iFlag = $iFlag + 3
		Case GUICtrlRead($g_idOptAbortRetryIgnore) = $GUI_CHECKED
			$iFlag = $iFlag + 2
		Case GUICtrlRead($g_idOptRetryCancel) = $GUI_CHECKED
			$iFlag = $iFlag + 5
		Case GUICtrlRead($g_idOptCancelRetryContinue) = $GUI_CHECKED
			$iFlag = $iFlag + 6
	EndSelect

	;Miscellaneous
	Select
		Case GUICtrlRead($g_idOptTopMost) = $GUI_CHECKED
			$iFlag = $iFlag + 262144
		Case GUICtrlRead($g_idOptRightJust) = $GUI_CHECKED
			$iFlag = $iFlag + 5244288
	EndSelect

	;Default Buttons
	Select
		Case GUICtrlRead($g_idOptSecond) = $GUI_CHECKED
			$iFlag = $iFlag + 256
		Case GUICtrlRead($g_idOptThird) = $GUI_CHECKED
			$iFlag = $iFlag + 512
	EndSelect

	Return $iFlag
EndFunc   ;==>_SetFlag
