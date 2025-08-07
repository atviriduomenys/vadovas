.. default-role:: literal

.. _agentas:

#######
Agentas
#######


Sinchronizacija
***************

**Sinchronizacija** – tai procesas, kurio metu sulyginama tiek duomenų struktūra, tiek patys duomenys tarp duomenų
šaltinio ir atvirų duomenų Kataloge saugomos informacijos.


Pasiruošimas
============

Prieš pradedant sinchronizaciją, reikia paruošti:

- **Atvirų duomenų Katalogą** – įregistruoti Agentą
- **Agentą** – sukonfigūruoti prisijungimą prie Katalogo

Šie žingsniai užtikrins, kad sinchronizacija vyktų sklandžiai.


Agento registracija Kataloge
----------------------------

Pirmasis žingsnis – **Agentų sąsajos registracija atvirų duomenų Kataloge**.

Registracija vykdoma organizacijos, kuriai priklauso naudotojas, puslapyje. Norėdami tai atlikti:

#. Prisijunkite prie atvirų duomenų Katalogo.
#. Viršutiniame dešiniajame kampe užveskite pelę ant savo naudotojo vardo.

    | |image_sinchronizacija_1|
    | *pav. Navigacijos juosta – vartotojo skirtukas*

#. Pasirinkite **„Mano organizacijos rinkiniai“**.

    | |image_sinchronizacija_2|
    | *pav. Nuoroda į organizacijos erdvę*

#. Atverkite skirtuką **„Agentai“**.

    | |image_sinchronizacija_3|
    | *pav. Agentų skirtukas*

#. Spustelėkite **„Pridėti Agentą“**.

    | |image_sinchronizacija_4|
    | *pav. Agento pridėjimo mygtukas*

#. Užpildykite formą ir spauskite **„Sukurti“**.

    - :ref:`Nuoroda į formos laukus su paaiškinimais <agent_create_edit_form>`

#. **Iš karto po sukūrimo** puslapyje bus parodyti prisijungimo duomenys (arba slaptas raktas).
   **Išsisaugokite juos**, nes jie rodomi tik vieną kartą.

   Jų turinys priklauso nuo pasirinktos :ref:`Agento rūšies<agent_create_edit_form_field_kind>`:

    - **Spinta** — pateikiamos dvi konfigūracijos:

        - :ref:`Prisijungimas prie Katalogo<configuration_credentials_cfg>`
        - :ref:`Prisijungimas prie duomenų šaltinio<configuration_config_yml>`

    - **Kita** — pateikiamas tik *OAuth 2.0* kliento **secret** raktas. Likusi konfigūracija – tiekėjo atsakomybė

        - :ref:`Slapto rakto konfigūracija<configuration_secret_key>`


.. _agent_configuration:

Agento konfigūracija
--------------------

Prisijungimo konfigūraciją įdėkite į failą `credentials.cfg`.

- Jei faile jau yra įrašų – pridėkite naują įrašo bloką apačioje.
- Sistema automatiškai parinks tinkamą konfigūraciją pagal kontekstą.

Daugiau informacijos apie šį failą: :ref:`Konfigūracija<configuration>`


Vykdymas
--------

Norint pradėti sinchronizaciją, turi būti paruošta:

- Agento „Spinta“ implementacija (žr. :ref:`Spinta<spinta>`)
- Struktūros aprašo failas, pvz., `data.csv`

Sinchronizacijos komanda:

.. code-block:: console

    spinta sync <failo_pavadinimas>

Kur:

- **<failo_pavadinimas>** — kelias iki struktūros aprašo failo, kurį norite sinchronizuoti su duomenų portalu.


Procesas
========

Įvykdžius komandą `spinta sync`, vykdomi šie veiksmai:

- Sistema patikrina, ar toks duomenų rinkinys jau egzistuoja Kataloge.
    - **Jei egzistuoja** – gausite klaidą. Šiuo metu esamų rinkinių atnaujinimas dar neįgyvendintas.
    - **Jei neegzistuoja** – sukuriamas naujas rinkinys ir jo struktūra įkeliama į Katalogą.


Klaidos ir jų paaiškinimai
==========================

Sinchronizacijos metu galite susidurti su šiomis klaidomis:


`ManifestFileNotProvided`:
    Komandoje `spinta sync` nebuvo nurodytas DSA failas.

    Failą būtina pateikti taip: `spinta sync <kelias_iki_failo>`.


`NotImplementedFeature`:
    Funkcionalumas dar nėra įgyvendintas.

    **Atributai:**

    - **feature** — Funkcionalumas, kuris nėra įgyvendintas.

`UnexpectedAPIResponse`:
    Katalogas grąžino netikėtą HTTP atsakymą.

    **Atributai:**

    - **operation** — bandytas veiksmas.

    - **expected_status_code** — tikėtasis HTTP būsenos kodas/kodai.

    - **response_status_code** — gautas HTTP būsenos kodas.

    - **response_data** — Katalogo atsakymas (**Python** programavimo kalbos *dict* formatu).

`UnexpectedAPIResponseData`:
    Katalogas grąžino teisingą HTTP kodą, bet atsakyme trūksta reikalingų duomenų.

    **Atributai:**

    - **operation** — bandytas veiksmas.

    - **context** — nurodo, kokio lauko pritrūko atsakyme.


Kliento administravimas
***********************

Kliento administravimas yra OAuth_ kliento kūrimas, peržiūra, keitimas ir trynimas.


.. _Oauth: https://en.wikipedia.org/wiki/OAuth

.. _agent-CRUD-update:

Kliento atnaujinimas
====================

Kliento atnaujinimas atliekamas PATCH užklausa adresu `spinta_url/auth/clients/{client_id}`,
siunčiant vieną ar kelis atributus, kuriuos norima pakeisti.

Užklausai reikalingas `auth_clients` leidimas (scope). Be jo, galima keisti tik kliento,
su kuriuo atliekama užklausa, slaptažodį.

Užklausa su pilnais duomenimis:

.. code-block:: json

    {
        "client_name": "New Client Name",
        "scopes": [
            "spinta_getone",
        ],
        "backends": {
            "new_resource_name": {
                "new_key": "new_value"
            }
        }
    }

client_name:
    Kliento pavadinimas, išduodamas kliento registravimo autentifikacijos servise metu.

scopes:
    Leidimai.

backends:
    Atributas, kuriame saugoma papildomi autentifikacijos duomenys, kurie gali būti naudojami
    prisijungimui prie duomenų šaltinio. Autentifikacijos duomenys saugomi kiekvienam :term:`DSA`
    resursui atskirai.


Užklausoje nenurodyti atributai nebus pakeisti. Sėkmingos užklausos atveju bus grąžinamas atsakymas:

.. code-block:: json

    {
        "client_id": "791cdc66-bed8-4c9f-9d92-0e49a061c3d0",
        "client_name": "New Client Name",
        "scopes": [
            "spinta_getone",
        ],
        "backends": {
            "new_resource_name": {
                "new_key": "new_value"
            }
        }
    }


.. _configuration:

Konfigūracija
*************


Agento prisijungimas prie Katalogo (Spinta konfigūracija)
=========================================================


Spinta
------

Sukūrus Agentą Kataloge, sugeneruojama konfigūracija. Šią konfigūraciją reikia įdėti į Agento `credentials.cfg` failą.
Kadangi faile gali būti keli įrašai, šį bloką įdėkite kaip atskirą konfigūracijos įrašą.

Toliau pateikiamas *Spinta* konfigūracijos failo įrašo pavyzdys:

.. code-block:: ini

    [default]
    server = http://example-server.com
    resource_server = http://example-resource-server.com
    client_id = <kliento_identifikatorius>
    client = agentas
    secret = <kliento_paslaptis>
    scopes =
        spinta_datasets_gov_vssa_dataset_getall
        spinta_datasets_gov_vssa_dataset_insert
        spinta_datasets_gov_vssa_dataset_dsa_getone
        spinta_datasets_gov_vssa_dataset_dsa_insert
        spinta_datasets_gov_vssa_dataset_dsa_update
        spinta_datasets_gov_vssa_distribution_getall
        spinta_datasets_gov_vssa_distribution_insert

**server**

    Nurodomas autorizacijos serverio adresas (URL), kuris išduoda prieigos žetoną (angl. access token) ir valdo
    *OAuth 2.0* klientus.

**resource_server**

    Nurodomas atvirų duomenų Katalogo adresas (URL), kur saugomi duomenys.

**client_id**

    Nurodomas *OAuth 2.0* kliento identifikatorius.

**client**

    Nurodomas *OAuth 2.0* kliento pavadinimas, automatiškai sukuriamas pagal Kataloge nurodytą pavadinimą ir naudojamas
    autorizacijos procese.

**secret**

    Pagrindinis slaptasis raktas naudojamas *OAuth 2.0* klientui. Galioja neribotą laiką.

**scopes**

    Prašomi leidimai, kurie yra siunčiami į autorizacijos serverį.
    Jei šie leidimai nesutampa su leidimais, suteiktais *OAuth 2.0* klientui, prieigos žetonas neveiks ir
    pokyčių atlikti nepavyks.
    Todėl konfigūracijoje palikite tik būtinus leidimus, papildomų, nenumatytų leidimų įtraukti nereikėtų.
    Esant poreikiui, galite palikti tik dalį jų.


Kita
----

Pasirinkus šią rūšį, konfigūracija, leidžianti pasiekti Katalogą, yra sprendimo įgyvendintojo atsakomybė. Sistemoje
pateiktas raktas yra *OAuth 2.0* kliento slaptasis raktas.


Agento prisijungimas prie duomenų šaltinio
==========================================

Norint iš Agento prisijungti prie duomenų šaltinio, naudokite
:ref:`šią dokumentaciją<spinta_configuration_with_data_source>`.


Formos, jų laukai ir paaiškinimai
*********************************


.. _agent_create_edit_form:

Agento kūrimo / redagavimo forma
=================================

Ši forma naudojama Agentui sukurti arba esamam Agentui redaguoti.

- Naujo Agento kūrimą inicijuokite paspaudę **[Pridėti Agentą]** viršutiniame dešiniajame kampe.
- Norėdami redaguoti jau sukurtą Agentą, sąraše spustelėkite **[Redaguoti]** šalia įrašo.

| |image_formos_ir_laukai_1|
| *pav. Agento kūrimo / redagavimo forma*


Formos laukai ir jų paaiškinimai
--------------------------------

**Pavadinimas**
    Vartotojui matomas Agento pavadinimas, naudojamas ir kodiniam pavadinimui generuoti.

.. _agent_create_edit_form_field_kind:

**Rūšis**
    Nurodo, kokia implementacija naudojama Agento veikimui:

    - **Spinta** – sugeneruojamos dvi konfigūracijos:

        - `credentials.cfg <https://atviriduomenys.readthedocs.io/spinta.html#duomenu-publikavimas-i-saugykla>`_
        - `config.yml <https://atviriduomenys.readthedocs.io/spinta.html?#config-yml>`_

    - **Kita** – suteikiamas prieigos raktas. Likusi dalis priklauso sprendimo tiekėjui.

**Agentas įjungtas**
    Nurodo, ar Agentas šiuo metu aktyvus.

**Atviri duomenys publikuojami Saugykloje**
    Pažymėjus šį lauką, leidžiama publikuoti atvirus duomenis per Agentą.

**Atvirų duomenų publikavimo nuoroda**
    Nurodoma tik tada, kai pažymėtas ankstesnis laukas dėl duomenų publikavimo.

.. note::
   Sukūrus Agentą, pateikiamos reikalingos konfigūracijos ir slaptas prisijungimo raktas.
   **Dėl saugumo šis raktas rodomas tik vieną kartą – būtinai jį išsaugokite.**


Agentų sąrašo lentelė
======================

Ši lentelė atvaizduoja visus registruotus Agentus ir jų pagrindinę informaciją.

| |image_formos_ir_laukai_2|
| *pav. Agentų sąrašo lentelė*


Rodomi laukai ir jų reikšmės
----------------------------

**Būsena**
    Būsena apima du indikatoriai:

    - Spalvotas rutuliukas, žymintis paskutinės sinchronizacijos rezultatą:

        - **Žalia** – sinchronizacija pavyko.
        - **Raudona** – sinchronizacija nepavyko.
        - **Juoda** – sinchronizacija dar nevykdyta.

    - Indikatorius, ar Agentas yra įjungtas.

**Kodinis pavadinimas**
    Unikalus pavadinimas, generuojamas sistemoje organizacijos mastu.

**Pavadinimas**
    Vartotojui matomas pavadinimas. Naudojamas kodiniam pavadinimui generuoti.

**Sukurtas**
    Agento sukūrimo data.

**Užklausa**
    Paskutinės sinchronizacijos arba bandymo data.

**Duomenų paslauga**
    Kiekvienam Agentui automatiškai sukuriama susijusi duomenų paslauga, kuriai priskirti duomenų rinkiniai.

**Veiksmai**
    Prie kiekvieno Agento pateikiami šie veiksmai:

    - **Žurnalas** – detali Agento informacija.
    - **Redaguoti** – Agento redagavimo forma.
    - **Pašalinti** – Agento pašalinimas iš sistemos.


Agento peržiūros forma
=======================

Ši forma naudojama peržiūrėti sukurto Agento informaciją ir būseną.

| |image_formos_ir_laukai_3|
| *pav. Agento peržiūros forma*


Paaiškinimai apie laukų reikšmes
--------------------------------

**Sukurtas**
    Agento sukūrimo data.

**Pavadinimas**
    Vartotojui matomas pavadinimas.

**Kodinis pavadinimas**
    Unikalus identifikatorius, generuojamas sistemoje.

**Servisas**
    Duomenų paslauga, automatiškai sukuriama ir susiejama su Agentu.

**Būsena**
    Nurodoma, ar Agentas įjungtas.

**Rūšis**
    Naudojama implementacija:

    - **Spinta** – naudojama „Spintos“ sinchronizavimo logika.
    - **Kita** – nestandartinė implementacija, įgyvendinta sprendimo tiekėjo.

**Paskutinės sinchronizacijos rezultatas**

    - **Žalia** – sinchronizacija pavyko.
    - **Raudona** – sinchronizacija nepavyko.
    - **Juoda** – sinchronizacija dar nevykdyta.

**Paskutinės sinchronizacijos data**
    Data ir laikas, kada paskutinė sinchronizacija įvyko.

**Publikuojami atviri duomenys**
    Ar leidžiama publikuoti atvirus duomenis per šį Agentą.

**Atvirų duomenų servisas**
    Nuoroda, kur atviri duomenys bus publikuojami. Numatytas adresas: https://get.data.gov.lt


Konfigūracija pagal Agento rūšį
-------------------------------

Papildomai, priklausomai nuo pasirinktos **rūšies**, rodoma specifinė Agento konfigūracija:

- **Spinta**
    Rodoma dvi konfigūracijos dalys:

    .. _configuration_credentials_cfg:

    - Prisijungimui prie Atvirų duomenų Katalogo.

        | |image_formos_ir_laukai_4|
        | *pav. Konfigūracija pasirinkus „Spinta“: Agentas -> Katalogas*

    .. _configuration_config_yml:

    - Prisijungimui prie duomenų šaltinio.

        | |image_formos_ir_laukai_5|
        | *pav. Konfigūracija pasirinkus „Spinta“: Agentas -> Duomenų Šaltinis*

- **Kita**

    .. _configuration_secret_key:

    Rodoma tik prieigos rakto informacija. Likusi konfigūracija – sprendimo tiekėjo atsakomybė.

    | |image_formos_ir_laukai_6|
    | *pav. Konfigūracija pasirinkus „Kita“*

Užklausų vykdomų per Agentą lentelė
-----------------------------------

Dar žemiau galima rasti visų užklausų, kurios į Katalogą yra vykdomos per Agentą, lentelę. Lentelėje matoma:

**Data ir laikas**
    Užklausos atlikimo data ir laikas. Data ir laikas taip pat yra nuoroda į detalesnę užklausos informaciją.
**Tipas**
    Atliktos užklausos tipas ("GET", "POST", "PUT", "DELETE", "PATCH").
**Adresas**
    Adresas, i kurį buvo atlikta užklausa.
**Rezultatas**
    Atliktos užklausos rezultatas ("Sėkminga" arba "Nesėkminga").
**Klaidos pranešimas**
    Jei atliekant užklausą įvyko klaida, matoma nuoroda į detalesnę užklausos informaciją.

| |image_uzklausu_istorija_lentele|
| *pav. Užklausų istorijos lentelė*


Užklausos peržiūros forma
=========================

Ši forma naudojama norint peržiūrėti detalią informaciją apie užklausą, atliktą per Agentą.

Paaiškinimai apie laukų reikšmes
--------------------------------

**Data ir laikas**
    Užklausos atlikimo data ir laikas.
**Agentas**
    Agentas, per kurį buvo atlikta užklausa į katalogą.
**Užklausos API adresas**
    Adresas, į kurį buvo atlikta užklausa.
**HTTP metodas**
    HTTP metodas, kuris buvo naudojamas atliekant užklausą ("GET", "POST", "PUT", "DELETE", "PATCH").
**Rezultatas**
    Atliktos užklausos rezultatas ("Sėkminga" arba "Nesėkminga").
**Statusas (HTTP)**
    Būsena kuri buvo pasiekta atliekant užklausą. Išsamiau paaiškina, kodėl rezultatas sėkmingas arba nesėkmingas.

| |image_uzklausu_detali_istorija_1|
| *pav. Užklausos peržiūros forma*

Klaidos atliekant užklausą
--------------------------

Jei atliekant užklausą buvo susidurta su klaida, klaidą galima matyti žemiau.

| |image_uzklausu_detali_istorija_2|
| *pav. Užklausos klaida*


Duomenų gavimas
***************


Klaidos ir jų paaiškinimai
==========================

`InvalidClientBackend`:
    Klaida kyla, kai turimas DSA aprašas su bent vienu resursu su `creds(key)` prepare funkcija,
    bet tarp kliento duomenų, `backends` atribute, nėra išsaugotas atributas su resurso pavadinimu.
    Būtent šiame kintamąjame `creds(key)` funkcija ieškos `key` reikšmės.

    Norint pataisyti klaidą, prie kliento duomenų `backends` atributo reikia pridėti
    atributą su resurso pavadinimu. Skaityti :ref:`agent-CRUD-update`.

`InvalidClientBackendCredentials`:
    Klaida kyla, kai turimas DSA aprašas su bent vienu resursu su `creds(key)` prepare funkcija,
    `backends` atribute yra išsaugotas atributas su resurso pavadinimu, bet atribute nėra
    išsaugota `key` reikšmė.

    Norint pataisyti klaidą, prie kliento duomenų `backends` atribute esančio atributo resurso pavadinimu
    reikia pridėti trūkstamą `key` reikšmę. Skaityti :ref:`agent-CRUD-update`.


.. |image_sinchronizacija_1| image:: /static/katalogas/okot/image_sinchronizacija_1.png
   :alt: Navigacijos juosta

.. |image_sinchronizacija_2| image:: /static/katalogas/okot/image_sinchronizacija_2.png
   :alt: Nuoroda į organizacijos erdvę

.. |image_sinchronizacija_3| image:: /static/katalogas/okot/image_sinchronizacija_3.png
   :alt: Agentų skirtukas

.. |image_sinchronizacija_4| image:: /static/katalogas/okot/image_sinchronizacija_4.png
   :alt: Agento pridėjimo mygtukas

.. |image_formos_ir_laukai_1| image:: /static/katalogas/okot/image_formos_ir_laukai_1.png
   :alt: Agento kūrimo/redagavimo forma

.. |image_formos_ir_laukai_2| image:: /static/katalogas/okot/image_formos_ir_laukai_2.png
   :alt: Agento sąrašo lentelė

.. |image_formos_ir_laukai_3| image:: /static/katalogas/okot/image_formos_ir_laukai_3.png
   :alt: Vieno Agento peržvalgos puslapis

.. |image_formos_ir_laukai_4| image:: /static/katalogas/okot/image_formos_ir_laukai_4.png
   :alt: Konfigūracija pasirinkus rūšį „Spinta“: Agentas -> Katalogas

.. |image_formos_ir_laukai_5| image:: /static/katalogas/okot/image_formos_ir_laukai_5.png
   :alt: Konfigūracija pasirinkus rūšį „Spinta“: Agentas -> Duomenų Šaltinis

.. |image_formos_ir_laukai_6| image:: /static/katalogas/okot/image_formos_ir_laukai_6.png
   :alt: Konfigūracija pasirinkus rūšį „Kita“

.. |image_uzklausu_istorija_lentele| image:: /static/katalogas/okot/image_uzklausu_istorija_lentele.png
   :alt: Agento užklausų istorijos lentelė

.. |image_uzklausu_detali_istorija_1| image:: /static/katalogas/okot/image_uzklausu_detali_istorija_1.png
   :alt: Detali agento atlikta užklausa

.. |image_uzklausu_detali_istorija_2| image:: /static/katalogas/okot/image_uzklausu_detali_istorija_2.png
   :alt: Agento užklausų istorijos klaidos
