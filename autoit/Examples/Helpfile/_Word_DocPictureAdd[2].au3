#include <MsgBoxConstants.au3>
#include <Word.au3>

; Create application object
Local $oWord = _Word_Create()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPictureAdd Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open the test document
Local $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPictureAdd Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Add a picture to the end of the document
; *****************************************************************************
; Set the range as insert marker to the end of the document
Local $oRange = _Word_DocRangeSet($oDoc, -2)
_Word_DocPictureAdd($oDoc, @ScriptDir & "\Extras\Screenshot.png", Default, Default, $oRange)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPictureAdd Example", _
		"Error adding the picture to the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPictureAdd Example", _
		"Picture has successfully been added at the end of the document.")
