#include <MsgBoxConstants.au3>
#include <Word.au3>

; Create application object
Local $oRange, $oWord = _Word_Create()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open the test document
Local $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\Extras\Test.doc", Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Scene 1
; Move the start of the range to the next paragraph and extend the end by 2
; words. Insert text before and after the range and display some statistics
; *****************************************************************************
; Move the start of the range to the next paragraph and extend the end by 2 words
$oRange = _Word_DocRangeSet($oDoc, -1, $wdParagraph, 1, Default, 2)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", _
		"Error setting/expanding range." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
$oRange.Select
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", _
		"Range has been successfully set to the first two words in the second paragraph.")

; Insert some text before the range
$oRange.InsertBefore("Inserted text at the start! ")
$oRange.Select
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", "Inserted text at the start of the range.")

; Insert some text after the range
$oRange.InsertAfter("inserted text at the end! ")
$oRange.Select
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", "Inserted text at the end of the range.")

; Display some statistics
Local $iWords = $oRange.ComputeStatistics(0)
Local $iCharacters = $oRange.ComputeStatistics(3)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", "The selected range has:" & @CRLF & _
		$iWords & " words " & @CRLF & $iCharacters & " characters.")

; *****************************************************************************
; Scene 2
; Move the end of the range one character to the left so the space to the next
; word isn't formatted and format the text bold, italic and underlined
; *****************************************************************************
$oRange = _Word_DocRangeSet($oDoc, $oRange, Default, Default, $wdCharacter, -1)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", _
		"Error setting/expanding range." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Format the range bold, italic und underline
$oRange.Bold = True
$oRange.Italic = True
$oRange.Underline = True
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", "Added some formatting.")

; *****************************************************************************
; Scene 3
; Collapse the range to 0 length (insert mark) and insert a line break
; *****************************************************************************
$oRange = _Word_DocRangeSet($oDoc, $oRange, Default, Default, -1, Default)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", _
		"Error setting/expanding range." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
$oRange.InsertBreak($wdLineBreak)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", "Inserted a break.")

; *****************************************************************************
; Scene 4
; Move the range to the first character in the next line (space) and remove it
; *****************************************************************************
$oRange = _Word_DocRangeSet($oDoc, $oRange, Default, Default, $wdCharacter, 1)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", _
		"Error setting/expanding range." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
$oRange.Delete
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocRangeSet Example", "Deleted a character.")
