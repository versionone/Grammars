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

## Grammar versus implementation ##
The grammars describe the intended syntax. Where a grammar and the server
disagree, the server wins. Known disagreements, from comparing these files
against the shipped implementation:

| # | The grammar says... | The server actually... |
| - | ------------------- | ---------------------- |
| 1 | The filter root rule is `filter2_token` | Reads the query parameter `where`. "Filter2" is an internal type name that never appears on the wire; there is no `filter=` parameter on rest-1.v1 |
| 2 | Selection comes from `sel` | Also accepts `select`, an alias that wins when both are present |
| 3 | Nothing about `find`, `findin`, `asof`, `deleted` or `needTotal` | Supports all five |
| 4 | Selection is exactly what you asked for | Expands every relation selection with the related asset's Name / ShortName / DisplayBy |
| 5 | Nothing about the default selection | Falls back to a per-asset-type basic set, not to all attributes |
| 6 | `paging_token : page_size (',' page_start)?` | Agrees - size first, then start. Note there is no default page size: omitting the page token returns the entire result set |
| 7 | `sort_token` has no default | Adds an implicit ascending Moment sort on history requests when `sort` is absent |
| 8 | Filtering, sorting and paging are properties of a query | Are not applied at all on single-asset `/Data/{Type}/{id}` requests, while `deleted`, `needTotal`, `sel`, `with` and `asof` still take effect |

The same points appear as IMPLEMENTATION NOTES in the grammar files, next to
the rules they qualify.

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
