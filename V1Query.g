grammar V1Query;




attribute_definition_token
	: asset_type_name '.' attribute_name;

attribute_name 
	: attribute_name_part ('.' attribute_name_part)* ('.@' aggregation_name)? ;

attribute_name_part
	: NAME NOW_OP? downcast_type_name? attribute_filter ;


downcast_type_name : ':' asset_type_name ;


oid_token : (asset_type_name ':' id_number (':' moment_number)?)  | 'NULL';



attribute_filter : '[' filter_expr ']' ;

filter_expr
	:  '(' filter_expr ')'
	// |  simple_filter_term another_filter_term?
	|  simple_filter_term (logical_op filter_expr)?
	;
	
	
simple_filter_term 
	//options {backtrack=true;}
	: attribute_name attribute_comparison?
	| EXISTENCE_OP attribute_name
	| NONEXISTENCE_OP attribute_name
	;

attribute_comparison
	:	comparison_operator simple_term_part
	;






simple_term_part : string_list | variable_name ;

string_list : string_literal ( ',' string_literal )* ;

string_literal : SINGLE_QUOTED_STRING | DOUBLE_QUOTED_STRING ;

SINGLE_QUOTED_STRING : '\'' ~('\'')* '\'' ;
	
DOUBLE_QUOTED_STRING : '"' ~('"')* '"' ; 


variable_name : '$' NAME? ;

aggregation_name : NAME ;

asset_type_name : NAME ;

id_number : NUMERIC ;

moment_number : NUMERIC ;



comparison_operator : EQ_OP | LTE_OP | GTE_OP | NE_OP ;

logical_op : AND_OP | OR_OP ;



NAME : ALPHANUMERIC+ ;

ALPHANUMERIC : ALPHA | DIGIT ;

fragment ALPHA : 'A'..'Z' | 'a'..'z'  | '_' ;

NUMERIC : '-'? DIGIT+ ;

fragment DIGIT : '0'..'9';

OR_OP	: '|' ;

AND_OP	: '&' | ';' ;

EXISTENCE_OP  :	'+' ;

NONEXISTENCE_OP : '-' ;

LTE_OP	: '<=' ;

GTE_OP	: '>=';

NE_OP 	: '!=';

EQ_OP	: '=';
	
NOW_OP	: '#' ;	





