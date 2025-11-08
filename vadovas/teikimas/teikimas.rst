.. default-role:: literal

.. _duomenu-teikimas:

Duomenų teikėjams
=================

VSSA pateikia sistemą, skirtą įgalinti Valstybines įstaigas dalintis duomenimis tarp savęs
vieningu `UDTS<https://ivpk.github.io/uapi/>`_ formatu.

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

    /atverimas/registracija
    /teikimas/is-registravimas
    /teikimas/tvarkytoju-registravimas
    /teikimas/agentas


    TODO
    agento užregistravimas su autentifikacijos serveriu?
    OpenAPI schemų nusiuntimas į Vartus
