
			    set NET="%PROGRAMFILES%\Microsoft SDKs\Windows\v6.0A\bin"
				rem -- alternative location: set NET="%PROGRAMFILES%\Microsoft.NET\SDK\v2.0\Bin"
				%NET%\gacutil /if IKVM.Runtime.dll
				%NET%\gacutil /if IKVM.OpenJDK.Core.dll
				%NET%\gacutil /if IKVM.OpenJDK.Charsets.dll
				%NET%\gacutil /if IKVM.OpenJDK.Util.dll
				%NET%\gacutil /if IKVM.OpenJDK.XML.API.dll
				%NET%\gacutil /if xercesImpl.dll
				%NET%\gacutil /if saxon9he.dll 
				%NET%\gacutil /if saxon9he-api.dll                
      