# While Loop

## While (\<condition>) {..run code..}

	A while loop will infinitely run through its given code so long as its condition statement is true.  
It will stop looping once the condition is false.

Example:
'''
while ($today is Friday) {
	wait 30 minutes 
	print (Thank god it's Friday!)
}
'''

If you don't want to provide a variable and just want it to run forever, then simply leave $ as the condition, like so:
'''
while ($) {
	...
}
'''

## While (\<condition>) {..run code..} Until (\<condition>)

	This specific While loop will loop infinitely until the second condition is met.

Example:  
'''
While ($) {
	wait 1 hour
	print ($current_time)
} until ($current_time is greater than or equal to 23:00)
'''