-- drops
DROP TABLE IF EXISTS utenti;
DROP TABLE IF EXISTS artisti;
DROP TABLE IF EXISTS brani;
DROP TABLE IF EXISTS episodi;
DROP TABLE IF EXISTS abbonamenti;
DROP TABLE IF EXISTS playlist;
DROP TABLE IF EXISTS preferiti;


-- creazione tabelle
CREATE TABLE utenti (
    nome varchar(25) NOT NULL,
    cognome varchar(25) NOT NULL,
    email varchar(25) UNIQUE NOT NULL,
    password varchar(16) NOT NULL,
    nickname varchar(25), -- TODO: same as above
    abbonamento char(1) NOT NULL,
    frequenzaAddebito char(1) NOT NULL,
    scadenzaAbbonamento date NOT NULL,
);

CREATE TABLE artisti (
    nome varchar(25),
    email varchar(25) NOT NULL,
    password varchar(16) NOT NULL,
    bic varchar(11) NOT NULL,
    iban char(27) NOT NULL,
    stato char(2) NOT NULL,
    cap char(5) NOT NULL,
    via varchar(50) NOT NULL,
    ncivico smallint NOT NULL -- TODO: Numeri civici con lettere es: 14/B? Metterei un varchar
);

CREATE TABLE brani (
    titolo varchar(25),
    artista varchar(25) NOT NULL,
    album varchar(25) NOT NULL,
    traccia smallint NOT NULL,
    durata varchar(8) NOT NULL,
    annoUscita year NOT NULL,
    genere varchar(12) NOT NULL,
    riproduzioni int(255) NOT NULL
);

CREATE TABLE episodi (
    titolo varchar(25),
    podcaster varchar(25) NOT NULL,
    podcast varchar(25) NOT NULL,
    nepisodio smallint NOT NULL,
    durata varchar(8) NOT NULL,
    annoUscita year NOT NULL,
    genere varchar(12) NOT NULL,
    riproduzioni int(255) NOT NULL
);

CREATE TABLE abbonamenti (
    id char(1),
    nome varchar(8) NOT NULL,
    prezzoMensile smallint NOT NULL,
    prezzoAnnuale smallint NOT NULL,
);

CREATE TABLE carte (
    numeroCarta char(16),
    circuito varchar(10) NOT NULL,
    scadenza date NOT NULL,
    ccv char(3) NOT NULL,
    intestatario varchar(25) NOT NULL
);

CREATE TABLE playlist (
    nome varchar(25),
    autore varchar(25) NOT NULL,
    dataCreazione date NOT NULL,
    titolo varchar(25) NOT NULL,
    artista varchar(25) NOT NULL,
    album varchar(25) NOT NULL,
);

CREATE TABLE preferiti (
    titolo varchar(25),
    autore varchar(25) NOT NULL,
    proprietario varchar(25) NOT NULL,
    tipo char(1) NOT NULL -- TODO: funzionale?
);

CREATE TABLE metodiDiPagamento (
    nickname varchar(25),
    numeroCarta char(16),
    email varchar(25)
);

CREATE TABLE digitali (
    email varchar(25),
    password varchar(16) NOT NULL,
    tipo varchar(10) NOT NULL
);

CREATE TABLE pagamenti (
    idTransazione varchar(25), --TODO: lunghezza variabile?
    iban char(27) NOT NULL,
    importo float(8,2) NOT NULL,
    beneficiario varchar(25) NOT NULL,
    dataEsecuzione year NOT NULL
);

-- inserimento dati
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('M', 'Music', );
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('P', 'Podcast', );
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('F', 'Full', );
