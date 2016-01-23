; == Example 2 for writing in SciTe output pane

ConsoleWrite('! = Red' & @CRLF) ; ! = red text color
ConsoleWrite('> = Blue' & @CRLF) ; > = blue text color
ConsoleWrite('- = Orange' & @CRLF) ; - = orange text color
ConsoleWrite('+ = Green' & @CRLF) ; + = green text color
ConsoleWrite('(5) : = Red (jump to line 5 when double-clicked)' & @CRLF) ; '(5) :' red text color and double click jumps to (line number)
ConsoleWrite('Start with String or Integer then ' & @TAB & '6' & ' = Pink (jump to line 6 when double-clicked)' & @CRLF)
; pink text color, any sign and then @TAB & 'line number'

; Example 1
ConsoleWrite('(' & @ScriptLineNumber & ') : = Red (jump to line ' & @ScriptLineNumber & ' when double-clicked)' & @CRLF)

; Clear console output pane of SciTE after 5000 ms
Sleep(5000)
ControlSend("[CLASS:SciTEWindow]", "", "Scintilla2", "+{F5}")
