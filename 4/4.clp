(defrule G1
?parsingHistory <- (parsingHistory $?vals)
?myText <- (text $?s1 am ?verb $?s2)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G1 $?s2))
(assert (parsingHistory $?vals G1))
)

(defrule G2
(declare (salience 99))
?parsingHistory <- (parsingHistory $?vals)
?myText <- (text $?s1 o ?noun $?s2)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G2 $?s2))
(assert (parsingHistory $?vals G2))
)

(defrule G3
?myText <- (text $?s1 la G2 $?s2)
?parsingHistory <- (parsingHistory $?vals)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G3 $?s2))
(assert (parsingHistory $?vals G3))
)

(defrule G3B
?myText <- (text $?s1 la ?noun $?s2)
?parsingHistory <- (parsingHistory $?vals)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G3 $?s2))
(assert (parsingHistory $?vals G3.1))
)

(defrule G4
(declare (salience 99))
?parsingHistory <- (parsingHistory $?vals)
?myText <- (text $?s1 G3 G1 $?s2)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G1 $?s2))
(assert (parsingHistory $?vals G4))
)

(defrule G4.1
(declare (salience 99))
?myText <- (text $?s1 G1 G3 $?s2)
?parsingHistory <- (parsingHistory $?vals)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G1 $?s2))
(assert (parsingHistory $?vals G4.1))
)

(defrule G5
(declare (salience 99))
?parsingHistory <- (parsingHistory $?vals)
?myText <- (text $?s1 G2 si G2 $?s2)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G2 $?s2))
(assert (parsingHistory $?vals G5))
)

(defrule G6
?myText <- (text $?s1 G1 si G1 $?s2)
?parsingHistory <- (parsingHistory $?vals)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G1 $?s2))
(assert (parsingHistory $?vals G6))
)

(defrule G7
(declare (salience 99))
?myText <- (text $?s1 G1 si G1 $?s2)
?parsingHistory <- (parsingHistory $?vals)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G1 $?s2))
(assert (parsingHistory $?vals G7))
)

(defrule G8
?myText <- (text $?s1 G1 G2 $?s2)
?parsingHistory <- (parsingHistory $?vals)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G8 $?s2))
(assert (parsingHistory $?vals G8))
)

(defrule G8.1
?myText <- (text $?s1 G8 G3 $?s2)
?parsingHistory <- (parsingHistory $?vals)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G8 $?s2))
(assert (parsingHistory $?vals G8.1))
)

(defrule G8.2
?myText <- (text $?s1 G8 si G8 $?s2)
?parsingHistory <- (parsingHistory $?vals)
=>
(retract ?myText)
(retract ?parsingHistory)
(assert (text $?s1 G8 $?s2))
(assert (parsingHistory $?vals G8.2))
)

(defrule success1
?myText <- (text G8)
?parsingHistory <- (parsingHistory $?vals)
=>
(retract ?myText)
(printout t "DA" $?vals crlf)
)

(defrule success2
?myText <- (text G1)
?parsingHistory <- (parsingHistory $?vals)
=>
(retract ?myText)
(printout t "DA" $?vals  crlf)
)


(defrule fail
?myText <- (text $?vals)
=>
(retract ?myText)
(printout t "NU" crlf)
)

(defrule readText
    ?parseText <- (parseText 1)
    =>
    (printout t "Citeste Textul:" crlf)
    (bind $?text (explode$ (readline)))
    (assert (text $?text))
    (printout t "List:" ?text crlf)
)

(defrule menu
    ?menuVal <- (menu 0)
	=>
	(retract ?menuVal)
	(assert (parseText 1))
)

(defrule main
	=>
	(assert (menu 0))
    (assert (parsingHistory))
)