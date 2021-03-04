(deffunction read-list ()
	(bind $?vals (explode$ (readline)))
	(return $?vals)
)

(deffunction bubble-sort ($?vals)
	(bind ?valsLen (length $?vals))
	(loop-for-count (?i 1 ?valsLen) do
		(loop-for-count (?j (+ ?i 1) ?valsLen) do
			(bind ?leftVal (nth$ ?i $?vals))
			(bind ?rightVal (nth$ ?j $?vals))
			(if (> ?leftVal ?rightVal) then
				(bind ?temp ?leftVal)
				(bind $?vals (replace$ $?vals ?i ?i ?rightVal))
				(bind $?vals (replace$ $?vals ?j ?j ?temp))
			)
		)	
	)
	(return $?vals)
)

(deffunction partition (?low ?high $?vals)
	(bind ?pivot (nth$ ?high $?vals))
	(bind ?i (- ?low 1))
	(loop-for-count (?j ?low (- ?high 1)) do
		(bind ?jVal (nth$ ?j $?vals))
		(if (<= ?jVal ?pivot) then
			(bind ?i (+ ?i 1))
			(bind ?iVal (nth$ ?i $?vals))
			(bind $?vals (replace$ $?vals ?i ?i ?jVal))
			(bind $?vals (replace$ $?vals ?j ?j ?iVal))
		)
	)
	(bind ?i (+ ?i 1))
	(bind ?iVal (nth$ ?i $?vals))
	(bind ?highVal (nth$ ?high $?vals))
	(bind $?vals (replace$ $?vals ?i ?i ?highVal))
	(bind $?vals (replace$ $?vals ?high ?high ?iVal))
	(return (create$ ?i $?vals))
)
	
(deffunction quick-sort-helper (?low ?high $?vals)
	(if (< ?low ?high) then
		(bind $?partitionResult (partition ?low ?high $?vals))
		(bind ?part (nth$ 1 $?partitionResult))
		(bind $?vals (rest$ $?partitionResult))
		(bind $?vals (quick-sort-helper ?low (- ?part 1) $?vals))
		(bind $?vals (quick-sort-helper (+ ?part 1) ?high $?vals))
	)
	(return $?vals)
)

(deffunction quick-sort ($?vals)
	(return (quick-sort-helper 1 (length $?vals) $?vals))
)

(deffunction append-element (?element $?vals)
	(bind $?vals (insert$ $?vals (+ (length $?vals) 1) ?element))
	(return $?vals)
)

(deffunction get-unique-elements ($?vals)
	(bind $?vals (quick-sort $?vals))
	(bind $?uniqueVals (create$ (nth$ 1 $?vals)))
	(loop-for-count (?i 2 (length $?vals)) do
		(if (neq (nth$ ?i $?vals) (nth$ (- ?i 1) $?vals)) then
			(bind $?uniqueVals (insert$ $?uniqueVals (+ (length $?uniqueVals) 1) (nth$ ?i $?vals)))
		)
	)
	(return $?uniqueVals)
)

(defrule read-list-rule
	?menuVal <- (menu 1)
	=>
	(bind $?vals (read-list))
	(assert (list $?vals))
	(printout t "Read values: " $?vals crlf)
	(retract ?menuVal)
	(assert (menu 0))
)

(defrule bubble-sort-rule
	?menuVal <- (menu 2)
	(list $?vals)
	=>
	(bind $?vals (bubble-sort $?vals))
	(printout t "Sorted values(using Bubble-Sort): " $?vals crlf)
	(retract ?menuVal)
	(assert (menu 0))
)

(defrule quick-sort-rule
	?menuVal <- (menu 3)
	(list $?vals)
	=>
	(bind $?vals (quick-sort $?vals))
	(printout t "Sorted values(using Quick-Sort): " $?vals crlf)
	(retract ?menuVal)
	(assert (menu 0))
)

(defrule append-element-rule
	?menuVal <- (menu 4)
	?listVal <- (list $?vals)
	=>
	(printout t "Which element do you want to insert in the list?" crlf)
	(bind ?element (read))
	(bind $?vals (append-element ?element $?vals))
	(retract ?listVal)
	(assert (list $?vals))
	(printout t "List values: " $?vals crlf)
	(retract ?menuVal)
	(assert (menu 0))
)

(defrule get-unique-elements-rule
	?menuVal <- (menu 5)
	(list $?vals)
	=>
	(bind $?vals (get-unique-elements $?vals))
	(printout t "Unique list elements: " $?vals crlf)
	(retract ?menuVal)
	(assert (menu 0))
)

(defrule quit-rule
	?menuVal <- (menu 6)
	=>
	(retract ?menuVal)
)

(defrule menu
	?menuVal <- (menu 0)
	=>
	(printout t "1. Citeste lista." crlf)
	(printout t "2. Afiseaza lista sortata crescator cu BubbleSort." crlf)
	(printout t "3. Afiseaza lista sortata crescator cu QuickSort." crlf)
	(printout t "4. Adauga un element in lista." crlf)
	(printout t "5. Afiseaza elementele care apar o singura data." crlf)
	(printout t "6. Iesire." crlf)
	(bind ?option (read))
	(retract ?menuVal)
	(assert (menu ?option))
)

(defrule main
	=>
	(assert (menu 0))
)