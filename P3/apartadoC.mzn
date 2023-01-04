% Use this editor as a MiniZinc scratch book
par int: A;
par int: C;
par int: E;
par int: T;
int: NOper;
array [1..NOper] of var int: operaciones = [60, 120, 180, 30, 45, 60];

array [1..A] of var int: anestesistasTiempo;
array [1..C] of var int: cirujanosTiempo;
array [1..E] of var int: enfermerosTiempo;
array [1..T] of var int: tecnicosTiempo;
array [1..A, 1..NOper] of var 0..1: anestesistasTurnos;
array [1..C, 1..NOper] of var 0..1: cirujanosTurnos;
array [1..E, 1..NOper] of var 0..1: enfermerosTurnos;
array [1..T, 1..NOper] of var 0..1: tecnicosTurnos;

%Comprobacion para que se trabaje hasta 6h
constraint forall (j in 1..A) (anestesistasTiempo[j] <= 360); 
constraint forall (j in 1..C) (cirujanosTiempo[j] <= 360); 
constraint forall (j in 1..E) (enfermerosTiempo[j] <= 360);
constraint forall (j in 1..T) (tecnicosTiempo[j] <= 360);

%Para saber el tiempo que trabaja cada persona
constraint forall (j in 1..A)(anestesistasTiempo[j] = (sum (i in 1..NOper) (operaciones[i] * anestesistasTurnos[j, i])));
constraint forall (j in 1..C)(cirujanosTiempo[j] = (sum (i in 1..NOper) (operaciones[i] * cirujanosTurnos[j, i])));
constraint forall (j in 1..E)(enfermerosTiempo[j] = (sum (i in 1..NOper) (operaciones[i] * enfermerosTurnos[j, i])));
constraint forall (j in 1..T)(tecnicosTiempo[j] = (sum (i in 1..NOper) (operaciones[i] * tecnicosTurnos[j, i])));

%Comprobacion de que en cada turno/operacion hay la cantidad de especialistas necesaria
constraint forall (j in 1..NOper) (sum(i in 1..A)(anestesistasTurnos[i, j]) == 1 );
constraint forall (j in 1..NOper) (sum(i in 1..E)(enfermerosTurnos[i, j]) == 2 );
constraint forall (j in 1..NOper) (sum(i in 1..T)(tecnicosTurnos[i, j]) == 2 );
constraint forall (j in 1..NOper where j != 4)(sum(i in 1..C)(cirujanosTurnos[i, j]) == 1 );

%Comprobacion de que la operacion 4 tiene al menos 2 cirujanos
constraint forall (j in 1..NOper where j == 4)(sum(i in 1..C)(cirujanosTurnos[i, j]) == 2 );

%Comprobacion de que no se realizan mas de tres operaciones por trabajador/a
constraint forall (j in 1..A) (sum(i in 1..NOper)(anestesistasTurnos[j, i]) <= 3 );
constraint forall (j in 1..C) (sum(i in 1..NOper)(cirujanosTurnos[j, i]) <= 3 );
constraint forall (j in 1..E) (sum(i in 1..NOper)(enfermerosTurnos[j, i]) <= 3 );
constraint forall (j in 1..T) (sum(i in 1..NOper)(tecnicosTurnos[j, i]) <= 3 );

%Comprobacion de que el cirujano no realiza operaciones consecutivas
constraint forall (j in 1..C, i in 1..NOper - 1) (cirujanosTurnos[j, i] != cirujanosTurnos[j, i + 1] /\ cirujanosTurnos[j, i] = 0 \/ cirujanosTurnos[j, i + 1] = 0);

%Comprobacion de que los cirujanos hacen las operaciones que se les han asignado
constraint cirujanosTurnos[2, 1] == 1 xor cirujanosTurnos[3, 1] == 1;
constraint cirujanosTurnos[1, 2] == 1 xor cirujanosTurnos[2, 2] == 1;
constraint cirujanosTurnos[1, 3] == 1 xor cirujanosTurnos[3, 3] == 1;


solve satisfy;