.. default-role:: literal

.. _duomenų-tipai:

Duomenų tipai
#############

.. describe:: absent

    Žymi :term:`savybę <savybė>`, kuri buvo ištrinta ir nebenaudojama. Žiūrėti
    :ref:`struktūros-keitimas`.

.. describe:: boolean

    Loginė reikšmė.

    **Brandos lygis**

    :1:
        - Duomyse nėra vientisumo, kartais `true` pateikta kaip `1`, kartais
          akip `taip`, arba `yes`.

    :2:
        - Visi duomenys pateikti vienoda, tačiau nestandartine forma.

    :3:
        - Duomenys pateikti standartine forma. Standartinė forma priklauso nuo
          pasirinkto duomenų saugojimo formato. Pavyzdžiui JSON formatu
          `boolean` tipas išreiškiamas kaip `true` ir `false`.

.. describe:: integer

    Sveikas skaičius.

    Mažiausia galima reikšmė: `-2147483648`.

    Didžiausia galima reikšmė: `2147483647`.

    :data:`property.ref` stulpelyje, nurodomi :ref:`matavimo-vienetai`.

.. describe:: number

    Realusis skaičius, apvalinamas naudojant `slankiojo kablelio aritmetiką`__,
    kur sveikoji skaičiaus dalis gali būti šešių skaitmenų dydžio.

    __ https://en.wikipedia.org/wiki/IEEE_754

    :data:`property.ref` stulpelyje, nurodomi :ref:`matavimo-vienetai`.

    Sveikoji dalis atskiriama `.` simbolių.

.. describe:: binary

    Dvejetainiai duomenys. Bendras baitų skaičius turi būti ne didesnis nei 1G.


.. _text-types:

Tekstiniai duomenys
===================

Tekstiniai duomenys skirstomi į du skirtingus tipus `string` ir `text`.


.. describe:: string

    Simbolių eilutė. Neriboto dydžio, tačiau fiziškai simbolių eilutė turėtu
    būti ne didesnė, nei 1G.

    Simboliu eilutė turėtu būti pateikta UTF-8 koduote.

    Šiuo tipu žymimi duomenų laukai, kuriuose tekstas pateiktas ne žmonių
    kalba. Tai gali būti įvairūs kategoriniai duomenys, identifikatoriai ar
    kito pobūdžio simbolių eilutės, kurios nėra užrašytos natūraliąja žmonių
    kalba.


.. describe:: text

    Natūraliaja žmonių kalba užrašytas tekstas.

    Galima nurodyti kokia kalba užrašytas tekstas naudojant `ISO 639-1`_ kodus.
    Kalbos kodas nurodomas :data:`property` stulpelyje, prie pavadinimo įrašant
    `@<kodas>`, kur `<kodas>` yra pakeičiamas į dviejų raidžių kalbos kodą.
    Pavyzdžiui `pavadinimas@lt`. Plačiau apie tai `RDF Turtle`_ specifikacijoje
    iš kur ir buvo pasiskolintas toks kalbų žymėjimas.

    .. _ISO 639-1: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
    .. _RDF Turtle: https://www.w3.org/TR/turtle/#turtle-literals

    Tekstas turėtu būti pateikta UTF-8 koduote. Jei šaltinyje tekstas nėra
    UTF-8 koduotės, tuomet galima :data:`prepare` stulepyje įrašoų formulių
    pagalba galima nurodyti transformavimo taisykles iš šatinio naudojamos į
    UTF-8 koduotę.


    :data:`property.ref` galima pateikti teksto formatą, nadojant vieną iš šių
    formatų:

    - `html` - tekstas pateiktas HTML_ formatu.
    - `md` - tekstas pateiktas Markdown_ formatu.
    - `rst` - tekstas pateitkas reStructuredText_ formatu.
    - `tei` - tekstas pateiktas TEI_ formatu.

    .. _HTML: https://en.wikipedia.org/wiki/HTML
    .. _Markdown: https://spec.commonmark.org/
    .. _reStructuredText: https://docutils.sourceforge.io/rst.html
    .. _TEI: https://en.wikipedia.org/wiki/Text_Encoding_Initiative

    Pavyzdys:

    ==  ==  ==  ==  ===============  ====  ====
    d   r   b   m   property         type  ref 
    ==  ==  ==  ==  ===============  ====  ====
    example                        
    -------------------------------  ----  ----
    \           Country            
    --  --  --  -------------------  ----  ----
    \               name\@lt         text      
    \               description\@lt  text  html
    ==  ==  ==  ==  ===============  ====  ====

    Šiame pavyzdyje `@lt` nurodo, kad šalies pavadinimai ir aprašymai pateikti
    Lietuvių kalba. Papildomai, šalies aprašymo teksto formatas yra HTML_ tipo.


.. _temporal-types:

Data ir laikas
==============

.. describe:: datetime

    Data ir laikas atitinkantis `ISO 8601`_.

    Mažiausia galima reikšmė: `0001-01-01T00:00:00`.

    Didžiausia galima reikšmė: `9999-12-31T23:59:59.999999`.

    .. _ISO 8601: https://en.wikipedia.org/wiki/ISO_8601

    Pagal `ISO 8601`_ standartą, data gali būti pateikta tokia forma::

        YYYY-MM-DD[*HH[:MM[:SS[.fff[fff]]]][+HH:MM[:SS[.ffffff]]]]

    Simbolis `*` reiškia, kad galima pateikti bet kokį vieną simbolį,
    dažniausiai naudojamas tarpo simbolis, arba raidė `T`.

    :data:`property.ref` stulpelyje, nurodomas `datos ir laiko tikslumas`__
    sekundėmis. Tikslumą galima nurodyti laiko vienetais, pavyzdžiui `Y`,
    `D`, `S`, arba `5Y`, `10D`, `30S`. Visi duomenys turi atitikti vienodą
    tikslumą, tikslumas negali varijuoti. Galimi vienetų variantai:

    =======  ================
    Reikšmė  Prasmė
    =======  ================
    Y        Metai
    M        Mėnesiai
    Q        Metų ketvirčiai
    W        Savaitės
    D        Dienos
    H        Valandos
    T        Minutės
    S        Sekundės
    L        Milisekundės
    U        Mikrosekundės
    N        Nanosekundžės
    =======  ================

    .. __: https://www.w3.org/TR/vocab-dcat-2/#Property:dataset_temporal_resolution


    **Brandos lygis**

    :1:
        - Data ir laikas pateikti naudojant skirtingus formatus, pavyzdžiui
          `2020-01-31`, `01/31/2020`, `31.1.20`.

        - Data ir laikas pateikti laisvu tekstu, pavyzdžiui `2020 paskutinę
          pirmo mėnesio dieną`.

    :2:
        - Duomenys pateikti nesatandartiniu formatu, tačiau visi duomenys
          pateikti vienodu formatu. Pavyzdžiui visi duomenys pateikti
          `01/31/2020` formatu.

    :3:
        - Duomenys pateikti standartiniu `ISO 8601`_ formatu.

        - Nenurodytas :data:`property.ref`, kuriame turėtu būti pateiktas
          duomenų tikslumas.


.. describe:: date

    Tas pats kas `datetime` tik dienos tikslumu. Šio tipo reikšmės taip pat
    turi atitikti `ISO 8601`_::

        YYYY-MM-DD

    Jei norima nurodyti datą žemesnio nei dienos tikslumo, tada vietoj mėnesio
    ir dienos galima naudoti `01` ir :data:`property.ref` stulpelyje nurodyti
    tikslumą:

    =======  ================
    Reikšmė  Prasmė
    =======  ================
    Y        Metai
    M        Mėnesiai
    Q        Metų ketvirčiai
    W        Savaitės
    D        Dienos
    =======  ================

.. describe:: time

    Dienos laikas, be konkrečios datos. Šio tipo reikšmės, kaip ir kiti
    su laiku sisję tipai turi atitikti `ISO 8601`_::

        HH[:MM[:SS[.fff[fff]]]][+HH:MM[:SS[.ffffff]]]

    Jei norima nurodyti žemesnio nei sekundžių tikslumo laiką, tada
    vietoj minučių ir/ar sekundžių galima naudoti `00` ir
    :data:`property.ref` stulpelyje nurodyti tikslumą:

    =======  ================
    Reikšmė  Prasmė
    =======  ================
    H        Valandos
    T        Minutės
    S        Sekundės
    L        Milisekundės
    U        Mikrosekundės
    N        Nanosekundžės
    =======  ================

.. describe:: temporal

    Apibrėžtis laike.

    Šis tipas atitinka `datetime`, tačiau nurodo, kad visas model yra
    apibrėžtas laike, būtent pagal šią savybę. Tik viena model savybė gali
    turėti `temporal` tipą. Pagal šios savybės reikšmes apskaičiuojamas ir
    įvertinamas `dct:temporal`_.

    .. _dct:temporal: https://www.w3.org/TR/vocab-dcat-2/#Property:dataset_temporal


.. _spatial-types:

Erdviniai duomenys
==================

.. describe:: geometry

    Erdviniai duomenys. Duomenys pateikiami WKT_ formatu, naudojant EPSG_
    duomenų bazės parametrus, skirtingoms projekcijoms išreikšti.

    .. _WKT: https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry
    .. _EPSG: https://epsg.org/home.html
    .. _WKB: https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry#Well-known_binary

    :data:`property.ref` stulpelyje nurodomas tikslumas metrais. Tikslumą
    galima pateikti naudojanti SI vienetus, pavyzdžiui `m`, `km` arba `10m`,
    `100km`.

    `geometry` tipas gali turėti du argumentus `geometry(form, crs)`:

    - `form` - geometrijos forma
    - `crs` - koordinačių sistema

    Pats tipas gali būti pateiktas vienu iš šių variantų:

    - `geometry(form, crs)` - nurodant formą ir koordinačių sistemą
    - `geometry(crs)` - nurodant tik koordinačių sistemą
    - `geometry(form)` - nurodant tik formą
    - `geometry` - be argumentų.

    **Geometrijos forma** (`form`)

    Galimi tokie geometrijos tipai:

    - `point` - taškas.
    - `linestring` - linija.
    - `polygon` - daugiakampis (pradžios ir pabaigos taškai **turi** sutapti).
    - `multipoint` - keli taškai.
    - `multilinestring` - kelios linijos.
    - `multipolygon` - keli daugiakampiai (kiekvieno daugiakampio pradžios ir pabaigos taškai **turi** sutapti).

    Kiekviena iš formų gali turėti tokias galūnes nurodančias papildomą dimensiją:

    - `z` - aukštis.
    - `m` - pasirinktas matmuo (pavyzdžiui laikas, atstumas, storis ir pan.)
    - `zm` - aukštis ir pasirinktas matmuo.

    Jei geometrijos forma nenurodyta, tada duomenys gali būti bet kokios
    geometrinės formos. Jei forma nurodyta, tada visi duomenys turi būti tik
    tokios formos, kokia nurodyta.

    **Koordinačių sistema** (`crs`)

    Antrasis `geometry` argumentas nurodomas pateikiant SRID_ numerį, kuris yra
    konkrečios koordinačių sistemos identifikacinis numeris EPSG_ duomenų
    bazėje. Jei koordinačių sistemos numeris nenurodytas, tuomet daroma
    prielaida, kad erdviniai duomenys atitinka `4326` (WGS84_) koordinačių
    sistemą.

    .. _SRID: https://en.wikipedia.org/wiki/Spatial_reference_system#Identifier

    Svarbu, kad pateikiant duomenis, koordinačių ašių eiliškumas atitiktų tokį
    eiliškumą, kuris nurodytas EPSG_ parametrų duomenų bazėje, konkrečiai
    koordinačių sistemai, kuria pateikiami duomenys.

    Pilną SRID_ kodų sąrašą galite rasti `epsg.io`_ svetainėje. Keletas
    dažniau naudojamų SRID_ kodų:

    .. _epsg.io: https://epsg.io/

    ======  ==========================  =======  ==================   =======  ==================  =========
    \                                   ašis #1                       ašis #2
    ------  --------------------------  ---------------------------   ---------------------------  ---------
    SRID    CRS                         kryptis  žymėjimas            kryptis  žymėjimas           vienetai
    ======  ==========================  =======  ==================   =======  ==================  =========
    `4326`  `WGS84`_                    šiaurė   latitude (platuma)   rytai    longitude (ilguma)  laipsniai
    `3346`  `LKS94`_                    šiaurė   x (abscisė)          rytai    y (ordinatė)        metrai
    `3857`  `WGS84 / Pseudo-Mercator`_  rytai    x (abscisė)          šiaurė   y (ordinatė)        metrai
    `4258`  `ETRS89`_                   šiaurė   latitude (platuma)   rytai    longitude (ilguma)  laipsniai
    ======  ==========================  =======  ==================   =======  ==================  =========

    .. _WGS84: https://epsg.io/4326
    .. _LKS94: https://epsg.io/3346
    .. _WGS84 / Pseudo-Mercator: https://epsg.io/3857
    .. _ETRS89: https://epsg.io/4258

    *Atkreipkite dėmesį, kad LKS94 koordinačių sistemoje geometrinės ašys
    neatitinka matematinių ašių ir yra sukeistos vietomis. Įprastai šiaurė ir y
    ašis yra viršuje, tačiau LKS94 atveju šiaurėje yra x ašis.*

        Ašinio meridiano projekcija yra abscisių (x) ašis. Šios ašies
        teigiamoji kryptis nukreipta į šiaurę. Ordinačių (y) ašies teigiamoji
        kryptis nukreipta į rytus.

        -- https://www.e-tar.lt/portal/lt/legalAct/TAR.6D575923F94A

    Prieš publikuojant duomenis, galite pasitikrinti, ar koordinačių ašys
    pateikiamos teisinga tvarka, naudotami taško atvaizdavimo įrankį.

    Pavyzdžiui, norint patikrinti Vilniaus Katedros varpinės bokšto taško
    koordinates, LKS94 (EPSG:3346) sistemoje, galite naršyklės adreso juostoje
    pateikti šį adresą:

    https://get.data.gov.lt/_srid/3346/6061789/582964

    Jei ašių eiliškumas teisingas, gausite tašką ten kur tikėjotės, jei ašys
    sukeistos vietomis, tada taškas žemėlapyje gali būti visai kitoje vietoje,
    nei tikėjotės.

    Adreso formatas::
    
        /_srid/{srid}/{ašis1}/{ašis2}

    - `{srid}` - EPSG_ duomenų bazėje esančios koordinačių sistemos SRID_ kodas
    - `{ašis1}` - pirmosios ašies reikšmė (kryptis priklauso nuo `{srid}`)
    - `{ašis2}` - antrosios ašies reikšmė (kryptis priklauso nuo `{srid}`)


    **Pavyzdžiai** (strukūros aprašas)

    - `geometry` - WGS84 projekcijos, bet kokio  tipo geometriniai objektai.
    - `geometry(3346)` - LKS94 projekcijos, bet kokio tipo geometriniai
      objektai.
    - `geometry(point)` - GWS84 projekcijos, bet `point` tipo geometriniai
      objektai.
    - `geometry(linestringm, 3345)` - LKS94 projekcijos, `linestringm` tipo
      geometriniai objektai su pasirinktu matmeniu, kaip trečia dimensija.


    **Pavyzdžiai** (duomenys)

    Vilniaus Katedros varpinės bokšto taškas, LKS94 (EPSG:3346) koordinačių sistemoje::

        POINT (6061789 582964)


    **Brandos lygis**

    :1:
        - Nenurodytas koordinačių sistema ir duomenys pateikti skirtingomis
          koordinatėmis.

        - Sumaišytos ašys, pavyzdžiui vieni duomenys pateikiami x, y, kiti y, x.

        - Sumaišyti vienetai, pavyzdžiui vieni duomenys pateikti metrais, kiti
          laipsniais.

        - Pateiktas adresas, nenurodant adreso koordinačių.

    :2:
        - Nenurodyta koordinačių sistema, tačiau visi duomenys pateikti
          naudojant vienodą koordinačių sistemą.

    :3:
        - Nenurodytas :data:`property.ref`, kuriame turėtu būti pateiktas
          duomenų tikslumas metrais.



.. describe:: spatial

    Apibrėžtis erdvėje.

    Šis tipas atitinka `geometry`, tačiau nurodo, kad visas model yra
    apibrėžtas erdvėje, būtent pagal šią savybę.  Tik viena model savybė
    gali turėti `spatial` tipą. Pagal šios savybės reikšmes apskaičiuojamas ir
    įvertinamas `dct:spatial`_.

    .. _dct:spatial: https://www.w3.org/TR/vocab-dcat-2/#Property:dataset_spatial


Valiuta
=======

.. describe:: currency

    Valiuta. Saugomas valiutos kiekis, nurodant tiek sumą, tiek valiutos
    kodą naudojant `ISO 4217`_ kodus.

    Valiutos kodas nurodomas :data:`property.ref` stulpelyje.

    .. _ISO 4217: https://en.wikipedia.org/wiki/ISO_4217

    Pavyzdys:

    ==  ==  ==  ==  ==============  ========  ===  ==============
    d   r   b   m   property        type      ref  source        
    ==  ==  ==  ==  ==============  ========  ===  ==============
    example                                                      
    ------------------------------  --------  ---  --------------
    \           Product                            PRODUCT       
    --  --  --  ------------------  --------  ---  --------------
    \               price           currency  EUR  PRICE         
    ==  ==  ==  ==  ==============  ========  ===  ==============

    Jei valiutos suma ir pavadinimas saugomi atskirai, tuomet valiutą galima
    aprašyti taip:

    ==  ==  ==  ==  ===============  ========  ===  ==============
    d   r   b   m   property         type      ref  source        
    ==  ==  ==  ==  ===============  ========  ===  ==============
    example                                                       
    -------------------------------  --------  ---  --------------
    \           Product                             PRODUCT       
    --  --  --  -------------------  --------  ---  --------------
    \               price            currency       
    \               price._value                    PRICE
    \               price._currency                 CURRENCY_CODE
    ==  ==  ==  ==  ===============  ========  ===  ==============


Failai
======

.. describe:: file

    Šis duomenų tipas yra sudėtinis, susidedantis iš tokių duomenų:

    id
        Laukas, kuris unikaliai identifikuoja failą, šis laukas duomenų
        saugojimo metu pavirs failo identifikatoriumi, jam suteikiant unikalų
        UUID.

    name
        Failo pavadinimas.

    type
        Failo `media tipas`__.

        __ https://en.wikipedia.org/wiki/Media_type

    size
        Failo turinio dydis baitais.

    content
        Failo turinys.

    Šiuos metaduomenis galima perduoti `file()` funkcijai, kai vardinius
    argumentus. Pavyzdžiui:

    ==  ==  ==  ==  ==============  ======  ==============  =======  =======
    d   r   b   m   property        type    source          prepare  access
    ==  ==  ==  ==  ==============  ======  ==============  =======  =======
    datasets/example
    ------------------------------  ------  --------------  -------  -------
    \           Country
    --  --  --  ------------------  ------  --------------  -------  -------
    \               name            string  NAME                     open
    \               flag_file_name  string  FLAG_FILE_NAME           private
    \               flag_file_data  binary  FLAG_FILE_DATA           private
    \               flag            file                    |file|   open
    ==  ==  ==  ==  ==============  ======  ==============  =======  =======

    .. |file| replace:: file(name: flag_file_name, content: flag_file_data)

    Šiame pavyzdyje, iš `flag_file_name` ir `flag_file_data` laukų padaromas
    vienas `flag` laukas, kuriame panaudojami duomenys iš dviejų laukų.
    Šiuo atveju, `flag_file_name` ir `flag_file_data` laukai tampa
    pertekliniais, todėl :data:`access` stulpelyje jie pažymėti `private`.

    Analogiškai, tokius pačius duomenis galima aprašyti ir nenaudojant
    formulių:

    ==  ==  ==  ==  ==============  ======  ==============  =======  =======
    d   r   b   m   property        type    source          prepare  access
    ==  ==  ==  ==  ==============  ======  ==============  =======  =======
    datasets/example
    ------------------------------  ------  --------------  -------  -------
    \           Country
    --  --  --  ------------------  ------  --------------  -------  -------
    \               name            string  NAME                     open
    \               flag            file                             open
    \               flag._name              FLAG_FILE_NAME           open
    \               flag._content           FLAG_FILE_DATA           open
    ==  ==  ==  ==  ==============  ======  ==============  =======  =======


.. describe:: image

    Paveiksliukas. `image` tipas turi tokias pačias savybes kaip `file`
    tipas.


.. _ref-types:

Išoriniai raktai
================

Taip pat žiūrėkite: :ref:`ryšiai`.

Išoriniai raktai iš dalies yra panašūs į sudėtinius tipus, kadangi laukas,
kuris rodo į kitą objektą, yra traktuojamas, kaip kitas objektas.


.. describe:: ref

    Ryšys su modeliu. Šis tipas naudojamas norint pažymėti, kad lauko
    reikšmė yra :data:`property.ref` stulpelyje nurodyto modelio objektas.

    Pagal nutylėjimą, jungimas su kito modelio objektais daromas per siejamo
    pirminį raktą (:data:`model.ref`), tačiau yra galimybė nurodyti ir kitą,
    nebūtinai pirminį raktą.

    Jei jungimas daromas, ne per pirminį raktą, tuomet, laukai per kuriuos
    daromas jungimas nurodomi :data:`property.ref` stulpelyje laužtiniuose
    sklaustuose, pavyzdžiui::

        Country[code]

    Čia jungiama su `Country` modeliu, per `Country` modelio `code` duomenų
    lauką.

    Jei laukas, per kurį daromas jungimas nenurodytas, pavyzdžiui::

        Country

    Tada, jungimas daromas per `Country` modelio pirminį raktą, kuris nurodytas
    :data:`model.ref` stulpelyje.


    Šio objekto reikšmės yra pateikiamos, kaip dalis objekto į kurį rodoma. Jei
    `ref` tipo lauko brandos lygis (:data:`property.level`) yra 4 ar didesnis,
    tuomet šio duomenų tipo reikšmės atrodo taip:

    .. code-block:: json

        {"_id": "69c98b0f-9e4e-424b-9575-9f601d79b68e"}

    Jei brandos lygis (:data:`property.level`) yra žemesnis nei 4, tada reikšmė
    atrodo taip:

    .. code-block:: json

        {"id": "69c98b0f-9e4e-424b-9575-9f601d79b68e"}

    Čia `id` yra :data:`model.ref` arba kitas laukas, per kurį daromas
    jungimas.

.. describe:: backref

    Atgalinis ryšys su modeliu.

    Šis tipas naudojamas norint pažymėti, kad tam tikras kitas modelis turi
    `ref` tipo lauką, kuris rodo į šį modelį. Šis laukas pats duomenų
    neturi, tai tik papildomas metaduomuo, padedantis geriau suprasti ryšius
    tarp modelių.

    Taip pat žiūrėkite :ref:`atgalinis-ryšys`.

.. describe:: generic

    Dinaminis ryšys su modeliu.

    Šis tipas naudojamas tada, kai yra poreikis perteikti dinaminį ryšį, t.
    y. duomenys siejami ne tik pagal id, bet ir pagal modelio pavadinimą.
    Tokiu būdu, vieno modelio laukas gali būti siejamas su keliais
    modeliais.

    Taip pat žiūrėkite :ref:`polimorfinis-ryšys`.

    Šis duomenų tipas yra sudėtinis, susidedantis iš tokių duomenų:

    object_model
        Pilnas modelio pavadinimas, su kuriuo yra siejamas objektas.

    object_id
        `object_model` modelio objekto id.


.. _sudėtiniai-tipai:

Sudėtiniai tipai
================

.. describe:: object

    Kompozicinis tipas.

    Šis tipas naudojamas apibrėžti sudėtiniams duomenims, kurie aprašyti
    naudojant kelis skirtingus tipas. Kompozicinio tipo atveju property
    stulpelyje komponuojami pavadinimai atskiriami taško simboliu.

    Sudarant duomenų modelį, rekomenduojama laikytis plokščios struktūros ir
    komponavimą įgyvendinti siejant modelius per `ref` ar `generic` tipus.

.. describe:: array

    Masyvas.

    Šis tipas naudojamas apibrėžti duomenų masyvams. Jei masyvo elementai
    turi vienodus tipus, tada elemento tipas pateikiamas property pavadinimo
    gale prirašant [] sufiksą, kuris nurodo, kad aprašomas ne pats masyvas,
    o masyvo elementas.

    Rekomenduojama vengti naudoti šį tipą, siekiant išlaikyti plokščią
    duomenų modelį. Vietoje `array` tipo rekomenduojama naudoti `backref`.


.. _other-types:

Kiti tipai
==========

.. describe:: url

    Unikali resurso vieta (URL) (angl. *Uniform Resource
    Locator*).

    Šis tipas naudojamas pateikiant nuorodas į išorinius šaltinius.

    https://en.wikipedia.org/wiki/Uniform_Resource_Locator


.. describe:: uri

    Unikalus resurso identifikatorius (URI) (angl. *Uniform Resource
    Identifier*).

    Šis tipas naudojamas tais atvejais, kai pateikiamas išorinio resurso
    identifikatorius.

    https://en.wikipedia.org/wiki/Uniform_Resource_Identifier
