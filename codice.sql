-- drops
DROP TABLE IF EXISTS utenti;
DROP TABLE IF EXISTS artisti;
DROP TABLE IF EXISTS brani;
DROP TABLE IF EXISTS episodi;
DROP TABLE IF EXISTS abbonamenti;
DROP TABLE IF EXISTS playlist;
DROP TABLE IF EXISTS preferiti;
DROP TABLE IF EXISTS pagamenti;
DROP TABLE IF EXISTS metodiDiPagamento;
DROP TABLE IF EXISTS digitali;
DROP TABLE IF EXISTS carte;


-- creazione tabelle
CREATE TABLE utenti (
    nome varchar(25) NOT NULL,
    cognome varchar(25) NOT NULL,
    email varchar(25) UNIQUE NOT NULL,
    password varchar(16) NOT NULL, 
    nickname varchar(25),
    abbonamento char(1) NOT NULL,
    frequenzaAddebito char(1) NOT NULL,
    scadenzaAbbonamento date NOT NULL,
    PRIMARY KEY (nickname)
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
    ncivico varchar(8) NOT NULL,
    PRIMARY KEY (nome)
);

CREATE TABLE brani (
    titolo varchar(25),
    artista varchar(25),
    album varchar(25),
    traccia smallint NOT NULL,
    durata varchar(8) NOT NULL,
    annoUscita year NOT NULL,
    genere varchar(12) NOT NULL,
    riproduzioni int(255) NOT NULL,
    PRIMARY KEY (titolo, artista, album),
    FOREIGN KEY (artista) REFERENCES artisti(nome)
);

CREATE TABLE episodi (
    titolo varchar(25),
    podcaster varchar(25),
    podcast varchar(25),
    nepisodio smallint NOT NULL,
    durata varchar(8) NOT NULL,
    annoUscita year NOT NULL,
    genere varchar(12) NOT NULL,
    riproduzioni int(255) NOT NULL,
    PRIMARY KEY (titolo, podcaster, podcast),
    FOREIGN KEY (podcaster) REFERENCES artisti(nome)
);

CREATE TABLE abbonamenti (
    id char(1),
    nome varchar(8) NOT NULL,
    prezzoMensile float(4,2) NOT NULL,
    prezzoAnnuale float(4,2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES utenti(abbonamento)
);

CREATE TABLE metodiDiPagamento (
    nickname varchar(25),
    numeroCarta char(16),
    email varchar(25),
    PRIMARY KEY (nickname)
);

CREATE TABLE carte (
    numeroCarta char(16),
    circuito varchar(10) NOT NULL,
    scadenza date NOT NULL,
    ccv char(3) NOT NULL,
    intestatario varchar(25) NOT NULL,
    PRIMARY KEY (numeroCarta),
    FOREIGN KEY (numeroCarta) REFERENCES metodiDiPagamento(numeroCarta)
);

CREATE TABLE playlist (
    nome varchar(25),
    autore varchar(25) NOT NULL,
    dataCreazione date NOT NULL,
    titolo varchar(25) NOT NULL,
    artista varchar(25) NOT NULL,
    album varchar(25) NOT NULL,
    PRIMARY KEY (nome),
    FOREIGN KEY (titolo, artista, album) REFERENCES brani(titolo, artista, album),
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

CREATE TABLE digitali (
    email varchar(25),
    password varchar(16) NOT NULL,
    tipo varchar(10) NOT NULL,
    PRIMARY KEY (email),
    FOREIGN KEY (email) REFERENCES metodiDiPagamento(email)
);

CREATE TABLE pagamenti (
    idTransazione char(5),
    iban char(27) NOT NULL,
    importo float(8,2) NOT NULL,
    beneficiario varchar(25) NOT NULL,
    dataEsecuzione date NOT NULL,
    PRIMARY KEY (idTransazione),
    FOREIGN KEY (iban) REFERENCES artisti(iban)
);

-- inserimento dati
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('M', 'Music', );
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('P', 'Podcast', );
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('F', 'Full', );
