; Open a browser with the basic example page, insert an
; event script into the head of the document that creates
; a JavaScript alert when someone clicks on the document

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IEHeadInsertEventScript($oIE, "document", "onclick", "alert('Someone clicked the document!');")
