.. default-role:: literal

.. _kodiniai-pavadinimai:

Kodiniai pavadinimai
####################

Kadangi :term:`DSA` lentelė skirta naudoti tiek žmonėms tiek automatizuotoms
priemonėms, tam tikros lentelės dalys privalo naudoti sutartinius kodinius
pavadinimus. Kodiniams pavadinimams keliami griežtesni reikalavimai, kadangi
šiuos pavadinimus interpretuos automatizuotos priemonės.

Visi :term:`DSA` lentelės stulpelių pavadinimai turi būti užrašyti tiksliai
taip, kaip nurodyta, kad kompiuterio programos galėtų juos atpažinti.

Kodiniai pavadinimai rašomi naudojant tik lotyniškas raidas. Lietuviškų
raidžių naudoti negalima, todėl geriausia pavadinimus užrašyti anglų kalba,
arba pakeičiant lietuviškas raides į lotyniškos raidės analogą.

Deja, vis dar pasitaiko vietų, kuriose palaikoma tik lotyniška abėcėlė, todėl
ir keliamas toks reikalavimas, siekiant užtikrinti maksimalų suderinamumą
tarp skirtingų sistemų.

Pavadinimai turėtu būti rašomi laikantis tokio stiliaus:


Vardų erdvių
************

Pavyzdys: `datasets/gov/abbr/short/word`

Visos mažosios raidės, stengiantis naudoti vieno žodžio trumpus
pavadinimus arba žodžio trumpinius. Kadangi vardų erdvė rašoma prie
kiekvieno modelio pavadinimo, todėl reikia stengtis vardų erdvių ir
duomenų rinkinių pavadinimus išlaikyti kiek įmanoma trumpesnius.

Vardų erdvės pavadinimai užrašomi daugiskaita.


Modeliai
********

Pavyzdys: `UpperCamelCase`

Kiekvieno modelio pavadinimo pirma raidė didžioji, kitos mažosios.
Pavadinimo žodžiai atskiriami juos užrašant iš didžiosios raidės. Tarp
žodžių neturi būti nei tarpų, nei kitų skyrybos ženklų.

Modelio pavadinimai užrašomi vienaskaita.

Modelio pavadinimas turi atspindėti duomenų subjektą.


Nekartojame vardų erdvės
========================

Modelio pavadinime nekartojamas vardų erdvės, kurioje yra modelis.

Pavyzdys, kaip nereikėtų daryti: `example/planets/EarthPlanet`. Šioje
vietoje nereikia kartoti `Planet`, kadangi tai atsispindi vardų erdvės
pavadinime `planets`.


Duomenų laukai
**************

Pavyzdys: `snake_case`

Visi duomenų lauko žodžiai rašomi mažosiomis raidėmis, atskiriami pabraukimo
ženklu `_`.


ref tipo laukai
===============

:data:`ref` tipo laukai rašomi be `id` ar `_id` galūnės, kadangi jis yra
perteklinis.

:data:`ref` tipo laukai atspindi ne konkretų identifikatorių, o visą
objektą. Konkretus identifikatorius yra rezervuotas pavadinimas ir
duomenų struktūros apraše nenurodomas.

Tais atvejais, kai duomenys yra denormalizuoti, duomenų lauko
pavadinimas užrašomas su tašku, nurodant duomenų lauką iš siejamo
modelio. Plačiau apie tai :ref:`ref-denorm`.


Nekartojame modelio ir tipo
===========================

Visi modelio duomenų laukai yra konkretaus modelio laukai, todėl
nereikia kartoti duomenų laukuose modelio pavadinimo, pavyzdžiui vietoje
tokių pavadinimų:

== ==================
m  property          
== ==================
City                 
---------------------
\  city_id           
\  city_name
== ==================

Reikėtų rašyti taip:

== ==================
m  property          
== ==================
City                 
---------------------
\  id           
\  name
== ==================
