#include <MsgBoxConstants.au3>
#include <Word.au3>

; Create application object
Local $oWord = _Word_Create()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkAdd Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open test.doc read-only
Local $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkAdd Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Add a link to the end of the document and set parameters
; ScreenTip and TextToDisplay
; *****************************************************************************
Local $oRange = _Word_DocRangeSet($oDoc, -2) ; Go to end of document
$oRange.Text = " " ; Add a space at the end of the document
$oRange = _Word_DocRangeSet($oDoc, -2)
_Word_DocLinkAdd($oDoc, $oRange, "http://www.autoitscript.com", Default, "AutoIt homepage", _
		"Hyperlink 3 - Another link to the AutoIt homepage")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkAdd Example", _
		"Error adding a link to the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocLinkAdd Example", "Hyperlink added to the end of the document.")
