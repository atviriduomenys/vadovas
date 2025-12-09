.. default-role:: literal

.. _agentas-saltiniu-konfiguravimas:

##############################
Agento šaltinių konfigūravimas
##############################

Agento šaltiniai gali būti konfigūruojami dviejose vietose:

a) ŠDSA apraše
b) Agento (spintos) konfigūraciniame faile.

Šaltinio konfigūravimas ŠDSA apraše aprašytas čia: https://ivpk.github.io/dsa/draft/saltiniai.html

Jei pasirenkat naudoti konfigūracinį failą, šaltinio duomenis reikia nurodyti prie `backends`:

.. code-block:: yaml

    backends:
      default:
        type: postgresql
        dsn: postgresql:///spinta

Galimi šaltiniai
****************

SQLite
------

Teikiant duomenis per agentą iš SQLite duomenų bazės, jokių papildomų paketų
diegti nereikia. `config.yaml` faile `backends` dalis atrodys taip:

.. code-block:: sh

    backends:
      default:
        type: sqlite
        dsn: sqlite:///spinta.db

Atkreipkite dėmesį, kad absoliutus kelias atrodo taip::

    sqlite:////data.db

O reliatyvus atrodo taip::

    sqlite:///data.db

PostgreSQL
----------

Teikiant duomenis per agentą iš PostgreSQL duomenų bazės, jums papildomai reikia
įdiegti tokį Python paketą:

.. code-block:: sh

    $ pip install psycopg2-binary

O `config.yaml` faile `backends` dalis atrodys taip:

.. code-block:: sh

    backends:
      default:
        type: postgresql
        dsn: postgresql:///spinta

MySQL
-----

Teikiant duomenis per agentą iš MySQL duomenų bazės, jums papildomai reikia
įdiegti tokį Python paketą:

.. code-block:: sh

    $ pip install pymysql

O `config.yaml` faile `backends` dalis atrodys taip:

.. code-block:: sh

    backends:
      default:
        type: mysql
        dsn: pymysql:///spinta


Microsoft SQL Server
--------------------

Teikiant duomenis per agentą iš Microsoft SQL Server duomenų bazės, jums
papildomai reikia įdiegti FreeTDS_ paketą:

.. _FreeTDS: http://www.freetds.org/

.. code-block:: sh

    $ sudo apt install freetds-bin

Ir pymssql_ Python paketą:

.. _pymssql: https://www.pymssql.org/

.. code-block:: sh

    $ pip install pymssql

Toliau reikia `sukonfigūruoti FreeTDS`_, rekomenduojame naudoti tokį
konfigūracijos failą:

.. _sukonfigūruoti FreeTDS: https://www.pymssql.org/freetds.html

.. code-block:: ini

    [global]
    tds version = 7.4
    port = 1433
    client charset = utf-8

O `config.yaml` faile `backends` dalis atrodys taip:

.. code-block:: sh

    backends:
      default:
        type: mssql
        dsn: pymssql:///spinta


Oracle
------

Teikiant duomenis per agentą iš Oracle duomenų bazės, jums
papildomai reikia įdiegti cx_Oracle_ paketą:

.. _cx_Oracle: https://oracle.github.io/python-cx_Oracle/

.. code-block:: sh

    $ pip install cx_Oracle

Dėl papildomos informacijos apie Oracle jungtį, skaitykite `cx_Oracle
dokumentacijoje`__.

__ https://cx-oracle.readthedocs.io/en/latest/index.html

O `config.yaml` faile `backends` dalis atrodys taip:

.. code-block:: sh

    backends:
      default:
        type: oracle
        dsn: cx_oracle:///spinta

