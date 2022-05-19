-- drops
DROP TABLE IF EXISTS pagamenti CASCADE;
DROP TABLE IF EXISTS preferiti CASCADE;
DROP TABLE IF EXISTS playlist CASCADE;
DROP TABLE IF EXISTS episodi CASCADE;
DROP TABLE IF EXISTS brani CASCADE;
DROP TABLE IF EXISTS metodiDiPagamento CASCADE;
DROP TABLE IF EXISTS digitali CASCADE;
DROP TABLE IF EXISTS carte CASCADE;
DROP TABLE IF EXISTS artisti CASCADE;
DROP TABLE IF EXISTS utenti CASCADE;
DROP TABLE IF EXISTS abbonamenti CASCADE;

-- creazione tabelle
CREATE TABLE abbonamenti (
    id CHAR(1),
    nome VARCHAR(8) NOT NULL,
    prezzoMensile FLOAT(24) NOT NULL,
    prezzoAnnuale FLOAT(24) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE utenti (
    username VARCHAR(25),
    nome VARCHAR(25) NOT NULL,
    cognome VARCHAR(25) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(16) NOT NULL, 
    abbonamento CHAR(1) NOT NULL,
    frequenzaAddebito CHAR(1) NOT NULL,
    scadenzaAbbonamento DATE NOT NULL,
    PRIMARY KEY (username),
    UNIQUE (email),
    FOREIGN KEY (abbonamento) REFERENCES abbonamenti(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE artisti (
    nome VARCHAR(25),
    iban VARCHAR(34) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(16) NOT NULL,
    tipo CHAR(1) NOT NULL,
    bic CHAR(11) NOT NULL,
    stato CHAR(2) NOT NULL,
    città VARCHAR(20) NOT NULL,
    cap VARCHAR(8) NOT NULL,
    via VARCHAR(50) NOT NULL,
    ncivico VARCHAR(5) NOT NULL,
    PRIMARY KEY (iban),
    UNIQUE (nome)
); 

CREATE TABLE carte (
    numeroCarta CHAR(19),
    circuito VARCHAR(20) NOT NULL,
    scadenza DATE NOT NULL,
    ccv CHAR(3) NOT NULL,
    intestatario VARCHAR(25) NOT NULL,
    PRIMARY KEY (numeroCarta)
);

CREATE TABLE digitali (
    email VARCHAR(50),
    password VARCHAR(12) NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    PRIMARY KEY (email)
);

CREATE TABLE metodiDiPagamento (
    username VARCHAR(25),
    numeroCarta CHAR(19),
    email VARCHAR(50),
    PRIMARY KEY (username),
    FOREIGN KEY (numeroCarta) REFERENCES carte(numeroCarta) 
        ON DELETE SET NULL -- TODO: è davvero giusto? testare
        ON UPDATE CASCADE,
    FOREIGN KEY (email) REFERENCES digitali(email)
        ON DELETE SET NULL -- TODO: è davvero giusto? testare
        ON UPDATE CASCADE,
    CHECK (numeroCarta IS NOT NULL OR email IS NOT NULL)
);

CREATE TABLE brani (
    titolo VARCHAR(25),
    artista VARCHAR(25) NOT NULL,
    album VARCHAR(25) NOT NULL,
    traccia SMALLINT NOT NULL CHECK (traccia > 0),
    durata VARCHAR(8) NOT NULL,
    annoUscita SMALLINT NOT NULL,
    genere VARCHAR(12) NOT NULL,
    riproduzioni int NOT NULL,
    PRIMARY KEY (titolo),
    FOREIGN KEY (artista) REFERENCES artisti(nome)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE episodi (
    titolo VARCHAR(50),--cambiato in 50, alcuni titoli erano troppo lunghi, cambiato anche su overleaf
    podcaster VARCHAR(25) NOT NULL,
    podcast VARCHAR(25) NOT NULL,
    nepisodio SMALLINT NOT NULL,
    durata VARCHAR(8) NOT NULL,
    annoUscita SMALLINT NOT NULL,
    genere VARCHAR(15) NOT NULL,--stessa cosa di sopra
    riproduzioni int NOT NULL CHECK (riproduzioni >= 0),
    PRIMARY KEY (titolo),
    FOREIGN KEY (podcaster) REFERENCES artisti(nome)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE playlist (
    nome VARCHAR(25),
    autore VARCHAR(25) NOT NULL,
    dataCreazione DATE NOT NULL,
    titolo VARCHAR(25) NOT NULL,
    artista VARCHAR(25) NOT NULL,
    PRIMARY KEY (nome),
    FOREIGN KEY (titolo) REFERENCES brani(titolo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (artista) REFERENCES artisti(nome)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (autore) REFERENCES utenti(username)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE preferiti (
    titolo VARCHAR(25),
    autore VARCHAR(25),
    proprietario VARCHAR(25) NOT NULL,
    tipo CHAR(1) NOT NULL,
    PRIMARY KEY (titolo, autore),
    FOREIGN KEY (titolo) REFERENCES brani(titolo)  --Anche qui da problemi, riconosce solo la chiave esterna con brani e non anche con episodi, bisogna capire bene come aggiustare
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (titolo) REFERENCES episodi(titolo)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE pagamenti (
    idTransazione CHAR(5),
    iban VARCHAR(34) NOT NULL,
    importo FLOAT(24) NOT NULL,
    beneficiario VARCHAR(25) NOT NULL,
    dataEsecuzione DATE NOT NULL,
    PRIMARY KEY (idTransazione),
    FOREIGN KEY (iban) REFERENCES artisti(iban)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- TODO: preferiti, playlist, episodi, brani, 
-- TODO: rimuovere alcune carte/digitali (anche da metodiDiPagamento)
-- inserimento dati

-- abbonamenti
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('M', 'Music', 4.99, 49.99);
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('P', 'Podcast', 2.99, 29.99);
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('F', 'Full', 7.99, 79.99);

-- utenti

INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('battfield0', 'Ber', 'Attfield', 'battfield0@dailymotion.com', 'wwWK7C4', 'P', 'M', '2023-03-15');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lglawsop1', 'Latrina', 'Glawsop', 'lglawsop1@paginegialle.it', '0WmnzxnXw', 'P', 'M', '2022-10-31');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('bbaldam2', 'Burgess', 'Baldam', 'bbaldam2@about.me', 'm9xRM68qoQGq', 'P', 'A', '2023-02-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('mbratch3', 'Mela', 'Bratch', 'mbratch3@bluehost.com', 'BFF8AfjFZ3t', 'F', 'A', '2023-07-23');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('mantognoni4', 'Maurizia', 'Antognoni', 'mantognoni4@de.vu', 'EUc93TnR', 'P', 'M', '2023-11-23');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('sisworth5', 'Sayre', 'Isworth', 'sisworth5@cmu.edu', 'iGuohPtAm', 'F', 'M', '2022-08-19');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('nsawney6', 'Nesta', 'Sawney', 'nsawney6@storify.com', '3CM6LElBd2', 'P', 'M', '2023-06-12');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('bboanas7', 'Binky', 'Boanas', 'bboanas7@istockphoto.com', 'vjT8zWIe4L3w', 'P', 'A', '2023-10-23');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('aleffek8', 'Adriena', 'Leffek', 'aleffek8@sogou.com', 'RrF2Wvs5qG', 'P', 'A', '2022-12-10');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('dmcinnery9', 'Dyana', 'McInnery', 'dmcinnery9@wordpress.org', 'Dy9Rl9wvg', 'M', 'A', '2022-08-15');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lgumerya', 'Libby', 'Gumery', 'lgumerya@japanpost.jp', 'DYDD9HyU1', 'M', 'M', '2022-12-20');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('gjohnseeb', 'Gusella', 'Johnsee', 'gjohnseeb@uol.com.br', 'DLG2WV', 'M', 'A', '2022-08-22');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('rgopsellc', 'Rice', 'Gopsell', 'rgopsellc@yahoo.co.jp', '8hNkXJQ2Rh', 'P', 'A', '2023-12-16');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('btonryd', 'Bobby', 'Tonry', 'btonryd@ovh.net', 'gHfwTF2', 'F', 'A', '2023-09-30');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('hbouldse', 'Hilary', 'Boulds', 'hbouldse@delicious.com', 'tZoWYdVazA', 'M', 'M', '2022-11-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('dlashbrookf', 'Dewey', 'Lashbrook', 'dlashbrookf@nature.com', 'eBUHK1ut', 'F', 'M', '2023-10-28');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('mruckhardg', 'Meg', 'Ruckhard', 'mruckhardg@globo.com', 'HeTCXRRB', 'P', 'M', '2023-07-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('qgreenleyh', 'Quill', 'Greenley', 'qgreenleyh@cdc.gov', 'Au7Dr6KQ', 'F', 'M', '2022-09-27');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('fpostilli', 'Fraze', 'Postill', 'fpostilli@t-online.de', 'LoNmvpaU0JC', 'M', 'M', '2023-10-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('shaycoxj', 'Samantha', 'Haycox', 'shaycoxj@fda.gov', 'lm3VFJmPweZ', 'P', 'A', '2023-01-08');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('tswinyardk', 'Titus', 'Swinyard', 'tswinyardk@trellian.com', 'pjO767HaL5wX', 'F', 'M', '2022-09-27');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('epotelll', 'Engelbert', 'Potell', 'epotelll@seattletimes.com', 'WsVzkfcMu0X', 'F', 'A', '2023-06-04');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('mvanderweedenburgm', 'Merv', 'Van Der Weedenburg', 'mvanderweedenburgm@moonfruit.com', '7iYW3D8dQRiR', 'P', 'M', '2023-07-22');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('ggrimmen', 'Giorgio', 'Grimme', 'ggrimmen@webeden.co.uk', 'G0v5Q7M', 'P', 'M', '2023-10-23');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('bskeatho', 'Bathsheba', 'Skeath', 'bskeatho@elegantthemes.com', 'JkYgYL7qc', 'F', 'A', '2023-11-20');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('mgarlandp', 'Merv', 'Garland', 'mgarlandp@trellian.com', 'v6FHW3h', 'F', 'A', '2022-10-19');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lstanbridgeq', 'Laurie', 'Stanbridge', 'lstanbridgeq@xing.com', 'VAM7TcBoWBs', 'P', 'M', '2023-11-22');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('otregustr', 'Odie', 'Tregust', 'otregustr@canalblog.com', 'gSAi6hsTDQ1', 'M', 'A', '2023-03-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('djaines', 'Drona', 'Jaine', 'djaines@yale.edu', 'U12n0MJrz', 'F', 'A', '2023-05-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('ldruhant', 'Leela', 'Druhan', 'ldruhant@umich.edu', 'TtgXIf', 'M', 'A', '2023-05-09');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('cmcgivenu', 'Carlynne', 'McGiven', 'cmcgivenu@cafepress.com', 'ASpbPbRp1x', 'F', 'M', '2023-11-18');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('pandinov', 'Pegeen', 'Andino', 'pandinov@npr.org', 'cr41uS', 'F', 'M', '2022-08-26');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('fseymarkw', 'Frans', 'Seymark', 'fseymarkw@nifty.com', 'xem816UC7xAU', 'P', 'M', '2022-08-03');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('asleighx', 'Austine', 'Sleigh', 'asleighx@tmall.com', 'xZ5Fca3l4mSx', 'P', 'M', '2023-07-10');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('tmclachlany', 'Tomasine', 'McLachlan', 'tmclachlany@mayoclinic.com', 'SrD6o3f3', 'F', 'M', '2023-06-28');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lhousinz', 'Lotti', 'Housin', 'lhousinz@discuz.net', 'JEZtUhVIz7O3', 'M', 'A', '2022-06-27');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('nchipps10', 'Noami', 'Chipps', 'nchipps10@behance.net', 'FUGfrQvkwki', 'F', 'M', '2023-01-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lsuttaby11', 'Lemar', 'Suttaby', 'lsuttaby11@github.com', 'yNGcJzzKK', 'P', 'M', '2023-04-01');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('wcasado12', 'Winn', 'Casado', 'wcasado12@twitter.com', 'ZiXK5une4V', 'P', 'A', '2023-05-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('pralph13', 'Pall', 'Ralph', 'pralph13@nationalgeographic.com', 'tg0pR1lcK', 'F', 'A', '2023-03-26');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('wannear14', 'Wendie', 'Annear', 'wannear14@prweb.com', 'Ql81lxN', 'P', 'M', '2022-07-06');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('esloane15', 'Elle', 'Sloane', 'esloane15@opera.com', 'QoCm9Jv', 'M', 'M', '2022-08-16');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('cparcell16', 'Christine', 'Parcell', 'cparcell16@home.pl', 'YjEbXdR', 'P', 'A', '2023-11-12');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('rburburough17', 'Richardo', 'Burburough', 'rburburough17@paypal.com', 'g7WpTS7VW', 'M', 'A', '2022-11-12');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('bmorot18', 'Bryna', 'Morot', 'bmorot18@berkeley.edu', 's66ij9in37E', 'M', 'M', '2023-01-28');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('gmorando19', 'Gaven', 'Morando', 'gmorando19@si.edu', 'dpIa41j6I87', 'M', 'M', '2022-10-08');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('pshepland1a', 'Perry', 'Shepland', 'pshepland1a@thetimes.co.uk', 'XmEv1R', 'F', 'A', '2023-01-31');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('eredmille1b', 'Emmett', 'Redmille', 'eredmille1b@symantec.com', 'rQf2FzAq', 'F', 'A', '2023-12-19');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('mbrazener1c', 'Millie', 'Brazener', 'mbrazener1c@nps.gov', '90pI022t0p', 'P', 'M', '2023-06-29');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('brennicks1d', 'Brandon', 'Rennicks', 'brennicks1d@cocolog-nifty.com', 'tNcOZFQKmxAh', 'P', 'M', '2023-09-28');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('jdalgliesh1e', 'Jenine', 'Dalgliesh', 'jdalgliesh1e@wiley.com', 'bIeCZbPsHn', 'F', 'A', '2022-07-18');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('cmahady1f', 'Cindra', 'Mahady', 'cmahady1f@sciencedirect.com', 'q1rzwQDBt', 'F', 'M', '2023-06-26');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('emcvitie1g', 'Evan', 'McVitie', 'emcvitie1g@list-manage.com', 'cCJkUxaZ0', 'F', 'M', '2023-04-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('mwheatman1h', 'Michal', 'Wheatman', 'mwheatman1h@harvard.edu', 'KNL3XA0SR', 'M', 'A', '2023-01-14');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('tmallen1i', 'Tabbie', 'Mallen', 'tmallen1i@va.gov', 'D2o3my', 'P', 'M', '2022-07-14');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('ptatterton1j', 'Perle', 'Tatterton', 'ptatterton1j@yandex.ru', 'bxBSfhDCi1V', 'M', 'A', '2022-12-25');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('pslyme1k', 'Paulo', 'Slyme', 'pslyme1k@cbsnews.com', 'MwV2OAw00Y0V', 'P', 'A', '2023-05-07');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('jinchboard1l', 'Jehanna', 'Inchboard', 'jinchboard1l@hubpages.com', 'xNeNt9EAqUU', 'M', 'M', '2022-12-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lstoaks1m', 'Lotty', 'Stoaks', 'lstoaks1m@123-reg.co.uk', 'He9hsfhd', 'F', 'A', '2023-11-17');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('ddundendale1n', 'Dare', 'Dundendale', 'ddundendale1n@w3.org', 'jWFeo7x', 'P', 'M', '2023-05-15');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('cvouls1o', 'Charin', 'Vouls', 'cvouls1o@4shared.com', 'YRZewt', 'M', 'M', '2022-11-20');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lfreckleton1p', 'Libbey', 'Freckleton', 'lfreckleton1p@ycombinator.com', 'irjqCR6', 'P', 'M', '2023-10-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lhalpine1q', 'Lotte', 'Halpine', 'lhalpine1q@prnewswire.com', '86UrMTear', 'F', 'M', '2023-08-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('bcrudginton1r', 'Bernie', 'Crudginton', 'bcrudginton1r@infoseek.co.jp', 'ltLBWVx', 'P', 'M', '2023-02-16');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('rlayson1s', 'Ricki', 'Layson', 'rlayson1s@twitter.com', 'c8eUpTe1k', 'F', 'A', '2023-09-09');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lkausche1t', 'Leesa', 'Kausche', 'lkausche1t@ted.com', 'aF8ufPlUYsTy', 'M', 'A', '2023-07-07');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('jdumberell1u', 'Jacklyn', 'Dumberell', 'jdumberell1u@google.es', 'JwjS1Ne8', 'P', 'A', '2022-07-30');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('apain1v', 'Aldus', 'Pain', 'apain1v@google.com.hk', '9sB0FGtF', 'P', 'A', '2022-07-05');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('epawfoot1w', 'Elysia', 'Pawfoot', 'epawfoot1w@fastcompany.com', 'dARpdp54e', 'P', 'A', '2023-11-10');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('epearcey1x', 'Ema', 'Pearcey', 'epearcey1x@1und1.de', 'XSCN12ZS', 'P', 'M', '2022-10-07');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('eedgley1y', 'Eliot', 'Edgley', 'eedgley1y@springer.com', 'BDUIp92Gx', 'P', 'A', '2023-03-08');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('jgeistbeck1z', 'Jacinda', 'Geistbeck', 'jgeistbeck1z@columbia.edu', 'bSCHakDLU', 'P', 'M', '2022-08-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('dmcmullen20', 'Drugi', 'McMullen', 'dmcmullen20@360.cn', 'R61TTFMO3Q9', 'P', 'M', '2023-07-16');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('eleggon21', 'Ellyn', 'Leggon', 'eleggon21@economist.com', 'SGzipq', 'P', 'M', '2022-07-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('jyarnley22', 'Jaime', 'Yarnley', 'jyarnley22@xinhuanet.com', 'ABf2NAn2H1b', 'F', 'M', '2023-12-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('jperche23', 'Jobey', 'Perche', 'jperche23@networksolutions.com', 'Xj8xxMS', 'M', 'A', '2023-02-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('jkemitt24', 'Jocelin', 'Kemitt', 'jkemitt24@ehow.com', 'rV40VxvBkxi', 'F', 'M', '2023-11-08');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('sklein25', 'Shelly', 'Klein', 'sklein25@msn.com', '6z6PDVLtT', 'M', 'A', '2023-09-04');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('rfreke26', 'Roddie', 'Freke', 'rfreke26@mlb.com', '7F7lXk97UF', 'P', 'A', '2022-10-05');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('bskypp27', 'Bernita', 'Skypp', 'bskypp27@opensource.org', '6pPeLIL5l9', 'P', 'A', '2022-09-30');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lpullman28', 'Lenna', 'Pullman', 'lpullman28@typepad.com', 'PN2XMpJVJr', 'F', 'A', '2023-09-25');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('tmccurry29', 'Therine', 'McCurry', 'tmccurry29@irs.gov', 'urDlM4w', 'F', 'M', '2022-08-09');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('blindner2a', 'Briggs', 'Lindner', 'blindner2a@taobao.com', 'pxW3HKVSzmu', 'M', 'A', '2023-11-07');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('dpocknoll2b', 'Donn', 'Pocknoll', 'dpocknoll2b@fc2.com', 'ZAuGp73Z1UmR', 'M', 'M', '2022-07-23');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('rjauncey2c', 'Ruthi', 'Jauncey', 'rjauncey2c@cpanel.net', 'vvRnyUSJ69MY', 'M', 'M', '2023-01-15');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('mbroadbent2d', 'Merell', 'Broadbent', 'mbroadbent2d@nydailynews.com', 'Yjnia0jwOr', 'F', 'M', '2023-10-30');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('gglasspoole2e', 'Gustie', 'Glasspoole', 'gglasspoole2e@uiuc.edu', 'YVcwok', 'M', 'M', '2023-09-20');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('hprowse2f', 'Hayden', 'Prowse', 'hprowse2f@fc2.com', 'CRcEVzvR', 'F', 'M', '2023-04-04');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('dalcido2g', 'Deva', 'Alcido', 'dalcido2g@japanpost.jp', 'cjm6Gi', 'P', 'A', '2023-04-26');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('lflanagan2h', 'Letisha', 'Flanagan', 'lflanagan2h@slideshare.net', 'YPTB8pzY', 'M', 'M', '2022-09-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('fminmagh2i', 'Fannie', 'Minmagh', 'fminmagh2i@github.io', 'DN34uU', 'M', 'A', '2023-11-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('rdoget2j', 'Rayna', 'Doget', 'rdoget2j@flavors.me', 'LXTjCej6eB', 'P', 'A', '2023-02-08');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('smurie2k', 'Sammy', 'Murie', 'smurie2k@soup.io', 'id1TtvsFG5t', 'P', 'A', '2022-10-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('cbingall2l', 'Claudianus', 'Bingall', 'cbingall2l@ca.gov', 'yMBmKC', 'M', 'A', '2023-12-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('dchesters2m', 'Damian', 'Chesters', 'dchesters2m@archive.org', 'CcFy40A410', 'M', 'M', '2023-04-17');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('jtenny2n', 'Jessamyn', 'Tenny', 'jtenny2n@gnu.org', 'sK3iTZg46Y5', 'M', 'A', '2023-05-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('smutter2o', 'Scarlet', 'Mutter', 'smutter2o@so-net.ne.jp', 'ApOqiDI1', 'M', 'M', '2022-12-13');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('fastupenas2p', 'Frank', 'Astupenas', 'fastupenas2p@china.com.cn', 'pUP0Y3jw', 'P', 'A', '2023-11-28');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('atitcumb2q', 'Alexina', 'Titcumb', 'atitcumb2q@so-net.ne.jp', 'Vt4MJuduhv', 'P', 'M', '2022-12-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAddebito, scadenzaAbbonamento) VALUES ('aplayle2r', 'Abner', 'Playle', 'aplayle2r@hostgator.com', 'N4kDCcNssSF', 'F', 'M', '2022-06-27');


--artisti
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Radiohead', 'FR63 7167 7478 48MA 8DWH XZ7G 807', 'radiohead@google.com.au', 'Ch2en6', 'M', '771367516-7', 'CO', 'Colorado Springs', '80925', 'Farwell Park', '309');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Oasis', 'SA52 25FB E7QU PBRE ST1N QJTO', 'oasis@google.es', 'S97iyf', 'M', '779039682-X', 'NY', 'Buffalo', '14276', 'Spaight Crossing', '18181');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Green Day', 'HR68 9944 1950 3043 0703 3', 'greenday@salon.com', 'lglnRN1', 'M', '703269183-8', 'PA', 'Erie', '16505', 'Golf Course Alley', '02');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Billie Eilish', 'RS03 7201 8004 3045 5248 23', 'billieeilish@virginia.edu', 'CF2elvCKuo6', 'M', '497355926-1', 'KY', 'Louisville', '40293', 'Huxley Alley', '709');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Michael Jackson', 'DK77 5379 4850 9758 03', 'michaeljackson@online.de', 'VLd1s9sh', 'M', '696402584-7', 'WI', 'Milwaukee', '53220', 'Gateway Center', '23');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('M83', 'IS80 3391 4060 2478 2952 2940 60', 'm83@webnode.com', 'su9dMNRa0qJ', 'M', '680243323-0', 'CA', 'Oakland', '94605', 'Sherman Circle', '895');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('N.W.A.', 'LB15 7107 V9ED IZUE ODJ6 WVWR WI6B', 'nwa@zdnet.com', 'wH2Sc3yIncF0', 'M', '406226729-2', 'OK', 'Oklahoma City', '73109', 'Carpenter Alley', '931');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('tha Supreme', 'FR74 9626 6814 426W AVTG OSQ1 N28', 'thasupreme@source.net', 'S7fHZ7', 'M', '221583928-7', 'MN', 'Saint Cloud', '56398', 'Gale Pass', '954');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Travis Scott', 'FR85 1739 6990 20M8 B40W F3S5 I38', 'travisscott@hexun.com', 'yBzcIxMa0B3Q', 'M', '167443761-7', 'MI', 'Detroit', '48224', 'School Hill', '1');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Sting', 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', 'sting@google.ca', 'iVa633m', 'M', '710344456-0', 'DC', 'Washington', '20260', 'Everett Parkway', '81348');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Paky', 'SA13 06LF 6MGT LDXO TF03 YPAI', 'paky@google.com', 'YM3TIroxk', 'M', '964237899-X', 'NY', 'Buffalo', '14225', 'Crowley Junction', '58974');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('U2', 'IT45 I433 6238 148O GK21 HBJK FCO', 'u2@gizmodo.com', '3pyaRfE4', 'M', '394432041-7', 'TX', 'El Paso', '79945', 'Eagle Crest Lane', '783');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('The Police', 'ME11 8326 6137 7728 8656 40', 'thepolice@bloomberg.com', 'um7JSN', 'M', '339743027-5', 'NC', 'Raleigh', '27610', 'Hayes Lane', '332');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Pink Floyd', 'SM77 X624 8847 138I XOVU MQJX 0Y0', 'pinkfloyd@globo.com', 'I2mG98moFKRi', 'M', '481675554-3', 'MS', 'Meridian', '39305', 'Briar Crest Lane', '3306');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Dire Straits', 'BG07 MSOP 0287 68IY XW71 7B', 'direstraits@mashable.com', '3HJ74y0', 'M', '471626091-7', 'CA', 'Garden Grove', '92844', 'Arkansas Circle', '561');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('One Direction', 'BG06 XMGU 6476 74C4 AUBY Q0', 'onedirection@ovh.net', '6vGrgxay1f', 'M', '594860296-6', 'GA', 'Atlanta', '31119', 'Schiller Pass', '3');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Eminem', 'GI44 HLYH JLEP SIVL PMD0 N6T', 'eminem@reference.com', 'VNkgNJnKaOno', 'M', '276594334-6', 'TX', 'Austin', '78749', 'Arkansas Parkway', '314');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('The Doors', 'FR37 1587 7806 71YF YPLR FOUC 324', 'thedoors@music.com', 'KKyB6Hr', 'M', '218789284-0', 'IL', 'Peoria', '61605', 'Hazelcrest Parkway', '5');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Hans Zimmer', 'LU36 892V P2MA KKNQ IPGU', 'hanszimmer@freemon.com', 'QY9AGlq', 'M', '606393650-5', 'CA', 'San Jose', '95133', 'Declaration Pass', '2');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Ennio Morricone', 'RS11 6947 4908 0336 2189 15', 'ennio@gmail.it', 'caIjwOgL0', 'M', '235657180-9', 'LA', 'New Orleans', '70142', 'Clemons Junction', '2700');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Marco Montemagno', 'GI13 UPHJ 7Z4R H3RF CX8A K6Y', 'montemagno@exper.it', 'gIioqujqK', 'P', '984843537-9', 'MI', 'Detroit', '48206', 'Melby Pass', '3422');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Alessandro Barbero', 'AZ97 HOQL WLQF WTN3 WKMH WCLI QLNC', 'barbero@volnet.it', 'M6YjjAchQ2z', 'P', '549876954-7', 'DC', 'Washington', '20051', 'Express Trail', '916');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Oroscopo', 'PL95 3506 6134 4492 5495 8021 5877', 'oroscopo@gmail.it', 'COEMandeutF', 'P', '403633470-0', 'CA', 'Oakland', '94605', 'Golf Plaza', '3918');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Muschio Selvaggio', 'MR37 2738 7388 1820 2464 1435 299', 'muschio@doorn.it', 'Z7CWDfWT5Q', 'P', '472972148-9', 'NY', 'Albany', '12237', 'Westridge Alley', '6037');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Joe Rogan', 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', 'joerogan@gmail.com', 'iStoHI3', 'P', '491884308-5', 'TX', 'Lubbock', '79491', 'Rigney Crossing', '11');

-- carte
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('6759642689777301564', 'maestro', '2027-02-28', 282, 'Ber Attfield');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('346475665414972', 'americanexpress', '2027-02-01', 537, 'Latrina Glawsop');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5038592000771312', 'maestro', '2026-08-21', 122, 'Burgess Baldam');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4091698261471', 'visa', '2027-02-21', 811, 'Mela Bratch');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017952707235243', 'visa', '2027-04-01', 446, 'Maurizia Antognoni');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('50389069269174638', 'maestro', '2026-03-16', 213, 'Sayre Isworth');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041591159421', 'visa', '2027-01-13', 794, 'Nesta Sawney');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374622274876035', 'americanexpress', '2025-05-13', 114, 'Binky Boanas');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('0604344144465236', 'maestro', '2024-06-29', 958, 'Adriena Leffek');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4616307499573', 'visa', '2026-05-16', 437, 'Dyana Mcinnery');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5038222259806441', 'maestro', '2026-03-11', 207, 'Libby Gumery');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5048371077548590', 'mastercard', '2026-09-27', 742, 'Gusella Johnsee');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175009230426332', 'visa-electron', '2026-08-08', 464, 'Rice Gopsell');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026875047072613', 'visa-electron', '2027-03-18', 199, 'Bobby Tonry');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017952669315', 'visa', '2025-06-04', 130, 'Hilary Boulds');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374288165617365', 'americanexpress', '2025-01-28', 277, 'Dewey Lashbrook');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('67629664149070867', 'maestro', '2026-11-15', 790, 'Meg Ruckhard');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('06045501397442055', 'maestro', '2024-08-02', 398, 'Quill Greenley');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026392629263834', 'visa-electron', '2025-08-03', 904, 'Fraze Postill');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('379128699877199', 'americanexpress', '2025-12-01', 654, 'Samantha Haycox');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175005090470741', 'visa-electron', '2026-03-24', 687, 'Titus Swinyard');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041590424184151', 'visa', '2025-02-22', 513, 'Engelbert Potell');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5048373937328809', 'mastercard', '2025-07-24', 950, 'Merv Van Der Weedenburg');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4405926849636419', 'visa-electron', '2024-10-13', 408, 'Giorgio Grimme');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026765974219685', 'visa-electron', '2025-12-25', 388, 'Bathsheba Skeath');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('372301403195250', 'americanexpress', '2024-11-25', 778, 'Merv Garland');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4508539408080675', 'visa-electron', '2026-05-02', 357, 'Laurie Stanbridge');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4508904770665554', 'visa-electron', '2025-08-09', 582, 'Odie Tregust');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4352948187401852', 'visa', '2026-04-02', 339, 'Drona Jaine');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4405053943092926', 'visa-electron', '2024-08-05', 981, 'Leela Druhan');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('6762432588492472825', 'maestro', '2027-03-07', 739, 'Carlynne Mcgiven');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4405390719744987', 'visa-electron', '2024-09-27', 481, 'Pegeen Andino');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5112455892424607', 'mastercard', '2026-04-23', 457, 'Frans Seymark');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017954063915582', 'visa', '2024-11-18', 891, 'Austine Sleigh');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5100139851467492', 'mastercard', '2026-12-30', 134, 'Tomasine Mclachlan');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('50207165182462785', 'maestro', '2024-11-18', 347, 'Lotti Housin');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('337941107502212', 'americanexpress', '2026-09-06', 242, 'Noami Chipps');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4913165213518623', 'visa-electron', '2025-08-13', 689, 'Lemar Suttaby');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('372073916534222', 'americanexpress', '2027-03-26', 765, 'Winn Casado');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5010121503137326', 'mastercard', '2027-03-08', 260, 'Pall Ralph');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5485740792548723', 'mastercard', '2025-01-29', 133, 'Wendie Annear');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4844773590834820', 'visa-electron', '2026-11-07', 336, 'Elle Sloane');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('372301559328747', 'americanexpress', '2025-09-30', 478, 'Christine Parcell');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4844237948303573', 'visa-electron', '2024-11-18', 992, 'Richardo Burburough');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5104459725390878', 'mastercard', '2027-01-31', 194, 'Bryna Morot');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('343683713952363', 'americanexpress', '2026-09-25', 696, 'Gaven Morando');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5007661032555329', 'mastercard', '2025-12-26', 821, 'Perry Shepland');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('371430824750673', 'americanexpress', '2025-08-20', 864, 'Emmett Redmille');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5100141327562617', 'mastercard', '2026-11-23', 820, 'Millie Brazener');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('379641305026910', 'americanexpress', '2025-01-17', 400, 'Brandon Rennicks');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4917315888596737', 'visa-electron', '2025-03-17', 916, 'Jenine Dalgliesh');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017953988050525', 'visa', '2027-02-15', 965, 'Cindra Mahady');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('6762291214747622813', 'maestro', '2027-02-15', 852, 'Evan Mcvitie');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041591874464838', 'visa', '2025-07-16', 981, 'Michal Wheatman');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5532690314080080', 'mastercard', '2027-03-07', 949, 'Tabbie Mallen');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4405683013184664', 'visa-electron', '2024-05-10', 462, 'Perle Tatterton');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175001273147719', 'visa-electron', '2027-01-18', 461, 'Paulo Slyme');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4508147564439394', 'visa-electron', '2024-05-21', 113, 'Jehanna Inchboard');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4837200778232', 'visa', '2026-12-24', 937, 'Lotty Stoaks');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026555721546476', 'visa-electron', '2025-10-14', 991, 'Dare Dundendale');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041590118261', 'visa', '2025-02-10', 634, 'Charin Vouls');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('67617138732098993', 'maestro', '2024-06-02', 381, 'Libbey Freckleton');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4844915967622128', 'visa-electron', '2026-12-10', 147, 'Lotte Halpine');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4917138230514806', 'visa-electron', '2024-12-30', 474, 'Bernie Crudginton');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4844508916295185', 'visa-electron', '2025-09-23', 541, 'Ricki Layson');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374622320951642', 'americanexpress', '2024-06-13', 785, 'Leesa Kausche');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041593201889836', 'visa', '2026-04-25', 249, 'Jacklyn Dumberell');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374288062438014', 'americanexpress', '2026-04-05', 290, 'Aldus Pain');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041595425703', 'visa', '2024-06-01', 893, 'Elysia Pawfoot');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('63049455595458511', 'maestro', '2025-08-18', 216, 'Ema Pearcey');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041378491482801', 'visa', '2026-02-15', 575, 'Eliot Edgley');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175008287018661', 'visa-electron', '2024-10-13', 492, 'Jacinda Geistbeck');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026127367872515', 'visa-electron', '2027-04-28', 685, 'Drugi Mcmullen');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374622417030177', 'americanexpress', '2025-11-12', 934, 'Ellyn Leggon');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('6761648794046732', 'maestro', '2026-05-23', 406, 'Jaime Yarnley');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175002447616167', 'visa-electron', '2026-11-18', 717, 'Jobey Perche');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5048376220068669', 'mastercard', '2026-08-01', 404, 'Jocelin Kemitt');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5108755717191208', 'mastercard', '2027-05-01', 430, 'Shelly Klein');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5893952058462260000', 'maestro', '2026-07-20', 845, 'Roddie Freke');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('6759717517827035', 'maestro', '2027-03-06', 377, 'Bernita Skypp');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('0604010361231480354', 'maestro', '2027-03-13', 832, 'Lenna Pullman');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4917181658344652', 'visa-electron', '2025-02-12', 359, 'Therine Mccurry');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5020364697566347452', 'maestro', '2025-09-19', 239, 'Briggs Lindner');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374622277123559', 'americanexpress', '2025-02-23', 274, 'Donn Pocknoll');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017950007294', 'visa', '2025-11-24', 597, 'Ruthi Jauncey');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175005610431017', 'visa-electron', '2026-07-15', 179, 'Merell Broadbent');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5145683001731452', 'mastercard', '2026-11-10', 517, 'Gustie Glasspoole');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4917517547908951', 'visa-electron', '2026-01-11', 201, 'Hayden Prowse');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026537772963966', 'visa-electron', '2024-06-01', 161, 'Deva Alcido');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('06041002787912074', 'maestro', '2026-08-24', 960, 'Letisha Flanagan');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('06042482624532708', 'maestro', '2027-03-02', 366, 'Fannie Minmagh');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5497746627918649', 'mastercard', '2025-06-23', 247, 'Rayna Doget');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374288916199788', 'americanexpress', '2026-03-12', 871, 'Sammy Murie');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('337941244866116', 'americanexpress', '2025-03-20', 319, 'Claudianus Bingall');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('50387373872227979', 'maestro', '2025-09-29', 805, 'Damian Chesters');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5018561737565192', 'maestro', '2026-11-05', 601, 'Jessamyn Tenny');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('6762904986674479', 'maestro', '2024-05-24', 715, 'Scarlet Mutter');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5893279803690937622', 'maestro', '2025-01-24', 985, 'Frank Astupenas');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017951357418356', 'visa', '2027-02-03', 232, 'Alexina Titcumb');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('372301387204805', 'americanexpress', '2025-05-24', 669, 'Abner Playle');

-- digitali
INSERT INTO digitali (email, password, tipo) VALUES ('battfield0@dailymotion.com', 'kyOMEck', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('lglawsop1@paginegialle.it', 'wFVrmJEP', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('bbaldam2@about.me', 'xBFZfLkU28', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('mbratch3@bluehost.com', 'CZKBXoTZWmyE', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('mantognoni4@de.vu', 'WNXN5XOYv4', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('sisworth5@cmu.edu', 'CHOqr1', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('nsawney6@storify.com', 'FeeECL', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('bboanas7@istockphoto.com', 'ocAQ1adF6u', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('aleffek8@sogou.com', 'UvfnQmNx', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('dmcinnery9@wordpress.org', 'kjGnJx5vh9', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('lgumerya@japanpost.jp', 'wNJvFy0', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('gjohnseeb@uol.com.br', 'DNrLfXypMF0', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('rgopsellc@yahoo.co.jp', '0gsxPZ2BkhN', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('btonryd@ovh.net', '8npInUD', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('hbouldse@delicious.com', 'FF0JxGFF', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('dlashbrookf@nature.com', '8lG3P4UANT', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('mruckhardg@globo.com', '66EsBc', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('qgreenleyh@cdc.gov', 'ZyfQI4Jj7', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('fpostilli@t-online.de', 'Fpy8Z6V', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('shaycoxj@fda.gov', 'M7ME2OOm', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('tswinyardk@trellian.com', 'hftMmGphar', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('epotelll@seattletimes.com', 'V9iYei7c9uIv', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('mvanderweedenburgm@moonfruit.com', 'zkdVUHgEO', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('ggrimmen@webeden.co.uk', 'JUjnfc1r', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('bskeatho@elegantthemes.com', 'LHkry6B3', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('mgarlandp@trellian.com', 'esfGK1Pu', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('lstanbridgeq@xing.com', 'cXiTaY0C', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('otregustr@canalblog.com', '9cMFoS', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('djaines@yale.edu', 'wUAESU', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('ldruhant@umich.edu', 'WLYnG42GjIE', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('cmcgivenu@cafepress.com', 'KQ8k8Y', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('pandinov@npr.org', 'FV02Myt5', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('fseymarkw@nifty.com', 'i2FC0eQID', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('asleighx@tmall.com', 'mmtiLwAch', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('tmclachlany@mayoclinic.com', '2myB5Uu', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('lhousinz@discuz.net', 'uBq3og68vfxR', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('nchipps10@behance.net', 'NLarlgLAYSYv', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('lsuttaby11@github.com', '0GKviC', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('wcasado12@twitter.com', 'riPdpY9Kd', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('pralph13@nationalgeographic.com', 'nViJJu', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('wannear14@prweb.com', 'KsxI0qFtgN', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('esloane15@opera.com', 'LeJ4sTbK7X9o', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('cparcell16@home.pl', 'ZjG9a9C5x', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('rburburough17@paypal.com', 'r9vty8a', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('bmorot18@berkeley.edu', 'jofFAuAzzU', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('gmorando19@si.edu', 'S7Lxls4t3SmG', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('pshepland1a@thetimes.co.uk', '9YU6fT06tuqh', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('eredmille1b@symantec.com', 'tcwGUeKmUmdM', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('mbrazener1c@nps.gov', 'CumX37xxLx4', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('brennicks1d@cocolog-nifty.com', '08pUhL76W', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('jdalgliesh1e@wiley.com', 'ZwcquojN0zM5', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('cmahady1f@sciencedirect.com', '55utDP8ibVPQ', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('emcvitie1g@list-manage.com', 'lgwVoj', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('mwheatman1h@harvard.edu', 'Gzpcgk', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('tmallen1i@va.gov', 'rCgmGE', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('ptatterton1j@yandex.ru', 'W6w1nRGc1', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('pslyme1k@cbsnews.com', 'eNLWgIuUe4cm', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('jinchboard1l@hubpages.com', 'g2TrO1o8Gjo', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('lstoaks1m@123-reg.co.uk', 'FqPhUWH', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('ddundendale1n@w3.org', '7sc32jNVTSUx', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('cvouls1o@4shared.com', 'uXMgykhf1f', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('lfreckleton1p@ycombinator.com', 'a1pJ9vu9pxYu', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('lhalpine1q@prnewswire.com', 'ANQkm3u', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('bcrudginton1r@infoseek.co.jp', 'PlMYikdS2', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('rlayson1s@twitter.com', '5wYfPjvy', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('lkausche1t@ted.com', 'ggHJyI', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('jdumberell1u@google.es', 'Zy9f4mNU', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('apain1v@google.com.hk', 'SUEFL2', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('epawfoot1w@fastcompany.com', 'dkd0P7chOP', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('epearcey1x@1und1.de', 'Km3O1sd2WjNW', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('eedgley1y@springer.com', '3bM6NPpf', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('jgeistbeck1z@columbia.edu', 'cY2uZjRW', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('dmcmullen20@360.cn', 'ackxfZvUc', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('eleggon21@economist.com', 'QdHyGd1ps', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('jyarnley22@xinhuanet.com', 'eYvLZ0', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('jperche23@networksolutions.com', 'O9tBOOmy7', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('jkemitt24@ehow.com', 'z5aI6jiv', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('sklein25@msn.com', 'NvfOigkRd', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('rfreke26@mlb.com', '4kw0qloI', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('bskypp27@opensource.org', 'yVQdaS0q', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('lpullman28@typepad.com', 'yyv1Hu', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('tmccurry29@irs.gov', '09HqUzza', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('blindner2a@taobao.com', '0m1BvCdHjF', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('dpocknoll2b@fc2.com', 'waVIV6', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('rjauncey2c@cpanel.net', 'IwIYU9SAoMG6', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('mbroadbent2d@nydailynews.com', 'IRZ3RItaLJb', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('gglasspoole2e@uiuc.edu', 'L1e2NQ1f9', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('hprowse2f@fc2.com', 'C4JF7Rd', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('dalcido2g@japanpost.jp', 'jgw1zwxjafP', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('lflanagan2h@slideshare.net', '8mopgt5ZGu', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('fminmagh2i@github.io', 'drFMZgaouGG', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('rdoget2j@flavors.me', '2fWSs5QQlVrf', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('smurie2k@soup.io', '96ZOoQgUCw', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('cbingall2l@ca.gov', 'Zc43DTi', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('dchesters2m@archive.org', 'HJ03m7JAK', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('jtenny2n@gnu.org', 'wD0gjfo', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('smutter2o@so-net.ne.jp', '67QODFbIfvpO', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('fastupenas2p@china.com.cn', 'rP6EDjR', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('atitcumb2q@so-net.ne.jp', 'peBNEKzw', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('aplayle2r@hostgator.com', 'r2fasNEKzw', 'P');

-- metodiDiPagamento
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('battfield0', '6759642689777301564', 'battfield0@dailymotion.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lglawsop1', '346475665414972', 'lglawsop1@paginegialle.it');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('bbaldam2', '5038592000771312', 'bbaldam2@about.me');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('mbratch3', '4091698261471', 'mbratch3@bluehost.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('mantognoni4', '4017952707235243', 'mantognoni4@de.vu');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('sisworth5', '50389069269174638', 'sisworth5@cmu.edu');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('nsawney6', '4041591159421', 'nsawney6@storify.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('bboanas7', '374622274876035', 'bboanas7@istockphoto.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('aleffek8', '0604344144465236', 'aleffek8@sogou.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('dmcinnery9', '4616307499573', 'dmcinnery9@wordpress.org');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lgumerya', '5038222259806441', 'lgumerya@japanpost.jp');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('gjohnseeb', '5048371077548590', 'gjohnseeb@uol.com.br');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('rgopsellc', '4175009230426332', 'rgopsellc@yahoo.co.jp');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('btonryd', '4026875047072613', 'btonryd@ovh.net');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('hbouldse', '4017952669315', 'hbouldse@delicious.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('dlashbrookf', '374288165617365', 'dlashbrookf@nature.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('mruckhardg', '67629664149070867', 'mruckhardg@globo.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('qgreenleyh', '06045501397442055', 'qgreenleyh@cdc.gov');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('fpostilli', '4026392629263834', 'fpostilli@t-online.de');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('shaycoxj', '379128699877199', 'shaycoxj@fda.gov');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('tswinyardk', '4175005090470741', 'tswinyardk@trellian.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('epotelll', '4041590424184151', 'epotelll@seattletimes.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('mvanderweedenburgm', '5048373937328809', 'mvanderweedenburgm@moonfruit.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('ggrimmen', '4405926849636419', 'ggrimmen@webeden.co.uk');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('bskeatho', '4026765974219685', 'bskeatho@elegantthemes.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('mgarlandp', '372301403195250', 'mgarlandp@trellian.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lstanbridgeq', '4508539408080675', 'lstanbridgeq@xing.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('otregustr', '4508904770665554', 'otregustr@canalblog.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('djaines', '4352948187401852', 'djaines@yale.edu');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('ldruhant', '4405053943092926', 'ldruhant@umich.edu');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('cmcgivenu', '6762432588492472825', 'cmcgivenu@cafepress.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('pandinov', '4405390719744987', 'pandinov@npr.org');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('fseymarkw', '5112455892424607', 'fseymarkw@nifty.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('asleighx', '4017954063915582', 'asleighx@tmall.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('tmclachlany', '5100139851467492', 'tmclachlany@mayoclinic.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lhousinz', '50207165182462785', 'lhousinz@discuz.net');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('nchipps10', '337941107502212', 'nchipps10@behance.net');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lsuttaby11', '4913165213518623', 'lsuttaby11@github.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('wcasado12', '372073916534222', 'wcasado12@twitter.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('pralph13', '5010121503137326', 'pralph13@nationalgeographic.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('wannear14', '5485740792548723', 'wannear14@prweb.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('esloane15', '4844773590834820', 'esloane15@opera.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('cparcell16', '372301559328747', 'cparcell16@home.pl');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('rburburough17', '4844237948303573', 'rburburough17@paypal.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('bmorot18', '5104459725390878', 'bmorot18@berkeley.edu');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('gmorando19', '343683713952363', 'gmorando19@si.edu');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('pshepland1a', '5007661032555329', 'pshepland1a@thetimes.co.uk');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('eredmille1b', '371430824750673', 'eredmille1b@symantec.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('mbrazener1c', '5100141327562617', 'mbrazener1c@nps.gov');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('brennicks1d', '379641305026910', 'brennicks1d@cocolog-nifty.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('jdalgliesh1e', '4917315888596737', 'jdalgliesh1e@wiley.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('cmahady1f', '4017953988050525', 'cmahady1f@sciencedirect.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('emcvitie1g', '6762291214747622813', 'emcvitie1g@list-manage.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('mwheatman1h', '4041591874464838', 'mwheatman1h@harvard.edu');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('tmallen1i', '5532690314080080', 'tmallen1i@va.gov');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('ptatterton1j', '4405683013184664', 'ptatterton1j@yandex.ru');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('pslyme1k', '4175001273147719', 'pslyme1k@cbsnews.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('jinchboard1l', '4508147564439394', 'jinchboard1l@hubpages.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lstoaks1m', '4837200778232', 'lstoaks1m@123-reg.co.uk');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('ddundendale1n', '4026555721546476', 'ddundendale1n@w3.org');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('cvouls1o', '4041590118261', 'cvouls1o@4shared.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lfreckleton1p', '67617138732098993', 'lfreckleton1p@ycombinator.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lhalpine1q', '4844915967622128', 'lhalpine1q@prnewswire.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('bcrudginton1r', '4917138230514806', 'bcrudginton1r@infoseek.co.jp');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('rlayson1s', '4844508916295185', 'rlayson1s@twitter.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lkausche1t', '374622320951642', 'lkausche1t@ted.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('jdumberell1u', '4041593201889836', 'jdumberell1u@google.es');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('apain1v', '374288062438014', 'apain1v@google.com.hk');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('epawfoot1w', '4041595425703', 'epawfoot1w@fastcompany.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('epearcey1x', '63049455595458511', 'epearcey1x@1und1.de');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('eedgley1y', '4041378491482801', 'eedgley1y@springer.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('jgeistbeck1z', '4175008287018661', 'jgeistbeck1z@columbia.edu');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('dmcmullen20', '4026127367872515', 'dmcmullen20@360.cn');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('eleggon21', '374622417030177', 'eleggon21@economist.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('jyarnley22', '6761648794046732', 'jyarnley22@xinhuanet.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('jperche23', '4175002447616167', 'jperche23@networksolutions.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('jkemitt24', '5048376220068669', 'jkemitt24@ehow.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('sklein25', '5108755717191208', 'sklein25@msn.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('rfreke26', '5893952058462260000', 'rfreke26@mlb.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('bskypp27', '6759717517827035', 'bskypp27@opensource.org');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lpullman28', '0604010361231480354', 'lpullman28@typepad.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('tmccurry29', '4917181658344652', 'tmccurry29@irs.gov');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('blindner2a', '5020364697566347452', 'blindner2a@taobao.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('dpocknoll2b', '374622277123559', 'dpocknoll2b@fc2.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('rjauncey2c', '4017950007294', 'rjauncey2c@cpanel.net');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('mbroadbent2d', '4175005610431017', 'mbroadbent2d@nydailynews.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('gglasspoole2e', '5145683001731452', 'gglasspoole2e@uiuc.edu');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('hprowse2f', '4917517547908951', 'hprowse2f@fc2.com');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('dalcido2g', '4026537772963966', 'dalcido2g@japanpost.jp');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('lflanagan2h', '06041002787912074', 'lflanagan2h@slideshare.net');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('fminmagh2i', '06042482624532708', 'fminmagh2i@github.io');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('rdoget2j', '5497746627918649', 'rdoget2j@flavors.me');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('smurie2k', '374288916199788', 'smurie2k@soup.io');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('cbingall2l', '337941244866116', 'cbingall2l@ca.gov');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('dchesters2m', '50387373872227979', 'dchesters2m@archive.org');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('jtenny2n', '5018561737565192', 'jtenny2n@gnu.org');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('smutter2o', '6762904986674479', 'smutter2o@so-net.ne.jp');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('fastupenas2p', '5893279803690937622', 'fastupenas2p@china.com.cn');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('atitcumb2q', '4017951357418356', 'atitcumb2q@so-net.ne.jp');
INSERT INTO metodiDiPagamento (username, numeroCarta, email) VALUES ('aplayle2r', '372301387204805', 'aplayle2r@hostgator.com');

--brani
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Creep', 'Radiohead', 'In Rainbows', 1, '3:15', 2011, 'Rock', 898589);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('No Surprises', 'Radiohead', 'In Rainbows', 2, '1:45', 2011, 'Rock', 387167);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Karma Police', 'Radiohead', 'In Rainbows', 3, '3:35', 2011, 'Rock', 835253);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('High and Dry', 'Radiohead', 'In Rainbows', 4, '2:37', 2011, 'Rock', 600172);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Exit Music', 'Radiohead', 'In Rainbows', 5, '2:35', 2011, 'Rock', 198867);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Kid A', 'Radiohead', 'Hail To the Thief', 1, '2:25', 2013, 'Rock', 336606);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Treefingers', 'Radiohead', 'Hail To the Thief', 2, '4:35', 2013, 'Rock', 870732);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Optimistic', 'Radiohead', 'Hail To the Thief', 3, '2:55', 2013, 'Rock', 283090);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('In Limbo', 'Radiohead', 'Hail To the Thief', 4, '3:35', 2013, 'Rock', 862193);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Idioteque', 'Radiohead', 'Hail To the Thief', 5, '2:24', 2013, 'Rock', 652371);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Morning Bell', 'Radiohead', 'Hail To the Thief', 6, '2:38', 2013, 'Rock', 687186);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Untitled', 'Radiohead', 'Hail To the Thief', 7, '2:32', 2013, 'Rock', 442084);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Columbia', 'Oasis', 'Be Here Now', 1, '2:37', 2012, 'Jazz', 991513);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Acquiesce', 'Oasis', 'Be Here Now', 2, '3:33', 2012, 'Jazz', 782745);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Supersonic', 'Oasis', 'Be Here Now', 3, '2:45', 2012, 'Jazz', 901986);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Hello', 'Oasis', 'Be Here Now', 4, '3:21', 2012, 'Jazz', 876328);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Some Might Say', 'Oasis', 'Be Here Now', 5, '2:35', 2012, 'Jazz', 307843);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Roll with It', 'Oasis', 'Definitely Maybe', 1, '2:31', 2014, 'Rock', 244145);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Slide Away', 'Oasis', 'Definitely Maybe', 2, '4:34', 2014, 'Rock', 949800);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Morning Glory', 'Oasis', 'Definitely Maybe', 3, '2:35', 2014, 'Rock', 592936);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Round Are Way', 'Oasis', 'Definitely Maybe', 4, '3:15', 2014, 'Rock', 930087);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Whatever', 'Oasis', 'Definitely Maybe', 5, '5:11', 2014, 'Rock', 136397);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Basket Case', 'Green Day', 'Insomniac', 1, '3:35', 2011, 'Punk', 380845);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('American Idiot', 'Green Day', 'Insomniac', 2, '2:40', 2011, 'Punk', 154721);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Brat', 'Green Day', 'Insomniac', 3, '2:15', 2011, 'Punk', 518123);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Stuck with Me', 'Green Day', 'Insomniac', 4, '1:35', 2011, 'Punk', 729011);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('No Pride', 'Green Day', 'Insomniac', 5, '2:54', 2011, 'Punk', 120463);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Brain Stew', 'Green Day', 'Insomniac', 6, '2:25', 2011, 'Punk', 198005);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Panic Song', 'Green Day', 'Revolution Radio', 1, '2:22', 2010, 'Indie Rock', 612817);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Jaded', 'Green Day', 'Revolution Radio', 2, '2:11', 2010, 'Indie Rock', 179711);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Westbound Sign', 'Green Day', 'Revolution Radio', 3, '2:33', 2010, 'Indie Rock', 523078);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Happier Than Ever', 'Billie Eilish', 'Happier Than Ever', 1, '3:25', 2019, 'Pop', 540259);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Lovely', 'Billie Eilish', 'Happier Than Ever', 2, '2:45', 2019, 'Pop', 162732);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Bored', 'Billie Eilish', 'Happier Than Ever', 3, '4:11', 2019, 'Pop', 353733);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Bad Guy', 'Billie Eilish', 'Happier Than Ever', 4, '1:35', 2019, 'Pop', 292032);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Getting Older', 'Billie Eilish', 'Happier Than Ever', 5, '2:44', 2019, 'Pop', 230577);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('My Future', 'Billie Eilish', 'dont smile at me', 1, '2:35', 2020, 'Pop', 904022);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Lost Cause', 'Billie Eilish', 'dont smile at me', 2, '3:38', 2020, 'Pop', 867152);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('OverHeated', 'Billie Eilish', 'dont smile at me', 3, '2:31', 2020, 'Pop', 133605);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Everybody Dies', 'Billie Eilish', 'dont smile at me', 4, '3:35', 2020, 'Pop', 523448);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Oxytocin', 'Billie Eilish', 'dont smile at me', 5, '2:26', 2020, 'Pop', 901283);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Your Power', 'Billie Eilish', 'dont smile at me', 6, '5:21', 2020, 'Pop', 234223);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('NDA', 'Billie Eilish', 'dont smile at me', 7, '2:15', 2020, 'Pop', 80619);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Therefore I Am', 'Billie Eilish', 'dont smile at me', 8, '2:35', 2020, 'Pop', 774420);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Billie Jean', 'Michael Jackson', 'Scream', 1, '2:11', 2005, 'Pop', 683381);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Beat It', 'Michael Jackson', 'Scream', 2, '1:24', 2005, 'Pop', 86187);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Smooth Criminal', 'Michael Jackson', 'Scream', 3, '4:39', 2005, 'Pop', 932762);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Thriller', 'Michael Jackson', 'Scream', 4, '2:15', 2005, 'Pop', 274771);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('This Place Hotel', 'Michael Jackson', 'Scream', 5, '3:35', 2005, 'Pop', 516585);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Leave Me Alone', 'Michael Jackson', 'Scream', 6, '2:24', 2005, 'Pop', 908147);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Scream', 'Michael Jackson', 'Scream', 7, '3:35', 2005, 'Pop', 582151);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Dangerous', 'Michael Jackson', 'Scream', 8, '2:26', 2005, 'Pop', 637085);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Midnight City', 'M83', 'Hurry up, We re Dreaming', 1, '2:22', 2013, 'Ambient', 359251);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Wait', 'M83', 'Hurry up, We re Dreaming', 2, '3:45', 2013, 'Ambient', 344719);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Outro', 'M83', 'Hurry up, We re Dreaming', 3, '2:14', 2013, 'Ambient', 445381);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Oblivion', 'M83', 'Hurry up, We re Dreaming', 4, '3:35', 2013, 'Ambient', 989133);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Hell Riders', 'M83', 'Hurry up, We re Dreaming', 5, '2:15', 2013, 'Ambient', 462521);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Colonies', 'M83', 'Hurry up, We re Dreaming', 6, '3:33', 2013, 'Ambient', 465745);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Feelings', 'M83', 'Hurry up, We re Dreaming', 7, '2:12', 2013, 'Ambient', 55428);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Straight Outta Compton', 'N.W.A.', 'Straight Outta Compton', 1, '3:35', 1997, 'Rap', 312112);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Fuck Tha Police', 'N.W.A.', 'Straight Outta Compton', 2, '2:45', 1997, 'Rap', 171181);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Gangsta Gangsta', 'N.W.A.', 'Straight Outta Compton', 3, '3:37', 1997, 'Rap', 353986);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Prelude', 'N.W.A.', 'Straight Outta Compton', 4, '2:48', 1997, 'Rap', 700241);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Niggaz 4 Life', 'N.W.A.', 'Straight Outta Compton', 5, '3:15', 1997, 'Rap', 798614);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Protest', 'N.W.A.', 'Efil4zaggin', 1, '2:32', 1994, 'Rap', 377660);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Real Niggaz', 'N.W.A.', 'Efil4zaggin', 2, '3:34', 1994, 'Rap', 540226);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Automobile', 'N.W.A.', 'Efil4zaggin', 3, '2:15', 1994, 'Rap', 193710);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('One Less Bitch', 'N.W.A.', 'Efil4zaggin', 4, '4:36', 1994, 'Rap', 954844);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('0ffline', 'tha Supreme', '23 6451', 1, '2:15', 2021, 'Rap', 94427);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('come fa1', 'tha Supreme', '23 6451', 2, '3:35', 2021, 'Rap', 895399);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('2ollipop', 'tha Supreme', '23 6451', 3, '2:22', 2021, 'Rap', 287197);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('fuck 3x', 'tha Supreme', '23 6451', 4, '3:38', 2021, 'Rap', 935268);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('scuol4', 'tha Supreme', '23 6451', 5, '2:45', 2021, 'Rap', 632821);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('5olo', 'tha Supreme', '23 6451', 6, '4:36', 2021, 'Rap', 502366);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('6itch', 'tha Supreme', '23 6451', 7, '2:55', 2021, 'Rap', 363141);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('blun7 a swishland', 'tha Supreme', '23 6451', 8, '3:33', 2021, 'Rap', 221113);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('m8nstar', 'tha Supreme', '23 6451', 9, '2:35', 2021, 'Rap', 824460);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('oh 9od', 'tha Supreme', '23 6451', 10, '2:37', 2021, 'Rap', 949124);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Goosebumps', 'Travis Scott', 'JACKBOYS', 1, '2:24', 2012, 'Trap', 635587);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Sicko Mode', 'Travis Scott', 'JACKBOYS', 2, '2:55', 2012, 'Trap', 54030);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Carousel', 'Travis Scott', 'JACKBOYS', 3, '2:17', 2012, 'Trap', 617906);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Stargazing', 'Travis Scott', 'ASTROWORLD', 1, '2:35', 2011, 'Trap', 988243);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Wake Up', 'Travis Scott', 'ASTROWORLD', 2, '3:31', 2011, 'Trap', 591772);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Nc-17', 'Travis Scott', 'ASTROWORLD', 3, '2:25', 2011, 'Trap', 141680);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Yosemite', 'Travis Scott', 'ASTROWORLD', 4, '4:36', 2011, 'Trap', 282862);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Skeletons', 'Travis Scott', 'Rodeo', 1, '2:35', 2014, 'Trap', 778088);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Coffee Bean', 'Travis Scott', 'Rodeo', 2, '3:15', 2014, 'Trap', 159583);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Astrothunder', 'Travis Scott', 'Rodeo', 3, '2:11', 2014, 'Trap', 247007);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Shape Of My Heart', 'Sting', 'The Bridge', 1, '2:35', 2011, 'Blues', 280808);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Redlight', 'Sting', 'The Bridge', 2, '3:22', 2011, 'Blues', 603722);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Fields Of Gold', 'Sting', 'The Bridge', 3, '2:44', 2011, 'Blues', 777603);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Loving You', 'Sting', 'The Bridge', 4, '2:35', 2011, 'Blues', 188835);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Captain Bateman', 'Sting', 'My Songs', 1, '3:35', 2017, 'Blues', 776113);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('The Bridge', 'Sting', 'My Songs', 2, '2:35', 2017, 'Blues', 815668);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Waters of Tyne', 'Sting', 'My Songs', 3, '2:35', 2017, 'Blues', 196512);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('All This Time', 'Sting', 'My Songs', 4, '3:35', 2017, 'Blues', 148864);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Mad About You', 'Sting', 'My Songs', 5, '2:35', 2017, 'Blues', 372306);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Star', 'Paky', 'Salvatore', 1, '2:35', 2011, 'Trap', 653156);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Vita sbagliata', 'Paky', 'Salvatore', 2, '2:35', 2011, 'Trap', 643901);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('No wallet', 'Paky', 'Salvatore', 3, '3:35', 2011, 'Trap', 874698);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Comandamento', 'Paky', 'Salvatore', 4, '2:35', 2011, 'Trap', 901215);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Blauer', 'Paky', 'Salvatore', 5, '2:35', 2011, 'Trap', 206139);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Vivi o muori', 'Paky', 'Salvatore', 6, '4:35', 2011, 'Trap', 986988);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Quando piove', 'Paky', 'Salvatore', 7, '2:35', 2011, 'Trap', 952903);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Auto tedesca', 'Paky', 'Salvatore', 8, '2:35', 2011, 'Trap', 277299);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Mi manchi', 'Paky', 'Salvatore', 9, '3:35', 2011, 'Trap', 514086);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Storie tristi', 'Paky', 'Salvatore', 10, '2:35', 2011, 'Trap', 298748);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('One', 'U2', 'Songs of Experience', 1, '2:35', 2011, 'Pop Rock', 518575);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Beautiful Day', 'U2', 'Songs of Experience', 2, '2:35', 2004, 'Pop Rock', 115349);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Zoo Station', 'U2', 'Songs of Experience', 3, '3:35', 2004, 'Pop Rock', 896240);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('The Fly', 'U2', 'Songs of Experience', 4, '2:35', 2004, 'Pop Rock', 719764);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('So Cruel', 'U2', 'Songs of Experience', 5, '4:35', 2004, 'Pop Rock', 390969);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Ultra Violent', 'U2', 'Songs of Experience', 6, '2:35', 2004, 'Pop Rock', 356162);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Acrobat', 'U2', 'Songs of Experience', 7, '2:35', 2004, 'Pop Rock', 537929);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Roxanne', 'The Police', 'Flexible Strategies', 1, '2:35', 1994, 'Rock', 549139);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Message In A Bottle', 'The Police', 'Flexible Strategies', 2, '3:35', 1994, 'Rock', 508437);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Dead End Job', 'The Police', 'Flexible Strategies', 3, '2:35', 1994, 'Rock', 852706);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('LandLord', 'The Police', 'Flexible Strategies', 4, '5:35', 1994, 'Rock', 912514);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Vision Of The Night', 'The Police', 'Flexible Strategies', 5, '2:35', 1994, 'Rock', 104766);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Friends', 'The Police', 'Synchronicity', 1, '2:35', 1996, 'Punk Rock', 769782);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('A Sermon', 'The Police', 'Synchronicity', 2, '4:35', 1996, 'Punk Rock', 633201);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Shambelle', 'The Police', 'Synchronicity', 3, '2:35', 1996, 'Punk Rock', 212808);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Low Life', 'The Police', 'Zenyatta Mondatta', 1, '2:35', 2001, 'Indie Rock', 961866);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Mother', 'The Police', 'Zenyatta Mondatta', 2, '3:35', 2001, 'Indie Rock', 499257);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('King Of Pain', 'The Police', 'Zenyatta Mondatta', 3, '4:35', 2001, 'Indie Rock', 631841);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Oh My God', 'The Police', 'Zenyatta Mondatta', 4, '2:35', 2001, 'Indie Rock', 333695);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Wish You Were Here', 'Pink Floyd', 'The Later Years', 1, '1:35', 2002, 'Rock', 190310);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Money', 'Pink Floyd', 'The Later Years', 2, '2:35', 2002, 'Rock', 304261);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Breathe', 'Pink Floyd', 'The Later Years', 3, '4:35', 2002, 'Rock', 775654);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('One Silip', 'Pink Floyd', 'The Later Years', 4, '3:35', 2002, 'Rock', 369456);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Terminal Frost', 'Pink Floyd', 'The Endless River', 1, '2:35', 2003, 'Rock', 986933);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('A New Machine', 'Pink Floyd', 'The Endless River', 2, '2:35', 2003, 'Rock', 177123);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Sorrow', 'Pink Floyd', 'The Endless River', 3, '2:35', 2003, 'Rock', 431794);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Learning To Fly', 'Pink Floyd', 'The Endless River', 4, '2:35', 2003, 'Rock', 216210);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Sings Of Life', 'Pink Floyd', 'Pulse', 1, '2:35', 2000, 'Indie Rock', 646881);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Yet Another Movie', 'Pink Floyd', 'Pulse', 2, '2:35', 2000, 'Indie Rock', 354621);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('The Dogs Of War', 'Pink Floyd', 'The Wall', 1, '2:35', 1999, 'Indie Rock', 796468);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Lost For Words', 'Pink Floyd', 'The Wall', 2, '2:35', 1999, 'Indie Rock', 936127);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Us And Them ', 'Pink Floyd', 'The Wall', 3, '2:35', 1999, 'Indie Rock', 537984);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Sultan Of Swing', 'Dire Straits', 'On The Night', 1, '2:35', 2022, 'Rock', 949411);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Walk Of Life', 'Dire Straits', 'On The Night', 2, '3:35', 2022, 'Rock', 266487);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Romeo And Juliet', 'Dire Straits', 'On The Night', 3, '2:35', 2022, 'Rock', 982179);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Money For Nothing', 'Dire Straits', 'On The Night', 4, '3:35', 2022, 'Rock', 819215);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Brothers In Arms', 'Dire Straits', 'Making Movies', 1, '2:35', 2008, 'Rock', 985808);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Calling Elvis', 'Dire Straits', 'Making Movies', 2, '3:35', 2008, 'Rock', 194933);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Heavy Fuel', 'Dire Straits', 'Making Movies', 3, '2:35', 2008, 'Rock', 961311);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Private Investigations', 'Dire Straits', 'Making Movies', 4, '2:35', 2008, 'Rock', 574257);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Fade To Black', 'Dire Straits', 'Making Movies', 5, '2:35', 2008, 'Rock', 699194);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('The Bug', 'Dire Straits', 'Making Movies', 6, '2:35', 2008, 'Rock', 173571);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Night Changes', 'One Direction', 'FOUR', 1, '2:35', 2010, 'Hip-Hop', 939202);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Story of My Life', 'One Direction', 'FOUR', 2, '3:35', 2010, 'Hip-Hop', 31968);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Drag Me Down', 'One Direction', 'FOUR', 3, '2:35', 2010, 'Hip-Hop', 651583);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Steal My Girl', 'One Direction', 'FOUR', 4, '2:35', 2010, 'Hip-Hop', 678174);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Perfect', 'One Direction', 'FOUR', 5, '3:35', 2010, 'Hip-Hop', 635604);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Infinity', 'One Direction', 'FOUR', 6, '2:35', 2010, 'Hip-Hop', 73154);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Hey Angel', 'One Direction', 'Midnight Memories', 1, '2:35', 2011, 'Hip-Hop', 398370);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('If I Could Fly', 'One Direction', 'Midnight Memories', 2, '3:35', 2011, 'Hip-Hop', 60925);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Long Way Down', 'One Direction', 'Midnight Memories', 3, '2:35', 2011, 'Hip-Hop', 975824);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('History', 'One Direction', 'Midnight Memories', 4, '2:35', 2011, 'Hip-Hop', 719543);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Never Enought', 'One Direction', 'Midnight Memories', 5, '3:35', 2011, 'Hip-Hop', 367639);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('A.M', 'One Direction', 'Midnight Memories', 6, '2:35', 2011, 'Hip-Hop', 587007);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Without Me', 'Eminem', 'Kamikaze', 1, '2:35', 2016, 'Rap', 556786);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Stan', 'Eminem', 'Kamikaze', 2, '3:35', 2016, 'Rap', 851935);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Alfred', 'Eminem', 'Kamikaze', 3, '2:35', 2016, 'Rap', 530050);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Tone Deaf', 'Eminem', 'Kamikaze', 4, '3:35', 2016, 'Rap', 488848);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Gnat', 'Eminem', 'Kamikaze', 5, '2:35', 2016, 'Rap', 217252);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Higher', 'Eminem', 'Revival', 1, '3:35', 2017, 'Rap', 754344);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Key', 'Eminem', 'Revival', 2, '2:35', 2017, 'Rap', 929715);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('She Loves Me', 'Eminem', 'Revival', 3, '3:35', 2017, 'Rap', 314333);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Killer', 'Eminem', 'Recovery', 1, '2:35', 2018, 'Rap', 820205);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Thus Far', 'Eminem', 'Recovery', 2, '3:35', 2018, 'Rap', 575939);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Premonition', 'Eminem', 'Recovery', 3, '2:35', 2018, 'Rap', 282138);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Riders on the Storm', 'The Doors', 'L.A. Woman', 1, '2:35', 2011, 'Rock', 850769);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Light My Fire', 'The Doors', 'L.A. Woman', 2, '3:35', 2011, 'Rock', 72325);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('People Are Strange', 'The Doors', 'L.A. Woman', 3, '2:35', 2011, 'Rock', 881731);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Roadhouse Blues', 'The Doors', 'L.A. Woman', 4, '2:35', 2011, 'Rock', 265786);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Verdillac', 'The Doors', 'L.A. Woman', 5, '4:35', 2011, 'Rock', 859315);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Love Her Madly', 'The Doors', 'L.A. Woman', 6, '2:35', 2011, 'Rock', 538459);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('L.A. Woman', 'The Doors', 'L.A. Woman', 7, '2:35', 2011, 'Rock', 215167);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Ship of Fools', 'The Doors', 'L.A. Woman', 8, '4:35', 2011, 'Rock', 580663);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Blue Sunday', 'The Doors', 'L.A. Woman', 9, '3:35', 2011, 'Rock', 48406);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Confield Chase', 'Hans Zimmer', 'Dune', 1, '12:35', 2022, 'Soundtrack', 543957);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Time', 'Hans Zimmer', 'Dune', 2, '8:35', 2022, 'Soundtrack', 63180);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Day One', 'Hans Zimmer', 'Dune', 3, '14:35', 2022, 'Soundtrack', 640876);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('S.T.A.Y.', 'Hans Zimmer', 'Dune', 4, '9:35', 2022, 'Soundtrack', 789891);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Mountains', 'Hans Zimmer', 'No Time To Die', 1, '9:35', 2011, 'Soundtrack', 286709);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Of The Earth', 'Hans Zimmer', 'No Time To Die', 2, '10:35', 2011, 'Soundtrack', 102682);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Il Gladiatore', 'Hans Zimmer', 'No Time To Die', 3, '11:35', 2011, 'Soundtrack', 702790);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Chant', 'Hans Zimmer', 'No Time To Die', 4, '13:35', 2011, 'Soundtrack', 356510);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Tribal War', 'Hans Zimmer', 'No Time To Die', 5, '7:35', 2011, 'Soundtrack', 358625);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('The Ecstasy Of Gold', 'Ennio Morricone', 'The Maestro', 1, '12:35', 2013, 'Soundtrack', 876801);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Gabriel s Oboe', 'Ennio Morricone', 'The Maestro', 2, '22:35', 2013, 'Soundtrack', 489971);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Love Theme', 'Ennio Morricone', 'The Maestro', 3, '13:35', 2013, 'Soundtrack', 449615);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Cannibal', 'Ennio Morricone', 'The Maestro', 4, '11:35', 2013, 'Soundtrack', 797918);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Le facce', 'Ennio Morricone', 'The Maestro', 5, '14:35', 2013, 'Soundtrack', 223641);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('La prima volta', 'Ennio Morricone', 'The Maestro', 6, '8:35', 2013, 'Soundtrack', 130356);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Madre assente', 'Ennio Morricone', 'The Maestro', 7, '9:35', 2013, 'Soundtrack', 87639);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Una donna sola', 'Ennio Morricone', 'The Maestro', 8, '5:35', 2013, 'Soundtrack', 259777);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('Splash', 'Ennio Morricone', 'The Maestro', 9, '7:35', 2013, 'Soundtrack', 829843);

-- episodi
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('La guerra dei cent''anni', 'Alessandro Barbero', 'Barbero Racconta: Il Medioevo', 12, '58:89', 2017, 'Storia', 59656);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Il Medioevo in Italia', 'Alessandro Barbero', 'Barbero Racconta: Il Medioevo', 2, '59:48', 2017, 'Storia', 34124);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('L''incastellamento', 'Alessandro Barbero', 'Barbero Racconta: Il Medioevo', 3, '58:64', 2017, 'Storia', 54123);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Carlo Magno', 'Alessandro Barbero', 'Barbero Racconta: Il Medioevo', 16, '57:91', 2017, 'Storia', 90012);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Il preconsolato', 'Alessandro Barbero', 'Barbero Racconta: L''Antica Roma', 7, '55:43', 2019, 'Storia', 920012);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('L''era di Augusto', 'Alessandro Barbero', 'Barbero Racconta: L''Antica Roma', 25, '54:61', 2019, 'Storia', 553120);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Cesare', 'Alessandro Barbero', 'Barbero Racconta: L''Antica Roma', 11, '59:94', 2019, 'Storia', 5502011);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Romani e Cristiani', 'Alessandro Barbero', 'Barbero Racconta: L''Antica Roma', 12, '58:81', 2019, 'Storia', 371241);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('JRE with Donald Trump', 'Joe Rogan', 'The Joe Rogan Experience', 223, '56:77', 2021, 'Politica', 35694054);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('JRE with Barack Obama', 'Joe Rogan', 'The Joe Rogan Experience', 253, '54:51', 2021, 'Politica', 87649053);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('JRE with Arnold Schwarzenegger', 'Joe Rogan', 'The Joe Rogan Experience', 3, '59:47', 2021, 'Politica', 87123136);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('JRE with Elon Musk', 'Joe Rogan', 'The Joe Rogan Experience', 44, '53:16', 2020, 'Scienza', 44123112);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('JRE with Lex Fridman', 'Joe Rogan', 'The Joe Rogan Experience', 550, '53:37', 2022, 'Scienza', 53129424);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('JRE with Mike Tyson', 'Joe Rogan', 'The Joe Rogan Experience', 62, '53:84', 2020, 'Intrattenimento', 13258249);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('JRE with Ricky Gervais', 'Joe Rogan', 'The Joe Rogan Experience', 565, '56:58', 2022, 'Intrattenimento', 12747834);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('JRE with Christian Bale', 'Joe Rogan', 'The Joe Rogan Experience', 257, '53:64', 2021, 'Intrattenimento', 66332003);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('JRE with Shaquille O''Neal', 'Joe Rogan', 'The Joe Rogan Experience', 102, '58:33', 2020, 'Intrattenimento', 25300320);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Come fondare un''azienda', 'Marco Montemagno', 'BeYourOwnBoss', 1, '25:38', 2016, 'Economia', 32012);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Gestire i guadagni', 'Marco Montemagno', 'BeYourOwnBoss', 2, '23:49', 2016, 'Economia', 38120);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Gestire le perdite', 'Marco Montemagno', 'BeYourOwnBoss', 3, '26:26', 2016, 'Economia', 45102);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Assumere dipendenti', 'Marco Montemagno', 'BeYourOwnBoss', 4, '24:04', 2017, 'Economia', 13140);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Partita IVA e 730', 'Marco Montemagno', 'BeYourOwnBoss', 5, '25:84', 2017, 'Economia', 20102);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('La routine di un CEO', 'Marco Montemagno', 'BeYourOwnBoss', 6, '22:01', 2017, 'Lifestyle', 35120);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Intervista a Frank Matano', 'Marco Montemagno', 'Montemagno Interviste', 1, '43:56', 2021, 'Intrattenimento', 330122);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Intervista a Paolo Ruffini', 'Marco Montemagno', 'Montemagno Interviste', 2, '44:85', 2021, 'Intrattenimento', 391234);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Intervista a Matthew McConaughey', 'Marco Montemagno', 'Montemagno Interviste', 3, '42:50', 2021, 'Intrattenimento', 475504);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Intervista a Paulo Dybala', 'Marco Montemagno', 'Montemagno Interviste', 4, '43:92', 2021, 'Intrattenimento', 854999);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Intervista a Vittorio Feltri', 'Marco Montemagno', 'Montemagno Interviste', 5, '45:99', 2021, 'Intrattenimento', 673466);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio x Capo Plaza', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 11, '48:93', 2021, 'Intrattenimento', 4120545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio x Alessandro Barbero', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 15, '43:62', 2021, 'Intrattenimento', 1120545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio x Christian De Sica', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 17, '46:25', 2021, 'Intrattenimento', 8420545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio x Donatella Versace', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 19, '40:58', 2021, 'Intrattenimento', 5520545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio x Twitch Italia', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 3, '44:25', 2021, 'Intrattenimento', 9920545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio x Gabriele Muccino', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 30, '45:46', 2021, 'Intrattenimento', 6920545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio x Vittorio Feltri', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 4, '48:50', 2021, 'Intrattenimento', 7520545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio x Vittorio Sgarbi', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 42, '40:28', 2021, 'Intrattenimento', 4220545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio Speciale Natale', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 44, '49:06', 2021, 'Intrattenimento', 8120545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio x Lazza', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 7, '48:60', 2021, 'Intrattenimento', 1220545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Muschio x Baby Gang', 'Muschio Selvaggio', 'Muschio Selvaggio Podcast', 9, '48:16', 2021, 'Intrattenimento', 2820545);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 1', 'Oroscopo', 'Oroscopodcast', 1, '15:50', 2022, 'Lifestyle', 50023);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 2', 'Oroscopo', 'Oroscopodcast', 2, '15:57', 2022, 'Lifestyle', 37050);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 3', 'Oroscopo', 'Oroscopodcast', 3, '15:55', 2022, 'Lifestyle', 16053);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 4', 'Oroscopo', 'Oroscopodcast', 4, '15:73', 2022, 'Lifestyle', 95053);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 5', 'Oroscopo', 'Oroscopodcast', 5, '15:63', 2022, 'Lifestyle', 33050);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 6', 'Oroscopo', 'Oroscopodcast', 6, '15:02', 2022, 'Lifestyle', 28504);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 7', 'Oroscopo', 'Oroscopodcast', 7, '15:41', 2022, 'Lifestyle', 87143);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 8', 'Oroscopo', 'Oroscopodcast', 8, '15:48', 2022, 'Lifestyle', 18123);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 9', 'Oroscopo', 'Oroscopodcast', 9, '15:14', 2022, 'Lifestyle', 86153);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 10', 'Oroscopo', 'Oroscopodcast', 10, '15:42', 2022, 'Lifestyle', 56543);
INSERT INTO episodi (titolo, podcaster, podcast, nepisodio, durata, annoUscita, genere, riproduzioni) VALUES ('Settimana 11', 'Oroscopo', 'Oroscopodcast', 11, '15:57', 2022, 'Lifestyle', 73122);

--playlist
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Light My Fire', 'The Doors');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Without Me', 'Eminem');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Light My Fire', 'The Doors');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'One', 'U2');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'American Idiot', 'Green Day');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Sultan Of Swing', 'Dire Straits');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Optimistic', 'Radiohead');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Roll with It', 'Oasis');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'One', 'U2');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Straight Outta Compton', 'N.W.A.');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Sultan Of Swing', 'Dire Straits');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Fields Of Gold', 'Sting');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Idioteque', 'Radiohead');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Perfect', 'Dire Straits');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Sultan Of Swing', 'Dire Straits');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Premonition', 'Eminem');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Hey Angel', 'One Direction');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Beautiful Day', 'U2');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Perfect', 'Dire Straits');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Goosebumps', 'Travis Scott');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', '5olo', 'tha Supreme');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Bad Guy', 'Billie Eilish');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Ultra Violent', 'U2');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Private Investigations', 'Dire Straits');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Mi manchi', 'Paky');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Leave Me Alone', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Goosebumps', 'Travis Scott');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Fields Of Gold', 'Sting');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'fuck 3x', 'tha Supreme');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Beat It', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Everybody Dies', 'Billie Eilish');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Private Investigations', 'Dire Straits');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'S.T.A.Y.', 'Hans Zimmer');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Straight Outta Compton', 'N.W.A.');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Roll with It', 'Oasis');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Smooth Criminal', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Beat It', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Mad About You', 'Sting');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'High and Dry', 'The Police');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Thriller', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'All This Time', 'Sting');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'This Place Hotel', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Optimistic', 'Radiohead');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Light My Fire', 'The Doors');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Astrothunder', 'Travis Scott');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'No wallet', 'Paky');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Brat', 'Green Day');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Premonition', 'Eminem');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'One', 'U2');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'm8nstar', 'tha Supreme');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Beat It', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Feelings', 'M83');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Captain Bateman', 'Sting');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Colonies', 'M83');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Perfect', 'Dire Straits');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Mi manchi', 'Paky');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Story of My Life', 'One Direction');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Beat It', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Carousel', 'Travis Scott');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Untitled', 'Radiohead');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Killer', 'Eminem');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Carousel', 'Travis Scott');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Roll with It', 'Oasis');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Treefingers', 'Radiohead');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Killer', 'Eminem');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Goosebumps', 'Travis Scott');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Ship of Fools', 'The Doors');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'This Place Hotel', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Scream', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Vivi o muori', 'Paky');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Outro', 'M83');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Lovely', 'Billie Eilish');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'All This Time', 'Sting');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'The Fly', 'U2');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Story of My Life', 'One Direction');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'NDA', 'Billie Eilish');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'History', 'One Direction');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'This Place Hotel', 'Michael Jackson');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'blun7 a swishland', 'tha Supreme');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Ultra Violent', 'U2');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'All This Time', 'Sting');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Colonies', 'M83');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Thus Far', 'Eminem');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'Feelings', 'M83');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'Lost Cause', 'Billie Eilish');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Hello', 'Oasis');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Roxanne', 'The Police');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Feelings', 'M83');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Redlight', 'Sting');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Sultan Of Swing', 'Dire Straits');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('AmiciInVacanza', 'lglawsop1', '2019-03-14', 'No Pride', 'Green Day');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Ship of Fools', 'The Doors');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Money', 'Pink Floyd');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'fuck 3x', 'tha Supreme');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('RapIsLife', 'mbratch3', '2020-06-14', 'S.T.A.Y.', 'Hans Zimmer');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Chilling', 'mantognoni4', '2020-10-14', 'Brat', 'Green Day');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'High and Dry', 'The Police');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'Roll with It', 'Oasis');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Sopa De Macaco', 'bbaldam2', '2021-01-24', 'Breathe', 'Pink Floyd');
INSERT INTO playlist (nome, autore, dataCreazione, titolo, artista) VALUES ('Bass & Love', 'battfield0', '2021-10-23', 'NDA', 'Billie Eilish');

--preferiti
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Muschio x Capo Plaza', 'Muschio Selvaggio', 'rdoget2j', 'P');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Sultan Of Swing', 'Dire Straits', 'hprowse2f', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Prelude', 'N.W.A.', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('JRE with Barack Obama', 'Joe Rogan', 'hprowse2f', 'P');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Roxanne', 'The Police', 'lflanagan2h', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Without Me', 'Eminem', 'hprowse2f', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Night Changes', 'One Direction', 'fminmagh2i', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Loving You', 'Sting', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Zoo Station', 'U2', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Loving You', 'Sting', 'fminmagh2i', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Night Changes', 'One Direction', 'rdoget2j', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Roxanne', 'The Police', 'hprowse2f', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Outro', 'M83', 'lflanagan2h', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Steal My Girl', 'One Direction', 'fminmagh2i', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Muschio x Christian De Sica', 'Muschio Selvaggio', 'rdoget2j', 'P');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Night Changes', 'One Direction', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Blauer', 'Paky', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Columbia', 'Oasis', 'lflanagan2h', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Confield Chase', 'Hans Zimmer', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Creep', 'Radiohead', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Il Medioevo in Italia', 'Alessandro Barbero', 'rdoget2j', 'P');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('JRE with Barack Obama', 'Joe Rogan', 'rdoget2j', 'P');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Carlo Magno', 'Alessandro Barbero', 'rdoget2j', 'P');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Settimana 1', 'Oroscopo', 'rdoget2j', 'P');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Time', 'Hans Zimmer', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Confield Chase', 'Hans Zimmer', 'hprowse2f', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Sicko Mode', 'Travis Scott', 'hprowse2f', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Prelude', 'N.W.A.', 'rdoget2j', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('S.T.A.Y.', 'Hans Zimmer', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Creep', 'Radiohead', 'lflanagan2h', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Basket Case', 'Green Day', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Sultan Of Swing', 'Dire Straits', 'fminmagh2i', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Creep', 'Radiohead', 'rdoget2j', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Settimana 3', 'Oroscopo', 'lflanagan2h', 'P');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Basket Case', 'Green Day', 'hprowse2f', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Basket Case', 'Green Day', 'rdoget2j', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('scuol4', 'tha Supreme', 'rdoget2j', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Billie Jean', 'Michael Jackson', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Billie Jean', 'Michael Jackson', 'lflanagan2h', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Happier Than Ever', 'Billie Eilish', 'rdoget2j', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Vivi o muori', 'Paky', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Steal My Girl', 'One Direction', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Prelude', 'N.W.A.', 'hprowse2f', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Without Me', 'Eminem', 'fminmagh2i', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Riders on the Storm', 'The Doors', 'lflanagan2h', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Sicko Mode', 'Travis Scott', 'dalcido2g', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Il Medioevo in Italia', 'Alessandro Barbero', 'dalcido2g', 'P');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('The Ecstasy Of Gold', 'Ennio Morricone', 'hprowse2f', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Loving You', 'Sting', 'hprowse2f', 'M');
INSERT INTO preferiti (titolo, autore, proprietario, tipo) VALUES ('Ultra Violent', 'U2', 'dalcido2g', 'M');


-- pagamenti
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (26131, 'FR63 7167 7478 48MA 8DWH XZ7G 807', '195280.72', 'Unicredit SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (42296, 'FR63 7167 7478 48MA 8DWH XZ7G 807', '52432.69', 'Unicredit SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (91068, 'FR63 7167 7478 48MA 8DWH XZ7G 807', '21362.04', 'Unicredit SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (70922, 'FR63 7167 7478 48MA 8DWH XZ7G 807', '89582.87', 'Unicredit SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (34443, 'FR63 7167 7478 48MA 8DWH XZ7G 807', '108055.45', 'Unicredit SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (14227, 'SA52 25FB E7QU PBRE ST1N QJTO', '126547.91', 'Intesa Sanpaolo SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (36398, 'SA52 25FB E7QU PBRE ST1N QJTO', '161726.99', 'Intesa Sanpaolo SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (21940, 'SA52 25FB E7QU PBRE ST1N QJTO', '31454.82', 'Intesa Sanpaolo SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (19336, 'SA52 25FB E7QU PBRE ST1N QJTO', '107473.64', 'Intesa Sanpaolo SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (57670, 'SA52 25FB E7QU PBRE ST1N QJTO', '70743.00', 'Intesa Sanpaolo SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (77387, 'HR68 9944 1950 3043 0703 3', '169170.75', 'Unicredit SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (48949, 'HR68 9944 1950 3043 0703 3', '150113.84', 'Unicredit SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (95625, 'HR68 9944 1950 3043 0703 3', '152822.40', 'Unicredit SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (26095, 'HR68 9944 1950 3043 0703 3', '119775.22', 'Unicredit SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (48665, 'HR68 9944 1950 3043 0703 3', '127431.22', 'Unicredit SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (28990, 'RS03 7201 8004 3045 5248 23', '32129.20', 'Unipol Banca SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (68204, 'RS03 7201 8004 3045 5248 23', '120182.31', 'Unipol Banca SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (51315, 'RS03 7201 8004 3045 5248 23', '171196.97', 'Unipol Banca SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (99146, 'RS03 7201 8004 3045 5248 23', '100201.84', 'Unipol Banca SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (87794, 'RS03 7201 8004 3045 5248 23', '168880.36', 'v', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (14057, 'DK77 5379 4850 9758 03', '29753.10', 'Credito Emiliano SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (45873, 'DK77 5379 4850 9758 03', '24205.64', 'Credito Emiliano SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (78536, 'DK77 5379 4850 9758 03', '199474.06', 'Credito Emiliano SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (77502, 'DK77 5379 4850 9758 03', '150387.90', 'Credito Emiliano SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (82692, 'DK77 5379 4850 9758 03', '48170.49', 'Credito Emiliano SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (81452, 'IS80 3391 4060 2478 2952 2940 60', '189494.57', 'Unipol Banca SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (32740, 'IS80 3391 4060 2478 2952 2940 60', '25918.06', 'Unipol Banca SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (23916, 'IS80 3391 4060 2478 2952 2940 60', '76773.53', 'Unipol Banca SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (13880, 'IS80 3391 4060 2478 2952 2940 60', '1199.67', 'Unipol Banca SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (35113, 'IS80 3391 4060 2478 2952 2940 60', '110885.44', 'Unipol Banca SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (43006, 'LB15 7107 V9ED IZUE ODJ6 WVWR WI6B', '33614.96', 'Unipol Banca SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (65571, 'LB15 7107 V9ED IZUE ODJ6 WVWR WI6B', '121584.35', 'Unipol Banca SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (23172, 'LB15 7107 V9ED IZUE ODJ6 WVWR WI6B', '188799.45', 'Unipol Banca SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (62592, 'LB15 7107 V9ED IZUE ODJ6 WVWR WI6B', '5592.40', 'Unipol Banca SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (54519, 'LB15 7107 V9ED IZUE ODJ6 WVWR WI6B', '146551.57', 'Unipol Banca SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (24146, 'FR74 9626 6814 426W AVTG OSQ1 N28', '97565.96', 'Intesa Sanpaolo SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (77131, 'FR74 9626 6814 426W AVTG OSQ1 N28', '148363.19', 'Intesa Sanpaolo SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (94389, 'FR74 9626 6814 426W AVTG OSQ1 N28', '66328.63', 'Intesa Sanpaolo SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (55154, 'FR74 9626 6814 426W AVTG OSQ1 N28', '88046.22', 'Intesa Sanpaolo SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (50114, 'FR74 9626 6814 426W AVTG OSQ1 N28', '60546.85', 'Intesa Sanpaolo SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (15759, 'FR85 1739 6990 20M8 B40W F3S5 I38', '134560.39', 'Unicredit SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (54264, 'FR85 1739 6990 20M8 B40W F3S5 I38', '187990.53', 'Unicredit SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (18559, 'FR85 1739 6990 20M8 B40W F3S5 I38', '76935.79', 'Unicredit SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (34490, 'FR85 1739 6990 20M8 B40W F3S5 I38', '96249.21', 'Unicredit SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (56596, 'FR85 1739 6990 20M8 B40W F3S5 I38', '94034.61', 'Unicredit SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (77549, 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', '197157.03', 'Credito Emiliano SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (69411, 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', '176682.26', 'Credito Emiliano SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (58246, 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', '102871.97', 'Credito Emiliano SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (89587, 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', '148262.15', 'Credito Emiliano SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (69798, 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', '128313.85', 'Credito Emiliano SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (45599, 'SA13 06LF 6MGT LDXO TF03 YPAI', '84548.57', 'Deutsche Bank SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (62139, 'SA13 06LF 6MGT LDXO TF03 YPAI', '53395.63', 'Deutsche Bank SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (83661, 'SA13 06LF 6MGT LDXO TF03 YPAI', '162149.12', 'Deutsche Bank SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (48768, 'SA13 06LF 6MGT LDXO TF03 YPAI', '113305.98', 'Deutsche Bank SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (22660, 'SA13 06LF 6MGT LDXO TF03 YPAI', '82154.81', 'Deutsche Bank SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (34840, 'IT45 I433 6238 148O GK21 HBJK FCO', '165718.61', 'Banca Sella SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (45312, 'IT45 I433 6238 148O GK21 HBJK FCO', '123909.94', 'Banca Sella SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (93888, 'IT45 I433 6238 148O GK21 HBJK FCO', '182306.12', 'Banca Sella SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (36965, 'IT45 I433 6238 148O GK21 HBJK FCO', '55557.47', 'Banca Sella SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (64954, 'IT45 I433 6238 148O GK21 HBJK FCO', '67576.80', 'Banca Sella SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (41845, 'ME11 8326 6137 7728 8656 40', '96523.31', 'Banca Sella SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (49801, 'ME11 8326 6137 7728 8656 40', '122544.20', 'Banca Sella SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (76771, 'ME11 8326 6137 7728 8656 40', '66119.15', 'Banca Sella SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (46982, 'ME11 8326 6137 7728 8656 40', '191044.89', 'Banca Sella SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (15712, 'ME11 8326 6137 7728 8656 40', '82519.18', 'Banca Sella SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (60469, 'SM77 X624 8847 138I XOVU MQJX 0Y0', '182615.63', 'Intesa Sanpaolo SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (69922, 'SM77 X624 8847 138I XOVU MQJX 0Y0', '140200.43', 'Intesa Sanpaolo SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (99263, 'SM77 X624 8847 138I XOVU MQJX 0Y0', '101776.16', 'Intesa Sanpaolo SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (88991, 'SM77 X624 8847 138I XOVU MQJX 0Y0', '180978.16', 'Intesa Sanpaolo SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (56582, 'SM77 X624 8847 138I XOVU MQJX 0Y0', '106321.18', 'Intesa Sanpaolo SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (96094, 'BG07 MSOP 0287 68IY XW71 7B', '136296.07', 'Intesa Sanpaolo SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (33492, 'BG07 MSOP 0287 68IY XW71 7B', '37995.39', 'Intesa Sanpaolo SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (53539, 'BG07 MSOP 0287 68IY XW71 7B', '184852.59', 'Intesa Sanpaolo SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (43008, 'BG07 MSOP 0287 68IY XW71 7B', '107400.20', 'Intesa Sanpaolo SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (80316, 'BG07 MSOP 0287 68IY XW71 7B', '43403.23', 'Intesa Sanpaolo SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (55584, 'BG06 XMGU 6476 74C4 AUBY Q0', '148844.31', 'Banco di Sardegna SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (90870, 'BG06 XMGU 6476 74C4 AUBY Q0', '139220.09', 'Banco di Sardegna SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (44044, 'BG06 XMGU 6476 74C4 AUBY Q0', '152332.77', 'Banco di Sardegna SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (72383, 'BG06 XMGU 6476 74C4 AUBY Q0', '97874.54', 'Banco di Sardegna SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (21924, 'BG06 XMGU 6476 74C4 AUBY Q0', '121584.25', 'Banco di Sardegna SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (67185, 'GI44 HLYH JLEP SIVL PMD0 N6T', '182109.27', 'Deutsche Bank SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (74895, 'GI44 HLYH JLEP SIVL PMD0 N6T', '84781.72', 'Deutsche Bank SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (83639, 'GI44 HLYH JLEP SIVL PMD0 N6T', '45814.61', 'Deutsche Bank SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (70945, 'GI44 HLYH JLEP SIVL PMD0 N6T', '38661.36', 'Deutsche Bank SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (67417, 'GI44 HLYH JLEP SIVL PMD0 N6T', '66210.78', 'Deutsche Bank SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (71514, 'FR37 1587 7806 71YF YPLR FOUC 324', '31218.74', 'Unipol Banca SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (26159, 'FR37 1587 7806 71YF YPLR FOUC 324', '44694.80', 'Unipol Banca SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (48169, 'FR37 1587 7806 71YF YPLR FOUC 324', '58428.06', 'Unipol Banca SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (62131, 'FR37 1587 7806 71YF YPLR FOUC 324', '27602.91', 'Unipol Banca SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (71817, 'FR37 1587 7806 71YF YPLR FOUC 324', '195978.30', 'Unipol Banca SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (74307, 'LU36 892V P2MA KKNQ IPGU', '69708.72', 'Banca Sella SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (68531, 'LU36 892V P2MA KKNQ IPGU', '199525.31', 'Banca Sella SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (29760, 'LU36 892V P2MA KKNQ IPGU', '9504.46', 'Banca Sella SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (54773, 'LU36 892V P2MA KKNQ IPGU', '15988.48', 'Banca Sella SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (83944, 'LU36 892V P2MA KKNQ IPGU', '31146.14', 'Banca Sella SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (74654, 'RS11 6947 4908 0336 2189 15', '170368.60', 'Banca Adriatico SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (82921, 'RS11 6947 4908 0336 2189 15', '143036.30', 'Banca Adriatico SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (55616, 'RS11 6947 4908 0336 2189 15', '143295.94', 'Banca Adriatico SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (77645, 'RS11 6947 4908 0336 2189 15', '153975.14', 'Banca Adriatico SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (27251, 'RS11 6947 4908 0336 2189 15', '60196.85', 'Banca Adriatico SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (19332, 'GI13 UPHJ 7Z4R H3RF CX8A K6Y', '81458.12', 'Banca Popolare Bari SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (15427, 'GI13 UPHJ 7Z4R H3RF CX8A K6Y', '55180.93', 'Banca Popolare Bari SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (23713, 'GI13 UPHJ 7Z4R H3RF CX8A K6Y', '182777.17', 'Banca Popolare Bari SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (56739, 'GI13 UPHJ 7Z4R H3RF CX8A K6Y', '5681.58', 'Banca Popolare Bari SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (94426, 'GI13 UPHJ 7Z4R H3RF CX8A K6Y', '27745.60', 'Banca Popolare Bari SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (51611, 'AZ97 HOQL WLQF WTN3 WKMH WCLI QLNC', '20930.96', 'Banco di Napoli SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (47769, 'AZ97 HOQL WLQF WTN3 WKMH WCLI QLNC', '150482.14', 'Banco di Napoli SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (14258, 'AZ97 HOQL WLQF WTN3 WKMH WCLI QLNC', '35361.56', 'Banco di Napoli SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (65381, 'AZ97 HOQL WLQF WTN3 WKMH WCLI QLNC', '83935.28', 'Banco di Napoli SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (81513, 'AZ97 HOQL WLQF WTN3 WKMH WCLI QLNC', '61602.84', 'Banco di Napoli SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (64773, 'PL95 3506 6134 4492 5495 8021 5877', '104655.66', 'Banco di Sardegna SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (91676, 'PL95 3506 6134 4492 5495 8021 5877', '17794.39', 'Banco di Sardegna SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (80510, 'PL95 3506 6134 4492 5495 8021 5877', '103595.42', 'Banco di Sardegna SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (84908, 'PL95 3506 6134 4492 5495 8021 5877', '85593.66', 'Banco di Sardegna SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (26018, 'PL95 3506 6134 4492 5495 8021 5877', '20645.96', 'Banco di Sardegna SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (37789, 'MR37 2738 7388 1820 2464 1435 299', '95601.02', 'Banco di Sardegna SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (47051, 'MR37 2738 7388 1820 2464 1435 299', '77252.44', 'Banco di Sardegna SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (54780, 'MR37 2738 7388 1820 2464 1435 299', '84190.17', 'Banco di Sardegna SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (15392, 'MR37 2738 7388 1820 2464 1435 299', '27174.33', 'Banco di Sardegna SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (91734, 'MR37 2738 7388 1820 2464 1435 299', '100128.61', 'Banco di Sardegna SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (74509, 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', '154976.20', 'Banco di Napoli SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (64688, 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', '84635.76', 'Banco di Napoli SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (30629, 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', '86987.50', 'Banco di Napoli SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (46026, 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', '101234.10', 'Banco di Napoli SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (76018, 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', '89283.68', 'Banco di Napoli SpA', '2021-05-01');
