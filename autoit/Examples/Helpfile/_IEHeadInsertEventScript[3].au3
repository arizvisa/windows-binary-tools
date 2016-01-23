; Open a browser with the basic example page, insert an
; event script into the head of the document that creates a
; JavaScript alert when we are about to navigate away from the
; page and presents the option to cancel the operation.

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IEHeadInsertEventScript($oIE, "window", "onbeforeunload", _
		"alert('Example warning follows...');return 'Pending changes may be lost';")
_IENavigate($oIE, "www.autoitscript.com")
