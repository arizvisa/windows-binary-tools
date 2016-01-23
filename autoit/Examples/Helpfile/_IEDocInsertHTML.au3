; Insert HTML at the top and bottom of a document

#include <IE.au3>

Local $oIE = _IECreate("http://www.autoitscript.com")
Local $oBody = _IETagNameGetCollection($oIE, "body", 0)
_IEDocInsertHTML($oBody, "<h2><font color=red>This HTML is inserted After Begin</font></h2>", "afterbegin")
_IEDocInsertHTML($oBody, "<h2><font color=red>This HTML is inserted Before End</font></h2>", "beforeend")
