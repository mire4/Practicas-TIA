; Práctica 2
; Mireia Pires State
(define (domain taxiAutonomo)

  (:requirements :strips :fluents :typing)

  (:types taxi usuario ubi -object)

  (:predicates
    (at ?x -(either usuario taxi) ?p -ubi)
    (in ?p -usuario ?t -taxi)
    (ubi-revision ?p -ubi)
    (ubi-carga-rapida ?p -ubi)
    (ubi-carga-lenta ?p -ubi)
    (ubi-carga-bono ?p -ubi)
  )


  (:functions
    ; Taxi
    (viajes-maximos)
    (viajes-pendientes ?t -taxi)
    (carga-taxi ?t -taxi)

    ; Pasajero
    (num-billetes ?p)
    (duracion-subir-usuario)
    (duracion-bajar-usuario)

    ; Sitios
    (distancia ?p1 -ubi ?p2 -ubi)

    ; Revisión
    (duracion-revision)

    ; Carga
    (coste-carga-rapida)
    (duracion-carga-rapida)
    (km-carga-rapida)
    (coste-carga-lenta)
    (duracion-carga-lenta)
    (km-carga-lenta)

    ; Recarga billetes
    (coste-recargar-bono)
    (coste-recargar-billete)
    (duracion-recargar-bono)
    (duracion-recargar-billete)
    (num-billetes-bono)
    (num-billetes-individual)

    ; Beneficio
    (beneficio-empresa)

    ; Coste
    (coste-recargas)
  )

  (:durative-action subir-usuario
      :parameters (?p -usuario ?t -taxi ?pl -ubi)
      :duration (= ?duration (duracion-subir-usuario))
      :condition (and
          (at start 
            (> (viajes-pendientes ?t) 0))
          (at start 
            (> (num-billetes ?p) 0))
          (at start
            (at ?p ?pl))
          (at start
            (at ?t ?pl))
          ; Otro pasajero no está en el taxi
          (at start 
            (not (exists (?op -usuario)
              (in ?op ?t))))
          (over all
            (at ?t ?pl))
      )
      :effect (and 
          (at start
            (not (at ?p ?pl)))
          (at end
            (in ?p ?t))
      )
  )

  (:durative-action bajar-usuario
      :parameters (?p -usuario ?t -taxi ?pl -ubi)
      :duration (= ?duration (duracion-bajar-usuario))
      :condition (and 
          (at start
            (at ?t ?pl))
          (at start
            (in ?p ?t))
          (over all
            (at ?t ?pl))
      )
      :effect (and
          (at start
            (not (in ?p ?t)))
          (at end
            (at ?p ?pl))
          (at end
            (decrease (viajes-pendientes ?t) 1))
      )
  )
  
  (:durative-action mover-taxi
      :parameters (?t -taxi ?p1 -ubi ?p2 -ubi)
      :duration (= ?duration (/ (distancia ?p1 ?p2) 4))
      :condition (and
          (at start
            (not (= ?p1 ?p2)))
          (at start
            (>= (carga-taxi ?t) (distancia ?p1 ?p2)))
          (at start
            (at ?t ?p1))
          )
      :effect (and 
          (at start
            (not (at ?t ?p1)))
          (at end
            (at ?t ?p2))
          (at end
            (decrease (carga-taxi ?t) (distancia ?p1 ?p2)))
      )
  )

  (:durative-action cargar-con-bateria-rapida
      :parameters (?t -taxi ?p -ubi)
      :duration (= ?duration (duracion-carga-rapida))
      :condition (and 
          (at start
            (at ?t ?p))
          (at start
            (ubi-carga-rapida ?p))
          (over all
            (at ?t ?p))
      )
      :effect (and 
          (at start
            (not (ubi-carga-rapida ?p)))
          (at end
            (ubi-carga-rapida ?p))
          (at end
            (increase (coste-recargas) (coste-carga-rapida)))
          (at end
            (increase (carga-taxi ?t) (km-carga-rapida)))
      )
  )
  
  (:durative-action cargar-con-bateria-lenta
      :parameters (?t -taxi ?p -ubi)
      :duration (= ?duration (duracion-carga-lenta))
      :condition (and 
          (at start
            (at ?t ?p))
          (at start
            (ubi-carga-lenta ?p))
          (over all
            (at ?t ?p))
      )
      :effect (and 
          (at start
            (not (ubi-carga-lenta ?p)))
          (at end
            (ubi-carga-lenta ?p))
          (at end
            (increase (coste-recargas) (coste-carga-lenta)))
          (at end
            (increase (carga-taxi ?t) (km-carga-lenta)))
      )
  )
  
  (:durative-action revisar-taxi
      :parameters (?t -taxi ?p -ubi)
      :duration (= ?duration (duracion-revision))
      :condition (and 
          (at start
            (<= (viajes-pendientes ?t) (- (viajes-maximos) 1)))
          (at start
            (at ?t ?p))
          (at start
            (ubi-revision ?p))
          (over all
            (at ?t ?p))
      )
      :effect (and 
          (at start
            (not (ubi-revision ?p)))
          (at end
            (ubi-revision ?p))
          (at end
            (assign (viajes-pendientes ?t) (viajes-maximos)))
      )
  )

  (:durative-action cargar-bono
      :parameters (?p -usuario ?p1 -ubi)
      :duration (= ?duration (duracion-recargar-bono))
      :condition (and 
          (at start
            (at ?p ?p1))
          (at start
            (ubi-carga-bono ?p1))
          (over all
            (at ?p ?p1))
      )
      :effect (and 
          (at start
            (not (ubi-carga-bono ?p1)))
          (at end
            (ubi-carga-bono ?p1))
          (at end
            (increase (beneficio-empresa) (coste-recargar-bono)))
          (at end
            (increase (num-billetes ?p) (num-billetes-bono)))
      )
  )

  (:durative-action cargar-billete-individual
      :parameters (?p -usuario ?p1 -ubi ?t -taxi)
      :duration (= ?duration (duracion-recargar-billete))
      :condition (and 
          (at start
            (at ?p ?p1))
          (at start
            (at ?t ?p1))
          (over all
            (at ?p ?p1))
          (over all
            (at ?t ?p1))
      )
      :effect (and 
          (at start
            (not (ubi-carga-bono ?p1)))
          (at end
            (ubi-carga-bono ?p1))
          (at end
            (increase (beneficio-empresa) (coste-recargar-billete)))
          (at end
            (increase (num-billetes ?p) (num-billetes-individual)))
      )
  )
  
)