/*
Trabajo Práctico De Prolog
  Parte 1: https://docs.google.com/document/d/1zEWqw1M1wiZpKjSjvVd_FdV9yVrXW9Ks2xN7smN3icI/edit
  Parte 2: https://docs.google.com/document/d/1FEHfmBmZJvgLqUsCLQTLKmA50fGhznyct7o0s3YQRuE/edit
*/

:- encoding(utf8).

/*#################################################################################################################################
#                                                  _____           _         __                                                   #
#                                                 |  __ \         | |       /_ |                                                  #
#                                                 | |__) |_ _ _ __| |_ ___   | |                                                  #
#                                                 |  ___/ _` | '__| __/ _ \  | |                                                  #
#                                                 | |  | (_| | |  | ||  __/  | |                                                  #
#                                                 |_|   \__,_|_|   \__\___|  |_|                                                  #
#                                                                                                                                 #
###################################################################################################################################*/

%----------------------------------------------       1 Punto A: Quién mira qué      ----------------------------------------------

mira(juan, himym).
mira(juan, futurama).
mira(juan, got).

mira(nico, starWars).
mira(nico, got).

mira(maiu, starWars).
mira(maiu, onePiece).
mira(maiu, got).

mira(gastón, hoc).

% Agregado del Punto 1 Punto A: Malo, malo, malo eres... (Parte 2)
mira(pedro,got).

popular(got).
popular(hoc).
popular(starWars).

quiereVer(juan, hoc).
quiereVer(aye, got).
quiereVer(gastón, himym).

% Issue #17 Recomendacion pava

temporardaPorEpisodios(got, 3, 12).
temporardaPorEpisodios(got, 2, 10).
temporardaPorEpisodios(himym, 1, 23).
temporardaPorEpisodios(drHouse, 8, 16).

/*
 Issue #18 Justificacion Principio de universo cerrado

Por definición de principio de universo cerrado se omita de la base de conocimientos los siguientes fragmentos del enunciado:
 .- Nadie mira “Mad men”
 .- Alf no ve ninguna serie porque el doctorado le consume toda la vida
 .- No recordamos cuántos episodios tiene la segunda temporada de “Mad men”

porque el motor asume como falso todo lo que no pueda probar como verdadero.

*/

%----------------------------------------------      2 Anexo: Lo que pasó, pasó      ----------------------------------------------

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

% Agregado del Punto 1 Punto A: Malo, malo, malo eres... (Parte 2)
leDijo(nico,juan,futurama,muerte(seymourDiera)).
leDijo(pedro,aye,got,relación(amistad,tyron,dragón)).
leDijo(aye,nico,got,relación(parentesco,tyron,dragón)).

%----------------------------------------------          3 Punto B: Es spoiler       ----------------------------------------------

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

%---------------------------------------------- 4 Punto C: Te pedí que no me lo dijeras -------------------------------------------

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
%----------------------------------------------        5 Punto D: Responsable        ----------------------------------------------

televidenteResponsable(Televidente):- loQueVeElTelevidente(Televidente, _), not(leSpoileo(Televidente, _, _)).

% BONUS:​ Lograr que el predicado sea inversible.

%----------------------------------------------       6 Punto E: Viene Zafando       ----------------------------------------------

esFuerte(Serie, Temporada):-paso(Serie, Temporada, _, muerte(_)).
esFuerte(Serie, Temporada):-paso(Serie, Temporada, _, relación(amorosa, _, _)).
esFuerte(Serie, Temporada):-paso(Serie, Temporada, _, relación(parentesco, _, _)).

%Issue #23 Pedicado segúnLaSerie

laSerieEsPopularOEsFuerte(Serie):- popular(Serie).
laSerieEsPopularOEsFuerte(Serie):-
  temporardaPorEpisodios(Serie, Temporada, _),
  forall( temporardaPorEpisodios(Serie, Temporada, _), esFuerte(Serie, Temporada)). %Issue 24 Pequeño cambio en forall


vieneZafando(Televidente, Serie):-
  loQueVeElTelevidente(Televidente, Serie),
  not(leSpoileo(_, Televidente, Serie)),
  laSerieEsPopularOEsFuerte(Serie).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              7 Testing              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(debugParte1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      Test: 3 Punto B: Es spoiler    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(es_cierto_que_la_muerte_de_Emperor_para_Star_Wars, nondet):-
  esSpoiler(starWars, muerte(emperor)).

%Issue #25 test(es_cierto_que_la_muerte_de_Emperor_para_Star_Wars, fail)
test(es_cierto_que_la_muerte_de_Pedro_para_Star_Wars, fail):-
  esSpoiler(starWars, muerte(pedro)).

test(es_cierto_que_la_relación_de_parentesco_entre_Anakin_y_el_Rey_es_un_spoiler_para_Star_Wars, nondet):-
  esSpoiler(starWars, relación(parentesco, anakin, rey)).

test(es_cierto_que_la_relación_de_parentesco_entre_Anakin_y_Lavezzi_sea_un_spoiler_para_Star_Wars, fail):-
  esSpoiler(starWars, relación(parentesco, anakin, lavezzi)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test: 4 Punto C: Te pedí que no me lo dijeras %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tets(gastón_le_dijo_a_Maiu_un_spoiler_de_Game_of_Thrones, nondet):-
    leSpoileo(gastón, maiu, got).

test(nico_le_dijo_a_Maiu_un_spoiler_de_Star_War, nondet):-
    leSpoileo(nico, maiu, starWars).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     Test: 5 Punto D: Responsable    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Test: 6 Punto E: Viene Zafando   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- end_tests(debugParte1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*#################################################################################################################################
#                                                  _____           _         ___                                                  #
#                                                 |  __  \        | |       |__  \                                                #
#                                                 | |__) |_ _ _ __| |_ ___     ) |                                                #
#                                                 |  ___/ _` | '__| __/ _ \   / /                                                 #
#                                                 | |  | (_| | |  | ||  __/  / /_                                                 #
#                                                 |_|   \__,_|_|   \__\___| |____|                                                #
#                                                                                                                                 #
###################################################################################################################################*/

%---------------------------------------------- 1 Punto A: Malo, malo, malo eres...  ----------------------------------------------

eresMalo(PersonaMala, PersonaInocente, Serie):-
  forall(leDijo(PersonaMala, PersonaInocente, Serie, _), leSpoileo(PersonaMala, PersonaInocente, Serie)).

eresMalo(PersonaMala, PersonaInocente, Serie):-
  leSpoileo(PersonaInocente, PersonaMala, Serie),
  mira(PersonaMala, Serie).

malaGente(PersonaMala):-
  leDijo(PersonaMala, PersonaInocente, Serie, _),
  eresMalo(PersonaMala, PersonaInocente, Serie).

%---------------------------------------------- 2 Punto B: Series con cosas fuertes  ----------------------------------------------

plotTwists(got,3,2,[suenio,sinPiernas]).
plotTwists(got,3,12,[fuego,boda]).
plotTwists(superCampeones,9,9,[suenio,coma,sinPiernas]).
plotTwists(drHouse,8,7,[coma,pastillas]).


fuerte(plotTwists(Serie, Temporada, Episodios, PalabrasClaves)):-
  plotTwists(Serie, Temporada, Episodios, PalabrasClaves),
  not(cliché(Serie, PalabrasClaves)),
  pasóEnELFinalDeTemporada(Serie, Temporada, Episodios).

pasóEnELFinalDeTemporada(Serie, Temporada, Episodios):-
  temporardaPorEpisodios(Serie, Temporada, Episodios).


cliché(Serie,PalabrasClaves):-
  sonPlotTwistsDistintos(Serie, PalabrasClaves, OtraLista),
  intersección(PalabrasClaves, OtraLista, Intersección),
  contieneTodasLasPalabrasClaves(Intersección, PalabrasClaves).


intersección(Lista, OtraLista, Intersección):-
  findall( Elemento,
           ( member(Elemento, Lista), member(Elemento, OtraLista) ),
           Intersección
          ).

contieneTodasLasPalabrasClaves(Intersección,PalabrasClaves):-
  length(PalabrasClaves,Cantidad),
  length(Intersección,Cantidad).

sonPlotTwistsDistintos(Serie,PalabrasClaves,OtraPalabras):-
  plotTwists(Serie, _, _,PalabrasClaves),
  plotTwists(OtraSerie, _, _, OtraPalabras),
  Serie \= OtraSerie.

relacionesFuertes(Serie,Relación):-
  paso(Serie, _, _, Relación).

%----------------------------------------------         3 Punto C: Popularidad       ----------------------------------------------

popular(hoc).
popular(Serie):- popularidad(Serie, Popularidad1), popularidad(starWars,Popularidad2), Popularidad1 >= Popularidad2.

popularidad(Serie, Popularidad):- cantidadPersonasMiran(Serie, CantPers), cantConversaciones(Serie,CantConv), Popularidad is CantPers * CantConv.

cantidadPersonasMiran(Serie, CantPers):- mira(_, Serie), findall(Persona, mira(Persona,Serie), Personas), length(Personas, CantPers).

cantConversaciones(Serie, CantConv):- leDijo(_,_,Serie,_), findall(Persona,leDijo(Persona,_,Serie,_), Conversación), length(Conversación,CantConv).

%---------------------------------------------- 4 Punto D: Amigos son los amigos...  ----------------------------------------------
amigo(nico, maiu).
amigo(maiu, gaston).
amigo(maiu, juan).
amigo(juan, aye).

fullSpoil(Spoileador, Spoileado):- leSpoileo(Spoileador, Spoileado,_).
fullSpoil(Spoileador, Spoileado):- amigo(Amigo, Spoileado), leSpoileo(Spoileador, Amigo,_), Spoileador \= Spoileado.
fullSpoil(Spoileador, Spoileado):- amigo(Amigo, Spoileado), fullSpoil(Spoileador, Amigo), Spoileador \= Spoileado.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                5 Testing            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(debugParte2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 Punto A: Malo, malo, malo eres... %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(es_cierto_que_gastón_es_mala_gente, nondet):-
  malaGente(gastón).

test(es_cierto_que_nico_es_mala_gente, nondet):-
  malaGente(nico).

test(no_es_cierto_que_pedro_es_mala_gente, fail):-
  malaGente(pedro).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  2 Punto B: Series con cosas fuertes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(la_muerte_de_Seymour_Diera_en_Futurama_es_fuerte, nondet):-
  relacionesFuertes(futurama,muerte(seymourDiera)).

test(la_muerte_de_Emperor_en_Star_Wars_es_fuerte, nondet):-
  relacionesFuertes(starWars, muerte(emperor)).

test(la_relación_de_parentesco_de_Anakin_y_el_Rey_en_Star_Wars_es_fuerte, nondet):-
  relacionesFuertes(starWars, relación(parentesco, anakin, rey)).

test(la_relación_de_parentesco_de_Darth_Vader_y_Luke_en_Star_Wars_es_fuerte, nondet):-
  relacionesFuertes(himym,relación(amorosa, ted, robin)).

test(la_relación_amorosa_de_Swarley_y_Robin_en_How_I_met_your_mother_es_fuerte, nondet):-
  relacionesFuertes(himym,relación(amorosa, swarley, robin)).


test(el_plot_twist_que_contiene_las_palabras_fuego_y_boda_en_Game_of_Thrones_es_fuerte, nondet):-
  fuerte(plotTwists(got,3,12,[fuego,boda])).

test(el_plot_twist_que_contiene_la_palabra_sueño_en_Game_of_Thrones_no_es_fuerte, fail):-
  fuerte(plotTwists(got,3,2,[suenio,sinPiernas])).

test(el_plot_twist_que_contiene_las_palabras_coma_y_pastillas_en_Doctor_House_no_es_fuerte, fail):-
  fuerte(plotTwists(drHouse,8,7,[coma,pastillas])).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       3 Punto C: Popularidad        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(es_cierto_que_game_of_thrones_es_popular, nondet):-
  popular(got).

test(es_cierto_que_starWars_es_popular, nondet):-
  popular(starWars).

test(es_cierto_que_house_of_cards_es_popular, nondet):-
  popular(hoc).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 4 Punto D: Amigos son los amigos... %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(es_cierto_que_nico_le_hizo_fullSpoil_a_Aye, nondet):-
  fullSpoil(nico, aye).

test(es_cierto_que_nico_le_hizo_fullSpoil_a_Juan, nondet):-
  fullSpoil(nico, juan).

test(es_cierto_que_nico_le_hizo_fullSpoil_a_maiu, nondet):-
  fullSpoil(nico, maiu).

test(es_cierto_que_nico_le_hizo_fullSpoil_a_gastón, nondet):-
  fullSpoil(nico, gastón).

test(es_cierto_que_gastón_le_hizo_fullSpoil_a_Aye, nondet):-
  fullSpoil(gastón, aye).

test(es_cierto_que_gastón_le_hizo_fullSpoil_a_Juan, nondet):-
  fullSpoil(gastón, juan).

test(es_cierto_que_gastón_le_hizo_fullSpoil_a_maiu, nondet):-
  fullSpoil(gastón, maiu).

test(no_es_cierto_que_maiu_le_hizo_fullSpoil_a_alguien, fail):-
  fullSpoil(maiu, PersonaALaQueLeHicieronFullSpoil ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- end_tests(debugParte2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
