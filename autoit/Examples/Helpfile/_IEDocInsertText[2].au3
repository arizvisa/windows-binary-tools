; Insert HTML at the top and bottom of a document

#include <IE.au3>

Local $oIE = _IE_Example("basic")
Local $oBody = _IETagNameGetCollection($oIE, "body", 0)
_IEDocInsertText($oBody, "This Text is inserted After Begin", "afterbegin")
_IEDocInsertText($oBody, "Notice that <b>Tags</b> are <encoded> before display", "beforeend")
