;Practica 2
;Mireia Pires State
(define (domain taxiAutonomo)

    (:requirements :strips :typing :durative-actions :fluents)

    ;; Tipos
    ;;  taxi: el taxi
    ;;  persona: el usuario
    ;;  punto: donde para el taxi
    (:types taxi persona punto -object)

    (:predicates
        (at ?x -(either passenger taxi) ?p -place)
        (in ?p -passenger ?t -taxi)
        (aval-revision-place ?p -place)
        (aval-fast-charge-place ?p -place)
        (aval-slow-charge-place ?p -place)
    )

)