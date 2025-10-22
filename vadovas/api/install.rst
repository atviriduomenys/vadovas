.. default-role:: literal

.. _saugykla-diegimas:

##################
Saugyklos diegimas
##################

Jei dėl tam tikrų priežasčių negalite naudoti valstybinės duomenų publikavimo
paslaugos pasiekiamos adresu get.data.gov.lt_, tuomet galite Saugyklą
pasileisti ir savo infrastruktūroje.

.. _get.data.gov.lt: https://get.data.gov.lt/

Čia rasite informaciją, kaip galite paleisti Saugyklą savo infrastruktūroje.

Saugykla veikia :ref:`Spinta` priemonės pagalba. :ref:`Spinta` gali veikit kaip
komandinės eilutės įrankis, tačiau taip pat gali veikti ir duomenų publikavimo
režimu.

Duomenų publikavimas gali veikti dviem režimais:

mode: internal
  Duomenys publikuojami iš Saugyklos vidinės duomenų bazės, kurioje laikoma
  šaltinio duomenų kopija. Vidinė duomenų bazė praturtina šaltinio duomenis
  metaduomenimis, kurie leidžia užtikrinti sklandesnį duomenų publikavimą.

mode: external
  Duomenys gali būti publikuojami tiesiai iš duomenų šaltinio (kol kas tai yra
  eksperimentinė funkcija, naudojama tik pasitikrinti, kaip atrodys duomenų
  publikavimas, prie atliekant realų duomenų perdavimą į Saugyklą).

Diegiant ir konfigūruojant duomenų publikavimo paslaugą rekomenduojame naudoti
`model: internal` režimą, būtent toks režimas naudojamas ir get.data.gov.lt_
adresu.


Techniniai reikalavimai
***********************

Saugykla veikia ir yra testuota Linux operacinėse sistemose, konkrečiai
naudojant Debian/Ubuntu distribucijas, todėl instrukcijos bus pateiktos būtent
Debian/Ubuntu aplinkai. Diegimą galima atlikti ir kitose Linux distribucijose,
tačiau tam tikros vietos nurodytos šioje dokumentacijoje turėtu būti
priderintos taip, kad veiktų kitoje distribucijoje.

Saugykla yra sukurta naudojant Python programavimo kalbą, reikalinga Python 3.9
ar naujesnė versija. Naujose Saugyklos versija reikalavimas Python versijai
gali keistis.

Dėl serverio resursų, tokių kaip CPU, RAM ir HDD, reikalingi resursai
tiesiogiai priklauso nuo publikuojamų duomenų kiekio ir naudotojų srauto, kurie
naudosis duomenų publikavimo paslauga.

Minimalūs reikalavimai Saugyklai, be duomenų ir su 5 naudotojais vienu metu
besinaudojančiais publikavimo paslauga būtų 1 CPU, 512 Mb RAM ir 1G HDD laisvos
vietos, kuri lieka pilnai įdiegus operacinę sistemą ir visas reikalingas
priklausomybes.

Pati savaime Saugykla su visomis Python priklausomybes diske užima apie 500 Mb
vietos, tačiau sunaudojamos vietos skaičius gali skirtis, skirtingose
distribucijose.

Saugyklos veikimas turėtu būti nuolat stebimas ir reikiami resursai didinami,
pagal poreikį.


Operacinės sistemos paruošimas
******************************

Saugykla turėtu būti diegiama ir leidžiama `spinta` naudotojo teisėmis, todėl
reikia sukurti sisteminį naudotoją:

.. code-block:: sh

    sudo useradd --system -g www-data --create-home --home-dir /opt/spinta spinta

Atkreipkite dėmesį, kad visose komandose, kurios prasideda `sudo`, komanda turi
būti vykdoma administratoriaus teisėmis, tačiau visur kur nėra `sudo`, komanda
turi būti vykdoma `spinta` naudotojo teisėmis. Tai yra svarbu, todėl
nesupainiokite kokio naudotojo teisėmis vykdote komandas, priešingu atveju
susidursite su sunkumais susijusiais su failų teisėmis.


PostgreSQL diegimas
*******************

Kai Saugykla veikia `mode: internal` režimu, jai reikalinga duomenų bazė,
kurioje saugoma publikuojamų duomenų kopija. Rekomenduojame naudoti PostgreSQL:

.. code-block:: sh

    sudo apt install postgresql
    sudo -Hiu postgres createuser spinta
    sudo -Hiu postgres createdb \
      --template=template0 \
      --owner=spinta \
      --encoding=UTF8 \
      --locale=C.UTF-8 \
      spinta

Žinomų apribojimų PostgreSQL versijai nėra. Rekomenduojame naudoti naujausią
PostgreSQL versiją.


Python diegimas
***************

Daugelis Linux distribucijų ateina su įdiegta Python versija, tačiau reikia
įsitikinti, ar distribucijos Python versija yra pakankama:

.. code-block:: sh

    python3 --version

Jei Python versija yra 3.9 ar naujesnė, tada galite pereiti prie sekančio
žingsnio.

Jei versija yra žemesnė nei 3.9, tuomet reikės įsidiegti naujesnę Python
versiją. Tai galite padaryti naudodami pyenv_ (dėl pačio pyenv_ diegimo
skaitykite `pyenv dokumentacijoje`_):

.. _pyenv: https://github.com/pyenv/pyenv
.. _pyenv dokumentacijoje: https://github.com/pyenv/pyenv/wiki#suggested-build-environment

.. code-block:: sh

    sudo apt update
    sudo apt upgrade
    sudo apt install -y \
      git make build-essential libssl-dev zlib1g-dev \
      libbz2-dev libreadline-dev libsqlite3-dev wget \
      curl llvm libncurses5-dev libncursesw5-dev \
      xz-utils tk-dev libffi-dev liblzma-dev \
      python-openssl
    git clone https://github.com/pyenv/pyenv.git
    export PYENV_ROOT=/opt/pyenv
    /opt/pyenv/bin/pyenv install --list | grep -v - | tail
    /opt/pyenv/bin/pyenv install 3.10.7  # Naudokite naujausią versiją

Naujausia Python versija bus įdiegta į `/opt/pyenv/versions/3.10.7/bin/python`.


Analogiškai, galite naudotis distribucijos teikiamais paketais, Ubuntu atveju
galite daryti taip:

.. code-block:: sh

    sudo apt update
    sudo apt upgrade
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt update
    sudo apt install python3.10 python3.10-venv

Naujausia python versija bus pasiekiama `python3.10` komandos pagalba.


Spinta diegimas
***************

Atkreipkite dėmesį, kad visos komandos diegiant Spinta turi būti vykdoma
`spinta` naudotojo teisėmis ir iš `spinta` naudotojo namų katalogo
`/opt/spinta`.

Aktyvų naudotoją ir katalogą galite pasikeisti taip:

.. code-block:: sh

    sudo -Hsu spinta
    cd

Saugykla veikia Spinta_ priemonės pagalba, kuriai reikia Python. Rekomenduojama
visus Python paketus diegti taip vadinamoje izoliuotoje Python aplinkoje, kurią
galima susikurti taip (nepamirškite nurodyti jūsų naudojamos Python versijos
numerį, kuris gali skirtis):

- Jei Python diegėte su venv_:

    .. code-block:: sh

        /opt/pyenv/versions/3.10.7/bin/python -m venv env

- Jei Python diegėte distribucijos priemonėmis:

    .. code-block:: sh

        python3.10 -m venv env

Toliau spintą įdiegsite taip:

.. code-block:: sh

    env/bin/pip install spinta
    env/bin/spinta --version


Saugyklos konfigūravimas
************************

Spinta yra konfigūruojama konfigūracijos failo pagalba, kurio, pagal nutylėjimą
ieškoma aktyviame kataloge. Kur Spinta ieško konfigūracijos failo, galima
patikrinti taip:

.. code-block:: sh

    env/bin/spinta config config

Konfigūracijos failas vieta gali būti keičiama komandinės eilutės:

.. code-block:: sh

    env/bin/spinta -o config=config.yml

Arba aplinkos kintamųjų pagalba:

.. code-block:: sh

    SPINTA_CONFIG=/opt/spinta/config.yml

Kuriuos, taip pat galima pateikti ir `.env` faile.

Pats konfigūracijos failas `config.yml` turėtu atrodyti panašiai taip:

.. code-block:: yaml

    config_path: /opt/spinta/config
    default_auth_client: default
    env: production
    manifest: default

    keymaps:
      default:
        type: sqlalchemy
        dsn: sqlite:////opt/spinta/var/keymap.db

    backends:
      default:
        type: postgresql
        dsn: postgresql:///spinta

    manifests:
      default:
        type: tabular
        path: /opt/spinta/manifest.csv
        backend: default
        mode: internal

    accesslog:
      type: file
      file: /opt/spinta/logs/access.log

Prieš testuojant ar konfigūracija veikia, sukuriame reikalingus katalogus:
      
.. code-block:: sh

    mkdir /opt/spinta/config
    mkdir /opt/spinta/logs
    mkdir /opt/spinta/var

Generuojame kriptografinius autorizacijos raktus:

.. code-block:: sh

    env/bin/spinta genkeys

Sukuriame `default_auth_client`, kuriam suteiktos teisės bus naudojamos visiems
neautorizuotiems klientams:

.. code-block:: sh

    env/bin/spinta client add -n default --add-secret --scope - <<EOF
    spinta_getone
    spinta_getall
    spinta_search
    spinta_changes
    EOF

Konkrečiai šiuo atveju suteikiamos visos skaitymo teisės.

Sukuriame klientą `myclient`, kuriam suteikiame rašymo teises (pasikeiskite
kliento pavadinimą savo nuožiūra):

.. code-block:: sh

    env/bin/spinta client add -n myclient --scope - <<EOF
    spinta_set_meta_fields 
    spinta_getone
    spinta_getall
    spinta_search
    spinta_changes
    spinta_insert
    spinta_upsert
    spinta_update
    spinta_patch
    spinta_delete
    EOF

Jei norite suteikti rašymo teistes tik į tam tikrą vardų erdvę, galite nurodyti
tai `scope` pagalba, pavyzdžiui `spinta_datasets_gov_myorg_insert`, kas
sureikia naujų objektų kūrimo teises į `datasets/gov/myorg` vardų erdvę.

Nepamirškite, kad `/opt/spinta/manifest.csv` faile, kaip nurodyta
konfigūracijos faile, turite pateikti duomenų struktūros aprašą, kurio pagrindu
veiks saugykla. Šioje vietoje reikia pateikti ne ŠDSA, o ADSA variantą, t.y.
struktūros aprašą, kuriame pašalinta viskas, kas nereikalinga atvėrimui
(žiūrėti :ref:`šdsa-vertimas-į-adsa`).

Galiausiai patikriname configūraciją:

.. code-block:: sh

   env/bin/spinta config config backends manifests accesslog

Patikriname ar konfigūracijoje ir pateiktame struktūros apraše nėra klaidų.

.. code-block:: sh

   env/bin/spinta check

Patikriname ar Spinta gali prisijungti prie duomenų bazės.

.. code-block:: sh

   env/bin/spinta wait 1

Ir galiausiai, paleidžiame duomenų bazės migracijas, kurių metu pagal
struktūros apraše pateiktus metaduomenis bus sukuriamos reikalingos lentelės
PostgreSQL duomenų bazėje.

.. code-block:: sh

    env/bin/spinta bootstrap

Keymap
******

Keymap naudojamas susieti išorinius identifikatorius su vidiniais identifikatoriais. Gali būti konfigūruojama.
Pagal numatytuosius nustatymus naudojama SQLite, kaip parodyta aukščiau pateiktame konfigūracijos pavyzdyje,
tačiau galima pakeisti į kitą, pvz. - greitesnę ar stabilesnę saugyklą. Čia pateikiamas pilnas galimų variantų sąrašas:

- SQLite duomenų bazė su SQLAlchemy backend'u, konfigūruojama taip:

  .. code-block:: yaml

      keymaps:
        default:
          type: sqlalchemy
          dsn: sqlite:////path/to/keymap.db

- Redis **persistent** saugykla su Redis, konfigūruojama taip:

  .. code-block:: yaml

      keymaps:
        default:
          type: redis
          dsn: redis://redis-address:6379/1

Redis Docker paleidimo konfigūracija pateikta projekto docker-compose.yml faile (root kataloge).
**SVARBU! Redis turi būti būtinai leidžiamas persistent režimu (appendonly yes parametras)**
Yra keli persistent režimai (žr. Redis/Valkey dokumentaciją).
Numatytasis režimas (appendonly) užtikrina didžiausią duomenų nepraradimo patikimumą,
tačiau turi mažiausią greitį, lyginant su kitais režimais.

Web serverio diegimas ir konfigūravimas
***************************************

Į Python virtualią aplinką įdiegiame Gunicorn_:

.. _Gunicorn: https://gunicorn.org/

.. code-block:: sh

    env/bin/pip install gunicorn uvloop httptools

Sukuriame SystemD_ servisą (atkreipkite dėmesį, kad jūsų pasirinkta
distribucija gali naudoti kitą servisų valdymo priemonę, tuomet šis pavyzdys
netiks):

.. _SystemD: https://systemd.io/

.. code-block:: ini

    # /etc/systemd/system/gunicorn.service
    [Unit]
    Description=gunicorn daemon
    After=network.target

    [Service]
    Type=notify
    RuntimeDirectory=gunicorn
    WorkingDirectory=/opt/spinta
    EnvironmentFile=/opt/spinta/.env
    ExecStart=/opt/spinta/env/bin/gunicorn -b 127.0.0.1:8000 -u spinta -g www-data -k uvicorn.workers.UvicornWorker spinta.asgi:app
    ExecReload=/bin/kill -s HUP $MAINPID
    KillMode=mixed
    TimeoutStopSec=5
    PrivateTmp=true

    [Install]
    WantedBy=multi-user.target

Aktyvuokite servisą:

.. code-block:: sh

    sudo systemctl enable gunicorn
    sudo systemctl daemon-reload
    sudo systemctl start gunicorn

Patikrinkite are servisas veikia:

.. code-block:: sh

    sudo systemctl status gunicorn

Įdiegiame pasirinktą Web serverio paketą, šiuo atveju pavyzdys pateiktas
Nginx_:

.. _Nginx: https://nginx.org/en/

.. code-block:: sh

   sudo apt update
   sudo apt install nginx


Sukuriame pasirinkto Web serverio, šiuo atveju Nginx, konfigūracijos failą
(pakeiskite *example.org* į jūsų domeno pavadinimą):

.. code-block:: nginx

    # /etc/nginx/sites-available/example.org
    server {
      listen 80;
      server_name example.org;

      location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      }
    }

Aktyvuojame konfigūracijos failą:

.. code-block:: sh

    sudo ln -s /etc/nginx/sites-available/example.org /etc/nginx/sites-enabled/

Patikriname ar konfigūracija veikia:

.. code-block:: sh

   sudo nginx -t

Perkraukite Nginx:

.. code-block:: sh

    sudo systemctl restart nginx

Patikrinkite ar servisas veikia:

.. code-block:: sh

    sudo systemctl restart nginx

Detalesnės instrukcijos apie tai, kaip konfigūruoti SSL sertifikatus ir kitus
Gunicorn ar Nginx parametrus rasite minėtų projektų dokumentacijoje.


Spintos naujinimas
******************

Norint atnaujinti Spinta versiją, jums reikia įvykdyti tokias komanas:

.. code-block:: sh

    sudo -Hsu spinta
    cd
    env/bin/pip install --upgrade spinta


Struktūros aprašo naujinimas
****************************

Jei pasikeitė struktūros aprašas, jį galite atnaujinti taip:

.. code-block:: sh

    scp manifest.csv example.org:/opt/spinta/manifest-new.csv
    ssh example.org
    sudo chown spinta:www-data /opt/spinta/manifest-new.csv
    sudo -Hsu spinta
    cd
    env/bin/spinta check manifest-new.csv
    cp manifest.csv manifest-old.csv
    mv manifest-new.csv manifest.csv

    diff -y --suppress-common-lines manifest-old.csv manifest-new.csv
    psql spinta
    \q

    env/bin/spinta bootstrap

    exit  # spinta user
    sudo systemctl restart gunicorn
    sudo systemctl status gunicorn
    exit  # server

Atkreipkite dėmesį, kad `spinta bootstrap` komanda gali sukurti tik naujas
lenteles, kurios dar nebuvo sukurtos. Jei keitėsi lentelė, kuri jau buvo
publikuojama anksčiau, tuomet, prieš `spinta bootstrap`, jums reikės
pasižiūrėti, kas keitėsi (`diff` komanda) ir atitinkamai pakoreguoti duomenų
bazės schema SQL užklausų pagalba (`psql` komanda).

Dažniausiai naudojamos SQL komandos schemos koregavimui pateiktos žemiau.

Lentelių sąrašo peržiūrą (PostgreSQL riboja lentelės pavadinimo ilgį, todėl
ilgi pavadinimai gali būti trumpinami):

.. code-block:: psql

    \dt "datasets/gov/myorg"*;

Lentelės trynimas:

.. code-block:: sql

    drop table "datasets/gov/org/dataset/Model/:changelog";
    drop table "datasets/gov/org/dataset/Model";

Lentelės pavadinimo keitimas:

.. code-block:: sql

    alter table "datasets/gov/org/dataset/Model/:changelog"
        rename to "datasets/gov/org/dataset/Model2/:changelog";
    alter table "datasets/gov/org/dataset/Model"
        rename to "datasets/gov/org/dataset/Model2";

Stulpelio pavadinimo keitimas:

.. code-block:: sql

    alter table "datasets/gov/org/dataset/Model" rename column "abc" to "xyz";

Naujo stulpelio pridėjimas:

.. code-block:: sql

    alter table "datasets/gov/org/dataset/Model" add "abc" integer;

Esamo stulpeio tipo keitimas:

.. code-block:: sql

    alter table "datasets/gov/org/dataset/Model" alter "abc" type double precision;


Problemos ir sprendimai
***********************

Jei kažkas neveikia, pirmiausiai reikėtų žiūrėti servisų žurnalus, pavyzdžiui:

.. code-block:: sh

    journalctl -u gunicorn -xe
    journalctl -u nginx -xe

Žurnaluose dažniausiai būti pateikta visa informacija, kas suprasti kas ir
kodėl neveikia.
