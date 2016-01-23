; COM Test file
;
; Test usage of Events with SAPI
;
; NOTE: To be able to run this example, you must first
;       download and install the Microsoft SAPI SDK 5.1
; http://www.microsoft.com/speech/download/sdk51/
;
; See also: http://www.microsoft.com/speech/techinfo/apioverview/
;
; And..READ the documentation carefully! Speech recognition is very complex stuff !

#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

; Create a simple GUI for our output
GUICreate("Event Speech API Test", 640, 480)
Global $g_idGUIEdit = GUICtrlCreateEdit("Debug Log:" & @CRLF, 10, 10, 600, 400)
GUISetState() ;Show GUI

Local $oRecoContext = ObjCreate("SAPI.SpSharedRecoContext")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "Error opening the 'SAPI.SpSharedRecoContext' object. Error number: " & Hex(@error, 8))
	Exit
EndIf

; Initialize our Event Handler
; Note: The default outgoing event interface will be: _ISpeechRecoContextEvents
Local $oSinkObject = ObjEvent($oRecoContext, "MYEvent_")
If @error Then
	GUICtrlSetData($g_idGUIEdit, "ObjEvent error: " & @error & @CRLF, "append")
Else
	GUICtrlSetData($g_idGUIEdit, "ObjEvent created Successfully!" & @CRLF, "append")

	;Imported from: SAPI.H
	Const $SPRS_INACTIVE = 0
	Const $SPRS_ACTIVE = 1
	Local $iSGDSActive = $SPRS_ACTIVE
	Local $iSGDSInactive = $SPRS_INACTIVE

	Local $oGrammar = $oRecoContext.CreateGrammar(1)
	$oGrammar.DictationLoad
	$oGrammar.DictationSetState($iSGDSActive)

	; Dictation starts here...you may speak now !

	GUICtrlSetData($g_idGUIEdit, "You have 10 seconds speaking time now...open your microphone and say something !" & @CRLF, "append")
	Sleep(10000)

	; Stop dictation
	$oGrammar.DictationSetState($iSGDSInactive)

EndIf

Sleep(5000) ; Some events arrive late...

GUICtrlSetData($g_idGUIEdit, @CRLF & "End of dictation time." & @CRLF, "append")
GUICtrlSetData($g_idGUIEdit, "You may close this window now !" & @CRLF, "append")

; Waiting for user to close the window
Local $iMsg
While 1
	$iMsg = GUIGetMsg()
	If $iMsg = $GUI_EVENT_CLOSE Then ExitLoop
WEnd

GUIDelete()

Exit

; --------------------
; SAPI Event functions

Func MYEvent_StartStream($iStreamNumber, $vStreamPosition)
	#forceref $vStreamPosition
	;     StreamNumber As Long,
	;     StreamPosition As Variant

	GUICtrlSetData($g_idGUIEdit, "StartStream(): StreamNumber is:" & $iStreamNumber & @CRLF, "append")
EndFunc   ;==>MYEvent_StartStream

Func MYEvent_Hypothesis($iStreamNumber, $vStreamPosition, $iResult)
	#forceref $iStreamNumber, $vStreamPosition
	;     StreamNumber As Long,
	;     StreamPosition As Variant,
	;     Result As ISpeechRecoResult

	GUICtrlSetData($g_idGUIEdit, "Hypothesis(): Hypothized text is: " & $iResult.PhraseInfo.GetText & @CRLF, "append")
EndFunc   ;==>MYEvent_Hypothesis

Func MYEvent_Interference($iStreamNumber, $vStreamPosition, $vInterference)
	#forceref $vStreamPosition, $vInterference
	;     StreamNumber As Long,
	;     StreamPosition As Variant,
	;     Interference As SpeechInterference

	GUICtrlSetData($g_idGUIEdit, "Interference(): StreamNumber is:" & $iStreamNumber & @CRLF, "append")
EndFunc   ;==>MYEvent_Interference

Func MYEvent_Recognition($iStreamNumber, $vStreamPosition, $vRecognitionType, $iResult)
	#forceref $iStreamNumber, $vStreamPosition, $vRecognitionType
	;    StreamNumber As Long,
	;    StreamPosition As Variant,
	;    RecognitionType As SpeechRecognitionType,
	;    Result As ISpeechRecoResult

	GUICtrlSetData($g_idGUIEdit, "Recognition(): Recognized text is: " & $iResult.PhraseInfo.GetText & @CRLF, "append")
EndFunc   ;==>MYEvent_Recognition

; SAPI has MANY more Events, but we won't use these here

Func MYEvent_SoundEnd($iStreamNumber, $vStreamPosition)
	#forceref $iStreamNumber, $vStreamPosition
	;     StreamNumber As Long,
	;     StreamPosition As Variant

	;GUICtrlSetData ( $g_idGUIEdit, "SoundEnd(): StreamNumber is:" & $iStreamNumber & @CRLF  , "append" )
EndFunc   ;==>MYEvent_SoundEnd

Func MYEvent_EndStream($iStreamNumber, $vStreamPosition, $bStreamReleased)
	#forceref $iStreamNumber, $vStreamPosition, $bStreamReleased
	;     StreamNumber As Long,
	;     StreamPosition As Variant,
	;     StreamReleased As Boolean

	; GUICtrlSetData ( $g_idGUIEdit, "EndStream(): StreamNumber is:" & $iStreamNumber & @CRLF  , "append" )
	; GUICtrlSetData ( $g_idGUIEdit, "EndStream(): StreamReleased is:" & $bStreamReleased & @CRLF  , "append" )
EndFunc   ;==>MYEvent_EndStream

Func MYEvent_SoundStart($iStreamNumber, $vStreamPosition)
	#forceref $iStreamNumber, $vStreamPosition
	;     StreamNumber As Long,
	;     StreamPosition As Variant

	;GUICtrlSetData ( $g_idGUIEdit, "SoundStart(), StreamNumber is: " & $iStreamNumber & @CRLF  , "append" )
	;GUICtrlSetData ( $g_idGUIEdit, "SoundStart(): StreamPosition is:" & $vStreamPosition & @CRLF  , "append" )
EndFunc   ;==>MYEvent_SoundStart

Func MYEvent_PhraseStart($iStreamNumber, $vStreamPosition)
	#forceref $iStreamNumber, $vStreamPosition
	;     StreamNumber As Long,
	;     StreamPosition As Variant

	;GUICtrlSetData ( $g_idGUIEdit, "PhraseStart(): StreamNumber is:" & $iStreamNumber & @CRLF  , "append" )
EndFunc   ;==>MYEvent_PhraseStart
