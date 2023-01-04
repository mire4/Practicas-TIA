; Práctica 2
; Mireia Pires State
(define (problem original) 
  (:domain taxiAutonomo)
  (:objects
    ; Taxis
    taxi1 -taxi
    taxi2 -taxi
    taxi3 -taxi
    taxi4 -taxi
    taxi5 -taxi

    ; Pasajeros
    usuario1 -usuario
    usuario2 -usuario
    usuario3 -usuario
    usuario4 -usuario
    usuario5 -usuario
    usuario6 -usuario
    usuario7 -usuario

    ; Sitios
    A -ubi
    B -ubi
    C -ubi
    D -ubi
    E -ubi
    F -ubi
    G -ubi
  )

  (:init
    ; Taxis
    (= (viajes-maximos) 2)

    (at taxi1 A)
    (= (viajes-pendientes taxi1) 0)
    (= (carga-taxi taxi1) 5)

    (at taxi2 A)
    (= (viajes-pendientes taxi2) 0)
    (= (carga-taxi taxi2) 10)

    (at taxi3 C)
    (= (viajes-pendientes taxi3) 1)
    (= (carga-taxi taxi3) 20)

    (at taxi4 B)
    (= (viajes-pendientes taxi4) 1)
    (= (carga-taxi taxi4) 40)

    (at taxi5 D)
    (= (viajes-pendientes taxi5) 1)
    (= (carga-taxi taxi5) 2)

    ; Pasajeros
    (= (duracion-subir-usuario) 1)
    (= (duracion-bajar-usuario) 1)

    (at usuario1 A)
    (at usuario2 B)
    (at usuario3 F)
    (at usuario4 D)
    (at usuario5 E)
    (at usuario6 A)
    (at usuario7 G)

    ; Sitios
    (= (distancia A A) 0)
    (= (distancia A B) 8)
    (= (distancia A C) 12)
    (= (distancia A D) 20)
    (= (distancia A E) 60)
    (= (distancia A F) 80)
    (= (distancia A G) 120)

    (= (distancia B A) 8)
    (= (distancia B B) 0)
    (= (distancia B C) 4)
    (= (distancia B D) 16)
    (= (distancia B E) 24)
    (= (distancia B F) 48)
    (= (distancia B G) 120)

    (= (distancia C A) 12)
    (= (distancia C B) 4)
    (= (distancia C C) 0)
    (= (distancia C D) 28)
    (= (distancia C E) 56)
    (= (distancia C F) 32)
    (= (distancia C G) 120)

    (= (distancia D A) 20)
    (= (distancia D B) 16)
    (= (distancia D C) 28)
    (= (distancia D D) 0)
    (= (distancia D E) 32)
    (= (distancia D F) 20)
    (= (distancia D G) 120)

    (= (distancia E A) 60)
    (= (distancia E B) 24)
    (= (distancia E C) 56)
    (= (distancia E D) 32)
    (= (distancia E E) 0)
    (= (distancia E F) 100)
    (= (distancia E G) 120)

    (= (distancia F A) 80)
    (= (distancia F B) 48)
    (= (distancia F C) 32)
    (= (distancia F D) 20)
    (= (distancia F E) 100)
    (= (distancia F F) 0)
    (= (distancia F G) 120)

    (= (distancia G A) 140)
    (= (distancia G B) 140)
    (= (distancia G C) 140)
    (= (distancia G D) 140)
    (= (distancia G E) 140)
    (= (distancia G F) 140)
    (= (distancia G G) 0)

    ; Revisión
    (ubi-revision A)
    (ubi-revision C)
    (ubi-revision E)
    (= (duracion-revision) 2)

    ; Carga
    (ubi-carga-rapida A)
    (ubi-carga-rapida B)
    (ubi-carga-rapida C)
    (ubi-carga-rapida G)
    (= (coste-carga-rapida) 5)
    (= (duracion-carga-rapida) 4)
    (= (km-carga-rapida) 50)

    (ubi-carga-lenta A)
    (ubi-carga-lenta D)
    (ubi-carga-lenta F)
    (ubi-carga-lenta G)
    (= (coste-carga-lenta) 8)
    (= (duracion-carga-lenta) 8)
    (= (km-carga-lenta) 100)

    ; Costes
    (= (coste-recargas) 0)
  )

  (:goal (and
      (at usuario1 F)
      (at usuario2 E)
      (at usuario3 D)
      (at usuario4 E)
      (at usuario5 A)
      (at usuario6 G)
      (at usuario7 C)
  ))

  (:metric minimize (+ (* 0.3 (total-time)) (* 0.7 (coste-recargas))))
)
