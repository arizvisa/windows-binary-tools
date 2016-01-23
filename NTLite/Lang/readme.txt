NTLite translation guidelines

New translation:
  - Before doing any actual translation contact us at info@ntlite.com to check if someone else is currently editing that language.
	There can be multiple translators for a given language, just not at the same time.
  - Copy \Lang\Template.xml as a new file, e.g. \Lang\MyLang.xml
  - Process can be simplified by using the free tool "Xml Content Translator" from http://www.nikse.dk/XmlContentTranslator
  - Open "Xml Content Translator", choose File-Open, then as first file choose the original \Lang\Template.xml, then as second file your \Lang\MyLang.xml.
  - Translate lines on the right and save when done.
  - You might want to try the Google Translated version as a starting point, option is on right-click in the same tool.
	For skipped auto-translated fields, retry individually.
	There could be many errors, be sure to review and correct.
  - To help you debug some basic issues, in case of a duplicate or missing ID, errors there will be logged in NTLite.log.
	Try using a tool a bit with your translation and then check the log for lines starting with "Translation error".
  - When done, you can send the translated file via email.

Translation updates:
To easily and precisely see the differences between versions, install both of them in separate directories and compare their \Lang\Template.xml files with programs like WinMerge (http://winmerge.org).
For this reason you could also backup last translated \Lang\Template.xml for easier reference.