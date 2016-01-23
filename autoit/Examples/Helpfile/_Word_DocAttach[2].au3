#include <MsgBoxConstants.au3>
#include <Word.au3>

; Create application object
Local $oWord = _Word_Create()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAttach Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open test document read-only
_Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAttach Example", "Error opening '.\Extras\Test.doc'." & _
		@CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Attach to the test document by "Text"
; *****************************************************************************
Local $oDoc = _Word_DocAttach($oWord, "Test", "Text")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAttach Example", _
		"Error attaching to '\Extras\Test.doc' by 'Text'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAttach Example", "Attach to document by 'Text' successfull!" & _
		@CRLF & @CRLF & "Text of the attached document:" & @CRLF & $oDoc.Range().Text)
