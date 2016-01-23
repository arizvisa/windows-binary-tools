Accompanying document for the 7-zip library v15.05 beta

- Description
The library, '7z.dll' (and '.\x64\7z.dll' for 64-bit), namely 7-zip, is distributed under the terms of the GNU Lesser General Public License version 3 (http://www.gnu.org/licenses/lgpl.html) and unRAR restriction (explained below).
See ..\COPYING.LGPLv3.txt for further details on the library license.
7-Zip Copyright (C) 1999-2015 Igor Pavlov

- Source code
The source code is available at http://sourceforge.net/projects/sevenzip

- Attaching
The source code have not been changed in any way, and library is being called via the standard LoadLibrary() Windows API.

- Upgrading
You can upgrade the library by simply replacing the file(s) with a different version. Just be careful to put a 64-bit version in the 'x64' subdirectory.



  unRAR restriction
  -----------------

    The decompression engine for RAR archives was developed using source 
    code of unRAR program.
    All copyrights to original unRAR code are owned by Alexander Roshal.

    The license for original unRAR code has the following restriction:

      The unRAR sources cannot be used to re-create the RAR compression algorithm, 
      which is proprietary. Distribution of modified unRAR sources in separate form 
      or as a part of other software is permitted, provided that it is clearly
      stated in the documentation and source comments that the code may
      not be used to develop a RAR (WinRAR) compatible archiver.