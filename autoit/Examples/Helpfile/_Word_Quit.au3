#include <MsgBoxConstants.au3>
#include <Word.au3>

; Create application object
Local $oWord = _Word_Create()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocQuit Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $bWordClose = @extended
; Open the test document read-only
_Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocQuit Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; If Word was running when this script is started only the reference to the
; object will be removed.
; If Word was started by this example all documents and Word will be closed.
; *****************************************************************************
Local $iResult
If $bWordClose Then
	$iResult = MsgBox(BitOR($MB_OKCANCEL, $MB_SYSTEMMODAL), "Word UDF: _Word_Quit Example", _
			"If you click OK ALL unsaved changes in ALL open documents of this Word instance will be lost and the instance will be closed.")
Else
	$iResult = MsgBox(BitOR($MB_OKCANCEL, $MB_SYSTEMMODAL), "Word UDF: _Word_Quit Example", _
			"Word was already running when function _Word_Create was called. Hence only the reference to the object will be removed.")
EndIf
If $iResult = 2 Then Exit
_Word_Quit($oWord)
If @error Then MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_Quit Example", _
		"Error closing the Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
