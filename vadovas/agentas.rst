.. default-role:: literal

.. _agentas:

#######
Agentas
#######


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
