.. default-role:: literal

.. _saugykla:

########
Saugykla
########

Atvirų duomenų Saugykla yra sudedamoji atvirų duomenų Portalo dalis. Saugyklos
paskirtis yra duomenų publikavimas :ref:`aukščiausiu brandos lygiu <level>`,
įvairiais formatais, per patogią mašininio duomenų skaitymo sąsają
(:term:`API`), laikantis aukščiausių duomenų publikavimo standartų.

Visi duomenų rinkiniai publikuojami Saugykloje yra apjungiami į vieną didelę
duomenų bazę, kur duomenys gali būti jungiami tarpusavyje, pateikiami pilna
apimtimi (angl. *in bulk*) arba pageidaujamais pjūviais. Suteikiamos
priemonės duomenis gauti palaipsniniu būdu (angl. `Incremental download`_).

.. _Incremental download: https://en.wikipedia.org/wiki/Incremental_computing


**Daugiau informacijos**

.. toctree::
    :maxdepth: 1

    install


Statusas ir planas
******************

Priemonė „Spinta“ yra eksperimentinis projektas, šiuo metu aktyviai vystomas.
Pagal `programinės įrangos gyvavimo ciklo schema`__, „Spinta“ yra PRE-ALPHA
etape.

__ https://en.wikipedia.org/wiki/Software_release_life_cycle

Nors projektas yra aktyviai vystomas, tačiau jis jau yra naudojamas
gamybinėje aplinkoje, kurią galite pasiekti šiais adresais:

https://get.data.gov.lt/
    Saugyklos sritis skirta viešai atvirų duomenų prieigai. Ši sritis veikia
    tik skaitymo režimu ir skirta plačiajai visuomenės daliai.

https://put.data.gov.lt/
    Saugyklos sritis skirta duomenų tiekėjams, kuriems suteikiama galimybė
    teikti duomenis į saugyklą. Ši sritis yra skirta tik duomenų tiekėjams.

.. _saugyklos-testinė-aplinka:

Taip pat yra analogiškos aplinkos skirtos testavimui, prieš pereinant prie
gamybinės aplinkos:

https://get-test.data.gov.lt/

https://put-test.data.gov.lt/

Kiekvienas pakeitimas projekto „Spinta“ kodo bazėje yra automatiškai
testuojamas vykdant beveik 1000 testų, kurie dengia beveik 90% viso kodo.
Todėl projektas yra gan stabilus.


Preliminarus projekto vystymo planas
====================================

==============  =================  =================
Etapas          Pradžia            Pabaiga
--------------  -----------------  -----------------
PRE-ALPHA       2019 metų pradžia  2021 metų pabaiga
ALPHA           2021 metų pabaiga  2022 metų vidurys
BETA            2022 metų vidurys  2023 metų kovas
STABLE          2023 metų kovas    -
==============  =================  =================


Ko tikėtis kiekvieno etapo metu?
================================

PRE-ALPHA (iki 2021 metų pabaigos)
    Projektas jau bus naudojamas gamybinėje aplinkoje, tačiau reikėtu tikėtis,
    kad dalykai ne visada veiks, funkcijos bus ne iki galo išbaigtos ir esamas
    funkcionalumas gali keistis. Tačiau nepaisant minėtu trūkumų, esminės atvirų
    duomenų saugyklos funkcijos turėtu veikti gan stabiliai, todėl
    rekomenduojame aktyviai naudotis saugykla tiek teikiant, tiek gaunant
    duomenis, nes tik tokiu būdu geriau suprasime ko reikia galutiniam
    naudotojui.

    Jei į saugyklą teikiate svarbius, didelę paklausą turinčius duomenis,
    rekomenduojame „Spinta“ projektą naudoti tik, kaip alternatyvią duomenų
    publikavimo priemonę, kartu publikuojant duomenis ir kitais kanalais,
    užtikrinančiais didesnį patikimumo lygį.

ALPHA (iki 2022 metų vidurio)
    Šio etapo metu didžiausias dėmesys bus skiriamas esamų funkcijų išbaigtumo
    didinimui, greitaveikos optimizavimui ir stabilumo didinimui. Šio etapo
    metu.

    Taip pat šio etapo metu bus dirbama ir prie duomenų brandos kėlimo funkcijų
    įgyvendinimo, peržiūrint visus saugykloje publikuojamus duomenis ir siekiant
    juos transformuoti taip, kad jie būtų suderinami su Europos ir
    tarptautiniais standartais, kiek įmanoma atitiktų vieningą duomenų žodyną.

BETA (iki 2023 metų kovo mėnesio)
    Šio etapo metu, jokių naujų funkcijų kurti nebeplanuojama, bus didinamas
    esamų funkcijų stabilumas, greitaveika, taisomos pastebėtos klaidos.

    Šio etapo metu rekomenduojame naudoti saugyklą, kaip pagrindinį atvirų
    duomenų publikavimo šaltinį.

STABLE (nuo 2023 metų kovo mėnesio)
    Šio etapo metu, bus vykdomas projekto palaikymas ir priežiūra, pastebėtų
    klaidų taisymas.


Prieš pradedant
***************

Pavyzdžių skaitymas
===================

Prieš pradedant skaityti verta susipažinti kokie įrankiai naudojami šios
dokumentacijos pavyzdžiuose.

Pavyzdžiuose HTTP užklausos atliekamos naudojant patogią httpie_ programėlę.

.. _httpie: https://httpie.io/

Pavyzdžiui::

    http /version

.. code-block:: http

    HTTP/1.1 200 OK
    content-type: application/json

    {
        "api": {
            "version": "0.0.1"
        },
        "build": null,
        "implementation": {
            "name": "Spinta",
            "version": "0.1.6"
        }
    }

Šiame pavyzdyje `http` komanda buvo įvykdyta su `/version` argumentu.

Pavyzdžiuose nepateikiamas konkretus domenas, kadangi domenas gali skirtis
priklausomai nuo to, kurią atvirų duomenų saugyklą naudojate, tačiau adreso
dalis einanti po domeno visada vienoda.

Apart to, kad pavyzdžiuose nenurodomas domenas, visa kita veikia taip kaip
parašyta httpie_ dokumentacijoje. Todėl rekomenduojame pirmiausia
pasiskaityti su httpie_ dokumentacija, prieš pradedant gilintis į šią atvirų
duomenų saugyklos dokumentaciją.


Duomenų modelis
===============

Visuose pavyzdžiuose bus naudojamas vienas ir tas pats žemynų, šalių ir miestų
duomenų modelis, kurios struktūra atrodo taip:

+---+---+-------------+---------+-----------+
| d | m | property    | type    | ref       |
+===+===+=============+=========+===========+
| datasets/gov/dc/geo |         |           |
+---+---+-------------+---------+-----------+
|   | Continent       |         |           |
+---+---+-------------+---------+-----------+
|   |   | name        | string  |           |
+---+---+-------------+---------+-----------+
|   | Country         |         |           |
+---+---+-------------+---------+-----------+
|   |   | code        | string  |           |
+---+---+-------------+---------+-----------+
|   |   | name        | string  |           |
+---+---+-------------+---------+-----------+
|   |   | continent   | ref     | continent |
+---+---+-------------+---------+-----------+
|   |   | capital     | ref     | city      |
+---+---+-------------+---------+-----------+
|   | City            |         |           |
+---+---+-------------+---------+-----------+
|   |   | name        | string  |           |
+---+---+-------------+---------+-----------+
|   |   | country     | ref     | country   |
+---+---+-------------+---------+-----------+

Šalys priklauso žemynams, o miestai šalims. Kiekviena šalis turi vieną miestą
sostinę.


API adreso struktūra
********************

API yra generuojamas dinamiškai iš :term:`DSA` `model` stulpelyje esančių
modelio :term:`kodinių pavadinimų <kodinis pavadinimas>`. Modelių pavadinimai
gali turėti vardų erdves, vardų erdvės yra atskirtos `/` simboliu, pavyzdžiui::

    /datasets/gov/dc/geo/Continent

Šis adresas sudarytas iš `datasets/gov/dc/geo` vardų erdvės ir `Continent`
modelio pavadinimo.

`datasets` vardų erdvė rodo, kad duomenys yra žali, t.y. tokie kokie pateikti
tam tikros įstaigos. Su laiku visų įstaigų duomenys bus transformuoti į vieningą
šalies masto žodyną ir pavyzdžiui `datasets/gov/dc/geo/Continent` gali būti
sulietas į vieną bendrą `Continent` modelį, šakninėje vardų erdvėje. Tačiau
užtikrinant stabilų ir nekintantį API bus paliekami ir pradiniai žalių duomenų
API taškai.

Konkrečiai visi `datasets` vardų erdvėje esantys modeliai turi aiškiai apibrėžtą
struktūrą, pavyzdžiui nagrinėjant `datasets/gov/dc/geo/Continent` pavyzdį
atskirų kelio komponentų prasmės būdų tokios:

- `datasets/` - vardų erdvė skirta žaliems pirminiams įstaigų duomenimis.
- `gov/` - vardų erdvė skirta valstybinių įstaigų duomenimis.
- `dc/` - konkrečios valstybinės įstaigos trumpinys.
- `geo/` - įstaigos atverto duomenų rinkinio trumpinys.
- `Continent` - duomenų modelis (arba lentelė).


Adreso parametrai
=================

Adresas gali turėti parametrus, parametrai atrodo taip::

    /:ns
    /:changes
    /:format/csv

Jei adreso kelio elementas prasideda `:` simboliu, tai po jo seka parametro
pavadinimas ir jei konkretus parametras turi argument, gali sekti vienas ar
daugiau argumentų.


Identifikatorius
================

Identifikatorius pat yra adreso parametras, tik jis neprasideda `:` simboliu, o
eina iš karto po modelio pavadinimo ir tai turi būti UUID simbolių eilutė,
pavyzdžiui::

    /datasets/gov/dc/geo/Continent/77e0bb52-f8ae-448f-b4c2-7de6bb150ff0

Identifikatorius taip pat gali turėti argumentus, identifikatoriaus
argumentai yra modelio savybė, pavyzdžiui::

    /datasets/gov/dc/geo/City/7d473db2-d363-4318-9b84-138eb5d70f70/continent

Tokiu būdu yra galimybė gauti tik konkrečios modelio savybės duomenis.


Užklausa
========

URL Query dalyje, po `?` simbolio galima pateikti papildomus užklausos
parametrus, pavyzdžiui::

    /datasets/gov/dc/geo/Continent?select(name)&sort(name)


.. _rezervuoti-pavadinimai:

Rezervuoti pavadinimai
**********************

Vadovaujantis duomenų struktūros aprašo taisyklėmis, vardų erdvės, modeliai
ir laukai turi būti pavadinti laikantis :ref:`kodinių pavadinimų
<kodiniai-pavadinimai>` reikalavimų.

Visi pavadinimai, kuri prasideda `_` simboliu, turi specialią prasmę ir
praturtina duomenis, tam tikrais metaduomenimis.

Naudojami tokie specialieji pavadinimai:

:_type:
    Modelio ar vardų erdvės pavadinimas.

:_id:
    Unikalus objekto pavadinimas UUID_ formatu.

:_revision:
    Objekto revizijos numeris, šio numerio pagalba užtikrinamas duomenų
    vientisumas keičiant duomenis. Kiekvieną kartą keičiant duomenis būdina
    nurodyti ir revizijos numeris, keitimas leidžiamas tik tuo atveju, jei
    išsaugoto objekto ir keitimo revizijos numeriais sutampa. Kiekvieną kartą,
    kai objektas pasikeičia, keičiasi ir jo revizijos numeris.

:_txn:
    Transakcijos numeris. Vienos užklausos metu, gali būti keičiama daug
    objektų, visiems, vienu kartu keičiamiems objektas suteikiamas vienas
    transakcijos keitimo numeris.

:_data:
    Objektų sąrašas, kei keli objektai pateikiami kartu.

:_cid:
    Keitimo numeris naudojamas :ref:`op-changes` užklausos metu.

:_created:
    Data ir laikas, kada duomenys buvo keisti, naudojamas :ref:`op-changes`
    užklausos metu.

:_op:
    Užklausos veiksmo pavadinimas. Plačiau :ref:`actions`.

:_where:
    Objekto atranka naudojama `upsert` užklausose.

.. _UUID: https://en.wikipedia.org/wiki/Universally_unique_identifier


Vardų erdvės
************

Atvirų duomenų saugykla yra didelis katalogas, kuriame sudėta įvairių modelių
duomenys. Katalogai vadinami vardų erdvėmis.

Aukščiausiame lygyje yra globali vardų erdvė::

    http /

.. code-block:: http

    HTTP/1.1 200 OK
    content-type: application/json

    {
        "_data": [
            {
                "_id": "datasets/:ns",
                "_type": "ns",
                "title": "datasets"
            }
        ]
    }


Globalioje vardų erdvėje yra kita vardų erdvė `datasets`. Žinome, kad `datasets`
yra vardų erdvė, kadangi tai nurodyta `_type` savybėje, kurios reikšmė `ns`, kas
reiškia *Name Space* arba *Vardų Erdvė* išvertus į Lietuvių kalbą.

Į vardu erdves reikia kreiptis nurodant `/:ns` parametrą::

    http /datasets/gov/dc/geo/:ns

.. code-block:: http

    HTTP/1.1 200 OK
    content-type: application/json

    {
        "_data": [
            {
                "_id": "datasets/gov/dc/geo/Continent",
                "_type": "model",
                "title": "Continent"
            },
            {
                "_id": "datasets/gov/dc/geo/Country",
                "_type": "model",
                "title": "Country"
            },
            {
                "_id": "datasets/gov/dc/geo/City",
                "_type": "model",
                "title": "City"
            }
        ]
    }

Jei `/:ns` parametras nebūtų nurodytas, tada saugykla bandytų ieškoti modelio
pavadinimu `datasets/gov/dc/geo` ir neradus tokio modelio būtų gražintas `404
Not Found` klaidos kodas.


Formatas
********

Saugykloje duomenys saugomi taip, kad juos būtų galima gauti įvairiais
formatais.

Reikia atkreipti dėmesį, kad nors Saugykla gali duomenis grąžinti įvairiais
formatais, tačiau nėra galimybės duomenis gauti konkretaus formato schemos
pavidalu. Pavyzdžiui turint naujienų duomenis, nėra galimybės tokių duomenų
gauti RSS_ formatu. Pats savaime RSS yra konkreti XML formato schema. Todėl
Saugykla gali grąžinti duomenis XML formatu, specifine Saugyklose schema.

.. _RSS: https://en.wikipedia.org/wiki/RSS

Saugykloje palaikomi tik bendrieji formatai, specializuoti, tam tikros
srities formatai nepalaikomi. Norint gauti duomenis tam tikru specializuotu
formatu, Saugykloje teikiamus duomenis reikia konvertuoti į pageidaujamą
specializuotą formatą.

Siekiant užtikrinti duomenų perdavimo ir skirtingų formatų palaikymą, visiems
duomenų laukams, modeliams ir vardų erdvėms taikomi :ref:`kodinių pavadinimų
<kodiniai-pavadinimai>` reikalavimai, :ref:`specialiosios paskirties duomenys
<rezervuoti-pavadinimai>` pateikiami su `_` prefiksu, tokiu būdu atskiriant
duomenis, nuo metaduomenų.

Grąžinant duomenis tam tikru formatu, gražinamų duomenų schema gali būti
skirtinga :ref:`skirtingo pobūdžio užklausoms <actions>`. Pavyzdžiui, jei
duomenų prašoma `getone` būdu, JSON formatu, tuomet rezultatas bus:

.. code-block:: json

    {
        "_type": "...",
        "_id": "...",
        "data": "...",
    }

Jei duomenų prašoma `getall` būdu, tada rezultatas bus toks:

.. code-block:: json

    {
        "_type": "...",
        "_data": [
            {
                "_id": "...",
                "data": "...",
            }
        ]
    }

Duomenų kitu formatu galima paprašyti adreso gale nurodžius `/:format/csv`,
kur `csv` yra pageidaujamas formatas. Šiuo atveju, bus grąžintas toks
rezultatas::

    _type,_id,data
    ...,...,...

Rezervuotų laukų sąrašas pateiktas skyriuje :ref:`rezervuoti-pavadinimai`.


Ryšiai tarp objektų
*******************

Plačiau apie ryšius tarp objektų struktūros apraše skaitykite :ref:`ryšiai`.

Duomenų laukai, kurių :data:`property.type` yra :data:`ref <types.ref>` įgauna objekto,
į kurį rodoma formą. Tarkime, jei turime tokį struktūros aprašą:

== == == == ================== ========= =========== =====
d  r  b  m  property           type      ref         level
== == == == ================== ========= =========== =====
datasets/gov/example/countries
------------------------------ --------- ----------- -----
\        Country                                     4
-- -- -- --------------------- --------- ----------- -----
\           name               string                4
\        City                                        4
-- -- -- --------------------- --------- ----------- -----
\           name               string                4
\           country            ref       Country     4
== == == == ================== ========= =========== =====

Tada `City.country` įgaus `Country` objekto pavidalą:

.. code-block:: json

    {
        "_type": "datasets/gov/example/countries/City",
        "_id": "78035ad0-8f59-4d59-8867-60ea856ba26f",
        "name": "Vilnius",
        "country": {
            "_id": "3c65deaa-8ef8-46d9-8b00-38b22bb91f95"
        }
    }

Tokia forma naudojama todėl, kad Saugykla leidžia jungti skirtingų modelių
duomenis tarpusavyje. Todėl, tam tikrais atvejais, gali būti pateikiamas ne
tik siejamo objekto identifikatorius, bet ir kiti to objekto laukai,
pavyzdžiui, jei duomenų atrankai naudotume tokią užklausą::

    /City?select(_id, name, country._id, country.name)

Tuomet atsakymas būtų toks:

.. code-block:: json

    {
        "_id": "78035ad0-8f59-4d59-8867-60ea856ba26f",
        "name": "Vilnius",
        "country": {
            "_id": "3c65deaa-8ef8-46d9-8b00-38b22bb91f95",
            "name": "Lietuva"
        }
    }

Tais atvejais, kai prašomas tik objektas, kuris yra ryšys su kitu objektų,
pavyzdžiui::

    /City?select(name, country)

Gausime tokį atsakymą:

.. code-block:: json

    {
        "name": "Vilnius",
        "country": {
            "_id": "3c65deaa-8ef8-46d9-8b00-38b22bb91f95",
        }
    }

Tie patys duomenys CSV formatu būtų pateikti taip::

    name,country._id
    Vilnius,3c65deaa-8ef8-46d9-8b00-38b22bb91f95


3 ir žemesnis brandos lygis
===========================

Atkreipkite dėmesį, kad ryšiai tarp objektų, taip, kaip aprašyta aukščiau,
veikia tik tuo atveju, jei :data:`ref <types.ref>` duomenų lauko brandos lygis
(:data:`level`) yra didesnis nei 3.

Jei :data:`ref <types.ref>` duomenų lauko brandos lygis yra 3 ar žemesnis, tada
jungimui naudojamas jungiamo modelio pirminis raktas (:data:`model.ref`) arba
nepirminis raktas nurodytas prie pačio :data:`ref <types.ref>` lauko (žiūrėti
:ref:`ref-fkey`). Jei nenurodytas nei :data:`model.ref`, nei :ref:`kitas laukas
<ref-fkey>`, tada jungimas daromas per `_id` lauką, tačiau netikrinama ar toks
`_id` egzistuoja jungiamame modelyje.

Pavyzdžiui, jei turime tokį struktūros aprašą:

== == == == ================== ========= =========== =====
d  r  b  m  property           type      ref         level
== == == == ================== ========= =========== =====
datasets/gov/example/countries
------------------------------ --------- ----------- -----
\        Country                         code        4
-- -- -- --------------------- --------- ----------- -----
\           code               string                4
\           name               string                4
\        City                                        4
-- -- -- --------------------- --------- ----------- -----
\           name               string                4
\           country            ref       Country     3
== == == == ================== ========= =========== =====

Tada, `City.country` jungimas su `Country` galimas tik per `code`, o ne per
`_id`, kadangi `City.country` yra 3 brandos lygio, kas nurodo, kad jingimas
daromas ne per pirminį raktą.

Šiuo atveju, `City` objektas atrodys taip:

.. code-block:: json

    {
        "_type": "datasets/gov/example/countries/City",
        "_id": "78035ad0-8f59-4d59-8867-60ea856ba26f",
        "name": "Vilnius",
        "country": {
            "code": "lt"
        }
    }

Analogiškai, jei `Country` modelis neturi :data;`model.ref`, tada jungimas
daromas, per `Country` lauką, kuris nurodytas `City.country`
:data:`property.ref` stulpeyje, pavyzdžiui:

== == == == ================== ========= ================ =====
d  r  b  m  property           type      ref              level
== == == == ================== ========= ================ =====
datasets/gov/example/countries                           
------------------------------ --------- ---------------- -----
\        Country                                          4
-- -- -- --------------------- --------- ---------------- -----
\           code               string                     4
\           name               string                     4
\        City                                             4
-- -- -- --------------------- --------- ---------------- -----
\           name               string                     4
\           country            ref       Country[code]    3
== == == == ================== ========= ================ =====

Šiuo atveju, `City` objektas atrodys lygiai taip pat, kaip anksčiau:

.. code-block:: json

    {
        "_type": "datasets/gov/example/countries/City",
        "_id": "78035ad0-8f59-4d59-8867-60ea856ba26f",
        "name": "Vilnius",
        "country": {
            "code": "lt"
        }
    }

Kadangi prie `City.country` nurodyta, kad jungimas daromas per `code`
(`Country[code]`).

Jei nenurodytas ne modelio su kuriuo daromas jungimas priminis raktas, nei prie
lauko nurodyta, per kurį modelio lauką daromas jungimas, tada jungimas daromas
per `_id`, netikrinant ar toks `_id` egzistuoja ar ne. Pavyzdžiui:

== == == == ================== ========= ========= =====
d  r  b  m  property           type      ref       level
== == == == ================== ========= ========= =====
datasets/gov/example/countries                    
------------------------------ --------- --------- -----
\        Country                                   4
-- -- -- --------------------- --------- --------- -----
\           code               string              4
\           name               string              4
\        City                                      4
-- -- -- --------------------- --------- --------- -----
\           name               string              4
\           country            ref       Country   3
== == == == ================== ========= ========= =====

Šiuo atveju, `City` objektas atrodys taip:

.. code-block:: json

    {
        "_type": "datasets/gov/example/countries/City",
        "_id": "78035ad0-8f59-4d59-8867-60ea856ba26f",
        "name": "Vilnius",
        "country": {
            "_id": "f23bb52b-bb55-4072-92b8-a8d9d77c9849"
        }
    }

Tačiau `Country` objektas su `_id` `f23bb52b-bb55-4072-92b8-a8d9d77c9849` gali
ir neegzistuoti, joks tikrinimas nedaromas.


.. _autorizacija:

Autorizacija
************

Norint gauti atvirus duomenis autorizacija nereikalinga, tačiau norint keisti
saugykloje esančius duomenis are įkelti naujus, būtina autorizacija.

Autorizacija atliekama OAuth_ standarto pagalba. Kol kas yra palaikoma tik
`client credentials`_ autorizavimo būdas.

.. _Oauth: https://en.wikipedia.org/wiki/OAuth
.. _client credentials: https://auth0.com/docs/flows/client-credentials-flow

Norint atlikti rašymo operacijas, pirmiausiai reikia, kad saugykloje jums
būtų sukurta paskyra. Tada naudodamiesi paskyros prisijungimo duomenimis
galite gauti autorizacijos raktą, kuris leis atlikti rašymo operacijas.

Autorizacijos raktas gaunamas taip:

.. code-block:: sh

    SERVER=https://put.data.gov.lt
    CLIENT=myclient
    SECRET=mysecret
    SCOPES="
    spinta_set_meta_fields
    spinta_getone
    spinta_getall
    spinta_search
    spinta_changes
    spinta_datasets_gov_myorg_insert
    spinta_datasets_gov_myorg_upsert
    spinta_datasets_gov_myorg_update
    spinta_datasets_gov_myorg_patch
    spinta_datasets_gov_myorg_delete
    spinta_datasets_gov_myorg_wipe
    "
    TOKEN=$(
        http \
            -a $CLIENT:$SECRET \
            -f $SERVER/auth/token \
            grant_type=client_credentials \
            scope="$SCOPES" \
        | jq -r .access_token
    )
    AUTH="Authorization: Bearer $TOKEN"
    echo $AUTH

    http "$SERVER/" "$AUTH"

Pavyzdyje `$SCOPES` kintamasis yra tarpo simboliais atskirtų leidimu sąrašas.
Leidimų pavadinimai formuojami taip:

.. code-block:: sh

    spinta_$ns_$action
    spinta_$model_$action
    spinta_$model_$property_$action

`$action` reikšmės aprašytos skyriuje :ref:`actions`.

Kiekvienas klientas gali gauti skirtingą `$SCEOPES` leidimų sąrašą ir jei
prašysite daugiau leidimų, nei jūsų klientui yra suteikta, gausite klaidą.


.. _actions:

Veiksmai
********

Užklausos skirstomos į šiuos veiksmus:

:getone:
    Vieno objekto duomenys, pagal pateiktą `_id`.

:getall:
    Visų objektų duomenys.

:search:
    Objektų duomenys taikant duomenų atrankos užklausą.

:changes:
    Keitimų žurnalas.

:insert:
    Naujo objekto kūrimas.

:upsert:
    Pilnas objekto perrašymas arba naujo objekto kūrimas. Jei pagal pateiktą
    užklausą objektas egzistuoja, tuomet jis perrašomas, jei objektas
    neegzistuoja, tuometi sukuriamas naujas.

:update:
    Pilnas objekto perrašymas, net jei pateikiami ne visi laukai, objektas
    perrašomas pilnai, laukams, kurie nebuvo pateikti suteikiant pirmines
    reikšmes.

:patch:
    Dalinis objekto keitimas, kai keičiamas ne visas, o tik dalis objekto,
    tam tikri objekto laukai.

:delete:
    Duomenų šalinimas. Tokiu būdu pašalinti duomenys išsaugomi keitimų žurnale.

:wipe:
    Pilnas ir neatstatomas duomenų pašalinimas, naudojama tik testavimo
    tikslams.



Skaitymo veiksmai
*****************

.. _getall:

getall
======

Šios užklausos pagalba galima gauti visus konkretaus modelio ar visos vardų
erdvės duomenis.

.. code-block:: sh

    http GET /datasets/gov/dc/geo/Continent

.. code-block:: http

    HTTP/1.1 200 OK
    Content-Type: application/json

    {
        "_type": "datasets/gov/dc/geo/Continent",
        "_data": [
            {
                "_id": "abdd1245-bbf9-4085-9366-f11c0f737c1d",
                "_revision": "16dabe62-61e9-4549-a6bd-07cecfbc3508",
                "_txn": "792a5029-63c9-4c07-995c-cbc063aaac2c",
                "continent": "Europe"
            }
        ]
    }

Taip pat žiūrėkite:

- :ref:`query-sort`
- :ref:`query-count`
- :ref:`query-batches`


.. _getone:

getone
======

Šios užklausos pagalba galima gauti vieną konkretų objektą pagal unikalų
objekto identifikatorių. Pavyzdžiui

.. code-block:: sh

    http GET /datasets/gov/dc/geo/Continent/abdd1245-bbf9-4085-9366-f11c0f737c1d

.. code-block:: http

    HTTP/1.1 200 OK
    Content-Type: application/json

    {
        "_type": "datasets/gov/dc/geo/Continent",
        "_id": "abdd1245-bbf9-4085-9366-f11c0f737c1d",
        "_revision": "16dabe62-61e9-4549-a6bd-07cecfbc3508",
        "_txn": "792a5029-63c9-4c07-995c-cbc063aaac2c",
        "continent": "Europe"
    }

Taip pat žiūrėkite:

- :ref:`getall`


.. _op-changes:

changes
=======

Šios užklausos pagalba galima gauti visų duomenų keitimų sąrašą. Ši užklausa
yra skirta tęstiniam duomenų atnaujinimui. Tam, kad nereikėtų kiekvieną kartą
iš naujo siųsti visų duomenų. Šios funkcijos pagalba, galite gauti tik tai, kas
pasikeitė, nuo jūsų paskutinio siuntimo.

Atkreipkite dėmesį, kad pasikeitimų žurnalas yra skirtas tik duomenų
sinchronizavimui ir keitimai yra periodiškai išvalomi. Jei norite gauti
istorinius duomenis, tuomet tai turėtu atsispindėti pačiuose duomenyse, o ne
keitimų žurnale. Keitimų žurnalas nėra skirtas istorinių duomenų saugojimui.

Norint sinchronizuoti duomenis, prieš pradedant sinchronizavimą, pirmiausiai
rekomenduojama atsisiųsti visus duomenis naudojant :ref:`getall` užklausą.
Siųsti viso keitimo žurnalo nėra prasmės, kadangi žurnalas yra nuolat valomas
ir jame paliekama tik kelių savaičių ar kelių mėnesių keitimai, priklausomai
nuo duomenų rinkinio.

Tačiau prieš siunčiant visus duomenis, reikia išsisaugoti paskutinio keitimo
ID, tai galite padaryti šios užklausos pagalba:

.. code-block:: sh

    http GET /datasets/gov/dc/geo/Continent/:changes/-1

.. code-block:: http

    HTTP/1.1 200 OK
    Content-Type: application/json

    {
        "_type": "datasets/gov/dc/geo/Continent",
        "_data": [
            {
                "_cid": "11",
                "_id": "abdd1245-bbf9-4085-9366-f11c0f737c1d",
                "_revision": "16dabe62-61e9-4549-a6bd-07cecfbc3508",
                "_txn": "792a5029-63c9-4c07-995c-cbc063aaac2c",
                "_created": "2021-07-30T14:03:14.645198",
                "_op": "insert",
                "continent": "Europe"
            }
        ]
    }

Čia argumentas `-1` nurodo, kad norite gauti paskutinį įrašą keitimų žurnale.
Šiame pavyzdyje, paskutinio keitimo ID yra `11`, keitimo ID yra nurodomas
`_cid` duomenų lauke.

Išsisaugojus paskutinio keitimo ID, galite atsisiųsti visus duomenis
naudodamiesi :ref:`getall` funkcija.

Atsisiuntus duomenis, galite pradėti sinchronizavimą, tokios užklausos pagalba:

.. code-block:: sh

    http GET /datasets/gov/dc/geo/Continent/:changes/11?limit(100)

.. code-block:: http

    HTTP/1.1 200 OK
    Content-Type: application/json

    {
        "_type": "datasets/gov/dc/geo/Continent",
        "_data": [
            {
                "_cid": "11",
                "_id": "abdd1245-bbf9-4085-9366-f11c0f737c1d",
                "_revision": "16dabe62-61e9-4549-a6bd-07cecfbc3508",
                "_txn": "792a5029-63c9-4c07-995c-cbc063aaac2c",
                "_created": "2021-07-30T14:03:14.645198",
                "_op": "insert",
                "continent": "Europe"
            }
        ]
    }

Šiuo atveju, užklausoje nurodomas išsaugotas keitimo id 11.

Atsakyme visada pateikiamas keitimas, kurio ID nurodėte. Rekomenduojama visada
patikrinti ar pirmas grąžintas keitimas yra būtent tas, kurį nurodėte,
papildomai rekomenduojama patikrinti ar sutampa `_id` ir `_revision` su tuo, ką
jūs gavote paskutinį kartą.

Toks patikrinimas reikalingas tam, kad įsitikinti, ar keitimų žurnalas nebuvo
išvalytas arba duomenys nebuvo perkrauti iš naujo. Jei patikrinimo metu, kažkas
nesutampa, toliau sinchronizavimą reikėtų nutraukti ir pakartoti viską iš
naujo, gaunat paskutinio keitimo ID, atsisiunčiant duomenis ir tik tada
sinchronizuojant.

Rekomenduojame sinchronizavimą daryti nedideliais puslapiais, pavyzdžiui po 100
įrašų, puslapio dydis nurodomas `limit(100)` parametro pagalba. Nuskaičius
vieną, puslapį, jei gavote daugiau nei vieną keitimą, tada galite kartoti
užklausą dar kartą, su paskutiniu gautu keitimo ID, tol, kol gausite vieną
keitimą, tą kurį nurodėte kaip argumentą.

Jei daugiau keitimų nėra, sekančią užklausą rekomenduojame daryti tada, kai
praeina prie duomenų rinkinio nurodytas duomenų atnaujinimo periodiškumas.
Pavyzdžiui, jei duomenys atnaujinami kasdien, tada sinchronizavimą taip pat
reikėtų daryti kasdien.

Dažnesnis sinchronizavimas nei nurodytas duomenų atnaujinimo periodiškumas yra
beprasmis, kadangi visais atvejais gausite tuščią keitimų sąrašą.

Keitimų įrašai turi tokius metaduomenis apie kiekvieną keitimą:

:_cid:
    Monotoniškai didėjantis keitimo numeris (keitimo ID).

:_id:
    Pakeisto objekto unikalus numeris (UUID formatu).

:_revision:
    Objekto revizijos numeris, naudojamas norint atlikti keitimo operaciją.
    Kiekvieną kartą, kai duomenys keičiami išduodamas naujas revizijos numeris.

:_txn:
    Tranzakcijos numeris, nurodo kokie keitimai buvo atlikti konkrečios keitimo
    tranzakcijos metu.

:_created:
    Data ir laikas, kada buvo atliktas keitimas.

:_op:
    Keitimo operacijos pavadinimas, gali būti tokie variantai:

    :insert:
        Sukurtas naujas objektas.

    :patch:
        Objekto keitimas, pateikiami tik toks reikšmės, kurios buvo pakeistos.
        Atkreipkite dėmesio, kad jei tam tikras laukas nebuvo pakeistas, jo
        keitimo įraše nebus. Jei laukas anksčiau buvo ir dabar yra ištrintas,
        tada keitimo įraše ištrintasis laukas bus pateiktas su `null` reikšme.

    :delete:
        Objektas buvo ištrintas.

    Atkreipkite dėmesį, kad vienam objektui, gali būti viena `insert`
    operacija, daug `patch` operacijų ir vienas `delete`.

Įgyvendinant duomenų atnaujinimą `:changes` protokolu, reikia interpretuoti
`_op` reikšmę ir atlikti atitinkamą operaciją savo pusėje.

Pavyzdžiui, jei gavote `_op=insert`, tuomet, savo pusėje, galite susikurti
naują įrašą. Jei gavote `_op=patch`, tada, savo pusėje turėtumėte atnaujinti
įrašą, pagal nurodyti `_id`. Ir atitinkamai, jei gavote `_op=delete`, tai
reiškia, kad objektas buvo ištrintas, turėtumėte jį ištrinti ir savo pusėje,
pagal `_id` reikšmę.

Keitimu žurnalas yra naudingas, tais atvejais, kai duomenys dažnai keičiasi ir
norite greitai gauti informaciją, kas ir kada pasikeitė. Taip pat, jei duomenų
yra labai daug ir jų siuntimas užtrunka daug laiko, tada galite atsisiųsti
duomenis vieną kartą ir toliau sekti keitimus.


Duomenų užklausos
*****************

Visos duomenų užklausos yra pateikiamos URL query dalyje, po `?` žymės.
Tai kas yra rašoma po `?` yra :ref:`formulės`, tokios pačios, kurios yra
naudojamos duomenų struktūros aprašo :data:`prepare` stulpelyje.

Atkreipkite dėmesį, kad dalis einanti po `?` turi būti tinkamai koduota
naudojanti `RFC 3986`_ specifikaciją. Kai kurie klientai tai padaro
automatiškai, kai kurie ne. Visuose pavyzdžiuose pateikiamas nekoduotas
variantas dėl geresnio skaitomumo.

.. _RFC 3986: https://datatracker.ietf.org/doc/html/rfc3986.html

Viso užklausoje naudojamos funkcijos yra atskiriamos `&` simboliu.
Pavyzdžiui::

    /example/Model?(col1="xyz"|col2<42)&select(col1,col2)&sort(col3)&limit(5)


.. _query-join:

Jungimas
========

Duomenis galima sujungti, jei duomenų struktūroje yra nurodyti ryšiai
tarp modelių.

Jungimas atliekamas `.` (taško) pagalba, pavyzdžiui, norime prie miestų
duomenų prijungti šalis, kurios pateiktos atskirame modelyjes tuomet
jungimą galime atlikti taip::


    /example/City?select(country.name)

Čia, `country` laukas priklauso miesto modeliui, o `name` laukas
priklauso šalied modeliui.

Taip apjungtus duomenų laukus galima naudoti atranko, filtravime ir
rūšiavime.


.. _query-select:

Atranka
=======

Yra galimėbė gauti ne visus duomenų laukus, o tik tim tikrus, kurie
nurodyti užklausoje. Tokią atranką galima atlikti naudojant `select()`
funkciją. Pavyzdžiui:

    /example/Model?select(prop1, prop2, prop3)


Filtravimas
===========

Galima atlikti duomenų atranką, pagal pateiktą filtrą. Palaikomi tokie
filtravimo operatoriai:

- `prop = value` - atranka pagal tikslią reikšmę,

- `prop != value` - atranka objektų, kurių reikšmė neatitinka nurodytai,

- `prop` [ `>`, `>=`, `<`, `<=` ] `value` - atranka palyginant ar
  reikšmų didesnė ar mažesnė.

- `prop.contains(value)` - atranka objektus, jei `value` yra `prop`
  reikšmės dalis.


- `prop.startswith(value)` - atrenka objektus, kurie prasideda `value`
  reikšme.

Tais atvejais jei `value` yra simbolių eilutė, reikia naudoti kabutes.

Filtruojanti taip pat galima naudoti AND ir OR operatorius, pavyzdžiui::

    /example/Model?prop=value1&prop=value2

    /example/Model?prop=value1|prop=value2

    /example/Model?prop=value1&(prop=value2|prop=value3)


.. _query-sort:

Rūšiavimas
==========

Duomenis rūšiuoti galima pasitelkus `sort()` funkciją:

- `sort(prop)` - rūšiuoja didėjančia tvarka.
- `sort(-prop)` - rūšiuoja mažėjančia tvarka.

Kalima rūšiuoti pagal kelis stulpelius, pavyzdžiui::

    /example/Model?sort(prop1,-prop2,prop3)


.. _query-limit:

Objektų skaičiaus ribojimas
===========================

Norint apriboti grąžinamų objektų skaičių galima naudoti `limit()`
funkciją, pavyzdžiui:

    /example/Model?limit(10)

Tokia užklausa grąžins ne daugiau kaip 10 objektų.


.. _query-count:

Objektų skaičius
================

Norinti gauti vieno modelio objektų skaičių galima panaudoti `count()` funkciją:

.. code-block:: sh

    http GET /datasets/gov/dc/geo/Continent?count()

.. code-block:: http

    HTTP/1.1 200 OK
    Content-Type: application/json

    {
        "_type": "datasets/gov/dc/geo/Continent",
        "_data": [
            {
                "count()": 3856
            }
        ]
    }


.. _query-batches:

Puslapiavimas
=============

Jei duomenų nepavyksta atsisiųsti vienu kartu dėl per didelės duomenų apimties,
reikia naudoti puslapiavimą ir duomenis siųstis mažesniais paketais.

Šiuo metu, puslapiavimas pagal nutylėjimą yra išjungtas, tačiau ateityje
didelės apimties duomenų rinkiniams puslapiavimas gali būti įjungtas
privalomai. Šiuo metu, jei duomenų yra labai daug ir jų siuntimas užtrunka per
ilgai, pavyzdžiui ilgiau nei 30 minučių, tada siuntimas gali būti nutrauktas.
Norint gauti visus duomenis, reikia naudoti puslapiavimą.

Jei norite nuolat turėti pačius naujausius duomenis, nereikia kiekvieną kartą
siųstis visų duomenų, o vietoj to naudoti :ref:`op-changes` API, kuris leidžia
gauti tik naujausius pasikeitimus duomenyse.

Kad įjungti puslapiavimą, pirmiausiai reikia nurodyti puslapio dydį `limit()`
funkcijos pagalba, pavyzdžiui:

.. code-block:: sh

    http GET /datasets/gov/dc/geo/Continent?limit(10000)

Gausite tokį atsakymą:

.. code-block:: http

    HTTP/1.1 200 OK
    Content-Type: application/json

    {
        "_type": "datasets/gov/dc/geo/Continent",
        "_page" {
            "next": "WyJhYmRkMTI0NS1iYmY5LTQwODUtOTM2Ni1mMTFjMGY3MzdjMWQiXQ=="
        },
        "_data": [
            {
                "_id": "abdd1245-bbf9-4085-9366-f11c0f737c1d",
                "_revision": "16dabe62-61e9-4549-a6bd-07cecfbc3508",
                "_txn": "792a5029-63c9-4c07-995c-cbc063aaac2c",
                "continent": "Europe"
            }
        ]
    }

Norint gauti sekantį puslapį, reikia pateikti sekančio puslapio raktą `page()`
funkcijai. Sekančio puslapio raktas pateikiamas kartu su duomenimis
`_page.next` duomenų lauke:

.. code-block:: sh

    http GET /datasets/gov/dc/geo/Continent?limit(10000)&page("WyJhYmRkMTI0NS1iYmY5LTQwODUtOTM2Ni1mMTFjMGY3MzdjMWQiXQ==")

Įvykdžius šią užklausą, gausite sekantį puslapį, o su sekančio puslapio
duomenimis, tolesnio puslapio raktą.

Tokiu būdu duomenis galite gauti mažesniais paketais, nurodant norimą puslapio
dydį.

Koks turėtu būti puslapio dydis, priklauso nuo duomenų struktūros, kuriuose
bandoma atsisiųsti. Jei struktūra labai didelė ir vieno objekto duomenų apimtis
yra labai didelė, tada puslapio dydis turėtu būti mažesnis. Jei vieno objekto
apimtis yra labai nedidelė, tada puslapio dydis gali būti didesnis.

Daugeliu atveju turėtu tikti puslapio dydis tarp 1000 ir 10000.



Rašymo veiksmai
***************

Atliekant rašymo veiksmus, Saugykla priima viską, ką bandote į ją rašyti, su
sąlyga, kad rašomos reikšmės atitinka nurodytus tipus.

Todėl perduodant duomenis į Saugyklą reikia išsisaugoti būseną, ką jau esate
atidavę, o kas dar nebuvo perduota. Kuriant naują objektą `insert` užklausos
pagalba,  Saugykla išduoda išorinį objekto raktą, kuris neturėtu niekada
keistis. Norint atnaujinti tą patį objektą, reikėtų daryti ne `insert`, o
`patch` veiksmą, siunčiant tik tas reikšmes, kurios pasikeitė.

Kartais nutinka taip, kad išsiuntus užklausą, negaunate atsakymo iš Saugyklos,
dėl kokios nors klaidos, tokiais atvejais nėra galimybės sužinoti ar duomenys
buvo įrašyti ar ne. Tokiu atveju turėtumėte daryti `search` arba `getone`
užklausą, nurodant vidinį arba išorinį pirminį raktą, kad įsitikintumėte ar
duomenys buvo įrašyti ar ne. Jei duomenys nebuvo įrašyti, tuomet rašymo
užklausą turėtumėte pakartoti.

Iliustruojant visą tai psiaudokodu, rašymas į Saugyklą turėtu vykti taip:

.. code-block:: python

    state = State()
    store = Store('put.data.gov.lt')

    # Sinchronizuojam, ką reikia naujinti, ką trinti, o ką publikuoti pirmą
    # kartą.
    state.update()

    # Kol ne visi objektas publikuoti, kartojam...
    while not state.empty():

        # Skaitom objektus, kuriuos reikia publikuoti.
        for obj in state.objects:
            try:

                # Objektas buvo ištrintas šaltinyje, triname Saugykloje.
                if obj.deleted:
                    store.delete(obj)

                # Objektas nebuvo publikuotas, publikuojam pirmą kartą.
                if obj.created:
                    store.insert(obj)

                # Objektas jau buvo publikuotas ir pasikeitė nuo paskutinio
                # publikavimo. Atnaujinam.
                if obj.changed:
                    store.patch(obj)

            # Klaidos atveju:
            except HTTPError, IOError:
                # Jei objektas turėjo ir buvo ištrintas, triname iš eilės.
                # šaliname iš eilės.
                if obj.deleted and not store.exists(obj):
                    state.remove(obj)

                # Jei objektas turėjo ir buvo publikuotas, triname iš eilės.
                if obj.created and store.exists(obj):
                    state.remove(obj)

                # Visais kitais atvejais, paliekame objektą eilėje ir kartojame
                # publikavimą, sekančios iteracijos metu.

            # Jei klaidų nebuvo, šaliname objektą iš eilės.
            else:
                state.remove(obj)


Šiame pavyzdyje į `state` objektą įtraukiami visi šaltinio objektai, kuriuos
reikia publikuoti, t.y. tuos, kurie dar nebuvo publikuoti, kurie pasikeitė nuo
paskutinio publikavimo, arba buvo ištrinti šaltinyje.

Jei publikavimo metu įvyko klaida, kurios metu nebuvo gautas atsakymas iš
Saugyklos, tikriname `store.exists(obj)` pagalba, ar realiai publikavimas įvyko
ar ne. Jei ne, paliekame objektą eilėje ir sekančios iteracijos metu, bandome
dar kartą.

Pats `store.exists(obj)` kreipiasi į Saugyklą ir bando gauti objektą, pagal jo
vidinį arba išorinį raktą. Kas yra išoriniai ir vidiniai raktai, paaiškinta
žemiau.

        
**Vidinis pirminis raktas**

Vidinis pirminis raktas yra vienas ar daugiau :data:`property`, kurie yra
įrašomi į struktūros aprašo :data:`model.ref`, taip nurodant lentelės pirminį
raktą.

Jei visi :data:`property` nurodyti :data:`model.ref` yra atviri, t.y.
`access=open`, tuomet, galite užtikrintai žinoti ar konkretus duomenų objektas
buvo įrašytas ar ne.


**Išorinis pirminis raktas**

Išorinis pirminis raktas `_id` yra generuojamas pačios Saugyklos, tačiau turint
`spinta_set_meta_fields` teises, galite išorinį pirminį raktą, UUIDv4 formatu
generuoti patys. Tokiu atveju, nebūtina publikuoti vidinio pirminio rakto ir
nebūtina laukti atsakymo iš Saugyklos, nes išorinis raktas generuojamas jūsų
pusėje ir klaidos atveju galite pasitikrinti ar objektas buvo įrašytas ar ne.


.. _insert:

insert
======

.. code-block:: sh

    http POST /datasets/gov/dc/geo/Continent $auth <<EOF
    {
        "continent": "Europe"
    }
    EOF

.. code-block:: http

    HTTP/1.1 201 Created
    Content-Type: application/json
    Location: /datasets/gov/dc/geo/Continent/abdd1245-bbf9-4085-9366-f11c0f737c1d

    {
        "_type": "datasets/gov/dc/geo/Continent",
        "_id": "abdd1245-bbf9-4085-9366-f11c0f737c1d",
        "_revision": "16dabe62-61e9-4549-a6bd-07cecfbc3508",
        "_txn": "792a5029-63c9-4c07-995c-cbc063aaac2c",
        "continent": "Europe"
    }


.. _upsert:

upsert
======

`upsert` veiksmas pirmiausiai patikrina ar jau yra sukurtas objektas
atitinkantis `_where` sąlygą, jei yra, tada vykdo `patch` veiksmą, jei nėra,
tada vykdo `update` veiksmą.

.. code-block:: sh

    http POST /datasets/gov/dc/geo/Continent $auth <<EOF
    {
        "_op": "upsert",
        "_where": "name='Africa'",
        "continent": "Africa"
    }
    EOF

.. code-block:: http

    HTTP/1.1 201 Created
    Content-Type: application/json
    Location: /datasets/gov/dc/geo/Continent/b8f1edaa-220d-4e0b-b59b-dc27555a0fb5

    {
        "_type": "datasets/gov/dc/geo/Continent",
        "_id": "b8f1edaa-220d-4e0b-b59b-dc27555a0fb5",
        "_revision": "988969c3-663b-4edf-bd64-861a3f1b1d1c",
        "_txn": "2c5feac6-1d72-48f6-ae63-8f2304693b21",
        "continent": "Africa"
    }


.. _update:

update
======

`update` veiksmas pilnai perrašo objektą. Jei tam tikros objekto savybės
nenurodomos, data tū savybių reikšmės pakeičiamos pagal nutylėjimą
naudojamomis reikšmėmis.

Vykdant `update` taip pat būtina perduoti `_revision` revizijos numeri. Jei
revizijos numeris nesutaps, su tuo, kas jau yra duomenų bazėje, tada duomenys
nebus keičiami ir bus gražinta klaida. Tai reikalinga tam, kad būtų
užtikrintas duomenų vientisumas.

.. code-block:: sh

    http PUT /datasets/gov/dc/geo/Continent/b8f1edaa-220d-4e0b-b59b-dc27555a0fb5 $auth <<EOF
    {
        "_revision": "988969c3-663b-4edf-bd64-861a3f1b1d1c",
        "continent": "Africa"
    }
    EOF

.. code-block:: http

    HTTP/1.1 200 OK
    Content-Type: application/json
    Location: /datasets/gov/dc/geo/Continent/b8f1edaa-220d-4e0b-b59b-dc27555a0fb5

    {
        "_type": "datasets/gov/dc/geo/Continent",
        "_id": "b8f1edaa-220d-4e0b-b59b-dc27555a0fb5",
        "_revision": "988969c3-663b-4edf-bd64-861a3f1b1d1c",
        "_txn": "2c5feac6-1d72-48f6-ae63-8f2304693b21",
    }

Jei duomenys duomenų bazėje ir duomenys perduoti `update` užklausos metu yra
identiški, tada duomenų bazėje niekas nekeičiama. Tačiau, jei duomenys
skiriasi, tada į keitimų žurnalą išsaugoma tai, kas buvo pakeista ir sukuriam
nauja revizija. Taip pat fiksuojama nauja transakcija.

`update` atsakyme grąžinamos tiks tos savybės, kurių reikšmės buvo pakeistos,
Jei reikšmės nepasikeitė, tada jos pateikiamos atsakyme.


.. _patch:

patch
=====

`patch` veikia panašiai, kaip ir `update`, tačiau objekto pilnai neperrašo,
keičia tik tas savybes, kurios nurodytos.

.. code-block:: sh

    http PATCH /datasets/gov/dc/geo/Continent/b8f1edaa-220d-4e0b-b59b-dc27555a0fb5 $auth <<EOF
    {
        "_revision": "988969c3-663b-4edf-bd64-861a3f1b1d1c",
        "continent": "Africa"
    }
    EOF

.. code-block:: http

    HTTP/1.1 200 OK
    Content-Type: application/json
    Location: /datasets/gov/dc/geo/Continent/b8f1edaa-220d-4e0b-b59b-dc27555a0fb5

    {
        "_type": "datasets/gov/dc/geo/Continent",
        "_id": "b8f1edaa-220d-4e0b-b59b-dc27555a0fb5",
        "_revision": "988969c3-663b-4edf-bd64-861a3f1b1d1c",
        "_txn": "2c5feac6-1d72-48f6-ae63-8f2304693b21",
    }


.. _delete:

delete
======

Trina objektą. Objektas pilnai nėra ištrinamas, jis vis dar lieka keitimų
žurnale ir gali būti atstatytas.

.. code-block:: sh

    http DELETE /datasets/gov/dc/geo/Continent/b8f1edaa-220d-4e0b-b59b-dc27555a0fb5 $auth

.. code-block:: http

    HTTP/1.1 204 No Content


.. _wipe:

wipe
====

Pilnai ištrina objektą, įskaitant ir objekto pėdsakus keitimo žurnale. Tokiu
būdu ištrinto objekto atstatyti neįmanoma.

.. note::

    **Naudoti tik išimtiniais atvejais.**

    `wipe` operacija naudojama tik išimtiniais atvejais, jei pastebėta
    esminių klaidų duomenų įkėlimo skriptuose, duomenys dėl įvairių klaidų
    buvo sugadinti ir pan. Duomenų įkėlimo procesą geriausia išsitestuoti
    :ref:`testinėje aplinkoje <saugyklos-testinė-aplinka>`.

    Duomenų įkėlimo praktika, kai visi publikuoti duomenys ištrinami ir
    įkeliami iš naujo nerekomenduotina, kadangi tokiu atveju dingsta duomenų
    keitimo istorija, gali pasikeisti objektų identifikatoriai. Duomenys turi
    būti pirmą kartą įkeliame, o tada atnaujinama tik tai, kas pasikeitė.

.. code-block:: sh

    http DELETE /datasets/gov/dc/geo/Continent/b8f1edaa-220d-4e0b-b59b-dc27555a0fb5/:wipe $auth

.. code-block:: http

    HTTP/1.1 200 OK
    
    {
        "wiped": true
    }


Grupiniai rašymo veiksmai
*************************

Vienos HTTP užklausos metu galima vykdyti rašymo veiksmus grupei objektų. Tokiu
būdu, veiksmai vykdomi vienoje duomenų bazės transakcijoje užtikrinant duomenų
vientisumą.

Grupiniai veiksmai gali būti vykdomi dviem būdais, paprastuoju ir srautiniu.

Paprastasis grupinis rašymas
============================

Paprastasis grupinis rašymas vykdomas per POST užklausą, kurioje yra
pateiktas `_data` masyvas veiksmų.

Vykdant grupinius veiksmus būdina nurodyti `_op` veiksmą ir `_type` modelio
pavadinimą, kuriam taikomas veiksmas.

Grupinis rašymas gali būti vykdomas konkrečiam vienam modeliui, arba keliems
skirtingiems modeliams, vykdant užklausą vardų erdvės kontekste.

.. code-block:: sh

    http POST /datasets/gov/dc/geo/Continent $auth <<EOF
    {
        "_data": [
            {
                "_op": "insert",
                "_type": "datasets/gov/dc/geo/Continent",
                "continent": "Africa"
            },
            {
                "_op": "insert",
                "_type": "datasets/gov/dc/geo/Continent",
                "continent": "Europe"
            }
        ],
    }
    EOF

.. code-block:: http

    HTTP/1.1 207 Multi-Status
    Content-Type: application/json

    {
        "_data": [
            {
                "_type": "datasets/gov/dc/geo/Continent",
                "_id": "b8f1edaa-220d-4e0b-b59b-dc27555a0fb5",
                "_revision": "988969c3-663b-4edf-bd64-861a3f1b1d1c",
                "_txn": "2c5feac6-1d72-48f6-ae63-8f2304693b21",
                "continent": "Africa"
            },
            {
                "_type": "datasets/gov/dc/geo/Continent",
                "_id": "abdd1245-bbf9-4085-9366-f11c0f737c1d",
                "_revision": "16dabe62-61e9-4549-a6bd-07cecfbc3508",
                "_txn": "2c5feac6-1d72-48f6-ae63-8f2304693b21",
                "continent": "Europe"
            }
        ]
    }


Srautinis grupinis rašymas
==========================

Paprastasis grupinis rašymas skirtas situacijoms, kai reikia atlikti veiksmus su
nedidele grupe objektų. Tačiau jei objektų labai daug, galima vykdyti srautinį
rašymą.

Srautinis rašymas priima duomenis JSONL formatu ir įeinančiame JSONL sraute
skaito po vieną eilutę ir toje eilutėje pateiktą objektą iš karto vykdo. Tuo
tarpu paprasto grupinio rašymo metu, visi objektai užkraunami į atmintį ir
tik data įrašomi į duomenų bazę.

Kadangi srautinio grupinio rašymo metu objektai skaitomi ir rašomi vienas po
kito, tai leidžia perduoti neribotą kiekį objektų rašymui.

Srautinio grupinio rašymo užklausa atrodo taip:

.. code-block:: sh

    http POST /datasets/gov/dc/geo/Continent $auth Content-Type:application/x-ndjson <<EOF
    {"_op": "insert", "_type": "datasets/gov/dc/geo/Continent", "continent": "Africa"}
    {"_op": "insert", "_type": "datasets/gov/dc/geo/Continent", "continent": "Europe"}
    EOF

.. code-block:: http

    HTTP/1.1 207 Multi-Status
    Content-Type: application/json

    {
        "_txn": "2c5feac6-1d72-48f6-ae63-8f2304693b21",
        "_status": {
            "insert": 2
        }
    }

Srautinio rašymo užklausai būtina perduoti `Content-Type` antrašte su viena
iš šių reikšmių::

    application/x-ndjson
    application/x-jsonlines

Tada bus vykdomas srautinis veiksmų vykdymas.

Srautinės užklausos atsakymas yra santrauka api tai, kiek kokių veiksmų buvo
įvykdyta ir transakcijos numeris. Naudojant transakcijos numerį, atskiros
užklausos metu, galima gauti visų pakeistų objektų identifikatorius `_id` ir
revizijos numerius `_revision` ir informaciją apie tai, kas tiksliai buvo pakeista.
