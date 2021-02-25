(deftemplate weather
	(slot Outlook (allowed-symbols Sunny Overcast Rain))
	(slot Humidity (allowed-symbols High Normal))
	(slot Wind (allowed-symbols Strong Weak))
)

(defrule nice_weather
	(weather (Outlook ?outlook) (Humidity ?humidity) (Wind ?wind))
	=>
	(if (or	(eq ?outlook Overcast)
			(and (eq ?outlook Sunny) (eq ?humidity Normal))
			(and (eq ?outlook Rain) (eq ?wind Weak))
		)
	then
	(printout t "It is a nice weather!" crlf)
	else
	(printout t "It is not a nice weather!" crlf)
	)
)