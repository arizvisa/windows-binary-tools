#include <Inet.au3>
#include <MsgBoxConstants.au3>

Local $sAddress = InputBox('Address', 'Enter the E-Mail address to send message to')
Local $sSubject = InputBox('Subject', 'Enter a subject for the E-Mail')
Local $sBody = InputBox('Body', 'Enter the body (message) of the E-Mail')
MsgBox($MB_SYSTEMMODAL, 'E-Mail has been opened', 'The E-Mail has been opened and process identifier for the E-Mail client is ' & _INetMail($sAddress, $sSubject, $sBody))
