/*
 * # V1FilterContext #
 * This file is part of the VersionOne Grammars project. This is an open source 
 * product and is licensed under a modified BSD license. Source code and other 
 * information is available from:
 * https://github.com/versionone/Grammars
 */

grammar V1FilterContext;

/*
 * The actual implementation of this grammar is done with simple token 
 * splitting. To represent it in this normative syntax, some ANTLR-specific 
 * coding (such as the following) has been added.
 */
@lexer::members {
    boolean valueMode = false;
}

/* 
 * The following is a non-normative representation to help interpret the 
 * normative syntax:
 * $<variable>=<value>(, ...) ( | ... )
 * 
 * assignment := variable = value (, value)*
 * SAMPLE:
 * $SCOPE=Scope:0,Scope:1,Scope:2
 *
 * context-token := assignment (| assignment)*
 * SAMPLE:
 * $STORY=Story:3|$SCOPE=Scope:0,Scope:1,Scope:2
 */

/*
 * A filter context token is used for variable assignment. Variables may be 
 * used in filters and are particularly useful when the same values must be 
 * repeated throughout a filter token.
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Epic?where=AssetState!='Closed';Scope=$Scope;-SuperAndUp[Scope=$Scope]&with=$Scope=Scope:0,Scope:1,Scope:2
 */
filter_context_token
	: ( filter_context_term ( PIPE filter_context_term )* )? EOF
	;

filter_context_term
	: VARIABLE_NAME EQ filter_context_values
	;

filter_context_values
	: CONTEXT_VALUE (COMMA CONTEXT_VALUE)*
	;

CONTEXT_VALUE		: {valueMode}?=> ~(',' | '|')* { valueMode = false; } ;
VARIABLE_NAME		: '$' NAME ;
NAME			: (NAME_CHAR)+ ;

EQ			: '=' { valueMode = true; } ;
COMMA			: ',' { valueMode = true; } ;
PIPE			: '|' ;

fragment NAME_CHAR	: ALPHA | DIGIT | '_' ;
fragment ALPHA		: 'A'..'Z' | 'a'..'z' ;
fragment DIGIT		: '0'..'9' ;
