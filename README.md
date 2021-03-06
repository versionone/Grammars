# VersionOne Grammars #
Copyright (c) 2012 VersionOne, Inc.
All rights reserved.

For Core REST API Developers who understand the basics of constructing queries, 
the VersionOne Grammars provide documentation of the syntax for tokens within 
the query parameters. Unlike the introductory documentation, these Grammars are 
written as comprehensive technical documentation so developers can learn to use 
more sophisticated facets of the API.

This product includes software developed at VersionOne 
(http://versionone.com/). This product is open source and is licensed under a 
modified BSD license. Source code is available from:
https://github.com/versionone/Grammars

## The Grammars ##
* V1Query.g - Describes the tokens for attribute names, selection (sel 
parameter), filters (where parameter), and sort (sort parameter).
* V1Paging.g - Describes the tokens for paging (page parameter).
* V1FilterContext.g - Describes the tokens for filter context (with parameter).

These grammars are written in ANTLR format so they can be executed. Although executable, they are provided for documentation and are not guaranteed to match the VersionOne core application implementation.

In the context of a VersionOne Core API request, the tokens will be combined in normal URL query syntax and should be URL encoded. As such, there is no single grammar for the whole URL syntax.

## Examples and Samples ##
All examples (preceded by EXAMPLE:) in the comments are live and can be sent 
to a browser to execute. Although all of the examples should execute and 
return some XML result, some queries may return 0 assets. Use the following 
credentials to connect:
Username: admin
Password: admin

In contrast, samples (preceded by SAMPLE:) comply with the syntax but are not 
associated with actual data in the live system. Executing them will result in 
an HTTP error.

## Generating HTML ##
```bash
pygmentize -f html -O full -o V1Query.html V1Query.g
```
## License ##
Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this 
  list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, 
  this list of conditions and the following disclaimer in the documentation 
  and/or other materials provided with the distribution.
* Neither the name of VersionOne, Inc. nor the names of its contributors may be 
  used to endorse or promote products derived from this software without 
  specific prior written permission of VersionOne, Inc.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR 
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON 
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## Acknowledgements ##
These Grammars were written using ANTLRWorks, which is open source software, 
written by Terence Parr.

The original software is available from:
   http://www.antlr.org/

Both ANTLR and ANTLRWorks are available under a Modified BSD License:
   http://www.antlr.org/license.html
