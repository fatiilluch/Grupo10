% Trabajo Practico De Prolog
% Parte 1: https://docs.google.com/document/d/1zEWqw1M1wiZpKjSjvVd_FdV9yVrXW9Ks2xN7smN3icI/edit
%-------------------------------------------------------1 Punto A: Quién mira qué------------------------------------------------------
:- encoding(utf8).

mira(juan, himym).
mira(juan, futurama).
mira(juan, got).

mira(nico, starWars).
mira(nico, got).

mira(maiu, starWars).
mira(maiu, onePiece).
mira(maiu, got).

mira(gastón, hoc).

popular(got).
popular(hoc).
popular(starWars).

quiereVer(juan, hoc).
quiereVer(aye, got).
quiereVer(gastón, himym).

% Issue #17 Recomendacion pava

espisodiosPorTemporadaDe(got, 3, 12).
espisodiosPorTemporadaDe(got, 2, 10).
espisodiosPorTemporadaDe(himym, 1, 23).
espisodiosPorTemporadaDe(drHouse, 8, 16).

/*
 Issue #18 Justificacion Principio de universo cerrado

Por definición de principio de universo cerrado se omita de la base de conocimientos los siguientes fragmentos del enunciado:
 .- Nadie mira “Mad men”
 .- Alf no ve ninguna serie porque el doctorado le consume toda la vida
 .- No recordamos cuántos episodios tiene la segunda temporada de “Mad men”

porque el motor asume como falso todo lo que no pueda probar como verdadero.

*/

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
leDijo(aye, juan, got, relación(amistad, tyrion, jhon)).
leDijo(aye, maiu, got, relación(amistad, tyrion, jhon)).
leDijo(aye, gastón, got, relación(amistad, tyrion, dragón)).

%-------------------------------------------------------3 Punto B: Es spoiler------------------------------------------------------

esSpoiler(Serie, Spoiler):- paso(Serie, _, _, Spoiler).

/*

Issue #19 Justificacion punto 3

Los tipos de consultas que se pueden hacer a la base de conocimientos son:
  .- Existenciales.
                    Por ejemplo haciendo la siguiente consulta:
                                                                esSpoiler(Serie,Spoiler).
                   Donde consulto si hay alguna serie que tiene spoiler en dicha base de conocimientos .Gracias a la
                   inversibilidad pasamos 2 (dos) incognicas Serie y Spoiler sin unificar para que después el motor nos las
                   unifique .
  .- Individual.
                  Por ejemplo haciendo la siguiente consulta:
                                                              esSpoiler(starWars,muerte(emperor)).
                   Donde se consulta si una serie tiene un cierto spoiler que se encuentre en la base de conocimientos. Mandamos
                   las variables unificadas y esperamos que nos diga true o false.

*/

%-------------------------------------------------------4 Punto C: Te pedí que no me lo dijeras------------------------------------------------------

% Issue #20  Expresividad en punto 4
% Issue #22 Predicado segunLaSerie

loQueVeElTelevidente(Televidente, Serie):- mira(Televidente, Serie).
loQueVeElTelevidente(Televidente, Serie):- quiereVer(Televidente, Serie).

leSpoileo(PersonaChamuyera, PersonaPerjudicada, Serie):-
  loQueVeElTelevidente(PersonaPerjudicada, Serie),
  leDijo(PersonaChamuyera, PersonaPerjudicada, Serie, Spoiler),
  esSpoiler(Serie, Spoiler).


/*
Issue #21 Justificacion teorica punto 4

Se pueden hacer consultas:
                          Individuales como:
                                              leSpoileo(gastón,maiu,got).
                        Consultamos si gastón le spoileo a maiu la serie got (Game of Thore).
                        Mandando las variables unificadas y esperamos que nos diga true o false.
y también pueden ser :
                        Existencial como:
                                              leSpoileo(gastón,maiu,Serie).
                        Consultamos si gastón le spoileo maiu alguna serie de nuestra base de conocimientos.
                        Gracias a la inversibilidad pasamos como incognicas a Serie sin unificar para que después el motor nos las
                        unifique .

*/
%-------------------------------------------------------5 Punto D: Responsable------------------------------------------------------

televidenteResponsable(Televidente):- loQueVeElTelevidente(Televidente, _), not(leSpoileo(Televidente, _, _)).

% BONUS:​ Lograr que el predicado sea inversible.

%-------------------------------------------------------6 Punto E: Viene Zafando------------------------------------------------------

esFuerte(Serie, Temporada):-paso(Serie, Temporada, _, muerte(_)).
esFuerte(Serie, Temporada):-paso(Serie, Temporada, _, relación(amorosa, _, _)).
esFuerte(Serie, Temporada):-paso(Serie, Temporada, _, relación(parentesco, _, _)).

%Issue #23 Pedicado segúnLaSerie

laSerieEsPopularOEsFuerte(Serie):- popular(Serie).
laSerieEsPopularOEsFuerte(Serie):-
  espisodiosPorTemporadaDe(Serie, Temporada, _),
  forall( espisodiosPorTemporadaDe(Serie, Temporada, _), esFuerte(Serie, Temporada)). %Issue 24 Pequeño cambio en forall


vieneZafando(Televidente, Serie):-
 loQueVeElTelevidente(Televidente, Serie),
  not(leSpoileo(_, Televidente, Serie)),
  laSerieEsPopularOEsFuerte(Serie).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7 Testing  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(debug).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test: 3 Punto B: Es spoiler %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(es_cierto_que_la_muerte_de_Emperor_para_Star_Wars, nondet):-
  esSpoiler(starWars, muerte(emperor)).

%Issue #25 test(es_cierto_que_la_muerte_de_Emperor_para_Star_Wars, fail)
test(es_cierto_que_la_muerte_de_Pedro_para_Star_Wars, fail):-
  esSpoiler(starWars, muerte(pedro)).

test(es_cierto_que_la_relación_de_parentesco_entre_Anakin_y_el_Rey_es_un_spoiler_para_Star_Wars, nondet):-
  esSpoiler(starWars, relación(parentesco, anakin, rey)).

test(es_cierto_que_la_relación_de_parentesco_entre_Anakin_y_Lavezzi_sea_un_spoiler_para_Star_Wars, fail):-
  esSpoiler(starWars, relación(parentesco, anakin, lavezzi)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test: 4 Punto C: Te pedí que no me lo dijeras %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tets(gastón_le_dijo_a_Maiu_un_spoiler_de_Game_of_Thrones, nondet):-
    leSpoileo(gastón, maiu, got).

test(nico_le_dijo_a_Maiu_un_spoiler_de_Star_War, nondet):-
    leSpoileo(nico, maiu, starWars).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test: 5 Punto D: Responsable %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Issue #26 test juan_aye_y_maiu_son_televidentes_responsables

test(juan_es_televidente_responsable, nondet):-
    televidenteResponsable(juan).

test(aye_es_televidente_responsable, nondet):-
    televidenteResponsable(aye).

test(maiu_es_televidente_responsable, nondet):-
    televidenteResponsable(maiu).

test(nico_es_televidente_responsable, fail):-
    televidenteResponsable(nico).

test(gastón_es_televidente_responsable, fail):-
    televidenteResponsable(gastón).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test: 6 Punto E: Viene Zafando %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(maiu_no_viene_zafando_con_ninguna_serie, fail):-
  vieneZafando(maiu, _).

test(juan_viene_zafando_tanto_con_himym, nondet ):-
  vieneZafando(juan, himym).

test(juan_viene_zafando_tanto_con_got, nondet):-
  vieneZafando(juan, got).

test(juan_viene_zafando_tanto_con_hoc, nondet):-
  vieneZafando(juan, hoc).

test(nico_viene_zafando_con_Star_Wars, [ true(Televidente == nico), nondet ] ):-
  vieneZafando(Televidente, starWars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- end_tests(debug).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
