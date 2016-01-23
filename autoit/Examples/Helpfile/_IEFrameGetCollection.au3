; Open frameset example, get collection of frames
; and loop through them displaying their source URL's

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("frameset")
Local $oFrames = _IEFrameGetCollection($oIE)
Local $iNumFrames = @extended
Local $sTxt = $iNumFrames & " frames found" & @CRLF & @CRLF
Local $oFrame = 0
For $i = 0 To ($iNumFrames - 1)
	$oFrame = _IEFrameGetCollection($oIE, $i)
	$sTxt &= _IEPropertyGet($oFrame, "innertext") & @CRLF
Next
MsgBox($MB_SYSTEMMODAL, "Frames Info", $sTxt)

_IEQuit($oIE)
