.. default-role:: literal

.. _agentas:

#######
Agentas
#######


Kliento administravimas
***********************

Kliento administravimas yra OAuth_ kliento kūrimas, peržiūra, keitimas ir trynimas.

.. _Oauth: https://en.wikipedia.org/wiki/OAuth


Kliento kūrimas
===============

Kliento kūrimas atliekamas POST užklausa adresu `spinta_url/auth/clients`, siunčiant tokius duomenis:

.. code-block:: json

    {
        "client_name": "My Example Client",
        "secret": "69549305ffiew43",
        "scopes": [
            "spinta_getone",
            "spinta_getall",
            "spinta_search"
        ],
        "backends": {
            "resource_name": {
                "key_one": "test",
                "key_two": 123
            }
        }
    }

client_name:
    Kliento pavadinimas, išduodamas kliento registravimo autentifikacijos servise metu.

secret:
    Kliento slaptažodis, išduodamas kliento registravimo autentifikacijos servise metu.

scopes:
    Leidimai.

backends:
    Atributas, kuriame saugoma papildomi autentifikacijos duomenys, kurie gali būti naudojami
    prisijungimui prie duomenų šaltinio. Autentifikacijos duomenys saugomi kiekvienam :term:`DSA`
    resursui atskirai.

Sėkmingos užklausos atveju bus sugeneruotas `client_id` ir grąžinamas atsakymas:

.. code-block:: json

    {
        "client_id": "791cdc66-bed8-4c9f-9d92-0e49a061c3d0",
        "client_name": "My Example Client",
        "scopes": [
            "spinta_getone",
            "spinta_getall",
            "spinta_search"
        ],
        "backends": {
            "resource_name": {
                "key_one": "test",
                "key_two": 123
            }
        }
    }

Taip pat, bus sukuriamas ir iš saugojamas kliento `yml` failas: `791cdc66-bed8-4c9f-9d92-0e49a061c3d0.yml`:

.. code-block:: yaml

    client_id: 791cdc66-bed8-4c9f-9d92-0e49a061c3d0
    client_name: My Example Client
    client_secret_hash: krognr[wlfe[pekfmlr54ltp;f23
    scopes:
      - spinta_getone
      - spinta_getall
      - spinta_search
    backends:
      resource_name:
        key_one: test
        key_two: 123


Kliento atnaujinimas
====================

Kliento atnaujinimas atliekamas PATCH užklausa adresu `spinta_url/auth/clients/{client_id}`,
siunčiant vieną ar kelis atributus, kuriuos norima pakeisti. Užklausa su pilnais duomenimis:

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

Jei užklausos nenurodyti atributai nebus pakeisti. Sėkmingos užklausos atveju bus grąžinamas atsakymas:

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

Taip pat, bus atnaujintas `791cdc66-bed8-4c9f-9d92-0e49a061c3d0.yml` kliento failas:

.. code-block:: yaml

    client_id: 791cdc66-bed8-4c9f-9d92-0e49a061c3d0
    client_name: New Client Name
    client_secret_hash: krognr[wlfe[pekfmlr54ltp;f23
    scopes:
      - spinta_getone
    backends:
      new_resource_name:
        new_key: new_value
