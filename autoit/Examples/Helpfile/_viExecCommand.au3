; - This assumes that you have instrument set to GPIB address 3
; If you have an instrument in a different address change "GPIB::3::0" to the
; corresponding descriptor. Do the same for the call to _viOpen
; It shows how to use the _viExecCommand function in stand alone mode and combined
; with _viOpen and _viClose.
; It also shows the _viGTL function

#include <MsgBoxConstants.au3>
#include <Visa.au3>

Local $h_Session = 0

; Query the ID of the instrument in GPIB address 3
MsgBox($MB_SYSTEMMODAL, "Step 1", "Simple GPIB query using a VISA Descriptor")
Local $s_Answer = _viExecCommand("GPIB::3::0", "*IDN?", 10000) ; 10 secs timeout
MsgBox($MB_SYSTEMMODAL, "GPIB QUERY result", $s_Answer) ; Show the answer

MsgBox($MB_SYSTEMMODAL, "Step 2", "Go to LOCAL using VISA Descriptor")
_viGTL("GPIB::1::0") ; Go to local (exit remote control mode)

MsgBox($MB_SYSTEMMODAL, "Step 3", "Simple GPIB query using a VISA address shortcut")
$s_Answer = _viExecCommand("1", "*IDN?") ; The address MUST BE A STRING
MsgBox($MB_SYSTEMMODAL, "GPIB QUERY result", $s_Answer) ; Show the answer
MsgBox($MB_SYSTEMMODAL, "Info", "Now let's use _viOpen and _viClose")

MsgBox($MB_SYSTEMMODAL, "Step 4", "Open the instrument connection with _viOpen")
Local $h_Instr = _viOpen(3)
MsgBox($MB_SYSTEMMODAL, "Instrument Handle obtained", "$h_Instr = " & $h_Instr) ; Show the Session Handle
; Query the instrument

MsgBox($MB_SYSTEMMODAL, "Step 5", "Query the instrument using the VISA instrument handle")
$s_Answer = _viExecCommand($h_Instr, "*IDN?") ; $h_Instr is NOT A STRING now!
MsgBox($MB_SYSTEMMODAL, "GPIB QUERY result", $s_Answer) ; Show the answer
; Query again. There is no need to OPEN the link again

MsgBox($MB_SYSTEMMODAL, "Step 6", "Query again. There is no need to OPEN the link again")
$s_Answer = _viExecCommand($h_Instr, "*IDN?")
MsgBox($MB_SYSTEMMODAL, "GPIB QUERY result", $s_Answer) ; Show the answer

MsgBox($MB_SYSTEMMODAL, "Step 7", "Go to LOCAL using VISA instrument handle")
_viGTL($h_Instr); Go to local (this is optional)

MsgBox($MB_SYSTEMMODAL, "Step 8", "Close the Instrument connection using _viClose")
_viClose($h_Instr) ; Close the instrument connection
