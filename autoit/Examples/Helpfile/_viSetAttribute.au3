; - This assumes that you have instrument set to GPIB address 3.
; If you have an instrument in a different address change "GPIB::3::0" to the
; corresponding descriptor. Do the same for the call to _viOpen
; It shows how to use the _viSetAttribute. In this example we use _viSetAttribute
; instead of _viSetTimeout to set the GPIB timeout of a _viExecCommand operation.

#include <MsgBoxConstants.au3>
#include <Visa.au3>

Local $h_Session = 0

; Query the ID of the instrument in GPIB address 3
MsgBox($MB_SYSTEMMODAL, "Step 1", "Simple GPIB query with explicit TIMEOUT set")
Local $s_Answer = _viExecCommand("GPIB::3::0", "*IDN?", 10000) ; 10 secs timeout
MsgBox($MB_SYSTEMMODAL, "GPIB QUERY result", $s_Answer) ; Show the answer

; This is the same as using the _viSetAttribute function first:
MsgBox($MB_SYSTEMMODAL, "Step 2", "_vOpen + timeout using _viSetAttribute + GPIB query")
Local $h_Instr = _viOpen(3)
; NOTE - This is the same as: _viSetTimeout($h_Instr, 10000)
_viSetAttribute($h_Instr, $VI_ATTR_TMO_VALUE, 10000) ; 10000 ms = 10 secs

$s_Answer = _viExecCommand($h_Instr, "*IDN?") ; No need to set the timeout now
MsgBox($MB_SYSTEMMODAL, "GPIB QUERY result", $s_Answer) ; Show the answer

MsgBox($MB_SYSTEMMODAL, "Step 3", "Close the Instrument connection using _viClose")
_viClose($h_Instr) ; Close the instrument connection
