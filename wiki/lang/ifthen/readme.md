[Back](/wiki/lang)  
# If / Then

	If \<conditional> then {...} (otherwise ... )

One of the more common commands used in programming.  
As the name implies, it checks whether the condition passes, and continues running code.

Examples:
	if $today is Thursday then {
		print(Today is Thursday)
	}
	
	if $bank_account.checking.value is greater than or equal to 5K then {
		print(So rich!)
	}

Sometimes you'll want something specific to happen if the condition isn't met.

Examples:
	if $package.status is delivered then {
		email($host.email, $host.name, $email_subject, $email_body)
	} otherwise {
		print(Package not arrived yet)
	}
	
Occassionally, you'll want to check for multiple conditions.

Example:
	if ($drink_ingredients contains alcohol) and ($drink_ingredients contains strawberry) then {
		order_drink()
	} otherwise if ($drink_ingredients contains alcohol) and ($drink_ingredients contains orange_juice) then {
		print(No thanks)
	} otherwise if ($drink_ingredients does not contain alcohol) then {
		order_drink()
	}