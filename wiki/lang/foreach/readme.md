# For Each

	for each \<placeholder> in \<argument> {...}

This function cycles through all arguments in a given variable or function.

Some variations of this function:
	For each
	For every
	For all

Examples:  
	for every $day in $the_week {
		print($day)
	}
	
	for each $contact in $address_book {
		print($contact.name)
		print($contact.email)
	}
	
	for all $participants in $sweepstakes {
		email($participants.email, $participants.name, $email_subject, $email_body)
	}