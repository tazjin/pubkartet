--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: pubs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pubs (
    pub_key integer NOT NULL,
    name text NOT NULL,
    description text,
    address text,
    location geography(Point,4326),
    tags text[] DEFAULT '{}'::text[] NOT NULL
);


ALTER TABLE pubs OWNER TO postgres;

--
-- Name: pubs_pub_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pubs_pub_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pubs_pub_key_seq OWNER TO postgres;

--
-- Name: pubs_pub_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pubs_pub_key_seq OWNED BY pubs.pub_key;


--
-- Name: pubs_raw; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pubs_raw (
    pub jsonb,
    pub_type text
);


ALTER TABLE pubs_raw OWNER TO postgres;

--
-- Name: pub_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pubs ALTER COLUMN pub_key SET DEFAULT nextval('pubs_pub_key_seq'::regclass);


--
-- Data for Name: pubs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pubs (pub_key, name, description, address, location, tags) FROM stdin;
1	3 Brødre	http://www.oslopubguide.com/T/3Brodre.php	\N	0101000020E6100000C084F3041D7C254049E58123DCF44D40	{brun}
2	To Kokker Mat og Vinhus	En trivelig brun cafe med stor uteplass.<br>http://www.oslopubguide.com/T/2Kokker.php	\N	0101000020E6100000003263C0488225406B7000A205F54D40	{brun}
3	Buckleys pub	http://www.oslopubguide.com/T/BuckleysPub.php<br>24 års grense når det ikke er konserter	\N	0101000020E61000008016026F377B254037818EFBFBF44D40	{brun}
4	Bør & Børsen	http://www.oslopubguide.com/T/BorBorsen.php	\N	0101000020E6100000C0B672405C87254002D19332A9F54D40	{brun}
5	Café 33	http://www.oslopubguide.com/T/Cafe33.php	\N	0101000020E610000080CB07A9808425408158CA8D7DF64D40	{brun}
6	Carl Berner Kjellern	http://www.oslopubguide.com/T/CarlBernerKjellern.php	\N	0101000020E610000000387469B28D2540BCED42739DF64D40	{brun}
7	Den Glade Munk	http://www.oslopubguide.com/T/DenGladeMunk.php	\N	0101000020E610000080EF9293E48025409FF0129CFAF44D40	{brun}
8	Dovrehallen	http://www.oslopubguide.com/T/Dovrehallen.php<br>Maten skal vere bra men eg har ikkje testa den	\N	0101000020E6100000807C7A6CCB8025405ED9AAC9F8F44D40	{brun}
9	Dovrestua	http://www.oslopubguide.com/T/Dovrestua.php (henger sammen med Dovrehallen)	\N	0101000020E6100000807C7A6CCB8025405ED9AAC9F8F44D40	{brun}
10	Hjørnet Kro	http://www.oslopubguide.com/T/HjoernetKro.php	\N	0101000020E61000008070CD1DFD8B2540B785425FD5F44D40	{brun}
11	Orlandos pub	\N	\N	0101000020E6100000804B8281318025406C1382B0AEF54D40	{brun}
12	Restaurant Schrøder	Harry Holes stamsted<br>http://www.oslopubguide.com/T/Schroeder.php	\N	0101000020E610000080D50FA0957A2540F12900C633F64D40	{brun}
13	Valkyrien Restaurant	http://www.oslopubguide.com/T/Valkyrien.php	\N	0101000020E610000080864E74026F2540F8C54A71FAF64D40	{brun}
14	Asylet	http://www.oslopubguide.com/T/Asylet.php	\N	0101000020E6100000C039D9BC6086254038166FBFD7F44D40	{vanlig}
15	Blå	\N	\N	0101000020E6100000406C66E3778125409ACBB2CCC7F54D40	{vanlig}
16	Bohemen Sportspub	http://www.oslopubguide.com/T/Bohemen.php	\N	0101000020E6100000000EF7915B7B25403B9FF0C80EF54D40	{vanlig}
17	Cafe Lyon	http://www.oslopubguide.com/T/CafeNero.php	\N	0101000020E6100000C0542D8E6F882540B4924550EBF64D40	{vanlig}
18	Cafe Sør	Nøgneøl på flaske	\N	0101000020E6100000000EFD6E157F25403A54F8D802F54D40	{vanlig}
19	Gamle Raadhus	http://www.oslopubguide.com/T/DetGamleRaadhus.php	\N	0101000020E610000080D997C7F57A25403F3965C977F44D40	{vanlig}
20	Eilefs Landhandleri	Tyskertorsdag!<br>http://www.oslopubguide.com/T/EilefsLandhandleri.php	\N	0101000020E610000000AD2127027B25403740D58D1CF54D40	{vanlig}
21	The Fly Fisher	http://www.oslopubguide.com/T/FlyFisher.php	\N	0101000020E610000001F116A3097725406C44D554BBF64D40	{vanlig}
22	Forest & Brown	http://www.oslopubguide.com/T/ForestBrown.php	\N	0101000020E610000000B2DD98F96D25407AEEF3CE57F54D40	{vanlig}
23	Fridtjof Pub	http://www.oslopubguide.com/T/FridtjofsPub.php	\N	0101000020E610000041A3F1FA82782540A7DE09ACD2F44D40	{vanlig}
24	Fru Burums	http://www.oslopubguide.com/T/FruBurums.php	\N	0101000020E61000004096992DB46E25403A89528C3DF54D40	{vanlig}
25	Fyret Mat & Drikke	http://www.oslopubguide.com/T/FyretMatDrikke.php	\N	0101000020E6100000C045FF15437F254085EB51B81EF54D40	{vanlig}
26	Herr Nilsen	http://www.oslopubguide.com/T/HerrNilsen.php	\N	0101000020E610000000C0232A547B2540B6ACB13A28F54D40	{vanlig}
27	Ivars Kro	http://www.oslopubguide.com/T/HjoernetKro.php	\N	0101000020E6100000003A27518A852540A67FEE70E0F44D40	{vanlig}
28	Jarlen Restaurant	Hvalbiff ...<br>http://www.oslopubguide.com/T/JarlenRestaurant.php	\N	0101000020E610000080D11DC4CE8C25401474C5D67DF44D40	{vanlig}
29	Konrad	https://untappd.com/venue/2495080	\N	0101000020E610000080B6589B10802540B340608A17F54D40	{vanlig}
30	Larsen restaurant	http://www.oslopubguide.com/T/LarsenRestaurant.php	\N	0101000020E610000000C78734856D25402CEF3E2201F74D40	{vanlig}
31	Magneten Pub & Scene	http://www.oslopubguide.com/T/Magneten.php	\N	0101000020E6100000409303D1EE872540CACE914BD2F74D40	{vanlig}
32	Olsen Restaurant & Bar	http://www.oslopubguide.com/T/OlsenRestaurantBar.php	\N	0101000020E61000004097C05202A32540D8ECED3B2BF44D40	{vanlig}
33	Pane e Vino	http://www.oslopubguide.com/T/PaneVino.php	\N	0101000020E6100000000D631C6D8A2540F3AE6994E4F54D40	{vanlig}
34	Palace grill	http://www.oslopubguide.com/T/PalaceBar.php	\N	0101000020E610000080BE43F6E670254020A45D3B07F54D40	{vanlig}
35	Per på Hjørnet	http://www.oslopubguide.com/T/PalaceBar.php	\N	0101000020E610000080FF8AA1417B2540287090B52BF54D40	{vanlig}
36	Politiker'n	http://www.oslopubguide.com/T/Politikern.php	\N	0101000020E6100000C045FF15437F254085EB51B81EF54D40	{vanlig}
37	Ruinen Bar & Cafe	http://www.oslopubguide.com/T/RuinenBarCafe.php	\N	0101000020E6100000804C101A668925405AEA20AF07F44D40	{vanlig}
38	Store Stå	http://www.oslopubguide.com/T/StoreStaaPub.php	\N	0101000020E61000004006D506277625402D675B7281F64D40	{vanlig}
39	O'Reillys Irish pub	\N	\N	0101000020E610000000BBFA67BC832540BB4B3D66FBF54D40	{vanlig}
40	Stortorvets Gjæstgiveri	http://www.oslopubguide.com/T/StoreStaaPub.php	\N	0101000020E610000000224D614A7D2540074F2157EAF44D40	{vanlig}
41	Teddy's Softbar	http://www.oslopubguide.com/T/TeddysSoftBar.php	\N	0101000020E61000000052746E2482254080784C9308F54D40	{vanlig}
42	Tilt	Litt fokussert på entertainment & spill	\N	0101000020E610000000B986BE608025406B89F08A3BF54D40	{vanlig}
43	Treffen Café & Sportsbar	http://www.oslopubguide.com/T/TreffenCafe.php	\N	0101000020E610000080496991488A2540A0C4420823F54D40	{vanlig}
44	Underwater Pub	http://www.oslopubguide.com/T/UnderwaterPub.php	\N	0101000020E610000000653CA5DE7A2540AB387AA125F64D40	{vanlig}
45	The Nighthawk Diner	Godt øl fra Grünerløkka Brygghus	\N	0101000020E6100000809C5D0883842540E342D43373F64D40	{vanlig}
46	St. Halvard Pub	http://www.oslopubguide.com/T/StHalvards.php	\N	0101000020E61000004000E88B18892540EDDE4037EAF34D40	{vanlig}
47	The Dubliner	\N	\N	0101000020E610000000BAF0283A7B25401CAB39E576F44D40	{vanlig}
48	Trafalgar pub	\N	\N	0101000020E61000000057FD5B13742540FE053873FEF54D40	{vanlig}
49	Welhavens cafe	\N	\N	0101000020E61000000062DE3E06762540E4E0D231E7F54D40	{vanlig}
50	Pøbberiet	https://untappd.com/venue/4025760	\N	0101000020E610000000CD0AA0738E25409BFDCBFFF5F64D40	{vanlig}
51	Skyggesiden	https://untappd.com/venue/291291 (åpent til kl. 3 hver dag!)	\N	0101000020E6100000804946CEC27A25409EF3AED579F44D40	{vanlig}
52	Frognerseteren Restaurant	Vanlig Nøgne osv.	\N	0101000020E6100000004C18CDCA5A2540E37F869224FD4D40	{vanlig}
53	BD57 (BrewDog)	Kven elskar ikkje Brewdog?<br>https://untappd.com/venue/2875445	\N	0101000020E610000000AB0084B4832540B0DEF2A2C0F54D40	{godt-utvalg}
54	Beer Palace	https://untappd.com/venue/3733<br>Strikt 23 årsgrense	\N	0101000020E6100000C0E3912EEC73254051966B1B90F44D40	{godt-utvalg}
55	Bjørungs	http://www.oslopubguide.com/T/Bjorungs.php	\N	0101000020E6100000C06C1E87C1742540260DDA50D6F54D40	{godt-utvalg}
56	Cafe Fiasco	http://www.oslopubguide.com/T/CafeFiasco.php<br>http://www.fiasco.no/menu/	\N	0101000020E610000080793A57948225405D0EAAC3C0F44D40	{godt-utvalg}
57	Cafe Nero	http://www.oslopubguide.com/T/CafeNero.php	\N	0101000020E6100000008A141450762540797F72CA92F64D40	{godt-utvalg}
58	Crowbar & Bryggeri	https://untappd.com/venue/78243 (23 på kvelden)	\N	0101000020E610000000A5AC95BF812540CBFDC4B766F54D40	{godt-utvalg}
59	Café Sara	http://www.cafesara.no/	\N	0101000020E61000004078921914822540E9A3E77173F54D40	{godt-utvalg}
60	Dattera til Hagen	https://untappd.com/venue/135666	\N	0101000020E6100000003CF71E2E8525402CC71AE4E4F44D40	{godt-utvalg}
61	Den Gamle Major	http://www.oslopubguide.com/T/DenGamleMajor.php	\N	0101000020E610000080941117806E254031134548DDF64D40	{godt-utvalg}
62	Dr. Jekyll's Pub	http://www.oslopubguide.com/T/DrJekyll.php <br>Mykje belgisk øl.	\N	0101000020E6100000004AA4236F772540FCD52D4CF0F44D40	{godt-utvalg}
63	Grünerløkka Brygghus	Favorittstedet!<br>https://untappd.com/venue/18674	\N	0101000020E6100000C0CCCCCCCC842540EE57A60469F64D40	{godt-utvalg}
64	Jarmann Gastropub	https://untappd.com/venue/2206427	\N	0101000020E610000040B7EC10FF742540FD76B7578BF44D40	{godt-utvalg}
65	Katedralen Pub & Spiseri	https://untappd.com/venue/29926<br>http://www.oslopubguide.com/T/KatedralenPub.php	\N	0101000020E610000040CF4A5AF1752540B00D15E3FCF54D40	{godt-utvalg}
66	Kulturhuset	https://untappd.com/venue/779522<br>23 aldersgrense på kveldene	\N	0101000020E6100000808A32C0AA7F25402F79A8120AF54D40	{godt-utvalg}
67	Lorry	http://www.oslopubguide.com/T/LorryRestaurant.php<br>https://untappd.com/venue/30086	\N	0101000020E610000040FFE89B34752540B3C34E67DDF54D40	{godt-utvalg}
68	Olympen	https://untappd.com/venue/4900<br>http://www.oslopubguide.com/T/OlympenMatVinhus.php	\N	0101000020E6100000C054FA0967872540D7C1C1DEC4F44D40	{godt-utvalg}
69	Oslo mekaniske verksted	https://untappd.com/venue/78243 (strikt 23)	\N	0101000020E6100000C1D43B8155862540928B7B3DA9F44D40	{godt-utvalg}
70	Oslo Mikrobryggeri	http://www.oslopubguide.com/T/OsloMikrobryggeri.php	\N	0101000020E610000040330BFEC8722540A8B9CB3450F64D40	{godt-utvalg}
71	Schouskjelleren	Kan vere vanskeleg å finne inngangen ;-)<br>https://untappd.com/venue/43944<br>http://www.oslopubguide.com/T/SchousKjelleren.php	\N	0101000020E6100000C0C22D1F498525405EC026C68DF54D40	{godt-utvalg}
72	Royal Gastropub	https://untappd.com/venue/2557498<br>Mykje dyrere enn dei fleste stadar, men bra	\N	0101000020E610000000CE86A17A802540E900D24895F44D40	{godt-utvalg}
73	Nedre Foss Gård	Kvil i Fred :'(<br>https://untappd.com/venue/2886153<br>http://www.osloby.no/nyheter/Deler-av-Nedre-Foss-gard-pa-Grnerlokka-totalskadet-i-brann-8300839.html	\N	0101000020E6100000C08168F7F581254024CBEE6E0AF64D40	{godt-utvalg}
74	Wurst Øl- og Pølsebar	Strikt 23, mykje tyskinspirert øl og pølser	\N	0101000020E6100000011AB677577F25407C4CB560F3F44D40	{godt-utvalg}
75	Amundsen Bryggeri & Spiseri	https://untappd.com/venue/47552	\N	0101000020E61000008002171A3E7825407E8C6FDEEEF44D40	{godt-utvalg}
76	Café Laundromat	https://untappd.com/venue/34098	\N	0101000020E610000000FECF0605762540645D370076F64D40	{godt-utvalg}
77	HåndverkerStuene	https://untappd.com/venue/58626	\N	0101000020E610000000BBC7E3B37A25409C8F7C6F1DF54D40	{godt-utvalg}
78	Gaasa	https://untappd.com/venue/265339	\N	0101000020E6100000403AEC191D832540FEA666C526F54D40	{godt-utvalg}
79	Hendrix Ibsen	https://untappd.com/venue/2903938	\N	0101000020E6100000C07E445DB5802540D5D63ED301F64D40	{godt-utvalg}
80	Nydalen Bryggeri og Spiseri	\N	\N	0101000020E610000080A608707A8725405DBD2FD39BF94D40	{godt-utvalg}
81	Smelteverket	https://untappd.com/venue/428663	\N	0101000020E6100000C002D19332812540E70AEF7211F64D40	{godt-utvalg}
82	The Pub	https://untappd.com/venue/1581114	\N	0101000020E6100000801B28F04E6E254040BFEFDFBCF64D40	{godt-utvalg}
\.


--
-- Name: pubs_pub_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pubs_pub_key_seq', 82, true);


--
-- Data for Name: pubs_raw; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pubs_raw (pub, pub_type) FROM stdin;
{"name": "3 Brødre", "coordinates": [10.742408899999987, 59.91296810000001, 0], "description": "http://www.oslopubguide.com/T/3Brodre.php"}	brun
{"name": "To Kokker Mat og Vinhus", "coordinates": [10.754461300000003, 59.91423440000002, 0], "description": "En trivelig brun cafe med stor uteplass.<br>http://www.oslopubguide.com/T/2Kokker.php"}	brun
{"name": "Buckleys pub", "coordinates": [10.740657300000066, 59.913939899999995, 0], "description": "http://www.oslopubguide.com/T/BuckleysPub.php<br>24 års grense når det ikke er konserter"}	brun
{"name": "Bør & Børsen", "coordinates": [10.76437569999996, 59.919225999999995, 0], "description": "http://www.oslopubguide.com/T/BorBorsen.php"}	brun
{"name": "Café 33", "coordinates": [10.758794099999932, 59.92570660000002, 0], "description": "http://www.oslopubguide.com/T/Cafe33.php"}	brun
{"name": "Carl Berner Kjellern", "coordinates": [10.776751800000056, 59.926680000000005, 0], "description": "http://www.oslopubguide.com/T/CarlBernerKjellern.php"}	brun
{"name": "Den Glade Munk", "coordinates": [10.751743900000065, 59.91389800000001, 0], "description": "http://www.oslopubguide.com/T/DenGladeMunk.php"}	brun
{"name": "Dovrehallen", "coordinates": [10.751551999999947, 59.91384240000001, 0], "description": "http://www.oslopubguide.com/T/Dovrehallen.php<br>Maten skal vere bra men eg har ikkje testa den"}	brun
{"name": "Dovrestua", "coordinates": [10.751551999999947, 59.91384240000001, 0], "description": "http://www.oslopubguide.com/T/Dovrestua.php (henger sammen med Dovrehallen)"}	brun
{"name": "Hjørnet Kro", "coordinates": [10.773415500000056, 59.9127616, 0], "description": "http://www.oslopubguide.com/T/HjoernetKro.php"}	brun
{"name": "Orlandos pub", "coordinates": [10.750377699999945, 59.91939360000001, 0], "description": null}	brun
{"name": "Restaurant Schrøder", "coordinates": [10.739422800000057, 59.923455, 0], "description": "Harry Holes stamsted<br>http://www.oslopubguide.com/T/Schroeder.php"}	brun
{"name": "Valkyrien Restaurant", "coordinates": [10.716815600000018, 59.92951790000001, 0], "description": "http://www.oslopubguide.com/T/Valkyrien.php"}	brun
{"name": "Asylet", "coordinates": [10.762456799999995, 59.9128341, 0], "description": "http://www.oslopubguide.com/T/Asylet.php"}	vanlig
{"name": "Blå", "coordinates": [10.75286779999999, 59.9201599, 0], "description": null}	vanlig
{"name": "Bohemen Sportspub", "coordinates": [10.740933000000041, 59.91451370000001, 0], "description": "http://www.oslopubguide.com/T/Bohemen.php"}	vanlig
{"name": "Cafe Lyon", "coordinates": [10.766476099999977, 59.92905620000002, 0], "description": "http://www.oslopubguide.com/T/CafeNero.php"}	vanlig
{"name": "Cafe Sør", "coordinates": [10.748210400000062, 59.9141494, 0], "description": "Nøgneøl på flaske"}	vanlig
{"name": "Gamle Raadhus", "coordinates": [10.740156399999933, 59.909905599999995, 0], "description": "http://www.oslopubguide.com/T/DetGamleRaadhus.php"}	vanlig
{"name": "Eilefs Landhandleri", "coordinates": [10.740250800000013, 59.91493389999999, 0], "description": "Tyskertorsdag!<br>http://www.oslopubguide.com/T/EilefsLandhandleri.php"}	vanlig
{"name": "The Fly Fisher", "coordinates": [10.732495400000063, 59.92759190000001, 0], "description": "http://www.oslopubguide.com/T/FlyFisher.php"}	vanlig
{"name": "Forest & Brown", "coordinates": [10.714794900000015, 59.9167422, 0], "description": "http://www.oslopubguide.com/T/ForestBrown.php"}	vanlig
{"name": "Fridtjof Pub", "coordinates": [10.735374299999991, 59.91267920000001, 0], "description": "http://www.oslopubguide.com/T/FridtjofsPub.php"}	vanlig
{"name": "Fru Burums", "coordinates": [10.716218400000002, 59.9159408, 0], "description": "http://www.oslopubguide.com/T/FruBurums.php"}	vanlig
{"name": "Fyret Mat & Drikke", "coordinates": [10.74855869999999, 59.915, 0], "description": "http://www.oslopubguide.com/T/FyretMatDrikke.php"}	vanlig
{"name": "Herr Nilsen", "coordinates": [10.740876500000013, 59.9152902, 0], "description": "http://www.oslopubguide.com/T/HerrNilsen.php"}	vanlig
{"name": "Ivars Kro", "coordinates": [10.760820899999999, 59.91309940000001, 0], "description": "http://www.oslopubguide.com/T/HjoernetKro.php"}	vanlig
{"name": "Jarlen Restaurant", "coordinates": [10.77501499999994, 59.91009030000001, 0], "description": "Hvalbiff ...<br>http://www.oslopubguide.com/T/JarlenRestaurant.php"}	vanlig
{"name": "Konrad", "coordinates": [10.75012670000001, 59.914780900000004, 0], "description": "https://untappd.com/venue/2495080"}	vanlig
{"name": "Larsen restaurant", "coordinates": [10.713906899999984, 59.92972210000002, 0], "description": "http://www.oslopubguide.com/T/LarsenRestaurant.php"}	vanlig
{"name": "Magneten Pub & Scene", "coordinates": [10.765493900000024, 59.9361052, 0], "description": "http://www.oslopubguide.com/T/Magneten.php"}	vanlig
{"name": "Olsen Restaurant & Bar", "coordinates": [10.81837710000002, 59.9075694, 0], "description": "http://www.oslopubguide.com/T/OlsenRestaurantBar.php"}	vanlig
{"name": "Pane e Vino", "coordinates": [10.770363699999962, 59.92103820000002, 0], "description": "http://www.oslopubguide.com/T/PaneVino.php"}	vanlig
{"name": "Palace grill", "coordinates": [10.72051209999995, 59.9142832, 0], "description": "http://www.oslopubguide.com/T/PalaceBar.php"}	vanlig
{"name": "Per på Hjørnet", "coordinates": [10.740735099999938, 59.91539640000002, 0], "description": "http://www.oslopubguide.com/T/PalaceBar.php"}	vanlig
{"name": "Politiker'n", "coordinates": [10.74855869999999, 59.915, 0], "description": "http://www.oslopubguide.com/T/Politikern.php"}	vanlig
{"name": "Ruinen Bar & Cafe", "coordinates": [10.768357100000003, 59.90648449999999, 0], "description": "http://www.oslopubguide.com/T/RuinenBarCafe.php"}	vanlig
{"name": "Store Stå", "coordinates": [10.730766499999959, 59.92582539999999, 0], "description": "http://www.oslopubguide.com/T/StoreStaaPub.php"}	vanlig
{"name": "O'Reillys Irish pub", "coordinates": [10.75729679999995, 59.9217346, 0], "description": null}	vanlig
{"name": "Stortorvets Gjæstgiveri", "coordinates": [10.744708100000025, 59.91340150000001, 0], "description": "http://www.oslopubguide.com/T/StoreStaaPub.php"}	vanlig
{"name": "Teddy's Softbar", "coordinates": [10.754184200000054, 59.91432420000001, 0], "description": "http://www.oslopubguide.com/T/TeddysSoftBar.php"}	vanlig
{"name": "Tilt", "coordinates": [10.750738100000035, 59.915879600000004, 0], "description": "Litt fokussert på entertainment & spill"}	vanlig
{"name": "Treffen Café & Sportsbar", "coordinates": [10.770084900000029, 59.915131599999995, 0], "description": "http://www.oslopubguide.com/T/TreffenCafe.php"}	vanlig
{"name": "Underwater Pub", "coordinates": [10.73997989999998, 59.9230234, 0], "description": "http://www.oslopubguide.com/T/UnderwaterPub.php"}	vanlig
{"name": "The Nighthawk Diner", "coordinates": [10.758812199999966, 59.9253907, 0], "description": "Godt øl fra Grünerløkka Brygghus"}	vanlig
{"name": "St. Halvard Pub", "coordinates": [10.76776540000003, 59.9055852, 0], "description": "http://www.oslopubguide.com/T/StHalvards.php"}	vanlig
{"name": "The Dubliner", "coordinates": [10.740678099999968, 59.9098784, 0], "description": null}	vanlig
{"name": "Trafalgar pub", "coordinates": [10.72671020000007, 59.92182769999998, 0], "description": null}	vanlig
{"name": "Welhavens cafe", "coordinates": [10.730516399999942, 59.92111800000001, 0], "description": null}	vanlig
{"name": "Pøbberiet", "coordinates": [10.778225900000052, 59.92938230000001, 0], "description": "https://untappd.com/venue/4025760"}	vanlig
{"name": "Skyggesiden", "coordinates": [10.73976749999997, 59.9099681, 0], "description": "https://untappd.com/venue/291291 (åpent til kl. 3 hver dag!)"}	vanlig
{"name": "Frognerseteren Restaurant", "coordinates": [10.67732849999993, 59.97767860000001, 0], "description": "Vanlig Nøgne osv."}	vanlig
{"name": "BD57 (BrewDog)", "coordinates": [10.757236599999942, 59.919941300000005, 0], "description": "Kven elskar ikkje Brewdog?<br>https://untappd.com/venue/2875445"}	godt-utvalg
{"name": "Beer Palace", "coordinates": [10.726411299999995, 59.9106478, 0], "description": "https://untappd.com/venue/3733<br>Strikt 23 årsgrense"}	godt-utvalg
{"name": "Bjørungs", "coordinates": [10.728038999999967, 59.92060289999999, 0], "description": "http://www.oslopubguide.com/T/Bjorungs.php"}	godt-utvalg
{"name": "Cafe Fiasco", "coordinates": [10.755038000000013, 59.91213270000001, 0], "description": "http://www.oslopubguide.com/T/CafeFiasco.php<br>http://www.fiasco.no/menu/"}	godt-utvalg
{"name": "Cafe Nero", "coordinates": [10.73107970000001, 59.9263547, 0], "description": "http://www.oslopubguide.com/T/CafeNero.php"}	godt-utvalg
{"name": "Crowbar & Bryggeri", "coordinates": [10.753414799999973, 59.9171972, 0], "description": "https://untappd.com/venue/78243 (23 på kvelden)"}	godt-utvalg
{"name": "Café Sara", "coordinates": [10.754059600000005, 59.9175856, 0], "description": "http://www.cafesara.no/"}	godt-utvalg
{"name": "Dattera til Hagen", "coordinates": [10.760117499999978, 59.9132352, 0], "description": "https://untappd.com/venue/135666"}	godt-utvalg
{"name": "Den Gamle Major", "coordinates": [10.715821000000005, 59.92862800000001, 0], "description": "http://www.oslopubguide.com/T/DenGamleMajor.php"}	godt-utvalg
{"name": "Dr. Jekyll's Pub", "coordinates": [10.733269800000016, 59.9135833, 0], "description": "http://www.oslopubguide.com/T/DrJekyll.php <br>Mykje belgisk øl."}	godt-utvalg
{"name": "Grünerløkka Brygghus", "coordinates": [10.759374999999977, 59.9250799, 0], "description": "Favorittstedet!<br>https://untappd.com/venue/18674"}	godt-utvalg
{"name": "Jarmann Gastropub", "coordinates": [10.728508499999975, 59.91050240000002, 0], "description": "https://untappd.com/venue/2206427"}	godt-utvalg
{"name": "Katedralen Pub & Spiseri", "coordinates": [10.730357000000026, 59.92178000000001, 0], "description": "https://untappd.com/venue/29926<br>http://www.oslopubguide.com/T/KatedralenPub.php"}	godt-utvalg
{"name": "Kulturhuset", "coordinates": [10.74934959999996, 59.91436989999999, 0], "description": "https://untappd.com/venue/779522<br>23 aldersgrense på kveldene"}	godt-utvalg
{"name": "Lorry", "coordinates": [10.728917000000024, 59.920819200000004, 0], "description": "http://www.oslopubguide.com/T/LorryRestaurant.php<br>https://untappd.com/venue/30086"}	godt-utvalg
{"name": "Olympen", "coordinates": [10.76445799999999, 59.912258, 0], "description": "https://untappd.com/venue/4900<br>http://www.oslopubguide.com/T/OlympenMatVinhus.php"}	godt-utvalg
{"name": "Oslo mekaniske verksted", "coordinates": [10.762371099999998, 59.9114148, 0], "description": "https://untappd.com/venue/78243 (strikt 23)"}	godt-utvalg
{"name": "Oslo Mikrobryggeri", "coordinates": [10.72418970000001, 59.924322700000005, 0], "description": "http://www.oslopubguide.com/T/OsloMikrobryggeri.php"}	godt-utvalg
{"name": "Schouskjelleren", "coordinates": [10.760323500000027, 59.9183891, 0], "description": "Kan vere vanskeleg å finne inngangen ;-)<br>https://untappd.com/venue/43944<br>http://www.oslopubguide.com/T/SchousKjelleren.php"}	godt-utvalg
{"name": "Royal Gastropub", "coordinates": [10.750935600000048, 59.9108058, 0], "description": "https://untappd.com/venue/2557498<br>Mykje dyrere enn dei fleste stadar, men bra"}	godt-utvalg
{"name": "Nedre Foss Gård", "coordinates": [10.753829699999983, 59.9221934, 0], "description": "Kvil i Fred :'(<br>https://untappd.com/venue/2886153<br>http://www.osloby.no/nyheter/Deler-av-Nedre-Foss-gard-pa-Grnerlokka-totalskadet-i-brann-8300839.html"}	godt-utvalg
{"name": "Wurst Øl- og Pølsebar", "coordinates": [10.748714199999997, 59.91367729999999, 0], "description": "Strikt 23, mykje tyskinspirert øl og pølser"}	godt-utvalg
{"name": "Amundsen Bryggeri & Spiseri", "coordinates": [10.734848800000009, 59.91353969999999, 0], "description": "https://untappd.com/venue/47552"}	godt-utvalg
{"name": "Café Laundromat", "coordinates": [10.730507100000068, 59.9254761, 0], "description": "https://untappd.com/venue/34098"}	godt-utvalg
{"name": "HåndverkerStuene", "coordinates": [10.739653699999963, 59.91496079999999, 0], "description": "https://untappd.com/venue/58626"}	godt-utvalg
{"name": "Gaasa", "coordinates": [10.756081399999971, 59.9152457, 0], "description": "https://untappd.com/venue/265339"}	godt-utvalg
{"name": "Hendrix Ibsen", "coordinates": [10.75138370000002, 59.9219307, 0], "description": "https://untappd.com/venue/2903938"}	godt-utvalg
{"name": "Nydalen Bryggeri og Spiseri", "coordinates": [10.764605999999958, 59.9500679, 0], "description": null}	godt-utvalg
{"name": "Smelteverket", "coordinates": [10.752339000000006, 59.92240750000001, 0], "description": "https://untappd.com/venue/428663"}	godt-utvalg
{"name": "The Pub", "coordinates": [10.715445999999929, 59.927639, 0], "description": "https://untappd.com/venue/1581114"}	godt-utvalg
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Name: pubs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pubs
    ADD CONSTRAINT pubs_pkey PRIMARY KEY (pub_key);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

