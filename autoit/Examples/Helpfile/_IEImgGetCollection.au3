; Create browser at AutoIt homepage, get a reference to the 5th Image
; on the page (note: the first image is index 0)
; and display information about it

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IECreate("http://www.autoitscript.com/")
Local $oImg = _IEImgGetCollection($oIE, 5)
Local $sInfo = "Src: " & $oImg.src & @CRLF
$sInfo &= "FileName: " & $oImg.nameProp & @CRLF
$sInfo &= "Height: " & $oImg.height & @CRLF
$sInfo &= "Width: " & $oImg.width & @CRLF
$sInfo &= "Border: " & $oImg.border
MsgBox($MB_SYSTEMMODAL, "5th Image Info", $sInfo)

_IEQuit($oIE)
