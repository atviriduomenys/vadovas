.. default-role:: literal
.. _vocab:

Išoriniai žodynai
=================

Išorinių žodynų pagalba, galima susieti aprašomus duomenis su išoriniais
žodynais. Susiejimas atliekamas :data:`model.uri` ir :data:`property.uri`,
naudojant :ref:`išorinių žodynų URI prefiksus <išorinių-žodynų-prefiksai>`.

Pavyzdžiui turint tokį duomenų šaltinį:

===  =========
country
--------------
id   name
===  =========
1    Lietuva
===  =========

===  =========  =======
city
-----------------------
id   name       country
===  =========  =======
1    Vilnius    1
===  =========  =======

Ir šį šaltinį atitinkančią :term:`DSA` lentelę:

+----+---+---+---+---+----------+---------+----------------+-------------------------------+
| id | d | r | b | m | property | type    | ref            | uri                           |
+====+===+===+===+===+==========+=========+================+===============================+
|    |   |   |   |   |          | prefix  | locn           | \http://www.w3.org/ns/locn#   |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    |   |   |   |   |          |         | dbpedia-owl    | \http://dbpedia.org/ontology/ |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    | datasets/example/geo     |         |                |                               |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    |   | salys                | sql     |                |                               |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    |   |   |   | Country      |         | id             | locn:Location                 |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    |   |   |   |   | id       | integer |                | dct:identifier                |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    |   |   |   |   | name\@lt | text    |                | locn:geographicName           |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    |   |   |   |   | capital  | ref     | City           | dbpedia-owl:capital           |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    |   |   |   | City         |         | id             | locn:Location                 |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    |   |   |   |   | id       | integer |                | dct:identifier                |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    |   |   |   |   | name\@lt | text    |                | locn:geographicName           |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+
|    |   |   |   |   | country  | ref     | Country        | dbpedia-owl:country           |
+----+---+---+---+---+----------+---------+----------------+-------------------------------+

Jei :data:`property` pavadinimai turi `@` žymes, tada generuojant RDF, prie
reikšmės pridedama atitinkama kalbos žymė.

Galima duomenis eksportuoti `RDF Turtle`_ formatu, kas atrodytų taip:

.. _RDF Turtle: https://en.wikipedia.org/wiki/Turtle_(syntax)

.. code-block:: ttl

    @base <https://get.data.gov.lt/> .
    @prefix dct: <http://purl.org/dc/terms/> .
    @prefix locn: <http://www.w3.org/ns/locn#> .
    @prefix dbpedia-owl: <http://dbpedia.org/ontology/> .

    <datasets/example/geo/Country/eb09946c-26e1-4698-a298-7bb1e468b165>
        a locn:Location ;
        dct:identifier 1 ;
        locn:geographicName "Lietuva"@lt ;
        dbpedia-owl:capital <datasets/example/geo/City/b54c21f6-08b8-4bdd-b785-be1cb2e93a98> .

    <datasets/example/geo/City/b54c21f6-08b8-4bdd-b785-be1cb2e93a98>
        a locn:Location ;
        dct:identifier 1 ;
        locn:geographicName "Vilnius"@lt ;
        dbpedia-owl:country <datasets/example/geo/Country/eb09946c-26e1-4698-a298-7bb1e468b165> .

Analogiškai, tie patys duomenys gali būti eksportuojami `RDF/XML`_ formatu:

.. _RDF/XML: https://www.w3.org/TR/rdf-syntax-grammar/

.. code-block:: xml

    <?xml version="1.0" encoding="utf-8"?>
    <rdf:RDF
        xml:base="https://get.data.gov.lt/"
        xmlns:dct="http://purl.org/dc/terms/"
        xmlns:locn="http://www.w3.org/ns/locn#"
        xmlns:dbpedia-owl="http://dbpedia.org/ontology/"
        xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">

        <locn:Location
            rdf:about="datasets/example/geo/Country/eb09946c-26e1-4698-a298-7bb1e468b165"
            dct:identifier="1">
            <locn:geographicName xml:lang="lt">Lietuva</locn:geographicName>
            <dbpedia-owl:capital
                rdf:resource="datasets/example/geo/City/b54c21f6-08b8-4bdd-b785-be1cb2e93a98" />
        </locn:Location>

        <locn:Location
            rdf:about="datasets/example/geo/City/b54c21f6-08b8-4bdd-b785-be1cb2e93a98"
            dct:identifier="1">
            <locn:geographicName xml:lang="lt">Vilnius</locn:geographicName>
            <dbpedia-owl:country
                rdf:resource="datasets/example/geo/Country/eb09946c-26e1-4698-a298-7bb1e468b165" />
        </locn:Location>
    </rdf:RDF>

Išoriniai žodynai suteikia galimybę eksportuoti duomenis :term:`RDF` formatu.

Jei struktūros apraše nėra užpildytas :data:`uri` stulpelis, data, turėtu būti
generuojamas tokie RDF duomenys:

.. code-block:: ttl

    @base <https://get.data.gov.lt/> .
    @prefix dct: <http://purl.org/dc/terms/> .
    @prefix locn: <http://www.w3.org/ns/locn#> .
    @prefix dbpedia-owl: <http://dbpedia.org/ontology/> .

    <datasets/example/geo/Country/eb09946c-26e1-4698-a298-7bb1e468b165>
        a <datasets/example/geo/Country> ;
        <datasets/example/geo/Country/id> 1 ;
        <datasets/example/geo/Country/name> "Lietuva"@lt ;
        <datasets/example/geo/Country/capital> <datasets/example/geo/City/b54c21f6-08b8-4bdd-b785-be1cb2e93a98> .

    <datasets/example/geo/City/b54c21f6-08b8-4bdd-b785-be1cb2e93a98>
        a <datasets/example/geo/City> ;
        <datasets/example/geo/City/id> 1 ;
        <datasets/example/geo/City/name> "Vilnius"@lt ;
        <datasets/example/geo/City/country> <datasets/example/geo/Country/eb09946c-26e1-4698-a298-7bb1e468b165> .


Subjekto URI
------------

Pagal nutylėjimą :term:`subjekto <subjektas>` URI yra automatiškai generuojamas
ir atrodo taip::

    https://get.data.gov.lt/datasets/example/geo/Country/eb09946c-26e1-4698-a298-7bb1e468b165

Tačiau naudojant kontroliuojamus žodynus, galima nurodyti kitą identifikatorių
tokiu būdu:

== =========== ========= ========== =============
m  property    type      ref        uri          
== =========== ========= ========== =============
Country                  id         locn:Location
-------------- --------- ---------- -------------
\  id          integer                           
\  uri         uri                  locn:Location
\  name\@lt    text                              
== =========== ========= ========== =============

Jei :data:`property.uri` sutampa su :data:`model.uri` ir :data:`property.type`
yra :data:`uri`, tada formuojant duomenis RDF formatu naudojame ne generuotą
subjekto URI, o naudojame lauko reikšmę, kurio :data:`property.uri` sutampa su
:data:`model.uri`.

Gali būti ne daugiau kaip vienas :data:`property.uri` su :data:`property.type`
:data:`uri`, kuris sutampa su :data:`model.uri`.

Jei yra keli :data:`uri` tipo laukai, kurie identifikuoja tą patį subjektą,
tada kitiems atvejams reikia naudoti ne :data:`model.uri`, o `owl:sameAs`_.

.. _owl:sameAs: https://www.w3.org/TR/owl-ref/#sameAs-def

Jei `uri` reikšmė bus `https://sws.geonames.org/597427/`, tada gautume tokius
RDF duomenis:

.. code-block:: ttl

    @base <https://get.data.gov.lt/example/> .
    @prefix locn: <http://www.w3.org/ns/locn#> .

    <https://sws.geonames.org/597427/>
        a locn:Location ;
        <Country/id> 1 ;
        <Country/name> "Lietuva"@lt .

Atkreipkite dėmesį, kad pats `uri` laukas nėra įtrautkas į RDF duomenis.

Analogiškai, jei :data:`ref` tipo laukas rodo į modelį, kurio :data:`model.uri`
sutampa su :data:`property.uri` kuris yra :data:`ref` tipo, tada :data:`ref`
lauko reikšmė taip pat įgyja ne gnenruotą URI, o URI iš duomenų.

Pratęsiant tą patį pavyzdį:

== =========== ========= ========== =============
m  property    type      ref        uri          
== =========== ========= ========== =============
Country                  id         locn:Location
-------------- --------- ---------- -------------
\  id          integer                           
\  uri         uri                  locn:Location
\  name\@lt    text                              
City                     id         locn:Location
-------------- --------- ---------- -------------
\  id          integer                           
\  name\@lt    text                              
\  country     ref       Country    locn:Location
== =========== ========= ========== =============

Gautumo tokius duomenis:

.. code-block:: ttl

    @base <https://get.data.gov.lt/example/> .
    @prefix locn: <http://www.w3.org/ns/locn#> .

    <https://sws.geonames.org/597427/>
        a locn:Location ;
        <Country/id> 1 ;
        <Country/name> "Lietuva"@lt .

    <City/b54c21f6-08b8-4bdd-b785-be1cb2e93a98>
        a locn:Location ;
        <City/id> 1 ;
        <City/name> "Vilnius"@lt ;
        <City/country> <https://sws.geonames.org/597427/> .
