(deftemplate conditions
	(slot PrinterCannotPrint (allowed-symbols Yes No))
	(slot RedLightFlashing (allowed-symbols Yes No))
	(slot PrinterUnrecognized (allowed-symbols Yes No))
)

(defrule check_power_cable
	(conditions (PrinterCannotPrint Yes)
				(RedLightFlashing No)
				(PrinterUnrecognized Yes)
	)
	=>
	(printout t "Check the power cable" crlf)
)

(defrule check_printer_computer_cable
	(conditions (PrinterCannotPrint Yes)
				(PrinterUnrecognized Yes)
	)
	=>
	(printout t "Check the printer-computer cable" crlf)
)

(defrule ensure_printer_software_installed
	(conditions (PrinterUnrecognized Yes)
	)
	=>
	(printout t "Ensure printer software is installed" crlf)
)

(defrule check_replace_ink
	(conditions (RedLightFlashing Yes)
	)
	=>
	(printout t "Check/replace ink" crlf)
)

(defrule check_paper_jam
	(conditions (PrinterCannotPrint Yes)
				(PrinterUnrecognized No)
	)
	=>
	(printout t "Check for paper jam" crlf)
)