grammar V1Query;

/*
 * Selection is used to determine which attributes are returned in a query. 
 * Attribute references are comma separated.
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Story?sel=Name,Number
 */
attribute_selection_token
	: ( attribute_name ( ',' attribute_name)* )? EOF
	;

/*
 * Filter is used to narrow the results of a query. Only valid when asking for 
 * a list of assets.
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Story?where=ToDo='0' 
 */
filter2_token
	: filter_expression? EOF
	;

/*
 * Sort is used to order the results of an asset query. For example you may 
 * wish to sort a list of Story assets by their Estimate and then Name. 
 * Attribute references are comma separated, as in the following example.
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Story?sort=Estimate,Name
 */
sort_token
	: ( sort_token_term ( COMMA sort_token_term )* )? EOF
	;

/*
 * Each sort term has an optional sort order. Use + for ascending and - for 
 * descending. If no order operator is supplied, ascending (+) is assumed. In 
 * the following example, Estimates are sorting in descending order and Names 
 * are sorted in ascending order.
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Story?sort=-Estimate,+Name
 */
sort_token_term
	: asc_sort_token_term | desc_sort_token_term
	;

asc_sort_token_term
	: PLUS? attribute_name
	;

desc_sort_token_term
	: MINUS attribute_name
	;

attribute_definition_token
	: asset_type_token DOT attribute_name EOF
	;

/*
 * Attributes describe the properties that make up each asset type. An 
 * attribute defines the type of its value, whether it is required and/or 
 * read-only, and many other qualities. Attribute definitions are identified by 
 * a name that is unique within its asset type. The dot operator "." is used to 
 * reference an attribute. For example, the following returns the parent Name 
 * of a Category on a Story.
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Story/1055/Category.Name
 * 
 * Attributes are defined as either scalars or relations to other assets. 
 * Further, relation attributes can be either single-value or multi-value. For 
 * example, the Estimate attribute on the Workitem asset type is a scalar 
 * (specifically, a floating-point number). The Workitem.Scope attribute is a 
 * single-value relation to a Scope asset. The complementary relationship, 
 * Scope.Workitems is a multi-value relation to Workitem assets.
 * 
 * When an attribute is a relation to another asset, then dot notation can be 
 * used to select the attribute on that referenced asset. For example, the 
 * following returns the Name values for the Workitems in the root project.
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Scope/0/Workitems.Name
 *
 * The aggregation can be used to roll-up a set of values to a single value. 
 * For example, the following returns the total number of Workitem assets that 
 * belong to Scope with ID 0.
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Scope/0/Workitems.@Count
 */
attribute_name :
	attribute_name_part 		// name part
	(DOT attribute_name_part)* 	// any number of dot separated name parts
	(DOT_AT aggregation_name)?	// optional aggretation
	;

/*
 * An aggregation is a simple mathematical function that returns a single value 
 * from the selected attribute values. The following aggretation types are 
 * defined:
 * Sum :			Sum the returned values
 * Count :			Count the returned assets
 * DistinctCount :	Count the returned assets, ensuring each asset is 
 * 						counted only once
 * Min : 			Find the least value from the returned values
 * Max :			Find the greatest value from the returned values
 * MinDate :		Find the oldest date from the returned values
 * MaxDate :		Find the newest date from the returned values
 * And :			Returns true if all the returned values are true
 * Or :				Returns true if any of the values are true
 * MaxState :		
 *
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Scope/0/Workitems.Estimate.@Sum
 */
aggregation_name	: NAME ;

attribute_name_part
	: NAME now_only? downcast? attribute_filter?
	;

now_only		: HASH ;

/*
 * In context of selecting an attribute, a term may need to be downcast to a
 * more specific type so a child attribute is available. For example of 
 * downcast, at the abstract level of Workitems, there is no Category 
 * attribute. At the concrete level of Story, there is a Category attribute. 
 * Therefore, in order to query for Categories on Workitems, the AssetType 
 * must be downcast to Story. Without the downcast, the query will fail.
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Scope/0/Workitems:Story.Category
 */
downcast
	: COLON asset_type_token
	;

asset_type_token	: NAME ;

/*
 * In context of selecting an attribute, a filter may be applied to reduce 
 * the set of returned assets. For example of a filter, the following returns 
 * Workitems in the root project that have a ToDo value equal to zero.
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Scope/0/Workitems[ToDo='0']
 */
attribute_filter
	: OPEN_BRACKET filter_expression CLOSE_BRACKET
	;

filter_expression 
	: ( grouped_filter_term | simple_filter_term ) 
	  ( 
		( and_operator | or_operator ) 
		( grouped_filter_term | simple_filter_term ) 
	  )*
	;

and_operator		: AMP | SEMI ;

or_operator		: PIPE ;

grouped_filter_term
	: OPEN_PAREN filter_expression CLOSE_PAREN
	;

simple_filter_term
	: ( attribute_name  ( binary_operator ( filter_value_list | variable ) )? )
	| unary_operator attribute_name
	;

variable 		: VARIABLE_NAME | CONTEXT_ASSET ;

binary_operator		: EQ | NE | LT | LTE | GT | GTE ;

unary_operator		: PLUS | MINUS ;

filter_value_list
	: filter_value (COMMA filter_value)*
	;

filter_value
	: SINGLE_QUOTED_STRING | DOUBLE_QUOTED_STRING
	;

/*
 * Lexing Rules
 */
SINGLE_QUOTED_STRING	: '\'' ~('\'')* '\'' ;
DOUBLE_QUOTED_STRING	: '"' ~('"')* '"' ; 
CONTEXT_ASSET		: '$' ;
VARIABLE_NAME		: '$' NAME ;
NAME					: (NAME_CHAR)+ ;

OPEN_PAREN		: '(' ;
CLOSE_PAREN		: ')' ;
OPEN_BRACKET		: '[' ;
CLOSE_BRACKET		: ']' ;

EQ			: '=' ;
NE			: '!=' ;
LT			: '<' ;
LTE			: '<=' ;
GT			: '>' ;
GTE			: '>=' ;
PLUS			: '+' ;
MINUS			: '-' ;

HASH			: '#' ;
PIPE			: '|' ;
AMP			: '&' ;
SEMI			: ';' ;
COLON			: ':' ;
COMMA			: ',' ;
DOT			: '.' ;
DOT_AT			: '.@' ;

fragment ASCII_VISIBLE	: ALPHA | DIGIT | SYMBOL ;
fragment NAME_CHAR	: ALPHA | DIGIT | '_' ;
fragment ALPHA		: 'A'..'Z' | 'a'..'z' ;
fragment DIGIT		: '0'..'9' ;
fragment SYMBOL		: '!'..'/' | ':'..'@' | '['..'`' | '{'..'~' ;
