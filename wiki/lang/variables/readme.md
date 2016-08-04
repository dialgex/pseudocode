[Back](/wiki/lang)  
# Variables

All variables in Pseudocode are preceded by the $ symbol and cannot contain spaces.  

Variables have 3 different types:
* String  
* Number  
* Boolean (True/False)  

The language will be able to identify on its own whether a variable is a number, string, or a boolean.  
However, if it is a mix of letters and numbers, it will default to being a string.

Example:  

	$Today is Wednesday  
	$Tomorrow is Thursday  

	print ($Today)  
	:Wednesday  

	print ($ Tomorrow)  
	:$ Tomorrow  
	
If you want to delete a variable all you have to do is make it empty.  
You can do so like this:  

	Delete $VarA  
	Empty $VarA  
	Nullify $VarA  
	
	$VarB is empty  
	$VarB is null  
	$VarB is deleted  
	
If you want to specify a variable's type, here's some ways to do that:  

	$day is a string  
	$time is a number  
	$noon is true
