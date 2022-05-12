-- drops
DROP TABLE IF EXISTS utenti CASCADE;
DROP TABLE IF EXISTS artisti CASCADE;
DROP TABLE IF EXISTS brani CASCADE;
DROP TABLE IF EXISTS episodi CASCADE;
DROP TABLE IF EXISTS abbonamenti CASCADE;
DROP TABLE IF EXISTS playlist CASCADE;
DROP TABLE IF EXISTS preferiti CASCADE;
DROP TABLE IF EXISTS pagamenti CASCADE;
DROP TABLE IF EXISTS metodiDiPagamento CASCADE;
DROP TABLE IF EXISTS digitali CASCADE;
DROP TABLE IF EXISTS carte CASCADE;


-- creazione tabelle
CREATE TABLE abbonamenti (
    id char(1),
    nome varchar(8) NOT NULL,
    prezzoMensile float(24) NOT NULL,
    prezzoAnnuale float(24) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE utenti (
    nickname varchar(25),
    nome varchar(25) NOT NULL,
    cognome varchar(25) NOT NULL,
    email varchar(25) NOT NULL,
    password varchar(16) NOT NULL, 
    abbonamento char(1) NOT NULL,
    frequenzaAddebito char(1) NOT NULL,
    scadenzaAbbonamento date NOT NULL,
    PRIMARY KEY (nickname),
    UNIQUE (email),
    FOREIGN KEY (abbonamento) REFERENCES abbonamenti(id)
);

CREATE TABLE artisti (
    nome varchar(25),
    iban char(27) NOT NULL,
    email varchar(25) NOT NULL,
    password varchar(16) NOT NULL,
    bic varchar(11) NOT NULL,
    stato char(2) NOT NULL,
    cap char(5) NOT NULL,
    via varchar(50) NOT NULL,
    ncivico varchar(8) NOT NULL,
    PRIMARY KEY (iban),
    UNIQUE (nome)
);

CREATE TABLE carte (
    numeroCarta char(16),
    circuito varchar(10) NOT NULL,
    scadenza date NOT NULL,
    ccv char(3) NOT NULL,
    intestatario varchar(25) NOT NULL,
    PRIMARY KEY (numeroCarta)
);

CREATE TABLE digitali (
    email varchar(25),
    password varchar(16) NOT NULL,
    tipo varchar(10) NOT NULL,
    PRIMARY KEY (email)
);

CREATE TABLE metodiDiPagamento (
    nickname varchar(25),
    numeroCarta char(16),
    email varchar(25),
    PRIMARY KEY (nickname),
    FOREIGN KEY (numeroCarta) REFERENCES carte(numeroCarta),
    FOREIGN KEY (email) REFERENCES digitali(email)
);

CREATE TABLE brani (
    titolo varchar(25),
    artista varchar(25) NOT NULL,
    album varchar(25) NOT NULL,
    traccia smallint NOT NULL,
    durata varchar(8) NOT NULL,
    annoUscita smallint NOT NULL,
    genere varchar(12) NOT NULL,
    riproduzioni int NOT NULL,
    PRIMARY KEY (titolo),
    FOREIGN KEY (artista) REFERENCES artisti(nome)
);

CREATE TABLE episodi (
    titolo varchar(25),
    podcaster varchar(25) NOT NULL,
    podcast varchar(25) NOT NULL,
    nepisodio smallint NOT NULL,
    durata varchar(8) NOT NULL,
    annoUscita smallint NOT NULL,
    genere varchar(12) NOT NULL,
    riproduzioni int NOT NULL,
    PRIMARY KEY (titolo),
    FOREIGN KEY (podcaster) REFERENCES artisti(nome)
);

CREATE TABLE playlist (
    nome varchar(25),
    autore varchar(25) NOT NULL,
    dataCreazione date NOT NULL,
    titolo varchar(25) NOT NULL,
    artista varchar(25) NOT NULL,
    PRIMARY KEY (nome),
    FOREIGN KEY (titolo) REFERENCES brani(titolo),
    FOREIGN KEY (artista) REFERENCES artisti(nome),
    FOREIGN KEY (autore) REFERENCES utenti(nickname)
);

CREATE TABLE preferiti (
    titolo varchar(25),
    autore varchar(25),
    contenutoIn varchar(25),
    proprietario varchar(25) NOT NULL,
    tipo char(1) NOT NULL,
    PRIMARY KEY (titolo, autore, contenutoIn),
    FOREIGN KEY (titolo) REFERENCES brani(titolo),
    FOREIGN KEY (titolo) REFERENCES episodi(titolo) -- ?: POSSIBILE?????
);

CREATE TABLE pagamenti (
    idTransazione char(5),
    iban char(27) NOT NULL,
    importo float(24) NOT NULL,
    beneficiario varchar(25) NOT NULL,
    dataEsecuzione date NOT NULL,
    PRIMARY KEY (idTransazione),
    FOREIGN KEY (iban) REFERENCES artisti(iban)
);

-- inserimento dati
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('M', 'Music', 4.99, 49.99);
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('P', 'Podcast', 2.99, 29.99);
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('F', 'Full', 7.99, 79.99);
