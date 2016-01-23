#include <MsgBoxConstants.au3>
#include <Word.au3>

; Create application object
Local $oWord = _Word_Create()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFind Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open test document read-only
Local $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFind Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Replace paragraph control character with paragraph + text + paragraph.
; Only change first occurence.
; *****************************************************************************
Local $oRangeFound
$oRangeFound = _Word_DocFind($oDoc, "^p")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFind Example", _
		"Error locating paragraph control character in the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
$oRangeFound.InsertAfter("[New Line] ")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFind Example", _
		"Error inserting text after the paragraph control character in the document." & @CRLF & "@error = " & @error & _
		", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFind Example", "Paragraph control character successfully replaced." & @CRLF & _
		"Text inserted in paragraph 2.")
