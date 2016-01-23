#include <MsgBoxConstants.au3>
#include <Word.au3>

; Create application object
Local $oWord = _Word_Create()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkGet Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open test.doc read-only
Local $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkGet Example", "Error opening '.\Extras\Test.doc'. @error = " & _
		@error & ", @extended = " & @extended)

; *****************************************************************************
; Return hyperlink number 2 and display some properties
; *****************************************************************************
Local $oLink = _Word_DocLinkGet($oDoc, 2)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkGet Example", _
		"Error accessing link collection of the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $sResult = "Total number of hyperlinks in the document: " & @extended & @CRLF & @CRLF & _
		"Text: " & $oLink.TextToDisplay & @CRLF & _
		"Address: " & $oLink.Address & @CRLF & _
		"Screentip: " & $oLink.Screentip
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkGet Example - Process hyperlink #2", $sResult)
