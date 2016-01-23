; Click on IMG by id

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IEImgClick($oIE, "AutoItImage", "id") ; "name" is still equivalent for HTML5 pages
