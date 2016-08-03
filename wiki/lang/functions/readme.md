# Functions

Functions are preceded by the # symbol and cannot contain spaces.  
They also support internal placeholder variables. 

Examples:

	#run_this() {
		run(C:\Thursday.psc)
	}
	#run_that() {
		run(C:\Script.psc)
	}

	if $tomorrow is Thursday then {
		run_this()
	} otherwise (
		run_that()
	)


	#Is_It_Thursday($the_date) {
		if $the_date is Thursday then {
			return with true
		} otherwise {
			return with false
		}
	}
