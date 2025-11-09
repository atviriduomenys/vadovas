.. default-role:: literal

.. _duomenu-teikimas:

Duomenų teikėjams
#################

VSSA pateikia sistemą, skirtą įgalinti Valstybines įstaigas dalintis duomenimis tarp savęs
vieningu `UDTS <https://ivpk.github.io/uapi/>`_ formatu.

Duomenų dalijimasis tarp Valstybės įstaigų UDTS formatu naudojantis Katalogu ir agentu:

.. image:: /static/procesai.svg


Duomenų teikėjams ir gavėjams pagalbą teikia:

Valstybės skaitmeninių sprendimų agentūra (VSSA)
    - Prižiūri visą šalies Valstybinių įstaigų dalijimosi duomenimis procesą ir konsultuoja duomenų
      teikėjus bei gavėjus visais klausimais susijusiais su duomenų teikimu ir gavimu.

    - Prižiūri duomenų :term:`Katalogą <ADK>`, kuriame vienoje vietoje
      skelbiami metaduomenys apie Valstybinių įstaigų teikiamus duomenys.

    - Kuria ir palaiko :ref:`technines priemones <spinta>` leidžiančias duomenis
      atverti automatizuotu būdu. Šios priemonės yra laisvai ir nemokamai
      teikiamos visiems duomenų teikėjams.

    - Vykdo :ref:`standartų, protokolų ir techninių dokumentacijų priežiūrą
      <dsa>`, kad duomenų teikimo procese dalyvaujančios šalys ir naudojami
      komponentai galėtų susišnekėti tarpusavyje.

    - Rengia mokymus ir mokomąją medžiagą tiek duomenų teikėjams apie
      duomenų teikimą, tiek naudotojams apie duomenų naudojimą.


.. _duomenu-teikimo-zingsniai:

1. Pasiruošimas teikti duomenis

.. image:: /static/pasiruosimas-teikti-duomenis.drawio.svg

2. Susitarimas teikti/gauti duomenis

.. image:: /static/susitarimas-teikti-gauti-duomenis.svg

3. Duomenų teikimas/gavimas

.. image:: /static/duomenu-teikimas.drawio.svg

.. toctree::
    :caption: Duomenų teikėjams
    :maxdepth: 2

    **Pasiruošimas**

    /atverimas/registracija
    /teikimas/is-registravimas
    /teikimas/tvarkytoju-registravimas
    /teikimas/agentas
    /teikimas/duomenu-rinkinio-registravimas

    TODO: Pabaigti Agento dalį

    TODO: Pabaigti Duomenų rinkinio registravimo dalį

    TODO: Metaduomenų nuskaitymas - skyrelis ŠDSA generavimas

    TODO: Metaduomenų importavimas į Katalogą

    TODO: Metaduomenų pildymas/koregavimas Kataloge

    TODO: (galbūt aprašyti ir github variantą)

    TODO: Metaduomenų įkėlimas į agentą (kol nėra sinchronizacijos - rankiniu būdu)

    TODO: Sutarčių šablonų sukūrimas

    **Susitarimas teikti/gauti duomenis:**

    TODO pakoreguoti BPMN, kad prasidėtų nuo Gavėjo (Panaudos atevejo sudarymas)

    TODO Panaudos atvejo sudarymas

    TODO Sutarties inicijavimas ir derinimas

    TODO Sutarties pasirašymas (gavėjo ir teikėjo)

    TODO Agento sukonfigūravimas duomenims teikti pagal sutartį

    TODO klientų sukonfigūravimas ir scopes suteikimas jiems

    **Duomenų teikimas/gavimas**

    TODO pašalinti iš BPMN trečią Lane (autentifikavimas)

    TODO Kliento autentifikavimasis

    TODO Užklausos formavimas ir siuntimas

    TODO Rezultatų gavimas ir interpretavimas



    TODO
    agento užregistravimas su autentifikacijos serveriu? (gal Agento konfigūracijos dalyje)
    OpenAPI schemų nusiuntimas į Vartus?
