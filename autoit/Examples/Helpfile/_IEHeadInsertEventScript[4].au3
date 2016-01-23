; Open a browser with the basic example page, insert an
; event script into the head of the document that prevents
; selection of text in the document

#include <IE.au3>

Local $oIE = _IE_Example()
_IEHeadInsertEventScript($oIE, "document", "ondrag", "return false;")
_IEHeadInsertEventScript($oIE, "document", "onselectstart", "return false;")
