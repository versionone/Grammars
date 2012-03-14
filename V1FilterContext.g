grammar V1FilterContext;

@lexer::members {
    boolean valueMode = false;
}

/*
 * TODO: Must have example since we use the special markers for ANTLR to lex properly. Makes it especially confusing.
 * TODO: A non-normative grammar will also help.
 
 <$var1>=<val>(, ...) ( | ... )
 context-token := assignment (| assignment)*
 assignment := variable = value (, value)*
 
 
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
