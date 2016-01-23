; Open a browser with the basic example page, insert an
; event script into the head of the document that creates
; a JavaScript alert when someone tries to right-click on the
; document and then the event script returns "false" to prevent
; the right-click context menu from appearing

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IEHeadInsertEventScript($oIE, "document", "oncontextmenu", "alert('No Context Menu');return false")
