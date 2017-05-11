*! Author: 		Hendrik van Broekhuizen
*! Date: 		2015/05/06
*! Description:	PROGRAM to transfer the value labels from one variable onto another row-by-row (useful when you want to present factor variables in a specific order while retaining the original labelling)
cap program drop getlabsfor 
program define getlabsfor
	version 12.0
	syntax varlist(max = 1 numeric), From(varname)
	
	local tovar `varlist'
	local fromvar `from'
	
	if substr("`:type `fromvar''",1,3) == "str" {
		mata st_vlmodify("`tovar'",st_data(.,"`tovar'",0),st_sdata(.,"`fromvar'",0))
	}
	else {
		mata st_vlmodify("`tovar'",st_data(.,"`tovar'",0),st_vlmap("`:value label `fromvar''",st_data(.,"`fromvar'",0)))
	}
	label values `tovar' `tovar'
end 