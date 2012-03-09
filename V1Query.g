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
	: filter_expression? EOF
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
	: '[' filter_expression ']'
	;

filter_expression 
	: ( simple_filter_term | grouped_filter_term ) ( ( and_operator | or_operator ) filter_expression)?
	;

	
grouped_filter_term
	:	'(' filter_expression ')'
	;
	
simple_filter_term
	: ( attribute_name  ( binary_operator ( filter_value_list | variable ) )? )
	| unary_operator attribute_name
	;

or_operator	: '|'
	;

and_operator	: '&' | ';'
	;

variable 
	:	VARIABLE_NAME | CONTEXT_ASSET ;

unary_operator
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

VARIABLE_NAME
	: '$' NAME
	;

binary_operator
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
