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

Vardų erdvės pavadinimai užrašomi daugiskaita ir turi prasidėti mažąja raide.


Modeliai
********

Pavyzdys: `UpperCamelCase`

Kiekvieno modelio pavadinimo pirma raidė didžioji, kitos mažosios.
Pavadinimo žodžiai atskiriami juos užrašant iš didžiosios raidės. Tarp
žodžių neturi būti nei tarpų, nei kitų skyrybos ženklų.

Modelio pavadinimai užrašomi vienaskaita išskyrus atvejus, kai subjekto
pavadinimas neturi vienaskaitos žodžio formos, pavyzdžiui rašom `Pajamos`, nes
tokio žodžio kaip `Pajama` nėra.

Modelio pavadinimas turi prasidėti didžiąja raide.

Modelio pavadinimas turi atspindėti `duomenų subjekto`__ tipą.
Duomnų subjektas yra dalykas turintis pavadinimą ar unikalų identifikatorių.
Duomenų subjekto tipas yra subjektų grupė priklausančių tai pačiai kategorijai
ar klasei__.

__ https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model#Entity%E2%80%93relationship_model
__ https://en.wikipedia.org/wiki/Class_(knowledge_representation)


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

Duomenų lauko pavadinimas turi prasidėti mažąja raide.


Ryšiai tarp modelių
===================

:data:`ref` tipo laukai rašomi be `id` ar `_id` galūnės, kadangi jis yra
perteklinis.

:data:`ref` tipo laukai atspindi ne konkretų identifikatorių, o visą
objektą. Konkretus identifikatorius yra rezervuotas pavadinimas ir
duomenų struktūros apraše nenurodomas.

Pavyzdžiui vietoje `country_id`, kurio tipas yra `ref`, reikėŧų rašyti
`country`.

== ========== ===== ========
m  property   type  ref     
== ========== ===== ========
Country                     
------------- ----- --------
\  name\@lt   text          
City                        
------------- ----- --------
\  name\@lt   text              
\  country    ref   Country 
== ========== ===== ========

Tais atvejais, kai duomenys yra denormalizuoti, duomenų lauko
pavadinimas užrašomas su tašku, nurodant duomenų lauką iš siejamo
modelio. Plačiau apie tai :ref:`ref-denorm`.


Nekartojame modelio pavadinimo
==============================

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

Jei kiti modeliai siejami su `City`, tada nurodant tarkim `city_name` iš
kito modelio, reikėtų rašyti `city.city_name`. Todėl `city.name` yra
aiškesnis pavadinimas, kuriame nesikartoja modelio pavadinimas.


Nekartojame duomenų tipo pavadinimo
===================================

Duomenų lauko pavadinime nereikia kartoti duomenų tipo pavadinimo.

Pavyzdžiui taip nereikėtų daryti:

== ================= ===========
m  property          type       
== ================= ===========
City                            
-------------------- -----------
\  founded_date      date
== ================= ===========

Reikėtų rašyti taip:

== ================= ===========
m  property          type       
== ================= ===========
City                            
-------------------- -----------
\  founded           date
== ================= ===========

Nėra prasmės kartoti duomenų tipo, lauko pavadinime.
