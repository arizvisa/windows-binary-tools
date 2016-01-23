; Create browser at AutoIt homepage, get Img collection
; and display src URL for each

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IECreate("http://www.autoitscript.com/")
Local $oImgs = _IEImgGetCollection($oIE)
Local $iNumImg = @extended

Local $sTxt = "There are " & $iNumImg & " images on the page" & @CRLF & @CRLF
For $oImg In $oImgs
	$sTxt &= $oImg.src & @CRLF
Next
MsgBox($MB_SYSTEMMODAL, "Img Info", $sTxt)

_IEQuit($oIE)
