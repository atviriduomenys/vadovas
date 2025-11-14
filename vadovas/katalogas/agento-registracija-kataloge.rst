.. default-role:: literal

.. _katalogas-agento-registracija:

Agento registracija Kataloge
############################

**Agentų sąsajos registracija duomenų Kataloge**.

Registracija vykdoma organizacijos, kuriai priklauso naudotojas, puslapyje. Norėdami tai atlikti:

#. Prisijunkite prie duomenų Katalogo.
#. Viršutiniame dešiniajame kampe užveskite pelę ant savo naudotojo vardo.

    | |image_navigation_bar|
    | *pav. Navigacijos juosta – vartotojo skirtukas*

#. Sąraše pasirinkite **„Mano organizacijos duomenų ištekliai“**.

    | |image_organization_resources|
    | *pav. Nuoroda į organizacijos duomenų išteklius*

#. Atverkite skirtuką **„Agentai“**.

    | |image_agent_tab|
    | *pav. Agentų skirtukas*

#. Spauskite **„Pridėti Agentą“**.

    | |image_agent_create|
    | *pav. Agento pridėjimas*

#. Užpildykite formos laukus ir spauskite **„Sukurti“**.

    - :ref:`Agento pildymo forma ir jos laukai <agent_create_edit_form>`

#. Atlikus registraciją, pateikiami prisijungimo duomenys. Juos reikia išsisaugoti, ypač slaptažodį (secret),
nes daugiau jis rodomas nebus.

Galimos dvi Agento rūšys: Spinta ir Kita. Priklausomai, kokios rūšies agentą naudosim, skirsis jo konfigūracija.


Agento kūrimo / redagavimo forma
=================================

Ši forma naudojama Agentui sukurti arba esamam Agentui redaguoti.

- Naujo Agento kūrimą inicijuokite paspaudę **[Pridėti Agentą]** viršutiniame dešiniajame kampe.
- Norėdami redaguoti jau sukurtą Agentą, sąraše spustelėkite **[Redaguoti]** šalia įrašo.

| |image_formos_ir_laukai_1|
| *pav. Agento kūrimo / redagavimo forma*


Formos laukai ir jų paaiškinimai
--------------------------------

**Pavadinimas**
    Vartotojui matomas Agento pavadinimas, naudojamas ir kodiniam pavadinimui generuoti.

.. _agent_create_edit_form_field_kind:

**Rūšis**
    Nurodo, kokia paslauga naudojama Agento veikimui:

    - **Spinta** – sugeneruojamos dvi konfigūracijos:

        - `credentials.cfg <https://atviriduomenys.readthedocs.io/spinta.html#duomenu-publikavimas-i-saugykla>`_
        - `config.yml <https://atviriduomenys.readthedocs.io/spinta.html?#config-yml>`_

    - **Kita** – suteikiamas prieigos raktas. Likusi dalis priklauso sprendimo tiekėjui.

**Duomenų paslauga**
    Nurodo, kuriai duomenų paslaugai Agentas bus priskirtas. Jei nenurodyta, duomenų paslauga bus sukurta automatiškai.

**Aplinka**
    Nurodo, kurioje aplinkoje bus diegiamas Agentas. Galimos reikšmės:

    - **Vystymo** – Agentas bus diegiamas vystymo aplinkoje.
    - **Testavimo** – Agentas bus diegiamas testavimo aplinkoje.
    - **Gamybinė** – Agentas bus diegiamas gamybinėje aplinkoje.

**Agento adresas**
    Nurodo Agento pasiekimą per URL arba IP adresą. Jei yra nurodytas vartų adresas, tada agento adresas yra vidinis adresas, kurį mato API vartai. Jei API vartai nenurodyti, tada yra nurodomas išorinis agento adresas.

**Autorizacijos serverio adresas**
    Nurodo autorizacijos serverio adresą, kuris bus naudojamas metaduomenų sinchronizacijai arba duomenų apsikeitimui.

**API vartų serverio adresas**
    Nurodo API vartų serverio adresą, kuris bus naudojamas metaduomenų sinchronizacijai arba duomenų apsikeitimui.

**Agentas įjungtas**
    Nurodo, ar Agentas šiuo metu aktyvus.

**Atviri duomenys publikuojami Saugykloje**
    Pažymėjus šį lauką, leidžiama publikuoti atvirus duomenis per Agentą.

**Duomenų publikavimo nuoroda**
    Nurodoma tik tada, kai pažymėtas ankstesnis laukas dėl duomenų publikavimo.

.. note::
   Sukūrus Agentą, pateikiamos reikalingos konfigūracijos ir slaptas prisijungimo raktas.
   **Dėl saugumo šis raktas rodomas tik vieną kartą – būtinai jį išsaugokite.**

Konfigūracija pagal Agento rūšį
-------------------------------

Papildomai, priklausomai nuo pasirinktos **rūšies**, rodoma specifinė Agento konfigūracija:

- **Spinta**
    Rodoma dvi konfigūracijos dalys:

    .. _configuration_credentials_cfg:

    - Prisijungimui prie Katalogo.

        | |image_formos_ir_laukai_4|
        | *pav. Konfigūracija pasirinkus „Spinta“: Agentas -> Katalogas*

    .. _configuration_config_yml:

    - Prisijungimui prie duomenų šaltinio.

        | |image_formos_ir_laukai_5|
        | *pav. Konfigūracija pasirinkus „Spinta“: Agentas -> Duomenų Šaltinis*

- **Kita**

    .. _configuration_secret_key:

    Rodoma tik prieigos rakto informacija. Likusi konfigūracija – sprendimo tiekėjo atsakomybė.

    | |image_formos_ir_laukai_6|
    | *pav. Konfigūracija pasirinkus „Kita“*



.. |image_navigation_bar| image:: /static/katalogas/okot/image_navigation_bar.png
   :alt: Navigacijos juosta

.. |image_organization_resources| image:: /static/katalogas/okot/image_organization_resources.png
   :alt: Nuoroda į organizacijos duomenų išteklius

.. |image_agent_tab| image:: /static/katalogas/okot/image_agent_tab.png
   :alt: Agentų skirtukas

.. |image_agent_create| image:: /static/katalogas/okot/image_agent_add.png
   :alt: Agento pridėjimas