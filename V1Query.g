grammar V1Query;


v1_token 
	: oid_token
	| asset_type_token
	| attribute_definition_token
	| attribute_selection_token
	| filter2_token
	| sort_token
	| paging_token
	| filter_context_token
	;

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
	:
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

