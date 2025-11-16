.. default-role:: literal

.. _agentas-diegimas:

###############
Agento diegimas
###############

Agentas - duomenų teikimo agentas, teikiantis duomenus pagal UDTS standartą.

Čia rasite informaciją, kaip galite paleisti Agentą, veikiantį :ref:`Spinta`
priemonės pagalba savo infrastruktūroje.

:ref:`Spinta` gali veikti kaip komandinės eilutės įrankis, tačiau taip pat
gali veikti ir duomenų publikavimo režimu.

Duomenų publikavimas gali veikti dviem režimais:

mode: internal
  Duomenys publikuojami iš duomenų bazės, kurioje laikoma
  šaltinio duomenų kopija. Šiuo atveju, Spinta praturtina šaltinio duomenis
  metaduomenimis, kurie leidžia užtikrinti sklandesnį duomenų publikavimą.

mode: external
  Duomenys gali būti publikuojami tiesiai iš duomenų šaltinio. Šis režimas
  turėtų būti naudojamas tada, kai nėra galimybės leisti Agentui rašyti papildomus
  duomenis į šaltinio duomenų bazę, ar šaltinis nėra reliacinė duomenų bazė.
  Šiuo būdu teikiant duomenis, šaltinio duomenų susiejimui su UDTS formato
  universaliais identifikatoriais (UUID), naudojama papildoma duomenų bazė (keymap).

Dažniausiai, bus naudojamas `external` režimas, nebent duomenų teikėjas
sutiktų leisti Agentui įrašyti papildomus metaduomenis, kurie padėtų užtikrinti
šį ir kitus funkcionalumus.

Agentas veikia ir yra testuotas Linux operacinėse sistemose, konkrečiai
naudojant Debian/Ubuntu distribucijas, todėl instrukcijos bus pateiktos būtent
Debian/Ubuntu aplinkai. Diegimą galima atlikti ir kitose Linux distribucijose,
tačiau tam tikros vietos nurodytos šioje dokumentacijoje turėtu būti
priderintos taip, kad veiktų kitoje distribucijoje.

`Spinta` yra sukurta naudojant Python programavimo kalbą, reikalinga Python 3.10
ar naujesnė versija. Naujose Agento versijose reikalavimas Python versijai
gali keistis.

Dėl serverio resursų, tokių kaip CPU, RAM ir HDD, reikalingi resursai
tiesiogiai priklauso nuo publikuojamų duomenų kiekio ir naudotojų srauto, kurie
naudosis duomenų publikavimo paslauga.

Minimalūs reikalavimai Agentui, be duomenų ir su 5 naudotojais vienu metu
besinaudojančiais duomenų teikimo paslauga:

CPU
    1 CPU, šiuo metu perduodant duomenis nėra naudojamas lygiagretinimas,
    todėl bus naudojamas tik vienas CPU, ateityje tai gali keistis.

RAM
    512Mb, duomenys skaitomi srautiniu būdu, todėl nepriklausomai nuo
    šaltinio dydžio, naudojamas fiksuotas RAM kiekis.

    Vienas Spinta procesas naudoja apie 100Mb RAM.

HDD
    Priklauso nuo duomenų kiekio.

    Unikalių identifikatorių duomenų įrašams suteikimui, saugomi papildomi duomenys:

    1. Vidinių ir publikuojamų pirminių raktų sąsaja, saugoma
       `~/.local/share/spinta/keymap.db` Sqlite arba Redis duomenų bazėje. Duomenys
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

Pats savaime Agentas su visomis Python priklausomybes diske užima apie 500 Mb
vietos, tačiau sunaudojamos vietos skaičius gali skirtis, skirtingose
distribucijose.

Agento veikimas turėtu būti nuolat stebimas ir reikiami resursai didinami,
pagal poreikį.

Operacinės sistemos paruošimas
******************************

Agentas turėtu būti diegiamas ir leidžiamas `spinta` naudotojo teisėmis, todėl
reikia sukurti sisteminį naudotoją:

.. code-block:: sh

    sudo useradd --system -g www-data --create-home --home-dir /opt/spinta spinta

Atkreipkite dėmesį, kad visose komandose, kurios prasideda `sudo`, komanda turi
būti vykdoma administratoriaus teisėmis, tačiau visur kur nėra `sudo`, komanda
turi būti vykdoma `spinta` naudotojo teisėmis. Tai yra svarbu, todėl
nesupainiokite kokio naudotojo teisėmis vykdote komandas, priešingu atveju
susidursite su sunkumais susijusiais su failų teisėmis.

Python diegimas
***************

Daugelis Linux distribucijų ateina su įdiegta Python versija, tačiau reikia
įsitikinti, ar distribucijos Python versija yra pakankama:

.. code-block:: sh

    python3 --version

Jei Python versija yra 3.10 ar naujesnė, tada galite pereiti prie sekančio
žingsnio.

Jei versija yra žemesnė nei 3.10, tuomet reikės įsidiegti naujesnę Python
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
    /opt/pyenv/bin/pyenv install 3.14.0  # Naudokite naujausią versiją

Naujausia Python versija bus įdiegta į `/opt/pyenv/versions/3.14.0/bin/python`.


Analogiškai, galite naudotis distribucijos teikiamais paketais, Ubuntu atveju
galite daryti taip:

.. code-block:: sh

    sudo apt update
    sudo apt upgrade
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt update
    sudo apt install python3.10 python3.14-venv

Naujausia python versija bus pasiekiama `python3.14` komandos pagalba.


Spinta diegimas
***************

Atkreipkite dėmesį, kad visos komandos diegiant Spinta turi būti vykdoma
`spinta` naudotojo teisėmis ir iš `spinta` naudotojo namų katalogo
`/opt/spinta`.

Aktyvų naudotoją ir katalogą galite pasikeisti taip:

.. code-block:: sh

    sudo -Hsu spinta
    cd

Agentas veikia Spinta_ priemonės pagalba, kuriai reikia Python. Rekomenduojama
visus Python paketus diegti taip vadinamoje izoliuotoje Python aplinkoje, kurią
galima susikurti taip (nepamirškite nurodyti jūsų naudojamos Python versijos
numerį, kuris gali skirtis):

- Jei Python diegėte su venv_:

    .. code-block:: sh

        /opt/pyenv/versions/3.14.0/bin/python -m venv env

- Jei Python diegėte distribucijos priemonėmis:

    .. code-block:: sh

        python3.14.0 -m venv env

Toliau diekite `spinta`:

DVMS partneriams projekto vystymo metu rekomenduojama diegti naujausią `pre-release`
versiją, kadangi joje yra naujausi projekto vystymui ir partnerių darbui atlikti pakeitimai:

.. code-block:: sh

    env/bin/pip install --pre spinta
    env/bin/spinta --version


Agento konfigūravimas
*********************

Spinta yra konfigūruojama konfigūracijos failo pagalba, kurio, pagal nutylėjimą
ieškoma aktyviame kataloge. Kur Spinta ieško konfigūracijos failo, galima
patikrinti taip:

.. code-block:: sh

    env/bin/spinta config config

Konfigūracijos failo vieta gali būti keičiama komandinės eilutės:

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
    token_validation_keys_download_url: https://<auth-serverio-adresas>  # auth serverio viešu raktu
                                                                             # (well-known) adresas, jei
                                                                             # naudojate autorizacijos serverį
                                                                             # (ne spinta), kuris palaiko raktų rotavimą

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
        mode: external

    accesslog:
      type: file
      file: /opt/spinta/logs/access.log

Jei naudojate daugiau, nei vieną manifestą, ir norite, kad Agentas pasiektų juos visus,
galima tai naudoti operatoriaus `sync` pagalba:

.. code-block:: yaml

    manifests:
      default:
        type: tabular
        path: /opt/spinta/manifest.csv
        backend: default
        mode: external
        sync: additional
      additional:
        type: tabular
        path: /opt/spinta/manifest2.csv
        backend: default
        mode: external


Prieš testuojant ar konfigūracija veikia, sukuriame reikalingus katalogus:

.. code-block:: sh

    mkdir /opt/spinta/config
    mkdir /opt/spinta/logs
    mkdir /opt/spinta/var

Generuojame kriptografinius autorizacijos raktus:

.. code-block:: sh

    env/bin/spinta key generate


Nepamirškite, kad `/opt/spinta/manifest.csv` faile, kaip nurodyta
konfigūracijos faile, turite pateikti duomenų struktūros aprašą, kurio pagrindu
veiks agentas.

Galiausiai patikriname konfigūraciją:

.. code-block:: sh

   env/bin/spinta config config backends manifests accesslog

Patikriname ar konfigūracijoje ir pateiktame struktūros apraše nėra klaidų.

.. code-block:: sh

   env/bin/spinta check

Patikriname ar Spinta gali prisijungti prie duomenų bazės.

.. code-block:: sh

   env/bin/spinta wait 1

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

Redis rekomenduojame diegti Docker konteineryje. Docker paleidimo konfigūracija:

.. code-block:: yaml

  redis-keymap: # sqlite faster alternative
    image: valkey/valkey:9
    restart: always
    command: [ "redis-server", "--appendonly", "yes" ] # persistence settings to persist always, without any data loss.
    volumes:
      - redis_keymap_data:/data
    ports:
      - "6379:6379"
volumes:
  redis_keymap_data:

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
    env/bin/pip install --upgrade --pre spinta


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

    exit  # spinta user
    sudo systemctl restart gunicorn
    sudo systemctl status gunicorn
    exit  # server


Problemos ir sprendimai
***********************

Jei kažkas neveikia, pirmiausiai reikėtų žiūrėti servisų žurnalus, pavyzdžiui:

.. code-block:: sh

    journalctl -u gunicorn -xe
    journalctl -u nginx -xe

Žurnaluose dažniausiai būna pateikta informacija, leidžianti suprasti kas ir
kodėl neveikia.
