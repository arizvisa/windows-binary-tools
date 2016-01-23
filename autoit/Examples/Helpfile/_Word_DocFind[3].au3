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
; Search for text "line" in lines 2-4 and mark the following number as bold.
; If the number is "3" insert text before text "line".
; *****************************************************************************
Local $oRangeFound, $oSearchRange, $oRangeText
$oSearchRange = _Word_DocRangeSet($oDoc, -1, $wdParagraph, 1, $wdParagraph, 3)
$oRangeFound = _Word_DocFind($oDoc, "line", $oSearchRange)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFind Example", _
		"Error locating the specified text in the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Mark the line number as bold. Create a new range moved one word to the right
$oRangeText = _Word_DocRangeSet($oDoc, $oRangeFound, Default, 1, Default, 1)
$oRangeText.Bold = True
While 1
	$oRangeFound = _Word_DocFind($oDoc, "line", $oSearchRange, $oRangeFound)
	If @error Then ExitLoop
	; Mark the line number as bold. Create a new range (duplicate to not alter the result of the find operating) and move it one word to the right
	$oRangeText = $oRangeFound.Duplicate
	$oRangeText = _Word_DocRangeSet($oDoc, $oRangeText, Default, 1, Default, 1)
	$oRangeText.Bold = True
	; Insert text if linenumber = 3
	If StringStripWS($oRangeText.Text, 8) = "3" Then $oRangeFound.InsertBefore("(maybe) ")
WEnd
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFind Example", _
		"All line numbers in paragraphs 2-4 marked as bold." & @CRLF & "Text inserted before 'line 3'.")
