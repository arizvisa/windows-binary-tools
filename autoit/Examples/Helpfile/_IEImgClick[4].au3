; Click on IMG by full src string

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IEImgClick($oIE, "http://www.autoitscript.com/images/autoit_6_240x100.jpg")
