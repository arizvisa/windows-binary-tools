#include <MsgBoxConstants.au3>
#include <String.au3>

; Will return : Somebody Lastnames
MsgBox($MB_SYSTEMMODAL, '', _StringProper("somebody lastnames"))
; Will return : Some.Body Last(Name)
MsgBox($MB_SYSTEMMODAL, '', _StringProper("SOME.BODY LAST(NAME)"))
Exit
