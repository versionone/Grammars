grammar V1Query;






filter_context_token
	:
	;

paging_token
	:
	;

sort_token
	:
	;

filter2_token
	:
	;

attribute_selection_token
	:
	;

attribute_definition_token
	: asset_type_token '.' attribute_name
	;

attribute_name
	: attribute_name_part ('.' attribute_name_part)* ('.@' aggregation_name)?
	;

attribute_name_part
	: NAME now_only? downcast? attribute_filter
	;

downcast
	: ':' asset_type_token
	;

now_only
	: '#'
	;

attribute_filter
	: '[' filter_criteria ']'
	;

filter_criteria
	: 
	;

simple_filter_term
	: (attribute_name binary_operator (filter_value_list | variable | context_asset) ) | (unary_operator? attribute_name)
	;

unary_operator
	: '+' | '-'
	;

filter_value_list
	: filter_value (',' filter_value)*
	;

filter_value
	: single_quoted_string | double_quoted_string
	;

single_quoted_string
	: '\'' ~('\'')* '\''
	;
	
double_quoted_string
	: '"' ~('"')* '"'
	; 

context_asset
	: '$'
	;

variable
	: '$' NAME
	;

binary_operator
	: '=' | '!=' | '>' | '>=' | '<' | '<='
	;

aggregation_name
	: NAME
	;



oid_token
	: asset_type_token ':' id (':' moment)?
	;


asset_type_token
	:	NAME ;
	
id 	:	NUMERIC ;

moment 	:	 NUMERIC ;

NAME 	:	('A'..'Z' | 'a'..'z' | '0'..'9' | '_')+ ;

NUMERIC	:	('0'..'9')+ ;

