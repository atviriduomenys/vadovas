.. default-role:: literal

.. _agentas:

#######
Agentas
#######


Sinchronizacija
***************

**Sinchronizacija** – tai procesas, kurio metu sulyginama tiek duomenų struktūra, tiek patys duomenys tarp duomenų
šaltinio ir duomenų Kataloge saugomos informacijos.


Pasiruošimas
============

Prieš pradedant sinchronizaciją, reikia:

    - :ref:`Užregistruoti Agentą Kataloge <agento-registracija-kataloge>`
    - :ref:`Sukonfigūruoti Agentą <agento-konfiguracija>`


.. _agento-registracija-kataloge:

Agento registracija Kataloge
----------------------------

**Agentų sąsajos registracija duomenų Kataloge**.

Registracija vykdoma organizacijos, kuriai priklauso naudotojas, puslapyje. Norėdami tai atlikti:

#. Prisijunkite prie duomenų Katalogo.
#. Viršutiniame dešiniajame kampe užveskite pelę ant savo naudotojo vardo.

    | |image_navigation_bar|
    | *pav. Navigacijos juosta – vartotojo skirtukas*

#. Sąraše pasirinkite **„Mano organizacijos duomenų ištekliai“**.

    | |image_organization_resources|
    | *pav. Nuoroda į organizacijos duomenų išteklius*

#. Atverkite skirtuką **„Agentai“**.

    | |image_agent_tab|
    | *pav. Agentų skirtukas*

#. Spauskite **„Pridėti Agentą“**.

    | |image_agent_create|
    | *pav. Agento pridėjimas*

#. Užpildykite formos laukus ir spauskite **„Sukurti“**.

    - :ref:`Agento pildymo forma ir jos laukai <agent_create_edit_form>`

#. Atlikus registraciją, pateikiami prisijungimo duomenys. Galimos dvi prisijungimo konfigūracijos, jos priklauso nuo pasirinktos :ref:`Agento rūšies<agent_create_edit_form_field_kind>`.


.. _agento-konfiguracija:

Agento konfigūracija
--------------------

Agentą reikia konfigūruoti, kad būtų galima pasiekti:

    a) **Duomenų Šaltinį**
    b) **Duomenų Katalogą**


Lokalaus/Agento DSA failo nustatymas
====================================

Norint vykdyti sinchronizaciją, Agentui reikia nurodyti vietą, kur bus saugomas DSA failas.
Pagal šį failą, lyginant jį su duomenų šaltiniu ir katalogu (atskiri proceso etapai), bus atliekami duomenų atnaujinimai
arba siunčiami pranešimai apie pasikeitusią duomenų struktūrą (į Katalogą).

Šio failo vietą failinėje sistemoje galima nustatyti `config.yml` faile.

.. note::

    Vietinio failo nustatymo `config.yml` konfigūracijoje pavyzdys:

    .. code-block:: yaml

        manifest: default
        manifests:
          default:
            type: csv
            path: /Users/john_doe/manifest.csv
            backend: default
            keymap: default
            mode: external

    **Pavyzdyje:**

        - `manifests.default.path` — nurodoma vietinio failo vieta failinėje sistemoje, kur įdiegtas Agentas (Spinta).
    

Agento prisijungimas prie Duomenų Šaltinio
==========================================

Norint prijungti agentą prie duomenų šaltinio, reikia papildomai sukonfigūruoti `config.yml` failą. Tam reikia nustatyti:

    - **Duomenų šaltinio tipą**
    - **Duomenų šaltinio nuorodą** (pvz.: duomenų bazės prisijungimo URL)

.. note::

    Failo `config.yml` pavyzdys konfigūruojant prisijungimą į PostgreSQL duomenų bazę:

    .. code-block:: yaml

        backends:
          default:
            type: sql
            dsn: postgresql://django:django@localhost:9432/django

    **Pavyzdyje:**

        - `backends.default.type` nurodomas duomenų šaltinio tipas.
        - `backends.default.dsn` nurodoma duomenų šaltinio nuoroda.


Agento prisijungimas prie Duomenų Katalogo
==========================================

Ši konfigūracija sugeneruojama automatiškai ir vartotojui reikia tik ją perkelti į `credentials.cfg` failą.

.. note::

    Failo `credentials.cfg` pavyzdys:

    .. code-block:: ini

        [default]
        server = https://example-server.com
        resource_server = https://example-resource-server.com
        organization = <kliento-organizacija>
        organization_type = <kliento-organizacijos-tipas>
        client_id = <kliento-identifikatorius>
        client = <klientas>
        secret = <kliento-paslaptis>
        scopes =
            uapi:/datasets/gov/vssa/dcat/Dataset/:getall
            uapi:/datasets/gov/vssa/dcat/Dataset/:create
            uapi:/datasets/gov/vssa/dcat/Dsa/:getone
            uapi:/datasets/gov/vssa/dcat/Dsa/:create
            uapi:/datasets/gov/vssa/dcat/Dsa/:patch
            uapi:/datasets/gov/vssa/dcat/Distribution/:getall
            uapi:/datasets/gov/vssa/dcat/Distribution/:create
            uapi:/datasets/gov/vssa/dcat/Agreement/:patch

    **server**

        Autorizacijos serverio adresas (URL), kuris išduoda prieigos žetoną (angl. *access token*) ir valdo *OAuth 2.0* klientus.

    **resource_server**

        Nurodomas duomenų Katalogo adresas (URL), su kuriuo vyks sinchronizacija.

    **organization**

        Organizacijos, kuriai priklauso klientas, pavadinimas.

    **organization_type**

        Organizacijos, kuriai priklauso klientas, tipas (Valstybinė įstaiga, Verslo organizacija, Nepelno ir nevalstybinė organizacija).

    **client_id**

        Nurodomas *OAuth 2.0* kliento identifikatorius.

    **client**

        Nurodomas *OAuth 2.0* kliento pavadinimas, automatiškai sukuriamas pagal Kataloge nurodytą pavadinimą ir naudojamas autorizacijos procese.

    **secret**

        Pagrindinis slaptasis raktas naudojamas *OAuth 2.0* klientui. Naudojamas gauti prieigos žetoną iš autorizacijos serverio. Galioja neribotą laiką.

    **scopes**

        Prašomi leidimai, kurie yra siunčiami į autorizacijos serverį.
        Jei šie leidimai nesutampa su leidimais, suteiktais *OAuth 2.0* klientui, prieigos žetonas neveiks ir
        pokyčių atlikti nepavyks.
        Todėl konfigūracijoje palikite tik būtinus leidimus. Papildomų ar  nenumatytų leidimų įtraukti nereikėtų.
        Esant poreikiui, galite palikti tik dalį jų.


Procesas
********

Sinchronizacija yra procesas, kurio metu norima įsitikinti, kad duomenų struktūra tarp trijų skirtingų vietų, kuriose ji saugoma, yra nepakitusi.

Struktūra yra saugoma:

    - **Duomenų šaltinyje** (pvz.: Duomenų bazė)
    - **Agente, lokaliame faile**
    - **Duomenų Kataloge** (dažniausiu atveju — https://data.gov.lt/)

Procesas vykdomas trimis etapais. Išsamesnė informacija apie kiekvieną etapą pateikta atitinkamuose skyriuose:

    - :ref:`Katalogas -> Agentas <sinchronizacija-katalogas-agentas>`
    - :ref:`Duomenų Šaltinis -> Agentas <sync_stage_data_source_to_agent>`
    - :ref:`Agentas -> Katalogas <sync_stage_agent_to_catalog>`

.. attention::

    **Norint pradėti sinchronizaciją, Agentui reikia įvykdyti komandą:** `spinta sync`


.. _sinchronizacija-katalogas-agentas:

Sinchronizacija: Katalogas -> Agentas
=====================================

Šio etapo metu yra atsisiunčiami duomenų rinkiniai iš Katalogo, susieti su pasirinktu Agentu.

Šie duomenų rinkiniai apjungiami į vieną struktūros aprašą, ir pradedamas kiekvienos eilutės palyginimas tarp atsisiųsto
failo iš Katalogo ir Agento vietinėje failinėje sistemoje esančio duomenų struktūros failo.

**Pakeitimai atliekami pagal tokią atvejų matricą:**

.. list-table:: Atvejų apžvalga
   :header-rows: 1

   * - Atvejo Nr.
     - Katalogas
     - Agentas
     - Veiksmas
   * - 1
     - Sutampa
     - Sutampa
     - Niekas neatliekama
   * - 2
     - Nesutampa
     - Nesutampa
     - Agento ŠDSA perrašomas iš Katalogo
   * - 3
     - Yra
     - Nėra
     - Agento ŠDSA papildomas Katalogo informacija
   * - 4
     - Nėra
     - Yra
     - Niekas neatliekama

.. admonition:: Pavyzdys

    Kataloge turint tokį duomenų struktūros aprašą:

    .. code-block:: ini

        id                                   | dataset | resource   | base | model   | property | type      | ref     | source                                                   | source.type | prepare | origin | count | level | status    | visibility | access | uri  | eli | title             | description
        b67a8e27-106c-47a6-a85e-a355c8bd9761 | vssa    |            |      |         |          |           |         | https://example.com                                      |             |         |        |       |       | open      |            |        |      |     | VSSA              | vssa
        e23139cb-3c6b-40fd-8fba-1d68e5701733 |         | geography  |      |         |          | dask/csv  |         | https://get.data.gov.lt/datasets/org/vssa/geography/:ns  |             |         |        |       | 4     |           |            |        |      |     | Geography         | geography
                                             |         |            |      |         |          |           |         |                                                          |             |         |        |       |       |           |            |        |      |     |                   |
        25568d69-1456-485c-9fca-8124d41a5295 |         |            |      | Country |          |           |         |                                                          |             |         |        |       | 4     | completed | package    | open   |      |     | Country           | country
        6faa42c1-7ad6-43be-a266-ccab35dd0bc9 |         |            |      |         |          | id        | integer | property_id                                              |             |         |        |       | 4     |           |            |        |      |     | Identifier        | identifier
        407270ca-f9bd-4c81-8c64-108b24bfafbe |         |            |      |         |          | size      | integer | property_size                                            |             |         |        |       | 4     |           |            |        |      |     | Size              | size


    O Agente turint tokį duomenų struktūros aprašą:

    .. code-block:: ini

        id                                   | dataset | resource   | base | model   | property | type      | ref     | source                                                   | source.type | prepare | origin | count | level | status    | visibility | access | uri  | eli | title             | description
        b67a8e27-106c-47a6-a85e-a355c8bd9761 | lrs     |            |      |         |          |           |         | https://example.com                                      |             |         |        |       |       | open      |            |        |      |     | LRS               | lrs
        e23139cb-3c6b-40fd-8fba-1d68e5701733 |         | law        |      |         |          | dask/csv  |         | https://get.data.gov.lt/datasets/org/vssa/geography/:ns  |             |         |        |       | 4     |           |            |        |      |     | Law               | example
                                             |         |            |      |         |          |           |         |                                                          |             |         |        |       |       |           |            |        |      |     |                   |
        25568d69-1456-485c-9fca-8124d41a5295 |         |            |      | Person  |          |           |         |                                                          |             |         |        |       | 4     | completed | package    | open   |      |     | Person            | person
        6faa42c1-7ad6-43be-a266-ccab35dd0bc9 |         |            |      |         |          | uuid      | string  | property_id                                              |             |         |        |       | 4     |           |            |        |      |     | Unique Identifier | unique identifier

    Galutinis struktūros aprašo rezultatas (Agente) atrodys taip:

    .. code-block:: ini

        id                                   | dataset | resource   | base | model   | property | type      | ref     | source                                                   | source.type | prepare | origin | count | level | status    | visibility | access | uri  | eli | title             | description
        b67a8e27-106c-47a6-a85e-a355c8bd9761 | vssa    |            |      |         |          |           |         | https://example.com                                      |             |         |        |       |       | open      |            |        |      |     | VSSA              | vssa
        e23139cb-3c6b-40fd-8fba-1d68e5701733 |         | geography  |      |         |          | dask/csv  |         | https://get.data.gov.lt/datasets/org/vssa/geography/:ns  |             |         |        |       | 4     |           |            |        |      |     | Geography         | geography
                                             |         |            |      |         |          |           |         |                                                          |             |         |        |       |       |           |            |        |      |     |                   |
        25568d69-1456-485c-9fca-8124d41a5295 |         |            |      | Country |          |           |         |                                                          |             |         |        |       | 4     | completed | package    | open   |      |     | Country           | country
        6faa42c1-7ad6-43be-a266-ccab35dd0bc9 |         |            |      |         |          | id        | integer | property_id                                              |             |         |        |       | 4     |           |            |        |      |     | Identifier        | identifier
        407270ca-f9bd-4c81-8c64-108b24bfafbe |         |            |      |         |          | size      | integer | property_size                                            |             |         |        |       | 4     |           |            |        |      |     | Size              | size


.. _sync_stage_data_source_to_agent:

Sinchronizacija: Duomenų Šaltinis -> Agentas
============================================

.. warning::

    **Funkcionalumas vystomas**


.. _sync_stage_agent_to_catalog:

Sinchronizacija: Agentas -> Katalogas
=====================================

.. warning::

    **Funkcionalumas vystomas**

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
    Nurodo, kokia paslauga naudojama Agento veikimui:

    - **Spinta** – sugeneruojamos dvi konfigūracijos:

        - `credentials.cfg <https://atviriduomenys.readthedocs.io/spinta.html#duomenu-publikavimas-i-saugykla>`_
        - `config.yml <https://atviriduomenys.readthedocs.io/spinta.html?#config-yml>`_

    - **Kita** – suteikiamas prieigos raktas. Likusi dalis priklauso sprendimo tiekėjui.

**Duomenų paslauga**
    Nurodo, kuriai duomenų paslaugai Agentas bus priskirtas. Jei nenurodyta, duomenų paslauga bus sukurta automatiškai.

**Aplinka**
    Nurodo, kurioje aplinkoje bus diegiamas Agentas. Galimos reikšmės:

    - **Vystymo** – Agentas bus diegiamas vystymo aplinkoje.
    - **Testavimo** – Agentas bus diegiamas testavimo aplinkoje.
    - **Gamybinė** – Agentas bus diegiamas gamybinėje aplinkoje.

**Agento adresas**
    Nurodo Agento pasiekimą per URL arba IP adresą. Jei yra nurodytas vartų adresas, tada agento adresas yra vidinis adresas, kurį mato API vartai. Jei API vartai nenurodyti, tada yra nurodomas išorinis agento adresas.

**Autorizacijos serverio adresas**
    Nurodo autorizacijos serverio adresą, kuris bus naudojamas metaduomenų sinchronizacijai arba duomenų apsikeitimui.

**API vartų serverio adresas**
    Nurodo API vartų serverio adresą, kuris bus naudojamas metaduomenų sinchronizacijai arba duomenų apsikeitimui.

**Agentas įjungtas**
    Nurodo, ar Agentas šiuo metu aktyvus.

**Atviri duomenys publikuojami Saugykloje**
    Pažymėjus šį lauką, leidžiama publikuoti atvirus duomenis per Agentą.

**Duomenų publikavimo nuoroda**
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

**Aplinka**
    Nurodo, kurioje aplinkoje Agentas bus diegiamas.

**Sukurtas**
    Agento sukūrimo data.

**Užklausa**
    Paskutinės sinchronizacijos arba bandymo data.

**Duomenų paslauga**
    Kiekvienam Agentui automatiškai sukuriama susijusi duomenų paslauga arba nurodyta kuriant/redaguojant Agentą.

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

**Duomenų paslauga**
    Duomenų paslauga, automatiškai sukuriama ir susiejama su Agentu arba nurodyta kuriant/redaguojant Agentą.

**Kodinis pavadinimas**
    Unikalus identifikatorius, generuojamas sistemoje.

**Aplinka**
    Aplinka, kurioje Agentas bus diegiamas.

**Būsena**
    Nurodoma, ar Agentas įjungtas.

**Rūšis**
    Naudojama implementacija:

    - **Spinta** – naudojama „Spintos“ sinchronizavimo logika.
    - **Kita** – nestandartinė implementacija, įgyvendinta sprendimo tiekėjo.

**Agento adresas**
    Agento pasiekimas per URL arba IP adresą.

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

    - Prisijungimui prie Katalogo.

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


.. |image_navigation_bar| image:: /static/katalogas/okot/image_navigation_bar.png
   :alt: Navigacijos juosta

.. |image_organization_resources| image:: /static/katalogas/okot/image_organization_resources.png
   :alt: Nuoroda į organizacijos duomenų išteklius

.. |image_agent_tab| image:: /static/katalogas/okot/image_agent_tab.png
   :alt: Agentų skirtukas

.. |image_agent_create| image:: /static/katalogas/okot/image_agent_add.png
   :alt: Agento pridėjimas

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
