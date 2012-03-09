grammar V1Query;






filter_context_token
	: 
	;

paging_token
	: page_size ( ',' page_start )? EOF
	;

page_start
	: NUMERIC
	;

page_size
	: NUMERIC
	;

sort_token
	: ( sort_token_term ( ',' sort_token_term )* )? EOF
	;

sort_token_term
	: asc_sort_token_term | desc_sort_token_term
	;

asc_sort_token_term
	: ('+')? attribute_name
	;

desc_sort_token_term
	: '-' attribute_name
	;

filter2_token
	: filter_expr? EOF
	;

attribute_selection_token
	: ( attribute_name ( ',' attribute_name)* )? EOF
	;

attribute_definition_token
	: asset_type_token '.' attribute_name EOF
	;

attribute_name
	: attribute_name_part ('.' attribute_name_part)* ('.@' aggregation_name)?
	;

attribute_name_part
	: NAME now_only? downcast? attribute_filter?
	;

downcast
	: ':' asset_type_token
	;

now_only
	: '#'
	;

attribute_filter
	: '[' filter_expr ']'
	;

filter_expr 
	: ( simple_filter_term | grouped_filter_term ) (logical_op filter_expr)?
	;

	
grouped_filter_term
	:	'(' filter_expr ')'
	;
	
simple_filter_term
	: ( attribute_name  ( BINARY_OPERATOR ( filter_value_list | VARIABLE | CONTEXT_ASSET ) )? )
	| UNARY_OPERATOR attribute_name
	;

logical_op
	: AND_OP | OR_OP
	;

OR_OP	: '|'
	;

AND_OP	: '&' | ';'
	;


UNARY_OPERATOR
	: '+' | '-'
	;

filter_value_list
	: filter_value (',' filter_value)*
	;

filter_value
	: SINGLE_QUOTED_STRING | DOUBLE_QUOTED_STRING
	;

SINGLE_QUOTED_STRING
	: '\'' ~('\'')* '\''
	;
	
DOUBLE_QUOTED_STRING
	: '"' ~('"')* '"'
	; 

CONTEXT_ASSET
	: '$'
	;

VARIABLE
	: '$' NAME
	;

BINARY_OPERATOR
	: '!=' | '>' | '>=' | '<' | '<=' | '='
	;

aggregation_name
	: NAME
	;



oid_token
	: ( ( asset_type_token ':' id ( ':' moment )? ) | 'NULL' ) EOF
	;


asset_type_token
	:	NAME ;
	
id 	:	NUMERIC ;

moment 	:	NUMERIC ;

NAME 	:	('A'..'Z' | 'a'..'z' | '_') ('A'..'Z' | 'a'..'z' | '0'..'9' | '_')* ;

NUMERIC	:	'-'? '0'..'9'+ ;
