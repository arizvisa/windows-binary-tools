; Click on IMG by src sub-string

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IEImgClick($oIE, "autoit_6_240x100.jpg", "src")
