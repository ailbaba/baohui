function getVoucherId(str)
{
//	alert(s) ;
	var s = str.split(",") ;
	if(s.length == 3)
	{
	   return s[1] ;
	}
	else if(s.length == 2)
	{
		return s[1] ;
	}
	return str ;
}