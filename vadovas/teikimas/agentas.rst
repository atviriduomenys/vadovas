.. default-role:: literal

.. _teikimas-agentas:

Agentas
=======

Duomenų teikimo agentas yra programinė įranga, diegiama duomenų teikėjo infrastruktūroje,
ir teikianti duomenis `UDTS <https://ivpk.github.io/uapi/>`_ formatu.

Šioje dokumentacijoje aprašomas VSSA vystomo agento, pavadinimu *spinta* diegimas ir konfigūravimas, bet teikėjas
gali naudoti ir savo programinę įrangą, kuri palaiko UDTS formatą ir įgyvendina metaduomenų sincronizacijos,
klientų autentifikacijos ir išmaniųjų sutarčių funkcionalumą.

Katalogo diegimo ir konfigūravimo žingsniai:

1. Agento registravimas Kataloge. Šiame žingsnyje reikia žinoti, kokiu adresu bus pasiekiamas agentas, bet
   pats agentas dar gali būti nesudiegtas

2. :ref:`Agento diegimas<saugykla-diegimas>` organizacijos infrastruktūroje. Šioje instrukcijoje reikia
   praleisti "PostgreSQL diegimas" dalį, nes agentas turės jungtis prie jūsų, jau esamų, šaltinių.
   Taip pat nereikia leisti `bootstrap` komandos, kadangi ji skirta
3. Agento konfigūravimas duomenų teikimui pagal Kataloge suteiktus duomenis

