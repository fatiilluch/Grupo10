% Trabajo Practico De Prolog
% Parte 1: https://docs.google.com/document/d/1zEWqw1M1wiZpKjSjvVd_FdV9yVrXW9Ks2xN7smN3icI/edit
%-------------------------------------------------------1 Punto A: Quién mira qué------------------------------------------------------

mira(juan, himym).
mira(juan, futurama).
mira(juan, got).

mira(nico, starWars).
mira(nico, got).

mira(maiu, starWars).
mira(maiu, onePiece).
mira(maiu, got).

mira(gastón,hoc).

popular(got).
popular(hoc).
popular(starWars).

quiereVer(juan, hoc).
quiereVer(aye, got).
quiereVer(gastón, himym).

espisodiosPorTemporadaDe(got, 12, 3).
espisodiosPorTemporadaDe(got, 10, 2).
espisodiosPorTemporadaDe(himym, 23, 1).
espisodiosPorTemporadaDe(drHouse, 16, 8).


% Por definición de universo cerrado se omita de la base de conocimientos los siguientes fragmentos del enunciado:
% .- Nadie mira “Mad men”
% .- Alf no ve ninguna serie porque el doctorado le consume toda la vida
% .- No recordamos cuántos episodios tiene la segunda temporada de “Mad men”


%-------------------------------------------------------2 Anexo: Lo que pasó, pasó------------------------------------------------------

paso(futurama, 2, 3, muerte(seymourDiera)).
paso(starWars, 10, 9, muerte(emperor)).
paso(starWars, 1, 2, relación(parentesco, anakin, rey)).
paso(starWars, 3, 2, relación(parentesco, vader, luke)).
paso(himym, 1, 1, relación(amorosa, ted, robin)).
paso(himym, 4, 3, relación(amorosa, swarley, robin)).
paso(got, 4, 5, relación(amistad, tyrion, dragón)).

leDijo(gastón, maiu, got, relación(amistad,tyrion,dragón)).
leDijo(nico, maiu, starWars, relación(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)).
leDijo(aye, juan, got, relación(amistad,tyrion,jhon)).
leDijo(aye, maiu, got, relación(amistad,tyrion,jhon)).
leDijo(aye, gastón, got, relación(amistad,tyrion,dragón)).

%-------------------------------------------------------3 Punto B: Es spoiler------------------------------------------------------

esSpoiler(Serie,Spoiler):- paso(Serie,_,_,Spoiler).

/*
Los tipos de consultas que se pueden hacer a la base de conocimientos son:
  .- Existenciales.
                    Por ejemplo haciendo la siguiente consulta:
                                                                esSpoiler(Serie,Spoiler).
                   donde consulto si hay alguna serie q tiene spoiler en dicha base de conocimientos.
  .- Individual.
                  Por ejemplo haciendo la siguiente consulta:
                                                              esSpoiler(starWars,muerte(emperor)).
                   donde se consulta si una serie tiene un cierto spoiler que se encuentre en la base de conocimientos.
*/

%-------------------------------------------------------4 Punto C: Te pedí que no me lo dijeras------------------------------------------------------

segúnLaSerie(Persona, Serie):- mira(Persona, Serie).
segúnLaSerie(Persona, Serie):- quiereVer(Persona, Serie).

leSpoileo(Persona1, Persona2, Serie):-
  segúnLaSerie(Persona2, Serie),
  leDijo(Persona1, Persona2, Serie, Spoiler),
  esSpoiler(Serie, Spoiler).


/*
Se pueden hacer consultas Individuales como:
                                          leSpoileo(gastón,maiu,got).
y también pueden ser Existencial como:
                                      leSpoileo(gastón,maiu,Serie).
*/
%-------------------------------------------------------5 Punto D: Responsable------------------------------------------------------

televidenteResponsable(Persona1):- segúnLaSerie(Persona1, _), not( (leSpoileo(Persona1, _, _)) ).

%-------------------------------------------------------6 Punto E: Viene Zafando------------------------------------------------------

esFuerte(Serie,Temporada):-paso(Serie,Temporada,_,muerte(_)).
esFuerte(Serie,Temporada):-paso(Serie,Temporada,_,relación(amorosa, _, _)).
esFuerte(Serie,Temporada):-paso(Serie,Temporada,_,relación(parentesco, _, _)).

segúnLaSerie(Serie):- popular(Serie).
segúnLaSerie(Serie):-
  espisodiosPorTemporadaDe(Serie,_,Temporada),
  forall(paso(Serie,Temporada,_,_), esFuerte(Serie,Temporada)).

vieneZafando(Persona2, Serie):-
  segúnLaSerie(Persona2, Serie),
  not( leSpoileo(_,Persona2, Serie) ),
  segúnLaSerie(Serie).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7 Testing  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(debug).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test: 3 Punto B: Es spoiler %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(es_cierto_que_la_muerte_de_Emperor_para_Star_Wars, nondet):-
  esSpoiler(starWars, muerte(emperor)).

test(es_cierto_que_la_muerte_de_Emperor_para_Star_Wars, fail):-
  esSpoiler(starWars, muerte(pedro)).

test(es_cierto_que_la_relación_de_parentesco_entre_Anakin_y_el_Rey_es_un_spoiler_para_Star_Wars,nondet):-
  esSpoiler(starWars, relación(parentesco, anakin, rey)).

test(es_cierto_que_la_relación_de_parentesco_entre_Anakin_y_Lavezzi_sea_un_spoiler_para_Star_Wars, fail):-
  esSpoiler(starWars, relación(parentesco, anakin, lavezzi)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test: 4 Punto C: Te pedí que no me lo dijeras %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tets(gastón_le_dijo_a_Maiu_un_spoiler_de_Game_of_Thrones , nondet):-
    leSpoileo(gastón, maiu, got).

test(nico_le_dijo_a_Maiu_un_spoiler_de_Star_War, nondet):-
    leSpoileo(nico, maiu, starWars).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test: 5 Punto D: Responsable %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(juan_aye_y_maiu_son_televidentes_responsables, set(Personas == [juan, aye, maiu])):-
    televidenteResponsable(Personas).

% BONUS:​ Lograr que el predicado sea inversible.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test: 6 Punto E: Viene Zafando %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(maiu_no_viene_zafando_con_ninguna_serie, fail):-
  vieneZafando(maiu, _).

test(juan_viene_zafando_tanto_con_himym_got_y_hoc, set( Series == [himym, got, hoc]) ):-
  vieneZafando(juan,Series).

test(nico_viene_zafando_con_Star_Wars, nondet):-
  vieneZafando(nico, starWars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- end_tests(debug).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
