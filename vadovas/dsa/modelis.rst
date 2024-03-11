.. default-role:: literal

Duomenų modeliavimas
####################

Rengiant struktūros aprašus svarbu suprasti, kas yra duomenų modelis ir kokie
yra duomenų modelio variantai ir bendrai kokie yra duomenų modeliavimo
principai.


Koncepcinis modelis
*******************

Koncepcinis duomenų modelis apibūdina realaus ar menamo pasaulio sąvokas ir
ryšius tarp jų. Koncepciniame modelyje nedetalizuojamos techninės detalės,
apibrėžiamos tik pačios sąvokos ir jų semantinė prasmė.

Skirtinguose kontekstuose koncepcinis modelis gali būti suprantamas skirtingai,
šiame dokumente koncepcinis modelis apibrėžiamas taip, kaip jis yra naudojamas
struktūros apraše.

Duomenų struktūros aprašo specifikacijos kontekste, koncepcinis modelis turi
būti parengtas naudojant OWL_, RDFS_ arba SKOS_ žodynus, pagal RDF_ duomenų
modelį. Tai reiškia, kad kiekvienai savokai suteikiamas unikalus
identifikatorius, IRI_ formatu.

Tarkime FOAF_ žodyne yra apibrėžtos tokios sąvokos:

- `foaf:Person <http://xmlns.com/foaf/spec/#term_Person>`_ - žmogus.
- `foaf:member <http://xmlns.com/foaf/spec/#term_member>`_ - narys.
- `foaf:Group <http://xmlns.com/foaf/spec/#term_Group>`_ - grupė.

Šioms sąvokoms yra priskirtas unikalus identifikatorius, tačiau nurodoma
sutrumpina forma, naudojant prefiksą `foaf:`. Prefiksas `foaf:` yra
sutrumpintas IRI_ vardų erdvės pavadinimas rodantis į
`http://xmlns.com/foaf/0.1/`.

Pilnas aukščiau nurodytų sąvokų IRI būtų toks:

- `foaf:Person` -> `http://xmlns.com/foaf/0.1/Person`
- `foaf:member` -> `http://xmlns.com/foaf/0.1/member`
- `foaf:Group` -> `http://xmlns.com/foaf/0.1/Group`

Svarbu suprasti, kad koncepcinis modelis yra tiesiog sąrašas sąvokų, kurioms
suteiktas identifikatorius ir nurodoma sąvokos semantinė prasmė.

Koncepcinis modelis yra skirtas plačiam taikymui, todėl sąvokų naudojimas nėra
griežtai apribotas.

Rengiant struktūros aprašus, sąsaja su koncepciniame modelyje apibrėžtomis
sąvokomis nurodoma `uri` stulpelyje.

Taip pat žiūrėkite:

- `What is a conceptual model <https://semiceu.github.io/style-guide/1.0.0/terminological-clarifications.html#sec:what-is-a-conceptual-model>`_, SEMIC Style guide.



Generalizacija ir specializacija
================================

Kalbant apie koncepcinius modelius, svarbu suprasti kas yra generalizacija ir
specializacija.

Koncepciniame modelyje pateikiame klases, savybes naudojant RDFS_ arba OWL_
žodynus ir kategorijas naudojant SKOS_ žodyną.

Generalizacija yra objektų klasifikavimo principas, kuris nurodo bendresnę
klasę ar kategoriją, kuriai priklauso objektas.

Tarkime imant tą patį FOAF_ žodyną, ir atliekame konkretaus žmogaus vardu
Vardenis Pavardenis generalizaciją:

- Vardenį Pavardenį galime priskirti bendrai klasei `foaf:Person`_.

- `foaf:Person`_ klasę, galima priskirti bendresnei klasei `foaf:Agent`_.

- `foaf:Agent`_ klasę, galima priskirti dar bendresnei klasei `owl:Thing`_.

Specializacija yra atvirkštinis procesas, kai vietoje bendresnės klasės,
parenkame labiau specializuotą.


Pakartotinis naudojimas
=======================

Yra labai daug žodynų, kurie apibrėžia įvairias savokas, pavyzdžiui `FOAF`_,
`OWL`_, `RDFS`_, `SKOS`_ ir pan. Svarbu, kad jei sąvoka jau yra apibrėžta
viename iš žodynų, būtina naudoti tokią sąvoką, kuri jau yra apibrėžta ir
deklaruoti naujas sąvokas tik tuo atveju, jei tokia sąvoka dar nėra apibrėžta
jokiame kitame žodyne.

Taip pat žiūrėkite:

- `Clarification on "reuse" <https://semiceu.github.io/style-guide/1.0.0/clarification-on-reuse.html>`_, SEMIC Style guide.



Loginis modelis
***************

Loginio modelio sąvoka gali būti interpretuojama skirtingai, skirtinguose
kontekstuose, čia pateikiama interpretacija, kuri yra naudojama rengiant
struktūros aprašus.

Loginis modelis naudoja koncepciniame modelyje apibrėžtas sąvokas, pagal jų
semantinę prasmę ir sudaro duomenų schemą, konkrečiam taikymo atvejui.

Koncepciniame modelyje nustatoma kiekvienos sąvokos semantinė prasmė ir
suteikiamas kiekvienai sąvokai identifikatorius, o loginiame modelyje nurodomos
tikslios kiekvienos sąvokos naudojimo taisyklės, konkreti duomenų modelio forma,
duomenų tikrinimo taisyklės.

Dažnai loginiame modelyje apjungiamos savokos iš kelių žodynų.

Loginis modelis nėra siejamas su konkrečiais duomenų serializavimo formatais ir
duomenys atitinkantys loginį modelį gali būti išreikšti įvairiais formatais.

Struktūros aprašuose loginis modelis nurodomas `model`, `property`, `type` ir
`ref` stulpeliuose.


Taip pat žiūrėkite:

- `What is an Application Profile (AP) specification? <https://semiceu.github.io/style-guide/1.0.0/terminological-clarifications.html#sec:what-is-an-ap-specification>`_, SEMIC Style guide.


Fizinis modelis
***************

Fizinis modelis siejamas su konkrečia loginio modelio schema, nurodant duomenų
vietą pagal konkretaus formato, kuriuo teikiami duomenys logiką.

Fizinis modelis yra pats žemiausias lygmuo, kalbantis apie fizinę duomenų
saugojimo logiką.






.. _OWL: https://www.w3.org/TR/owl2-overview/
.. _RDFS: https://www.w3.org/TR/rdf-schema/
.. _IRI: https://www.ietf.org/rfc/rfc3987.txt
.. _RDF: https://www.w3.org/TR/rdf11-concepts/
.. _FOAF: http://xmlns.com/foaf/spec/
.. _SKOS: https://www.w3.org/TR/skos-primer/
.. _owl:Thing: https://www.w3.org/TR/2004/REC-owl-semantics-20040210/syntax.html#owl_Thing_syntax
.. _foaf:Person: http://xmlns.com/foaf/spec/#term_Person
.. _foaf:member: http://xmlns.com/foaf/spec/#term_member
.. _foaf:Group: http://xmlns.com/foaf/spec/#term_Group
.. _foaf:Agent: http://xmlns.com/foaf/spec/#term_Agent
