#include <String.au3>

; Inserts three "moving" underscores and prints them to the console.
For $i = -20 To 20
	ConsoleWrite($i & @TAB & _StringInsert("Supercalifragilistic", "___", $i) & @CRLF)
Next
