.. default-role:: literal
.. _level:

Brandos lygiai
==============

Duomenų brandos lygis nurodomas :data:`level` stulpelyje.

Duomenų brandos lygis atitinka `5 ★ Open Data`_ skalę, tačiau adaptuota duomenų
struktūros aprašo kontekstui. Papildomai įtrauktas nulinis lygis, kai duomenys
nekaupiami, tačiau yra reikalingi ir yra parengtas jų :term:`duomenų struktūros
aprašas <DSA>`.

.. _5 ★ Open Data: https://5stardata.info/

Tim Berners Lee brandos lygius aprašo, kaip pavyzdį pasitelkiant duomenų
distribucijų formatus. Tačiau duomenų distribucijų formatai yra labai
netikslus pavyzdys. Rengiant duomenų struktūros aprašą, brandos lygis
vertinamas kiekvienam duomenų laukui atskirai, todėl tarkime CSV failas, gali
būti didesnio arba mažesnio nei trečias brandos lygis, priklausomai nuo CSV
faile esančių duomenų turinio. Tačiau grubiai vertinant, vidutiniškai CSV
failai turi daugiau ar mažiau 3 brandos lygį, koks ir yra nurodytas Tim
Berners Lee pavyzdžiuose.

Taip pat reikėtų atkreipti dėmesį, kad duomenų brandos lygis ar formatas nėra
susijęs su duomenų atvirumu. Duomenys gali būti pateikti aukščiausiu 5
brandos lygiu, tačiau pats duomenų prieinamumas gali būti visiškai uždaras,
siauram naudotojų ratui, kurie turi ribotą ir saugų prieigos kanalą prie
duomenų.

Rengiant duomenų struktūros aprašą, reikėtų nurodyti ne šaltinio duomenų
brandos lygį, o galutinį brandos lygį, kuris yra gaunamas atlikus visas
duomenų struktūros apraše nurodytas transformacijas.


.. describe:: level

    .. describe:: 0

        **Nekaupiama**

        Duomenys nekaupiami. Duomenų rinkinys užregistruotas atvirų duomenų
        portale. Užpildyta :data:`dataset` eilutė.

        Plačiau apie brandos lygio kėlimą skaitykite skyriuje :ref:`to-level-0`.

        **Pavyzdžiai**

        ========== ===================
        Imone                         
        ------------------------------
        imones_id  imones_pavadinimas 
        ========== ===================
        42         UAB "Įmonė"        
        ========== ===================

        ============= ========= ========== ======================= =======
        Filialas                                                  
        ------------------------------------------------------------------
        ikurimo_data  atstumas  imones_id  imones_pavadinimas._id  tel_nr
        ============= ========= ========== ======================= =======
        ============= ========= ========== ======================= =======

        == == == == ====================== ======== =========== ======
        Struktūros aprašas                                            
        --------------------------------------------------------------
        d  r  b  m  property               type     ref         level 
        == == == == ====================== ======== =========== ======
        example                                                       
        ---------------------------------- -------- ----------- ------
        \        Imone                              imones_id   4     
        -- -- -- ------------------------- -------- ----------- ------
        \           imones_id              integer              4     
        \           imones_pavadinimas     string               2     
        \        Filialas                                       0     
        -- -- -- ------------------------- -------- ----------- ------
        \           ikurimo_data           string               0     
        \           atstumas               string               0     
        \           imone                  ref      Imone       0     
        \           tel_nr                 string               0     
        == == == == ====================== ======== =========== ======

        - **Duomenų nėra** - nuliniu brandos lygiu žymimi duomenys, kurių nėra,
          pavyzdžiui jei įmonės filialų duomenų niekas nefiksuoja.

        - **Duomenys nepublikuojami** - nuliniu brandos lygiu žymimi duomenys,
          kurie fiziškai egzistuoja, tačiau nėra publikuojami jokia forma.

        - **Ribojamas duomenų naudojimas** - nuliniu brandos lygiu žymimi
          duomenys, kuri yra prieinami, tačiau pagal tokias naudojimo sąlygas,
          kurios nėra suderinamos su atvirų duomenų licencijomis.

    .. describe:: 1

        **Publikuojama**

        Duomenys publikuojami bet kokia forma. Užpildyta :data:`resource`
        eilutė.

        Plačiau apie brandos lygio kėlimą skaitykite skyriuje :ref:`to-level-1`.

        Pirmu brandos lygiu žymimi duomenų laukai, kurių reikšmės neturi
        vientisumo, tarkime ta pati reikšmė gali būti pateikta keliais
        skirtingais variantais.

        **Pavyzdžiai**

        ========== ===================
        Imone                         
        ------------------------------
        imones_id  imones_pavadinimas 
        ========== ===================
        42         UAB "Įmonė"        
        ========== ===================

        ==================== ========= ============== =================== ===============
        Filialas                                                      
        ---------------------------------------------------------------------------------
        ikurimo_data         atstumas  imones_id._id  imones_pavadinimas  tel_nr  
        ==================== ========= ============== =================== ===============
        vakar                1 m.      1              Įmonė 1             +370 345 36522
        2021 rugpjūčio 1 d.  1 m       1              UAB Įmonė 1         8 345 36 522
        1/9/21               1 metras  1              Įmonė 1, UAB        (83) 45 34522
        21/9/1               0.001 km  1              „ĮMONĖ 1“, UAB      037034536522
        ==================== ========= ============== =================== ===============

        == == == == ===================== ========= =========== =====
        Struktūros aprašas
        -------------------------------------------------------------
        d  r  b  m  property              type      ref         level
        == == == == ===================== ========= =========== =====
        example                                                  
        --------------------------------- --------- ----------- -----
        \        Imone                              id          4
        -- -- -- ------------------------ --------- ----------- -----
        \           imones_id             integer               2
        \           imones_pavadinimas    string                2
        \        Filialas                                       3
        -- -- -- ------------------------ --------- ----------- -----
        \           ikurimo_data          string                1
        \           atstumas              string                1
        \           imones_id             ref       Imone       1
        \           imones_pavadinimas    string                1
        \           tel_nr                string                1
        == == == == ===================== ========= =========== =====

        - **Neaiški struktūra** - pirmu brandos lygiu žymimi duomenys, kuriuose
          nėra aiškios struktūros, pavyzdžiui `ikurta` datos formatas nėra
          vienodas, kiekviena data užrašyta vis kitokiu formatu.

        - **Nėra vientisumo** - pirmu brandos lygiu žymimi duomenuys, kuruose
          nėra vientisumo, pavyzdžiui `atstumas` užrašytas laikantis tam tikros
          struktūros, tačiau skirtingais vienetais.

        - **Neįmanomas jungimas** - pirmu brandos lygiu žymimi
          duomenys, kurių neįmanoma arba sudėtinga sujungti. Pavyzdžiui
          `Filialas` duomnų laukas `imone` naudoja tam tikrą identifikatorių,
          kuris nesutampa nei su vienu iš `Imone` atributų, pagal kuriuose būtų
          galima identifikuoti filialo įmonę.

    .. describe:: 2

        **Struktūruota**

        Duomenys kaupiami struktūruota, mašininiu būdu nuskaitoma forma, bet
        kokiu formatu. Užpildytas :data:`property.source` stulpelis.

        Plačiau apie brandos lygio kėlimą skaitykite skyriuje :ref:`to-level-2`.

        Antru brandos lygiu žymimi duomenų laukai, kurie pateikti vieninga
        forma arba pagal aiškų ir vienodą šabloną. Tačiau pateikimo būdas nėra
        standartinis. Nestandartinis duomenų formatas yra toks, kuris neturi
        viešai skelbiamos ir atviros formato specifikacijos arba kuris nėra
        priimtas kaip standartas, kurį prižiūri tam tikra standartizacijos
        organizacija.

        **Pavyzdžiai**

        ========== ===================
        Imone                         
        ------------------------------
        imones_id  imones_pavadinimas 
        ========== ===================
        42         UAB "Įmonė"        
        ========== ===================

        ============= ========= ========== ======================= ================
        Filialas                                                  
        ---------------------------------------------------------------------------
        ikurimo_data  atstumas  imones_id  imones_pavadinimas._id  tel_nr  
        ============= ========= ========== ======================= ================
        1/9/21        1 m.      1          UAB "Įmonė"             (83\) 111 11111
        2/9/21        2 m.      1          UAB "Įmonė"             (83\) 222 22222
        3/9/21        3 m.      1          UAB "Įmonė"             (83\) 333 33333
        4/9/21        4 m.      1          UAB "Įmonė"             (83\) 444 44444
        ============= ========= ========== ======================= ================

        == == == == ===================== ========= ========== =====
        Struktūros aprašas                                     
        ------------------------------------------------------------
        d  r  b  m  property              type      ref        level
        == == == == ===================== ========= ========== =====
        example                                                 
        --------------------------------- --------- ---------- -----
        \        JuridinisAsmuo                     kodas      4
        -- -- -- ------------------------ --------- ---------- -----
        \           kodas                 integer              4
        \           pavadinimas\@lt       text                 4
        \        Imone                              imones_id  2
        -- -- -- ------------------------ --------- ---------- -----
        \           imones_id             integer              2
        \           imones_pavadinimas    string               2
        \     /                                                                                
        -- -- -- ------------------------ --------- ---------- -----
        \        Filialas                                      3
        -- -- -- ------------------------ --------- ---------- -----
        \           ikurimo_data          string               2
        \           atstumas              string               2
        \           imones_id             integer              2
        \           imones_pavadinimas    string               2
        \           tel_nr                string               2
        == == == == ===================== ========= ========== =====

        - **Nestandartiniai duomenų tipai** - antru brandos lygiu žymimi duomenys,
          kurių nurodytas tipas neatitinka realaus duomenų tipo. Pavyzdžiui:

          - `ikurimo_data` - nurodytas `string`, turėtu būti `date`.
          - `imones_pavadinimas` - nurodytas `string`, turėtu būti `text`.
          - `atstumas` - nurodytas `string`, turėtu būti `integer`.

        - **Nestandartinis formatas** - antru brandos lygiu žymimi duomenys,
          kurie pateikti nestandartiniu formatu. Standartinis duomenų
          pateikimas nurodytas prie kiekvieno duomenų tipo skyriuje
          :ref:`duomenų-tipai`. Payvzdžiui:

          - `ikurimo_data` - nurodytas `DD/MM/YY`, turėtu būti `YYYY-MM-DD`.
          - `atstumas` - nurodyta `X m.`, turėtu būti `X`.
          - `tel_nr` - nurodytas `(XX) XXX XXXXX`, turėtu būti
            `+XXX-XXX-XXXXX`.

        - **Nestandartiniai kodiniai pavadinimai** - antru brandos lygiu žymimi
          duomenys, kurių kodiniai pavadinimai, neatitinka :ref:`standartinių
          reikalavimų keliamų kodiniams pavadinimams <kodiniai-pavadinimai>`.
          Pavyzdžiui:

          - `imones_id` - dubliuojamas modelio pavadinimas, turėtu būti `id`.
          - `imones_pavadinimas` - dubliuojamas modelio pavadinimas, turėtu
            būti `pavadinimas`.
          - `ikurimo_data` - dubliuojamas tipo pavadinimas, turėtu būti
            `ikurta`.

        - **Nepatikimi identifikatoriai** - antru brandos lygiu žymimi
          duomenys, kurių `ref` tipui naudojami nepatikimi identifikatoriai,
          pavyzdžiui tokie, kaip pavadinimai, kurie gali keistis arba kartotis.
          Pavyzdžiui:

          - `imones_pavadinimas` - jungimas daromas per įmonės pavadinimą,
            tačiau šiuo atveju kito varianto nėra, nes `Filialas.imones_id`
            nesutampa su `Imone.imones_id`.

        - **Denormalizuoti duomenys** - antru brandos lygiu žymimi duomenys,
          kurie dubliuoja kito modelio duomenis ir yra užrašyti nenurodant, kad
          tai yra duomenys dubliuojantys kito modelio duomenis. Pavyzdžiui:

          - `Filialas.imones_id` turėtu būti `Filialas.imone.imones_id`.
          - `Filialas.imones_pavadinimas` turėtu būti
            `Filialas.imone.imones_pavadinimas`.

          Plačiau apie denormalizuotus duomenis skaitykite skyriuje
          :ref:`ref-denorm`.

        - **Nenurodytas susiejimas** - antru brandos lygiu žymimi duomenys,
          kurie siejasi su kitu modeliu, tačiau tokia informacija nėra pateikta
          metaduomenyse. Pavyzdžiui:

          - `Filialas.imone` - `Filialas` siejasi su `Imone`, per
            `Filialas.imones_pavadiniams`, todėl turėtu būti nurodytas `imone
            ref Imone` ryšys su `Imone`.

        - **Neatitinka modelio bazės** - antru brandos lygiu žymimi duomenys,
          kurie priklauso vienai semantinei klasei, tačiau duomenų schema
          nesutampa su bazinio modelio schema. Pavyzdžiui:

          - `Imone` - priklauso semantinei klasei `JuridinisAsmuo`, tačiau tai
            nėra pažymėta metaduomenyse.
          - `Imone.imones_id` turėtu būti `Imone.kodas`, kad sutaptu su baze
            (`JuridinisAsmuo.kodas`).
          - `Imone.imones_pavadinimas` turėtu būti `Imone.pavadinimas@lt`, kad
            sutaptu su baze (`JuridinisAsmuo.pavadinimas@lt`).

    .. describe:: 3

        **Standartizuota**

        Duomenys saugomi atviru, standartiniu formatu. Užpildytas
        :data:`property.type` stulpelis ir duomenys atitinka nurodytą tipą.

        Plačiau apie brandos lygio kėlimą skaitykite skyriuje :ref:`to-level-3`.

        Trečias brandos lygis suteikiamas tada, kai duomenys pateikti vieninga
        forma, vieningu masteliu, naudojamas formatas yra standartinis, tai
        reiškia, kad yra viešai skelbiama ir atvira formato specifikacija arba
        pats formatas yra patvirtintas ir prižiūrimas kokios nors
        standartizacijos organizacijos.

        **Pavyzdžiai**

        ===== ================
        Imone                                                       
        ----------------------
        id    pavadinimas\@lt 
        ===== ================
        42    UAB "Įmonė"
        ===== ================

        =========== ========= ========== ====================== =============
        Filialas                                         
        ---------------------------------------------------------------------
        ikurta      atstumas  imone._id  imone.pavadinimas\@lt  tel_nr  
        =========== ========= ========== ====================== =============
        2021-09-01  1         42         UAB "Įmonė"            +37011111111
        2021-09-02  2         42         UAB "Įmonė"            +37022222222
        2021-09-03  3         42         UAB "Įmonė"            +37033333333
        2021-09-04  4         42         UAB "Įmonė"            +37044444444
        =========== ========= ========== ====================== =============

        == == == == ===================== ========= =========== =====
        Struktūros aprašas
        -------------------------------------------------------------
        d  r  b  m  property              type      ref         level
        == == == == ===================== ========= =========== =====
        example                                                  
        --------------------------------- --------- ----------- -----
        \        JuridinisAsmuo                     kodas       4
        -- -- -- ------------------------ --------- ----------- -----
        \           kodas                 integer               4
        \           pavadinimas\@lt       text                  4
        \     JuridinisAsmuo                                    4
        -- -- --------------------------- --------- ----------- -----
        \        Imone                              kodas       4
        -- -- -- ------------------------ --------- ----------- -----
        \           kodas                                       4
        \           pavadinimas\@lt                             4
        \     /                                                                                
        -- -- --------------------------- --------- ----------- -----
        \        Filialas                                       3
        -- -- -- ------------------------ --------- ----------- -----
        \           ikurta                date                  3
        \           atstumas              integer               3
        \           imone                 ref       Imone       3
        \           imone.kodas                                 4
        \           imone.pavadinimas\@lt                       4
        \           tel_nr                string                4
        == == == == ===================== ========= =========== =====

        - **Nenurodytas pirminis raktas** - trečiu brandos lygiu žymimi
          duomenys, kurie neturi nurodyto pirminio rakto :data:`model.ref`
          stulpelyje. Pavyzdžiui:

          - `Filialas` - nenurodytas pirminis raktas :data:`model.ref`
            stulpelyje.

        - **Nenurodyt vienetai** - trečiu brandos lygiu žymimi kiekybiniai
          duomenys, kuriems nėra nurodyti matavimo vienetai
          :data:`property.ref` stulpelyje. Pavyzdžiui:

          - `atstumas` - nenurodyta, kokiais vienetais matuojamas atstumas.

        - **Nenurodyti tikslumas** - trečiu brandos lygiu žymimi laiko ir
          erdviniai duomenys, kuriems nėra nurodytas matavimo tikslumas.
          Matavimo tikslumas nurodomas `property.ref` stulpelyje. Pavyzdžiui:

          - `ikurta` - nenurodytas datos tikslumas, turėtu būti `D` - vienos
            dienos tiksumas.

        - **Siejimas ne per priminį raktą** - trečiu brandos lygiu žymimi `ref`
          tipo duomenų laukai, kurie siejami ne per perminį raktą `_id`, o per
          kitą identifikatorių. Pavyzdžiui:

          - `Filialas.imone` - siejimas atliekamas per `Imone.kodas`, o ne per
            `Imone._id`.

    .. describe:: 4

        **Identifikuojama**

        Duomenų objektai turi aiškius, unikalius identifikatorius. Užpildyti
        :data:`model.ref` ir :data:`property.ref` stulpeliai.

        .. note::

            :data:`property.ref` stulpelis pildomas šiais atvejais:

            - Jei duomenų laukas yra išorinis raktas (žiūrėti :ref:`ref-types`).

            - Jei duomenų laukas yra kiekybinis ir turi matavimo vienetus
              (žiūrėti :ref:`matavimo-vienetai`).

            - Jei duomenų laukas žymi laiką ar vietą (žiūrėti
              :ref:`temporal-types` ir :ref:`spatial-types`).

        Plačiau apie brandos lygio kėlimą skaitykite skyriuje :ref:`to-level-4`.

        Ketvirtas duomenų brandos lygis labiau susijęs ne su pačių duomenų
        formatu, bet su metaduomenimis, kurie lydi duomenis.

        Duomenų struktūros apraše :data:`model.ref` stulpelyje, pateikiamas
        objektą unikaliai identifikuojančių laukų sąrašas, o
        :data:`property.type` stulpelyje įrašomas `ref` tipas, kuris nurodo
        ryšį tarp dviejų objektų.

        **Pavyzdžiai**

        ===================================== ===== ================
        Imone                                                       
        ------------------------------------------------------------
        _id                                   id    pavadinimas\@lt 
        ===================================== ===== ================
        26510da5-f6a6-45b0-a9b9-27b3d0090a58  42    UAB "Įmonė"
        ===================================== ===== ================

        ===================================== === =========== ========= ===================================== ========= ====================== =============
        Filialas                                                                                                      
        ------------------------------------- --- ----------------------------------------------------------------------------------------------------------
        _id                                   id  ikurta      atstumas  imone._id                             imone.id  imone.pavadinimas\@lt  tel_nr       
        ===================================== === =========== ========= ===================================== ========= ====================== =============
        63161bd2-158f-4d62-9804-636573abb9c7  1   2021-09-01  1         26510da5-f6a6-45b0-a9b9-27b3d0090a58  42        UAB "Įmonė"            +37011111111
        65ec7208-fb97-41a8-9cfc-dfedd197ced6  2   2021-09-02  2         26510da5-f6a6-45b0-a9b9-27b3d0090a58  42        UAB "Įmonė"            +37022222222
        2b8cdfa6-1396-431a-851c-c7c6eb7aa433  3   2021-09-03  3         26510da5-f6a6-45b0-a9b9-27b3d0090a58  42        UAB "Įmonė"            +37033333333
        1882bb9e-73ee-4057-b04d-d4af47f0aae8  4   2021-09-04  4         26510da5-f6a6-45b0-a9b9-27b3d0090a58  42        UAB "Įmonė"            +37044444444
        ===================================== === =========== ========= ===================================== ========= ====================== =============

        == == == == ===================== ========= =========== =====
        Struktūros aprašas
        -------------------------------------------------------------
        d  r  b  m  property              type      ref         level
        == == == == ===================== ========= =========== =====
        example                                                  
        --------------------------------- --------- ----------- -----
        \        JuridinisAsmuo                     kodas       4
        -- -- -- ------------------------ --------- ----------- -----
        \           kodas                 integer               4
        \           pavadinimas\@lt       text                  4
        \     JuridinisAsmuo                                    4
        -- -- --------------------------- --------- ----------- -----
        \        Imone                              kodas       4
        -- -- -- ------------------------ --------- ----------- -----
        \           id                    integer               4
        \           pavadinimas\@lt       text                  4
        \     /                                                                                
        -- -- --------------------------- --------- ----------- -----
        \        Filialas                           id          4
        -- -- -- ------------------------ --------- ----------- -----
        \           id                    integer               4
        \           ikurta                date      D           4
        \           atstumas              integer   km          4
        \           imone                 ref       Imone       4
        \           imone.id                                    4
        \           imone.pavadinimas\@lt                       4
        \           tel_nr                string                4
        == == == == ===================== ========= =========== =====

        - **Nesusieta su standartiniu žodynu** - ketvirtu brandos lygiu žimimi
          duomenys, kurie nėra susieti su standartiniais žodynais ar
          ontologijomis. Siejimas su žodynais atliekamas `model.uri` ir
          `property.uri` stulpeluose.

    .. describe:: 5

        **Susieta su išoriniu žodynu**

        Modeliai iš įstaigų duomenų rinkinių vardų erdvės susieti su modeliais
        iš standartų vardų erdvės, užpildytas :data:`base` eilutė. Standartų
        vardų erdvėje esantiems :term:`modeliams <modelis>` ir jų
        :term:`savybėms <savybė>` užpildytas :data:`uri` stulpelis.

        Daugiau apie vardų erdves skaitykite skyrelyje: :ref:`vardų-erdvės`.

        Plačiau apie brandos lygio kėlimą skaitykite skyriuje :ref:`to-level-5`.

        Penkto brandos lygio duomenys yra lygiai tokie patys, kaip ir ketvirto
        brandos lygio, tačiau penktame brandos lygyje, duomenys yra praturtinami
        metaduomenimis, pateikiant nuorodas į išorinius žodynus arba bend jau
        pateikiant aiškius pavadinimus ir aprašymus, užpildant `title` ir
        `description` stulpelius.

        Penktame brandos lygyje visas dėmesys yra sutelkiamas yra semantinę
        duomenų prasmę.

        **Pavyzdžiai**

        ===================================== ===== ================
        Imone                                                       
        ------------------------------------------------------------
        _id                                   id    pavadinimas\@lt 
        ===================================== ===== ================
        26510da5-f6a6-45b0-a9b9-27b3d0090a58  42    UAB "Įmonė"
        ===================================== ===== ================

        ===================================== === =========== ========= ===================================== ========= ====================== =================
        Filialas                                                                                                      
        ------------------------------------- ------------------------------------------------------------------------------------------------------------------
        _id                                   id  ikurta      atstumas  imone._id                             imone.id  imone.pavadinimas\@lt  tel_nr           
        ===================================== === =========== ========= ===================================== ========= ====================== =================
        63161bd2-158f-4d62-9804-636573abb9c7  1   2021-09-01  1         26510da5-f6a6-45b0-a9b9-27b3d0090a58  42        UAB "Įmonė"            \tel:+37011111111
        65ec7208-fb97-41a8-9cfc-dfedd197ced6  2   2021-09-02  2         26510da5-f6a6-45b0-a9b9-27b3d0090a58  42        UAB "Įmonė"            \tel:+37022222222
        2b8cdfa6-1396-431a-851c-c7c6eb7aa433  3   2021-09-03  3         26510da5-f6a6-45b0-a9b9-27b3d0090a58  42        UAB "Įmonė"            \tel:+37033333333
        1882bb9e-73ee-4057-b04d-d4af47f0aae8  4   2021-09-04  4         26510da5-f6a6-45b0-a9b9-27b3d0090a58  42        UAB "Įmonė"            \tel:+37044444444
        ===================================== === =========== ========= ===================================== ========= ====================== =================

        == == == == ====================== ========= =========== ===== ============================
        Struktūros aprašas                                                                         
        -------------------------------------------------------------- ----------------------------
        d  r  b  m  property               type      ref         level uri                         
        == == == == ====================== ========= =========== ===== ============================
        example                                                                                    
        ---------------------------------- --------- ----------- ----- ----------------------------
        \                                  prefix    foaf              \http://xmlns.com/foaf/0.1/                            
        \                                            dct               \http://purl.org/dc/terms/
        \                                            schema            \http://schema.org/
        \        JuridinisAsmuo                       kodas      4                             
        -- -- -- ------------------------- --------- ----------- ----- ----------------------------
        \           kodas                  integer               4                             
        \           pavadinimas\@lt        text                  4                             
        \     JuridinisAsmuo                                     4                             
        -- -- ---------------------------- --------- ----------- ----- ----------------------------
        \        Imone                               id          5     foaf:Organization           
        -- -- -- ------------------------- --------- ----------- ----- ----------------------------
        \           id                                           5     dct:identifier                            
        \           pavadinimas\@lt                              5     dct:title                            
        \     /                                                                                
        -- -- ---------------------------- --------- ----------- ----- ----------------------------
        \        Filialas                            id          5     schema:LocalBusiness
        -- -- -- ------------------------- --------- ----------- ----- ----------------------------
        \           id                     date      1D          5     dct:identifier                            
        \           ikurta                 date      1D          5     dct:created                            
        \           atstumas               integer   km          5     schema:distance
        \           imone                  ref       Imone       5     foaf:Organization                            
        \           imone.id               integer               5     dct:identifier
        \           imone.pavadinimas\@lt  text                  5     dct:title                            
        \           tel_nr                 string                5     foaf:phone
        == == == == ====================== ========= =========== ===== ============================

