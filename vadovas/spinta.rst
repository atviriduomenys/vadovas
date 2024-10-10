.. default-role:: literal

.. _spinta:

Spinta
######

Kad būtų paprasčiau atverti duomenis, rekomenduojame naudoti įrankį pavadinimu
`Spinta`__, kuris sukurtas duomenų atvėrimo automatizavimui. Spinta leidžia
automatizuotai generuoti duomenų struktūros aprašus, juos patikrinti ar nėra
klaidų, perduoti duomenis į :ref:`saugyklą <saugykla>` ir :ref:`publikuoti
<saugykla>` atvertus duomenis aukščiausiu :ref:`brandos lygiu <level>` ir
laikantis geriausių atvirų duomenų publikavimo praktikų.

__ https://github.com/atviriduomenys/spinta

Jei naudodamiesi Spinta radote kokių nors klaidų ar turite kitų pastabų,
galite `pranešti apie klaidą`__, kad galėtume ją pataisyti.

__ https://github.com/atviriduomenys/spinta/issues/new


Diegimas
********

Techniniai reikalavimai
=======================

Techniniai reikalavimai gali skirtis, priklausomai nuo to, kokiu tikslu
naudojama Spinta priemonė. Jei naudojama tik duomenų atvėrimui, o ne
publikavimui tuomet užtenka:

CPU
    1 CPU, šiuo metu perduodant duomenis nėra naudojamas lygiagretinimas,
    todėl bus naudojamas tik vienas CPU, ateityje tai gali keistis.

RAM
    512Mb, duomenys skaitomi srautiniu būdu, todėl nepriklausomai nuo
    šaltinio dydžio, naudojamas fiksuotas RAM kiekis.

    Vienas Spinta procesas naudoja apie 100Mb RAM.

HDD
    Priklauso nuo duomenų kiekio.

    Duomenų perdavimui iš šaltinio į saugyklą, saugomi papildomi duomenys:

    1. Vidinių ir publikuojamų pirminių raktų sąsaja, saugoma
       `~/.local/share/spinta/keymap.db` Sqlite duomenų bazėje. Duomenys
       atrodo taip::

           bb969358-ce9e-4255-b596-c748f6885332|bf8b4530d8d246dd74ac53a13471bba17941dff7|BINDATA...
           522a3615-8527-4eb7-8327-977fe4383dcd|c4ea21bb365bbeeaf5f2c654883e56d11e43c44e|BINDATA...
           9be3e60b-d557-4596-a370-660f3c337772|9842926af7ca0a8cca12604f945414f07b01e13d|BINDATA...
           60c2f4da-c32a-4fba-a39a-8e85252a77ad|a42c6cf1de3abfdea9b95f34687cbbe92b9a7383|BINDATA...
           ab2baaa6-508d-4069-9a45-53bce46676ca|8dc00598417d4eb788a77ac6ccef3cb484905d8b|BINDATA...

       Saugomas išorinis raktas, vidinio rakto sha1 ir vidinio rakto reikšmė
       MsgPack formatu.

       Šios lentelės dydis tiesiogiai proporcingas šaltinio įrašų skaičiui ir
       šaltinio lentelių pirminių raktų dydžiui.

       Vidutiniškai, 10^6 įrašų telpa į 200Mb.

    2. Perduodamų duomenų būsenos lentelė, kuri saugoma
       `~/.local/share/spinta/push` kataloge. Kiekvienai saugyklai į kurią
       perduodami duomenys sukuriama atskira būsenos lentelė, Sqlite formatu.
       Būsenos duomenys atrodo taip::

           bb969358-ce9e-4255-b596-c748f6885332|5d28bd0ccad38701a5fcc775259b91e53bf3b1b3|2022-02-10 13:26:39.255110
           522a3615-8527-4eb7-8327-977fe4383dcd|0711b352478dda05732c4448e689aa9246986911|2022-02-10 13:26:39.255602
           9be3e60b-d557-4596-a370-660f3c337772|ea85925a127b84a30d7be40daa150236954a39f6|2022-02-10 13:26:39.255976
           60c2f4da-c32a-4fba-a39a-8e85252a77ad|7d5d3486ff456a2419476c4d7e6b2a73ae7bca22|2022-02-10 13:26:39.256167
           ab2baaa6-508d-4069-9a45-53bce46676ca|fe5e2696e1768bc40ecce6b7418723d06e62a53a|2022-02-10 13:26:39.256342

       Saugomas išorinis pirminis raktas, visų perduodamų duomenų sha1 ir
       data, kad buvo perduoti duomenys paskutinį kartą.

       Vidutiniškai, 10^6 įrašų talpa į 200Mb.

    Apytiksliai, vienam milijonui įrašų reikėtų turėti bend 0.5G laisvos
    disko vietos.

Duomenų atvėrimo priemonė Spinta yra sukurta naudojant Python_ technologiją.
Todėl prieš diegiant, jūsų naudojamoje aplinkoje turi būti `įdiegta`__ Python
3.9 arba naujesnė versija.

.. _Python: https://www.python.org/

__ https://www.python.org/downloads/


.. _install-debian-ubuntu:

Debian/Ubuntu
=============

Pirmiausia, prieš atliekant diegimą, reikėtų pasirinkti kokiame failų
sistemos kataloge diegsite priemones. Rekomenduojame diegti į `/opt/spinta`
katalogą.

Jei diegimą atliekate serveryje, tuomet verta sukurti atskirą naudotoją,
kurio teisėmis bus leidžiamos priemonės, tai padaryti galite taip:

.. code-block:: sh

    $ sudo useradd --system --create-home --home-dir /opt/spinta spinta
    $ sudo -u spinta -s --set-home
    $ cd

Toliau visus veiksmus atliksime `/opt/spinta` kataloge.

Pirmiausia reikėtų įsitikinti ar jūsų naudojama distribucijos versija turi
reikalinga Python versiją, tai galite pažiūrėti taip:

.. code-block:: sh

    $ python3 --version

Jei turite 3.9 ar naujesnę versiją, tuomet galite pereiti prie
:ref:`install-debian-python-packages` žingsnio.

Naujesnę Python versiją galite įsidiegti pasirinkdami vieną iš dviejų galimų
variantų:

- :ref:`Variantas 1 <install-debian-pyenv>`: naudojant pyenv_, kuris atsisiūs
  Python išeities kodą ir sukompiliuos reikiamą Python versiją. Šis variantas
  yra universalesnis, tačiau sudėtingesnis ir reikalaujantis daugiau laiko.

- :ref:`Variantas 2 <install-debian-ppa>` Naudojant PPA_ repozitoriumus, kurie
  veiks tik Ubuntu aplinkoje, tačiau reikiamą Python versiją gausite žymiai
  paprasčiau.

.. _PPA: https://help.ubuntu.com/community/PPA
.. _pyenv: https://github.com/pyenv/pyenv

.. _install-debian-pyenv:

Naujesnės Python versijos diegimas naudojant pyenv
--------------------------------------------------

Pirmiausia mums reikia įdiegti pyenv_ ir visus šiai priemones ir Python
kompiliavimui reikalingus paketus:

.. code-block:: sh

    $ sudo apt update
    $ sudo apt upgrade
    $ sudo apt install -y \
         git make build-essential libssl-dev zlib1g-dev \
         libbz2-dev libreadline-dev libsqlite3-dev wget \
         curl llvm libncurses5-dev libncursesw5-dev \
         xz-utils tk-dev libffi-dev liblzma-dev \
         python-openssl
    $ curl https://pyenv.run | bash

Naujausios Python versijos diegimas naudojant pyenv_ daromas taip:

.. code-block:: sh

    $ .pyenv/bin/pyenv install 3.10.7

Jei diegiate Spintą kitoje Linux distribucijoje, reikalingų paketų sąrašą
galite rasti `pyenv dokumentacijoje`_.

.. _pyenv dokumentacijoje: https://github.com/pyenv/pyenv/wiki#suggested-build-environment

Atlikus naujos Python versijos diegimo veiksmus susikuriame izoliuotą aplinką,
kurioje diegsime reikalingus Python paketus:

.. code-block:: sh

    $ .pyenv/versions/3.10.7/bin/python -m venv venv


.. _install-debian-ppa:

Naujesnės Python versijos diegimas naudojant PPA
------------------------------------------------

Naujausios Python versijos diegimas naudojant PPA_ daromas taip:

Pirmiausiai mums reikia įdiegti PPA_ repozitoriumų valdymo priemones:

.. code-block:: sh

    $ sudo apt update
    $ sudo apt install software-properties-common
    $ sudo add-apt-repository ppa:deadsnakes/ppa

Ir galiausiai įdiegiame pageidaujamą Python versiją:

.. code-block:: sh

    $ sudo apt update
    $ sudo apt install python3.10 python3.10-venv

Atlikus naujos Python versijos diegimo veiksmus susikuriame izoliuotą aplinką,
kurioje diegsime reikalingus Python paketus:

.. code-block:: sh

    $ python3.10 -m venv venv


.. _install-debian-python-packages:

Python paketų diegimas
----------------------

Kai jau turite tinkamą Python_ versiją ir esate susikūrė izoliuotą Python
aplinką, Spinta galima įdiegti taip:

.. code-block:: sh

    $ venv/bin/pip install spinta

Galiausiai, įdiegus Spinta paketą, reikia aktyvuoti izoliuotą aplinką, kad
galėtumėte toliau dirbti su Spinta paketo teikiama komanda `spinta`:

.. code-block:: sh

    $ source venv/bin/activate

Tai padarius, galite patikrinti ar komanda `spinta` veikia:

.. code-block:: sh

    $ spinta --version
    0.1.9

Ši komanda turi išvesti, Spinta priemonės versijos numerį.

.. note::

    Atkreipkite dėmesį, kad `spinta` komanda yra pasiekiama tik tada, kai yra
    aktyvuota Python virtuali aplinka:

    .. code-block:: sh

        $ source venv/bin/activate

    Python virtualios aplinkos aktyvavimas galioja tol, kol yra aktyvi terminalo
    sesija.


Windows
=======

Tiesioginio Windows palaikymo nėra, tačiau Spinta galima įdiegti ir naudoti
per Windows Subsystem for Linux (WSL). Informaciją apie tai, kaip įsidiegti
WSL galite rasti `Microsoft Windows dokumentacijoje`__.

__ https://docs.microsoft.com/en-us/windows/wsl/install-win10

Renkantis Linux distribuciją iš Microsoft Store rekomenduojame rinktis Ubuntu_.

.. _Ubuntu: https://www.microsoft.com/en-in/p/ubuntu/9nblggh4msv6?activetab=pivot:overviewtab

Įsidiegus ir pasileidus Ubuntu per WSL, toliau sekite
:ref:`install-debian-ubuntu` instrukcijas.


Galimos problemos ir jų sprendimai
==================================

Jei įvykdžius sekančią komandą:

.. code-block:: sh

    $ curl https://pyenv.run | bash

Gaunate tokią klaidą::

    % Total % Received % Xferd Average Speed Time Time Time Current
    Dload Upload Total Spent Left Speed
    100 285 100 285 0 0 396 0 --:--:-- --:--:-- --:--:-- 395
    curl: (60) SSL certificate problem: self signed certificate in certificate chain
    More details here: https://curl.haxx.se/docs/sslcerts.html

    curl failed to verify the legitimacy of the server and therefore could not
    establish a secure connection to it. To learn more about this situation and
    how to fix it, please visit the web page mentioned above.

Tuomet įsitikinkite, kad jūsų ugniasienė neblokuoja  prieigos prie išorinių
resursų. Taip pat galite laikinai sustabdyti antivirusinė, kuri taip pat gali
blokuoti tokio pobūdžio komandų vykdymą.

Kitas variantas, `curl` komandą galite vykdyti su `-k` argumentu.

Panaši situacija gali pasitaikyti ir vykdant:

.. code-block:: sh

    .pyenv/bin/pyenv install $PYVER

Šios komandos vykdymo metu galite gauti tokią klaidą::

    Downloading Python-3.9.5.tar.xz...
    -> https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tar.xz
    error: failed to download Python-3.9.5.tar.xz

    BUILD FAILED (Ubuntu 20.04 using python-build 2.0.0)

Tokių atveju įsitikinkite ar ugniasienė leidžia kreiptis į išore ir
pabandykite laikinai sustabdyti antivirusinę programą.


Testavimas
**********

Prieš darant naujų versijų atnaujinimus, reikomenduojama išsitestuoti ar naujos
versijos veikia gerai. Testavimą geriausia atlikti atskiroje, izoliuotoje
testavimo aplinkoje, kad nesugadinti duomenų failų.

Prieš išleidžiant stabilias versijas, Spinta paketas išleidžiamas su `rcX`
žyme, kur raidės `rc` reiškia leidimo kandidatai (angl. *release candidate*), o
`X` kandidato numeris.

Leidimo kandidatai nėra įdiegiami automatiškai, todėl diegimą reikia atlikti
naudojant `--pre` argumentą.

Žemiau pateikiama pilna instrukcija, kaip parengti izoliuotą aplinką testavimui
ir kaip įsidiegti naujas versijas testavimo aplinkoje.

Atkreipkite dėmesį, kad visos komandos turi būti vykdomos vienoje terminalo
sesijoje, kadangi yra naudojami kintamieji tokie kaip `BASEDIR`, kurie galioja
tik vienoje aktyvioje terminalo sesijoje. Jei pradedate dirbti su nauja sesija,
nepamirškite iš naujo deklaruoti kintamuosius.

1. Pirmiausiai deklaruojame kintamuosius, kuriuos naudosime kitose komandose.

   Pakeiskite `0.1.64` versijos numerį į tą, kurį norite testuoti.

   ::

        BASEDIR=$PWD/test/0.1.64
        export SPINTA_CONFIG=$BASEDIR/config.yml

   Šių kintamųjų pagalba, nurodome atskirą katalogą, skirtą konkrečios versijos
   testavimui, visi duomenų ir konfigūracijos failai bus saugomi `BASEDIR`
   kantamojo apibrėžtame kataloge.

2. Toliau sukuriame katalogą, kuriame bus saugomi visi konkrečios versijos
   failai.

   ::

        mkdir -p $BASEDIR

3. Sukuriame konfigūracijos failą, skirtą konkrečios versijos testavimui.

   Jei naudojate savo konfigūracinė failą galite jį nurodyti `<
   ~/.config/spinta/config.yml`, taip, kaip parodyta pavyzdyje. Jei savo
   konfigūracijos failo nenaudojate, tada reikėtu ištrinti šią dalį.

   Konfigūracijos failą galite sukurti šios komandos pagalba:

   ::

        cat > $BASEDIR/config.yml < ~/.config/spinta/config.yml <<EOF

        # Test environment overrides
        config_path: $BASEDIR/config
        data_path: $BASEDIR/data

        keymaps:
          default:
            type: sqlalchemy
            dsn: sqlite:///$BASEDIR/data/keymap.db

        accesslog:
          type: file
          file: $BASEDIR/accesslog.json
        EOF

   Atkreipkite dėmesį, kad konfigūracijos failo tekste naudojas `BASEDIR`
   kintamasis. Jei konfigūracijos failą kursite teksto redaktoriaus pagalba,
   nepamiršite pakeisti `$BASEDIR` į katalogą, kuriame testuojate versiją.

   Ar failas sukurtas teisinga galite peržiūrėti taip::

        cat $BASEDIR/config.yml

4. Nusikopijuokite savo konfigūracijos ir duomenų failus į įzoliuotą naujos
   versijos testavimo katalogą. Tokiu būdu, testavimo metu, jūsų esami failai
   nebus sugadinti.

   ::

        cp -avi ~/.config/spinta $BASEDIR/config
        cp -avi ~/.local/share/spinta $BASEDIR/data

5. Susikurkite izoliuotą Spinta paketo aplinką ir įdiektie norimą Spintos
   paketo versiją:

   ::

        python -m venv $BASEDIR/venv
        source $BASEDIR/venv/bin/activate
        pip install --upgrade --pre spinta
        spinta --version

   `--pre` argumentas nurodo, kad atnaujinimas turi būti daromas iki naujausios
   versijos, kuri dar nėra stabili. Be šio argumento, bus atnaujinama tik iki
   naujausios stabilios versijos.

   Jei norite ištestuoti naujausią stabilią versiją, tada `--pre` argumento
   nereikia.

   Norint įdiegti konkrečią versiją, versijos numeris nurodomas taip::

        pip install spinta==0.1.55

6. Galiausiai, galite leisti įprastas komans, tik duomenų kėlimą reikėtu daryti
   į put-test.data.gov.lt Saugyklos testinę aplinką.

7. Įsitikinus, kad nauja versija veikia, galite ją atsinaujinti ir savo
   gamybinėje aplinkoje. Tačiau, prieš tai reikia deaktyvuoti testinę aplinką:

   ::

        deactivate


Atnaujinimas
************

Norint atnaujinti Spinta paketą, reikia atlikti tokius žingsnius:

1. Komandų eilutėje pakeisti aktyvų kelią, kur yra įdiegta Spinta:

   .. code-block:: sh

       cd /kelias/iki/spinta

2. Atnaujinti Spinta paketą:

   .. code-block:: sh

       venv/bin/pip install --upgrade spinta


.. _spinta-configuravimas:

Konfigūravimas
**************

Įdiegus Spinta jokia papildoma konfigūracija nereikalinga, kadangi visus
reikalingus parametrus galima perduoti per komandinės eilutės argumentus,
pavyzdžiui:

.. code-block:: sh

    $ spinta inspect -r sql sqlite:///sqlite.db -o sdsa.xlsx


config.yml
==========

Norint išvengti jautrių duomenų perdavimo per komandinę eilutę ir pageidaujant,
kad duomenų bazės prisijugnimo parametrai nebūtų įrašomi į struktūros aprašą,
dalį parametrų galima iškelti į konfigūracijos failą:

.. code-block:: yaml
    :caption: config.yml

    backends:
      mydb:
        type: sql
        dsn: sqlite://sqlite.db

Iškėlus duomenų bazės konfigūracijos parametrus į konfigūracinį failą, komandų
eilutėje `-o config=config.yml` nurodoma configūracinio failo vieta, `-r sql
mydb` nurodo pavadinimą iš `backends` sąrašo:

.. code-block:: sh

    $ spinta -o config=config.yml inspect -r sql mydb -o sdsa.xlsx


.. _šdsa-generavimas:

ŠDSA generavimas
****************

Spinta leidžia automatiškai generuoti :term:`DSA` lentelę iš duomenų
šaltinio.

Tarkime, jei turime SQLite duomenų bazę su viena lentele:

.. code-block:: sh

    $ sqlite3 sqlite.db <<EOF
    CREATE TABLE COUNTRY (
        NAME TEXT
    );
    EOF

Tada iš tokio duomenų šaltinio, :term:`DSA` lentelę galima sugeneruoti taip:

.. code-block:: sh

    $ spinta inspect -r sql sqlite:///sqlite.db
    d | r | b | m | property | type   | ref | source
    dataset                  |        |     |
      | sql                  | sql    |     | sqlite:///sqlite.db
                             |        |     |
      |   |   | Country      |        |     | COUNTRY
      |   |   |   | name     | string |     | NAME

Šiuo atveju, kadangi nenurodėme kur saugoti sugeneruotą :term:`DSA` lentelę,
ji buvo tiesiog išvesta į ekraną.

`-r` argumentui perduoti du argumentai `sql` ir `sqlite:///sqlite.db`, kurie
atitinka :data:`resource.type` ir :data:`resource.source`.

Jei norima :term:`DSA` lentelę išsaugoti į Excel lentelę, tada argumento `-o`
pagalba galima nurodyti kelią iki failo, kuriame reikia išsaugoti :term:`DSA`
lentelę XLSX formatu:

.. code-block:: sh

    $ spinta inspect -r sql sqlite:///sqlite.db -o sdsa.xlsx

:term:`DSA` lentelę, išsaugotą XLSX formatu galima atsidaryti ir redaguoti
naudojant LibreOffice Calc, Excel ar kitomis skaičiuoklės programomis. Tačiau
taip pat lentelės turinį galima peržiūrėti ir Spintos pagalba:

.. code-block:: sh

    $ spinta show manifest.csv
    d | r | b | m | property | type   | ref | source
    dataset                  |        |     |
      | sql                  | sql    |     | sqlite:///sqlite.db
                             |        |     |
      |   |   | Country      |        |     | COUNTRY
      |   |   |   | name     | string |     | NAME


Jei turite daug duomenų šaltinių, galima juos visus surašyti į :term:`DSA`
lentelę, ir tada paleisti `inspect` komandą, kuri nuskaitys visus lentelėje
esančius duomenų šaltinius ir kiekvienam iš jų sugeneruos duomenų struktūros
aprašus.

Naują :term:`DSA` lentelę galite pradėti kurti taip:

.. code-block:: sh

    $ spinta init sdsa.xlsx

Ši komanda sugeneruos tuščią :term:`DSA` lentelę:

.. code-block:: sh

    $ spinta show sdsa.xlsx
    d | r | b | m | property | type   | ref | source

Tada, šią lentelę galite atsidaryti su jūsų `mėgiama skaičiuoklės programa`__ ir
užpildyti turimus duomenų šaltinius, pavyzdžiui, tokia užpildyta lentelė galėtų
atrodyti taip:

__ https://www.libreoffice.org/discover/calc/

.. code-block:: sh

    $ spinta show resources.xlsx

    d | r | b | m | property | type   | ref | source
    dataset                  |        |     |
      | sql                  | sql    |     | sqlite:///sqlite.db


Struktūros generavimas daromas panašiai, kaip ir nurodant resursus `-r`
argumentų pagalba, tik šį karta reikia nurodyti kelia iki :term:`DSA` lentelės:

.. code-block:: sh

    $ spinta inspect resources.xlsx -o sdsa.xlsx
    $ spinta show sdsa.xlsx
    d | r | b | m | property | type   | ref | source
    dataset                  |        |     |
      | sql                  | sql    |     | sqlite:///sqlite.db
                             |        |     |
      |   |   | Country      |        |     | COUNTRY
      |   |   |   | name     | string |     | NAME


Analogiškai :term:`DSA` lentelės generuojamos ir visiems kitiems
:data:`resource.type` formatams.


CSV
===

.. note::

    Kol kas Spinta neturi įmontuoto CSV formato palaikymo, todėl
    ši rekomendacija yra laikinas trūkstamo CSV palaikymo apėjimas. Ateityje
    planuojama integruoti Dask_ karkasą, kurio dėka atsiras CSV ir `daugelio
    kitų formatų`__ palaikymas.

    .. _Dask: https://dask.org/

    __ https://docs.dask.org/en/latest/dataframe-api.html#create-dataframes

Norint gauti pradinė ŠDSA variantą iš CSV failų, pirmiausiai CSV failus
reikėtų importuoti į SQLite duomenų bazę:

.. code-block:: sh

    $ sqlite3 data.db -csv ".import table1.csv table1"
    $ sqlite3 data.db -csv ".import table2.csv table2"
    $ sqlite3 data.db -csv ".import table3.csv table3"

Tokiu būdu importavus duomenis į SQLite, duomenų struktūros aprašas
generuojamas taip:

.. code-block:: sh

    $ spinta inspect -r sql sqlite:///data.db -o sdsa.xlsx

Jei pageidaujate, trūkstamus metaduomenis, tokius kaip duomenų laukus,
pirminius raktus ar ryšius galite pateikti naudodami `DB Browser for SQLite`_
programą. Tačiau tą patį galite padaryti ir skaičiuoklės pagalba, redaguodami
ŠDSA lentelę.

.. _DB Browser for SQLite: https://sqlitebrowser.org/


SQL
===

Jei norite struktūros aprašą nuskaityti iš vienos konkrečios duomenų bazės
schemos, tada galite naudoti `-f` parametrą, kuris leidžia nurodyti papildomus
parametrus:

.. code-block:: sh

    $ spinta inspect -r sql sqlite:///sqlite.db -f "connect(schema: 'MYSCHEMA')" -o sdsa.xlsx


SQLite
------

Generuojant :term:`DSA` iš SQLite duomenų bazės, jokių papildomų paketų
diegti nereikia. `inspect` komanda atrodys taip:

.. code-block:: sh

    $ spinta inspect -r sql sqlite:///data.db -o sdsa.xlsx

Atkreipkite dėmesį, kad absoliutus kelias atrodo taip::

    sqlite:////data.db

O reliatyvus atrodo taip::

    sqlite:///data.db


PostgreSQL
----------

Generuojant :term:`DSA` iš PostgreSQL duomenų bazės, jums papildomai reikia
įdiegti tokį Python paketą:

.. code-block:: sh

    $ pip install psycopg2-binary

O `inspect` komanda atrodys taip:

.. code-block:: sh

    $ spinta inspect -r sql postgresql+psycopg2://user:pass@host:port/db -o sdsa.xlsx


MySQL
-----

Generuojant :term:`DSA` iš MySQL duomenų bazės, jums papildomai reikia
įdiegti tokį Python paketą:

.. code-block:: sh

    $ pip install pymysql

O `inspect` komanda atrodys taip:

.. code-block:: sh

    $ spinta inspect -r sql mysql+pymysql://user:pass@host:port/db -o sdsa.xlsx


MySQL (<5.6)
------------

`pymysql` biblioteka palaiko MySQL >= 5.6 ir MariaDB >= 10 versijas. Jei
naudojate labai seną MySQL versiją, tuomet, vietoj `pymysql` reikėtų naudoti
senesnę mysqlclient_ biblioteką, kuri palaiko MySQL >= 3.23.32. `mysqlclient`
diegimui pirmiausia reikės įsidiegti tokius sisteminius paketus:

.. _mysqlclient: https://pypi.org/project/mysqlclient/

.. code-block:: sh

    $ sudo apt install build-essential python3-dev default-libmysqlclient-dev

O data ir pačią `mysqlclient` biblioteką:

.. code-block:: sh

    pip install mysqlclient

`inspect` komanda atrodys taip:

.. code-block:: sh

    spinta inspect -r sql mysql+mysqldb://user:pass@host:port/db -o sdsa.xlsx

*p.s. jei vis dar naudojate tokią seną MySQL versiją, laikas atsinaujinti!*


Microsoft SQL Server
--------------------

Generuojant :term:`DSA` iš Microsoft SQL Server duomenų bazės, jums
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

`inspect` komanda atrodys taip:

.. code-block:: sh

    $ spinta inspect -r sql mssql+pymssql://user:pass@host:port/db -o sdsa.xlsx


Oracle
------

Generuojant :term:`DSA` iš Oracle duomenų bazės, jums
papildomai reikia įdiegti cx_Oracle_ paketą:

.. _cx_Oracle: https://oracle.github.io/python-cx_Oracle/

.. code-block:: sh

    $ pip install cx_Oracle

Dėl papildomos informacijos apie Oracle jungtį, skaitykite `cx_Oracle
dokumentacijoje`__.

__ https://cx-oracle.readthedocs.io/en/latest/index.html

`inspect` komanda atrodys taip:

.. code-block:: sh

    $ spinta inspect -r sql oracle+cx_oracle://user:pass@host:port/db -o sdsa.xlsx


XML
===

Jei naudojamas XML duomenų šaltinis, :term:`DSA` struktūrą galima sugeneruoti dviem būdais:
iš XML formatu turimų duomenų arba iš XSD schemos.

XML failas
----------

Iš XML formatu turimų duomenų :term:`DSA` generuojamas naudojant komandą `inspect`:

.. code-block:: sh

    $ spinta inspect -r xml data.xml -o sdsa.xlsx

Šiuo atveju, jei XML struktūra bus ši:

.. code-block:: xml

    <city code="KNS">
        <name>
            Kaunas
        </name>
        <population>
            200000
        </population>
    </city>

Tai sugeneruotas :term:`DSA` atrodys taip:

.. code-block:: sh

id | d | r | b | m | property   | type                    | ref | source       | prepare | level | access | uri | title | description
   | dataset                    |                         |     |              |         |       |        |     |       |
   |   | resource               | xml                     |     | data.xml     |         |       |        |     |       |
   |                            |                         |     |              |         |       |        |     |       |
   |   |   |   | City           |                         |     | /cities/city |         |       |        |     |       |
   |   |   |   |   | code       | string required unique  |     | @code        |         |       |        |     |       |
   |   |   |   |   | name       | string required unique  |     | name         |         |       |        |     |       |
   |   |   |   |   | population | integer required unique |     | population   |         |       |        |     |       |


XSD schema
----------

XSD schema aprašo XML duomenų struktūrą. Iš jos galima sugeneruoti :term:`DSA`, skirtą aprašyti XML duomenų šaltinį.

:term:`DSA` iš XSD schemos generuojamas naudojant `spinta copy` komandą:

.. code-block:: sh

  $ spinta copy schema.xsd -o sdsa.xslx

Šiuo atveju, aukščiau pavaizduotą :term:`DSA`, sugeneruotą iš XML, galima sugeneruoti iš tokios XSD schemos:

.. code-block:: xml

    <element name="city">
        <attribute name="code"></attribute>
        <element name="name" type="string"></element>
        <element name="population" type="int"></element>
    </element>


Jei yra poreikis, šitaip :term:`DSA` failą galima paruošti ir visam katalogui:

.. code-block:: sh

  $ spinta copy xsd_failai/* -o sdsa.xslx


ŠDSA atnaujinimas
*****************

Po to, kai yra sugeneruojamas pradinis ŠDSA ir papildomas trūkstamais
duomenimis, dažniausiai po tam tikro laiko, šaltinio duomenų struktūra
keičiasi ir karts nuo karto reikia atnaujinti esamą ŠDSA ir šaltinio,
įtraukiant naujausius pakeitimus šaltinyje.

Tai galima padaryti tokiu būdu:

.. code-block:: sh

    $ spinta inspect sdsa.xlsx -o sdsa_updated.xlsx

`sdsa_updated.xlsx` faile išliks visi metaduomenys, kuris buvo pradiniame `sdsa
.xlsx`, papildant juos naujais metaduomenimis iš šaltinio.


.. _šdsa-testavimas:

ŠDSA testavimas prieš publikuojant
**********************************

Kai jau yra parengtas ŠDSA variantas iš kurio galima atverti duomenis
pirmiausia reikia patikrinti are ŠDSA yra be klaidų. Tai galima padaryti šios
komandos pagalba:

.. code-block:: sh

    $ spinta check sdsa.xlsx

Jei klaidų nėra, tuomet papildomai, galima paleisti duomenų publikavimo
priemonę, kuri duomenis publikuos tiesiai iš pirminio duomenų šaltinio. Duomenų
publikavimas iš pirminio šaltinio turi tam tikrų apribojimų, tačiau ši galimybė
leidžia peržiūrėti, kaip atrodys publikuojami duomenys, prie juos publikuojan
viešai.

Kaip atrodys publikuojami duomenys, galite peržiūrėti taip:

.. code-block:: sh

    $ spinta run --mode external sdsa.xlsx

Ši komanda paleis HTTP serverį 127.0.0.1:8000 adresu, atsidarę šį adresą
naršyklėje galėsite peržiūrėti kaip atrodo duomenys.


.. _šdsa-vertimas-į-adsa:

ŠDSA vertimas į ADSA
********************

ŠDSA yra toks duomenų struktūros aprašas, kuris yra susietas su duomenų
šaltiniu, yra užpildytas :data:`source` stulpelis.

Verčiant ŠDSA į ADSA, iš esmės pašalinami :data:`source` ir :data:`prepare`
stulpelių duomenys, o taip pat pašalinamos visos eilutės, kurių
:data:`access` yra mažesnis, nei `open`.

ŠDSA vertimą į ADSA galima daryti automatiškai taip:

.. code-block:: sh

    $ spinta copy sdsa.xlsx --no-source --access open -o adsa.csv


.. _automatinis-atvėrimas:

Duomenų publikavimas į Saugyklą
*******************************

Prieš publikuojant duomenis į :ref:`Saugyklą <saugykla>`, Saugykloje turi būti
įkeltas :ref:`duomenų struktūros aprašas <dsa>`. Saugykla gali priimti tik
duomenis, turinčius :term:`DSA`.

Taip pat, prieš publikuojant duomenis, Saugykloje turi būti užregistruotas
klientas, kuriam suteikiamos rašymo į saugyklą teisės. Klientui suteikiamos
rašymo teisės į tam tikrą vardų erdvę, todėl skirtingi klientai, gali rašyti
duomenis tik į tam tikrą, jiems skirtą vardų erdvę.

Kliento autorizacijos duomenys turėtu būti pateikiami `credentials.cfg` faile.
`credentials.cfg` failo ieškoma `$XDG_CONFIG_HOME/spinta kataloge`__
(pavyzdžiui
`~/.config/spinta/credentials.cfg`). Šio failo formatas atrodo taip:

__ https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html

.. code-block:: ini

    [myclient@put.data.gov.lt]
    client = myclient
    secret = verysecret
    scopes =
      spinta_getall
      spinta_getone
      spinta_search
      spinta_changes
      spinta_datasets_gov_myorg_insert
      spinta_datasets_gov_myorg_upsert
      spinta_datasets_gov_myorg_update
      spinta_datasets_gov_myorg_patch
      spinta_datasets_gov_myorg_delete

Čia nurodomas kliento pavadinimas, slaptažodis ir leidimai (`scopes`).
Suteiktas leidimas skaityti visus duomenis ir rašyti tik į
`datasets/gov/myorg` vardų erdvę.

Kol kas kliento kūrimas Saugykloje yra daromas rankiniu būdu, atskiru
paklausimu, tačiau planuojama tai `automatizuoti`__.

__ https://github.com/atviriduomenys/spinta/issues/122

Galiausiai, įkėlus duomenų struktūros aprašą į Katalogą, iš Katalogo įkėlus
aprašą į saugyklą ir turinti klientą Saugykloje, galima publikuoti duomenis į
saugyklą tokiu būdu:

.. code-block:: sh

    $ spinta push sdsa.csv -o myclient@put.data.gov.lt

Vietoj `sdsa.csv` galima naudoti ir `sdsa.xlsx`, abu formatai, tiek CSV, tiek
XLSX yra palaikomi.

Dar vienas dalykas, į kurį reikėtu atkreipti dėmesį yra būsenos ir objektų
identifikatorių failai. Kadangi `spinta push` komanda į Saugyklą siunčia tik
tuos duomenis kurie dar nebuvo siųsti arba kurie pasikeitė, kad tai veiktų
saugoma duomenų perdavimo į Saugyklą būsena ir identifikatoriai. Būsena saugoma
SQLite duomenų bazėje, `$XDG_DATA_HOME/spinta/push/{remote}.db`__ faile (pavyzdžiui
`~/.local/share/spinta/push/get_data_gov_lt.db`). Identifikatoriai saugomi
`$XDG_DATA_HOME/spinta/keymap.db` SQLite faile (pavyzdžiui
`~/.local/share/spinta/keymap.db`. Priklausomai nuo duomenų kiekio šie failai
gali užimti gan daug vietos. Būsenos ir identifikatorių failuose saugomi
Saugykloje suteikti objektų identifikatoriai, vietiniai identifikatoriai ir
duomenų kontrolinės sumos.

__ https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html

Kadangi `spinta push` komanda saugo būseną, šią komandą galima leisti daug
kartų ir ji tęs duomenų perdavimą nuo tos vietose kur buvo baigta paskutinį
kartą.

Rekomenduojama šią duomenų publikavimo komanda įtraukti į automatiškai
vykdomų užduočių sąrašą, kad duomenys būtų publikuojamai automatiškai,
pavyzdžiui kas naktį arba kas valandą.

Reikėtu atkreipti dėmesį į tai, kad vienu metu reikėtu leisti tik vieną
`spinta push` komandos procesą.

`spinta push` komanda, prieš siunčiant duomenis, pirmiausiai suskaičiuoja kiek
yra objektų, kurie bus siunčiami, kad galėtų atvaizduoti progreso juostą. Jei
jūsų šaltinis yra lėtas galite naudoti `--no-progress-bar`, kad neskaičiuotų
objektų, pavyzdžiui:

.. code-block:: sh

    $ spinta push sdsa.csv -o myclient@put.data.gov.lt --no-progress-bar

Kitus galimus komandinės eilutės argumentus galite sužinoti taip:


.. code-block:: sh

    $ spinta push --help
