; Open browser with basic example, get link collection,
; loop through items and display the associated link URL references

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("basic")
Local $oLinks = _IELinkGetCollection($oIE)
Local $iNumLinks = @extended

Local $sTxt = $iNumLinks & " links found" & @CRLF & @CRLF
For $oLink In $oLinks
	$sTxt &= $oLink.href & @CRLF
Next
MsgBox($MB_SYSTEMMODAL, "Link Info", $sTxt)
