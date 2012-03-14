grammar V1Paging;

/*
 * A paging parameter is used to indicate how many assets you want to retrieve 
 * and where to start in the list of assets. The size specifies the number of 
 * assets to return per page. The start specifies the number of assets to skip. 
 * Therefore, the start value should increment by the page size. 
 * 
 * For example, if you have 100 assets and want to see 10 at a time, you would 
 * use a page start of 0, and a page size of 10. To retrieve the second page 
 * simply ask for a page start of 10 with a page size of 10, and so on. The 
 * following would return the 2nd page of results. 
 * EXAMPLE:
 * https://www14.v1host.com/v1sdktesting/rest-1.v1/Data/Story?page=10,10
 */
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