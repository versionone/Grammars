grammar V1Paging;


paging_token
	: page_size ( ',' page_start )? EOF
	;

page_start
	: INT
	;

page_size
	: INT
	;

INT	: '0'..'9'+ ;