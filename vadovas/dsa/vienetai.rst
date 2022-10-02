.. default-role:: literal

.. _matavimo-vienetai:

Matavimo vienetai
#################


Apibrėžtis laike
****************

`date` ir `datetime` tipo duomenų laukams gali būti žymimas ir :ref:`laiko
<temporal-types>` duomenų tikslumas, pavyzdžiui:

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

Žymint laiko tikslumą, galite naudoti tokius sutartinius simbolius (atkreipkite
dėmesį, kad šie vienetai veikia tik su `date` ir `datetime` tipais):

========  ================
Simbolis  Prasmė
========  ================
Y         Metai
Q         Metų ketvirčiai
M         Mėnesiai
W         Savaitės
D         Dienos
H         Valandos
T         Minutės
S         Sekundės
L         Milisekundės
U         Mikrosekundės
N         Nanosekundžės
========  ================


Apibrėžtis erdvėje
******************

`geometry` tipo duomenų laukams galibūti žymimas :ref:`erdvinių
<spatial-types>` duomenų tikslumas, pavyzdžiui:

========  ====================
Simbolis  Prasmė
========  ====================
nm        Nanometrai (10⁻⁹ m)
mm        Milimetrai (10⁻³ m)
cm        Centimetrai (10⁻² m)
m         Metrai
km        Kilometrai (10³ m)
========  ====================


Kokybiniai duomenys
*******************

Kokybiniai duomenys skirstomi į dvi kategorijas:

- pavadinimai ir identifikatoriai
- kategoriniai duomenys

Pavadinimai ir identifikatoriai :data:`property.ref` stulpelyje neturi jokio
žymėjimo ir jiems suteikiamas `4` brandos lygis.

Kategoriniai duomenys žymini naudojant papildomą `enum` dimensiję, kurioje
išvardinamos visos galimos kategorinių duomenų reikšmės.

Jei kategoriniai duomenys yra paliginami, pavyzdžiui:

- puikiai
- gerai
- vidutiniškai
- blogai

Tada, tokiems duomenims, turi būti naudojamas `integer` tipas, kad nebūtų
prarastos palyginamosios savybės.

Jei duomenys yra nepalyginami, pavyzdžiui:

- raudona
- geltona
- žalia
- mėlyna

tada nebūtina naudoti `integer` tipą.



Kiekybiniai duomenys
********************

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

Vienetai užrašomi naudojant matematinę notaciją, kurioje galima naudoti
skaičius, daugybos ir dalybos simbolius, kėlimą laipsniu ir atskirų vienetų
sudėtį:

======================================================  =====================
Žymėjimas                                               Reikšmė              
======================================================  =====================
⋅ · *                                                   Daugyba
/                                                       Dalyba
(tarpas)                                                Sudėtis
^\ :sup:`(+-)(skaičius)` arba ⁺ ⁻ ⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹   Kėlimas laipsniu
======================================================  =====================

Pavyzdžiai:

    | m
    | 1m
    | 10m
    | m^2
    | m²
    | km¹⁰
    | kg⋅m²⋅s⁻³⋅A⁻¹
    | kg*m^2*s^-3⋅A^-1
    | 8kg⋅m²⋅s⁻³⋅A⁻¹
    | mg/l
    | g/m^2
    | mg/m^3
    | mm
    | U/m^2
    | U/m^3
    | %
    | ha
    | min
    | h
    | bar
    | U
    | 10^6s
    | 10⁶s
    | μ/m³
    | yr
    | 3mo
    | yr 2mo 4wk
    | °C
    | °


Prefiksai
=========

Kiekybiniai matavimo vienetai gali turėti tokius prefiksus:


==========  ==============  ==========
Žymėjimas   10\ :sup:`n`    Priešdėlis
==========  ==============  ==========
Y           10\ :sup:`24`   yotta
Z           10\ :sup:`21`   zetta
E           10\ :sup:`18`   exa
P           10\ :sup:`15`   peta
T           10\ :sup:`12`   tera
G           10\ :sup:`9`    giga
M           10\ :sup:`6`    mega
k           10\ :sup:`3`    kilo
h           10\ :sup:`2`    hecto
da          10\ :sup:`1`    deca
d           10\ :sup:`-1`   deci
c           10\ :sup:`-2`   centi
m           10\ :sup:`-3`   milli
µ           10\ :sup:`-6`   micro
n           10\ :sup:`-9`   nano
p           10\ :sup:`-12`  pico
f           10\ :sup:`-15`  femto
a           10\ :sup:`-18`  atto
z           10\ :sup:`-21`  zepto
y           10\ :sup:`-24`  yocto
==========  ==============  ==========


Vienetai
========

Specialiejie vienetai
---------------------

==========  ===========================
Žymėjimas   Pavadinimas
==========  ===========================
U           vienetai (keikis vienetais)
%           procentai
==========  ===========================


Laiko vienetai
--------------

Naudojami tik tais atvejais, kai matuojamas laiko kiekis, o ne data ir laikas.
Datos ir laiko (`date` ir `datetime` tipai) tikslumui žymėti, naudojamos kitos
žymės.

==========  =====================================
Žymėjimas   Pavadinimas
==========  =====================================
s           sekundė
min         minutė
h           valanda
d           diena (24 valandos)
wk          savaitė (7 dienos)
mo          mėnuo (28-31 diena arba 4 savaitės)
yr          metai (354.37 dienos arba 12 mėnesių)
==========  =====================================


SI Baziniai vienetai
--------------------

==========  ============
Žymėjimas   Pavadinimas
==========  ============
m           metre
g           gram
s           second
A           ampere
K           kelvin
mol         mole
cd          candela
==========  ============


SI Išvestiniai vienetai
-----------------------

==========  ============
Žymėjimas   Pavadinimas
==========  ============
Hz          hertz
rad         radian
sr          steradian
N           newton
Pa          pascal
J           joule
W           watt
C           coulomb
V           volt
F           farad
Ω           ohm
S           siemens
Wb          weber
T           tesla
H           henry
°C          degree Celsius
lm          lumen
lx          lux
Bq          becquerel
Gy          gray
Sv          sievert
kat         katal
==========  ============



Kiti vienetai
-------------

=================  ====================================
Žymėjimas          Pavadinimas
=================  ====================================
au                 astronomical unit
°                  degree
′                  arcminute
″                  arcsecond
ha                 hectare
l                  litre
L                  litre
t                  tonne
Da                 dalton
eV                 electronvolt
Np                 neper
B                  bel
dB                 decibel
Gal                gal (acceleration)
u                  unified atomic mass unit
var                volt-ampere reactive
pc                 parsec
c₀ arba c_0        natural unit of speed
ħ                  natural unit of action
mₑ arba m_e        natural unit of mass
e                  atomic unit of charge
a₀ arba a_0        atomic unit of length
E_h                atomic unit of energy
M                  nautical mile
kn                 knot
Å                  ångström
a                  are
b                  barn
bar                bar
atm                standard atmosphere
Ci                 curie
R                  roentgen
rem                rem
erg                erg
dyn                dyne
P                  poise
st                 stokes
Mx                 maxwell
G                  gauss
Oe                 ørsted
sb                 stilb
ph                 phot
Torr               torr
kgf                kilogram-force
cal                calorie
μ                  micron
xu                 x-unit
γ                  gamma (mass, magnetic flux density)
λ                  lambda
Jy                 jansky
mmHg               millimetre of mercury
=================  ====================================
