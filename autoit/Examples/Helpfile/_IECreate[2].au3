; Create new browser windows pointing to each of 3 different URLs
; if one does not already exist ($f_tryAttach = 1)
; do not wait for the page loads to complete ($f_wait = 0)

#include <IE.au3>

_IECreate("www.autoitscript.com", 1, 1, 0)
_IECreate("my.yahoo.com", 1, 1, 0)
_IECreate("www.google.com", 1, 1, 0)
