.. default-role:: literal

.. _matavimo-vienetai:

Matavimo vienetai
#################

Matavimo vienetai naudojant `SI simbolius`__, `išvestinius SI simbolius`__ ir
`simbolius patvirtintus naudojimui su SI`__,  pateikiami :data:`property.ref`
stulpelyje.

.. __: https://en.wikipedia.org/wiki/International_System_of_Units
.. __: https://en.wikipedia.org/wiki/SI_derived_unit
.. __: https://en.wikipedia.org/wiki/Non-SI_units_mentioned_in_the_SI

Pateikus vienetus, laukui gali būti suteikiamas 4-as brandos lygis.

Pavyzdys:

== == == == ============= ======== ===== =====
d  r  b  m  property      type     ref   level
== == == == ============= ======== ===== =====
datasets/example         
------------------------- -------- ----- -----
\        Matavimas                 id         
-- -- -- ---------------- -------- ----- -----
\           id            integer        4
-- -- -- -- ------------- -------- ----- -----
\           temperatura   number   °C    4
\           svorlis       number   kg    4
\           plotas        number   m²    4
\           turis         number   m³    4
\           greitis       number   km/h  4
== == == == ============= ======== ===== =====

Papildomai, gali būti žymimas ir :ref:`laiko <temporal-types>` ar
:ref:`erdvinių <spatial-types>` duomenų tikslumas, pavyzdžiui:

== == == == ============= ======================= ===== =====
d  r  b  m  property      type                    ref   level
== == == == ============= ======================= ===== =====
datasets/example                                 
------------------------- ----------------------- ----- -----
\        Matavimas                                id         
-- -- -- ---------------- ----------------------- ----- -----
\           id            integer                       4
-- -- -- -- ------------- ----------------------- ----- -----
\           laikas        datetime                1S    4
\           vieta         geometry(point, 4326)   1m    4
== == == == ============= ======================= ===== =====

Šiuo atveju, nurodyta, kad laukas `laikas` yra 1 sekundės tikslumu, o `vieta` 1
metro tikslumu.

Žymint laiko tikslumą, galite naudoti tokius sutartinius simbolius:

========  ================
Simbolis  Prasmė
========  ================
Y         Metai
M         Mėnesiai
Q         Metų ketvirčiai
W         Savaitės
D         Dienos
H         Valandos
T         Minutės
S         Sekundės
L         Milisekundės
U         Mikrosekundės
N         Nanosekundžės
========  ================

Žymin vietos tikslumą, galite naudoti tokius sutartinius simbolius:

========  ====================
Simbolis  Prasmė
========  ====================
nm        Nanometrai (10⁻⁹ m)
mm        Milimetrai (10⁻³ m)
cm        Centimetrai (10⁻² m)
m         Metrai
km        Kilometrai (10³ m)
========  ====================

Matavimo vienetai naudojami tik kiekybinėms reikšmėms žymėti. Pavyzdžiui šiuo
atveju `id` laukas nėra kiekybinis, tai yra kokybinis duomuo nurodantis unikalų
matavimo numerį (kodą).

Jei prie `integer` ar `number` nurodytas 4-as brandos lygis, bet nepateiktas
vienetas (neužpildytas `ref` stulpelis), tada laikoma, kad duomenų laukas yra
kokybinis.
