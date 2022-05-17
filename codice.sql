-- ! ROBINE UTILI IN FONDO AL FILE
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

-- TODO: Sistemare gli ON UPDATE e ON DELETE
-- creazione tabelle
CREATE TABLE abbonamenti (
    id char(1),
    nome varchar(8) NOT NULL,
    prezzoMensile float(24) NOT NULL,
    prezzoAnnuale float(24) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE utenti (
    username varchar(25),
    nome varchar(25) NOT NULL,
    cognome varchar(25) NOT NULL,
    email varchar(50) NOT NULL,
    password varchar(16) NOT NULL, 
    abbonamento char(1) NOT NULL,
    frequenzaAddebito char(1) NOT NULL,
    scadenzaAbbonamento date NOT NULL,
    PRIMARY KEY (username),
    UNIQUE (email),
    FOREIGN KEY (abbonamento) REFERENCES abbonamenti(id)
);

CREATE TABLE artisti (
    nome varchar(25),
    iban varchar(33) NOT NULL,
    email varchar(50) NOT NULL,
    password varchar(16) NOT NULL,
    tipo char(9) NOT NULL,
    bic char(11) NOT NULL,
    stato char(2) NOT NULL,
    città varchar(20) NOT NULL,
    cap varchar(8) NOT NULL,
    via varchar(50) NOT NULL,
    ncivico varchar(5) NOT NULL,
    PRIMARY KEY (iban),
    UNIQUE (nome)
); 

CREATE TABLE carte (
    numeroCarta char(19),
    circuito varchar(20) NOT NULL,
    scadenza date NOT NULL,
    ccv char(3) NOT NULL,
    intestatario varchar(25) NOT NULL,
    PRIMARY KEY (numeroCarta)
);

CREATE TABLE digitali (
    email varchar(50),
    password varchar(12) NOT NULL,
    tipo varchar(10) NOT NULL,
    PRIMARY KEY (email)
);

CREATE TABLE metodiDiPagamento (
    username varchar(25),
    numeroCarta char(19),
    email varchar(50),
    PRIMARY KEY (username),
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
    FOREIGN KEY (autore) REFERENCES utenti(username)
);

CREATE TABLE preferiti (
    titolo varchar(25),
    autore varchar(25),
    proprietario varchar(25) NOT NULL,
    tipo char(1) NOT NULL,
    PRIMARY KEY (titolo, autore),
    FOREIGN KEY (titolo) REFERENCES brani(titolo),
    FOREIGN KEY (titolo) REFERENCES episodi(titolo)
);

CREATE TABLE pagamenti (
    idTransazione char(5),
    iban varchar(33) NOT NULL,
    importo float(24) NOT NULL,
    beneficiario varchar(25) NOT NULL,
    dataEsecuzione date NOT NULL,
    PRIMARY KEY (idTransazione),
    FOREIGN KEY (iban) REFERENCES artisti(iban)
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
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Radiohead', 'FR63 7167 7478 48MA 8DWH XZ7G 807', 'radiohead@google.com.au', 'Ch2en6', 'Musicista', '771367516-7', 'CO', 'Colorado Springs', '80925', 'Farwell Park', '309');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Oasis', 'SA52 25FB E7QU PBRE ST1N QJTO', 'oasis@google.es', 'S97iyf', 'Musicista', '779039682-X', 'NY', 'Buffalo', '14276', 'Spaight Crossing', '18181');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Green Day', 'HR68 9944 1950 3043 0703 3', 'greenday@salon.com', 'lglnRN1', 'Musicista', '703269183-8', 'PA', 'Erie', '16505', 'Golf Course Alley', '02');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Billie Eilish', 'RS03 7201 8004 3045 5248 23', 'billieeilish@virginia.edu', 'CF2elvCKuo6', 'Musicista', '497355926-1', 'KY', 'Louisville', '40293', 'Huxley Alley', '709');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Michael Jackson', 'DK77 5379 4850 9758 03', 'michaeljackson@online.de', 'VLd1s9sh', 'Musicista', '696402584-7', 'WI', 'Milwaukee', '53220', 'Gateway Center', '23');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('M83', 'IS80 3391 4060 2478 2952 2940 60', 'm83@webnode.com', 'su9dMNRa0qJ', 'Musicista', '680243323-0', 'CA', 'Oakland', '94605', 'Sherman Circle', '895');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('N.W.A.', 'LB15 7107 V9ED IZUE ODJ6 WVWR WI6B', 'nwa@zdnet.com', 'wH2Sc3yIncF0', 'Musicista', '406226729-2', 'OK', 'Oklahoma City', '73109', 'Carpenter Alley', '931');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('tha Supreme', 'FR74 9626 6814 426W AVTG OSQ1 N28', 'thasupreme@source.net', 'S7fHZ7', 'Musicista', '221583928-7', 'MN', 'Saint Cloud', '56398', 'Gale Pass', '954');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Travis Scott', 'FR85 1739 6990 20M8 B40W F3S5 I38', 'travisscott@hexun.com', 'yBzcIxMa0B3Q', 'Musicista', '167443761-7', 'MI', 'Detroit', '48224', 'School Hill', '1');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Sting', 'FR70 7720 2579 44OQ 0M4M ZFGZ N76,', 'sting@google.ca', 'iVa633m', 'Musicista', '710344456-0', 'DC', 'Washington', '20260', 'Everett Parkway', '81348');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Paky', 'SA13 06LF 6MGT LDXO TF03 YPAI', 'paky@google.com', 'YM3TIroxk', 'Musicista', '964237899-X', 'NY', 'Buffalo', '14225', 'Crowley Junction', '58974');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('U2', 'IT45 I433 6238 148O GK21 HBJK FCO', 'u2@gizmodo.com', '3pyaRfE4', 'Musicista', '394432041-7', 'TX', 'El Paso', '79945', 'Eagle Crest Lane', '783');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('The Police', 'ME11 8326 6137 7728 8656 400', 'thepolice@bloomberg.com', 'um7JSN', 'Musicista', '339743027-5', 'NC', 'Raleigh', '27610', 'Hayes Lane', '332');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Pink Floyd', 'SM77 X624 8847 138I XOVU MQJX 0Y0', 'pinkfloyd@globo.com', 'I2mG98moFKRi', 'Musicista', '481675554-3', 'MS', 'Meridian', '39305', 'Briar Crest Lane', '3306');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Dire Straits', 'BG07 MSOP 0287 68IY XW71 7B', 'direstraits@mashable.com', '3HJ74y0', 'Musicista', '471626091-7', 'CA', 'Garden Grove', '92844', 'Arkansas Circle', '561');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('One Direction', 'BG06 XMGU 6476 74C4 AUBY Q0', 'onedirection@ovh.net', '6vGrgxay1f', 'Musicista', '594860296-6', 'GA', 'Atlanta', '31119', 'Schiller Pass', '3');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Eminem', 'GI44 HLYH JLEP SIVL PMD0 N6T', 'eminem@reference.com', 'VNkgNJnKaOno', 'Musicista', '276594334-6', 'TX', 'Austin', '78749', 'Arkansas Parkway', '314');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('The Doors', 'FR37 1587 7806 71YF YPLR FOUC 324', 'thedoors@music.com', 'KKyB6Hr', 'Musicista', '218789284-0', 'IL', 'Peoria', '61605', 'Hazelcrest Parkway', '5');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Hans Zimmer', 'LU36 892V P2MA KKNQ IPGU', 'hanszimmer@freemon.com', 'QY9AGlq', 'Musicista', '606393650-5', 'CA', 'San Jose', '95133', 'Declaration Pass', '2');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Ennio Morricone', 'RS11 6947 4908 0336 2189 15', 'ennio@gmail.it', 'caIjwOgL0', 'Musicista', '235657180-9', 'LA', 'New Orleans', '70142', 'Clemons Junction', '2700');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Marco Montemagno', 'GI13 UPHJ 7Z4R H3RF CX8A K6Y', 'montemagno@exper.it', 'gIioqujqK', 'Podcaster', '984843537-9', 'MI', 'Detroit', '48206', 'Melby Pass', '3422');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Alessandro Barbero', 'AZ97 HOQL WLQF WTN3 WKMH WCLI QLNC', 'barbero@volnet.it', 'M6YjjAchQ2z', 'Podcaster', '549876954-7', 'DC', 'Washington', '20051', 'Express Trail', '916');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Oroscopo', 'PL95 3506 6134 4492 5495 8021 5877', 'oroscopo@gmail.it', 'COEMandeutF', 'Podcaster', '403633470-0', 'CA', 'Oakland', '94605', 'Golf Plaza', '3918');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Muschio Selvaggio', 'MR37 2738 7388 1820 2464 1435 299', 'muschio@doorn.it', 'Z7CWDfWT5Q', 'Podcaster', '472972148-9', 'NY', 'Albany', '12237', 'Westridge Alley', '6037');
INSERT INTO artisti (nome, iban, email, password, tipo, bic, stato, città, cap, via, ncivico) VALUES ('Joe Rogan', 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', 'joerogan@gmail.com', 'iStoHI3', 'Podcaster', '491884308-5', 'TX', 'Lubbock', '79491', 'Rigney Crossing', '11');

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
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('battfield0', '6759642689777301564', 'battfield0@dailymotion.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lglawsop1', '346475665414972', 'lglawsop1@paginegialle.it');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('bbaldam2', '5038592000771312', 'bbaldam2@about.me');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('mbratch3', '4091698261471', 'mbratch3@bluehost.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('mantognoni4', '4017952707235243', 'mantognoni4@de.vu');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('sisworth5', '50389069269174638', 'sisworth5@cmu.edu');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('nsawney6', '4041591159421', 'nsawney6@storify.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('bboanas7', '374622274876035', 'bboanas7@istockphoto.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('aleffek8', '0604344144465236', 'aleffek8@sogou.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('dmcinnery9', '4616307499573', 'dmcinnery9@wordpress.org');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lgumerya', '5038222259806441', 'lgumerya@japanpost.jp');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('gjohnseeb', '5048371077548590', 'gjohnseeb@uol.com.br');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('rgopsellc', '4175009230426332', 'rgopsellc@yahoo.co.jp');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('btonryd', '4026875047072613', 'btonryd@ovh.net');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('hbouldse', '4017952669315', 'hbouldse@delicious.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('dlashbrookf', '374288165617365', 'dlashbrookf@nature.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('mruckhardg', '67629664149070867', 'mruckhardg@globo.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('qgreenleyh', '06045501397442055', 'qgreenleyh@cdc.gov');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('fpostilli', '4026392629263834', 'fpostilli@t-online.de');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('shaycoxj', '379128699877199', 'shaycoxj@fda.gov');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('tswinyardk', '4175005090470741', 'tswinyardk@trellian.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('epotelll', '4041590424184151', 'epotelll@seattletimes.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('mvanderweedenburgm', '5048373937328809', 'mvanderweedenburgm@moonfruit.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('ggrimmen', '4405926849636419', 'ggrimmen@webeden.co.uk');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('bskeatho', '4026765974219685', 'bskeatho@elegantthemes.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('mgarlandp', '372301403195250', 'mgarlandp@trellian.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lstanbridgeq', '4508539408080675', 'lstanbridgeq@xing.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('otregustr', '4508904770665554', 'otregustr@canalblog.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('djaines', '4352948187401852', 'djaines@yale.edu');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('ldruhant', '4405053943092926', 'ldruhant@umich.edu');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('cmcgivenu', '6762432588492472825', 'cmcgivenu@cafepress.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('pandinov', '4405390719744987', 'pandinov@npr.org');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('fseymarkw', '5112455892424607', 'fseymarkw@nifty.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('asleighx', '4017954063915582', 'asleighx@tmall.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('tmclachlany', '5100139851467492', 'tmclachlany@mayoclinic.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lhousinz', '50207165182462785', 'lhousinz@discuz.net');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('nchipps10', '337941107502212', 'nchipps10@behance.net');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lsuttaby11', '4913165213518623', 'lsuttaby11@github.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('wcasado12', '372073916534222', 'wcasado12@twitter.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('pralph13', '5010121503137326', 'pralph13@nationalgeographic.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('wannear14', '5485740792548723', 'wannear14@prweb.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('esloane15', '4844773590834820', 'esloane15@opera.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('cparcell16', '372301559328747', 'cparcell16@home.pl');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('rburburough17', '4844237948303573', 'rburburough17@paypal.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('bmorot18', '5104459725390878', 'bmorot18@berkeley.edu');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('gmorando19', '343683713952363', 'gmorando19@si.edu');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('pshepland1a', '5007661032555329', 'pshepland1a@thetimes.co.uk');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('eredmille1b', '371430824750673', 'eredmille1b@symantec.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('mbrazener1c', '5100141327562617', 'mbrazener1c@nps.gov');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('brennicks1d', '379641305026910', 'brennicks1d@cocolog-nifty.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('jdalgliesh1e', '4917315888596737', 'jdalgliesh1e@wiley.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('cmahady1f', '4017953988050525', 'cmahady1f@sciencedirect.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('emcvitie1g', '6762291214747622813', 'emcvitie1g@list-manage.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('mwheatman1h', '4041591874464838', 'mwheatman1h@harvard.edu');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('tmallen1i', '5532690314080080', 'tmallen1i@va.gov');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('ptatterton1j', '4405683013184664', 'ptatterton1j@yandex.ru');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('pslyme1k', '4175001273147719', 'pslyme1k@cbsnews.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('jinchboard1l', '4508147564439394', 'jinchboard1l@hubpages.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lstoaks1m', '4837200778232', 'lstoaks1m@123-reg.co.uk');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('ddundendale1n', '4026555721546476', 'ddundendale1n@w3.org');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('cvouls1o', '4041590118261', 'cvouls1o@4shared.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lfreckleton1p', '67617138732098993', 'lfreckleton1p@ycombinator.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lhalpine1q', '4844915967622128', 'lhalpine1q@prnewswire.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('bcrudginton1r', '4917138230514806', 'bcrudginton1r@infoseek.co.jp');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('rlayson1s', '4844508916295185', 'rlayson1s@twitter.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lkausche1t', '374622320951642', 'lkausche1t@ted.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('jdumberell1u', '4041593201889836', 'jdumberell1u@google.es');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('apain1v', '374288062438014', 'apain1v@google.com.hk');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('epawfoot1w', '4041595425703', 'epawfoot1w@fastcompany.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('epearcey1x', '63049455595458511', 'epearcey1x@1und1.de');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('eedgley1y', '4041378491482801', 'eedgley1y@springer.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('jgeistbeck1z', '4175008287018661', 'jgeistbeck1z@columbia.edu');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('dmcmullen20', '4026127367872515', 'dmcmullen20@360.cn');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('eleggon21', '374622417030177', 'eleggon21@economist.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('jyarnley22', '6761648794046732', 'jyarnley22@xinhuanet.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('jperche23', '4175002447616167', 'jperche23@networksolutions.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('jkemitt24', '5048376220068669', 'jkemitt24@ehow.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('sklein25', '5108755717191208', 'sklein25@msn.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('rfreke26', '5893952058462260000', 'rfreke26@mlb.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('bskypp27', '6759717517827035', 'bskypp27@opensource.org');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lpullman28', '0604010361231480354', 'lpullman28@typepad.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('tmccurry29', '4917181658344652', 'tmccurry29@irs.gov');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('blindner2a', '5020364697566347452', 'blindner2a@taobao.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('dpocknoll2b', '374622277123559', 'dpocknoll2b@fc2.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('rjauncey2c', '4017950007294', 'rjauncey2c@cpanel.net');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('mbroadbent2d', '4175005610431017', 'mbroadbent2d@nydailynews.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('gglasspoole2e', '5145683001731452', 'gglasspoole2e@uiuc.edu');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('hprowse2f', '4917517547908951', 'hprowse2f@fc2.com');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('dalcido2g', '4026537772963966', 'dalcido2g@japanpost.jp');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('lflanagan2h', '06041002787912074', 'lflanagan2h@slideshare.net');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('fminmagh2i', '06042482624532708', 'fminmagh2i@github.io');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('rdoget2j', '5497746627918649', 'rdoget2j@flavors.me');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('smurie2k', '374288916199788', 'smurie2k@soup.io');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('cbingall2l', '337941244866116', 'cbingall2l@ca.gov');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('dchesters2m', '50387373872227979', 'dchesters2m@archive.org');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('jtenny2n', '5018561737565192', 'jtenny2n@gnu.org');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('smutter2o', '6762904986674479', 'smutter2o@so-net.ne.jp');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('fastupenas2p', '5893279803690937622', 'fastupenas2p@china.com.cn');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('atitcumb2q', '4017951357418356', 'atitcumb2q@so-net.ne.jp');
INSERT INTO metodiDiPagamento (nickname, numeroCarta, email) VALUES ('aplayle2r', '372301387204805', 'aplayle2r@hostgator.com');

--brani
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'In Rainbows', 1, '3:15', '2021-07-31', 'Rock', 898589);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'In Rainbows', 2, '1:45', '2019-01-29', 'Rock', 387167);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'In Rainbows', 3, '3:35', '2019-03-13', 'Rock', 835253);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'In Rainbows', 4, '2:37', '2021-09-30', 'Rock', 600172);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'In Rainbows', 5, '2:35', '2017-08-18', 'Rock', 198867);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'Hail To the Thief', 1, '2:25', '2020-05-28', 'Rock', 336606);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'Hail To the Thief', 2, '4:35', '2020-12-25', 'Rock', 870732);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'Hail To the Thief', 3, '2:55', '2018-04-02', 'Rock', 283090);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'Hail To the Thief', 4, '3:35', '2018-08-05', 'Rock', 862193);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'Hail To the Thief', 5, '2:24', '2019-02-09', 'Rock', 652371);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'Hail To the Thief', 6, '2:38', '2021-11-15', 'Rock', 687186);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Radiohead', 'Hail To the Thief', 7, '2:32', '2020-09-02', 'Rock', 442084);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Oasis', 'Be Here Now', 1, '2:37', '2019-04-23', 'Jazz', 991513);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Oasis', 'Be Here Now', 2, '3:33', '2022-02-28', 'Jazz', 782745);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Oasis', 'Be Here Now', 3, '2:45', '2018-02-18', 'Jazz', 901986);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Oasis', 'Be Here Now', 4, '3:21', '2018-01-25', 'Jazz', 876328);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Oasis', 'Be Here Now', 5, '2:35', '2017-06-05', 'Jazz', 307843);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Oasis', 'Definitely Maybe', 1, '2:31', '2017-02-22', 'Rock', 244145);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Oasis', 'Definitely Maybe', 2, '4:34', '2018-08-17', 'Rock', 949800);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Oasis', 'Definitely Maybe', 3, '2:35', '2019-12-01', 'Rock', 592936);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Oasis', 'Definitely Maybe', 4, '3:15', '2016-12-25', 'Rock', 930087);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Oasis', 'Definitely Maybe', 5, '5:11', '2017-10-04', 'Rock', 136397);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Green Day', 'Insomniac', 1, '3:35', '2017-04-14', 'Punk', 380845);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Green Day', 'Insomniac', 2, '2:40', '2017-08-15', 'Punk', 154721);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Green Day', 'Insomniac', 3, '2:15', '2018-09-09', 'Punk', 518123);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Green Day', 'Insomniac', 4, '1:35', '2020-10-03', 'Punk', 729011);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Green Day', 'Insomniac', 5, '2:54', '2019-01-09', 'Punk', 120463);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Green Day', 'Insomniac', 6, '2:25', '2020-12-03', 'Punk', 198005);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Green Day', 'Revolution Radio', 1, '2:22', '2017-06-20', 'Indie Rock', 612817);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Green Day', 'Revolution Radio', 2, '2:11', '2019-06-18', 'Indie Rock', 179711);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Green Day', 'Revolution Radio', 3, '2:33', '2019-09-15', 'Indie Rock', 523078);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'Happier Than Ever', 1, '3:25', '2018-02-23', 'Pop', 540259);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'Happier Than Ever', 2, '2:45', '2021-04-23', 'Pop', 162732);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'Happier Than Ever', 3, '4:11', '2022-01-11', 'Pop', 353733);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'Happier Than Ever', 4, '1:35', '2021-12-20', 'Pop', 292032);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'Happier Than Ever', 5, '2:44', '2020-09-19', 'Pop', 230577);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'dont smile at me', 1, '2:35', '2018-02-17', 'Pop', 904022);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'dont smile at me', 2, '3:38', '2019-11-15', 'Pop', 867152);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'dont smile at me', 3, '2:31', '2017-11-17', 'Pop', 133605);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'dont smile at me', 4, '3:35', '2017-07-05', 'Pop', 523448);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'dont smile at me', 5, '2:26', '2021-03-10', 'Pop', 901283);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'dont smile at me', 6, '5:21', '2018-03-31', 'Pop', 234223);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'dont smile at me', 7, '2:15', '2021-09-27', 'Pop', 80619);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Billie Eilish', 'dont smile at me', 8, '2:35', '2018-08-12', 'Pop', 774420);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Michael Jackson', 'Scream', 1, '2:11', '2021-10-05', 'Pop', 683381);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Michael Jackson', 'Scream', 2, '1:24', '2019-12-23', 'Pop', 86187);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Michael Jackson', 'Scream', 3, '4:39', '2017-05-25', 'Pop', 932762);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Michael Jackson', 'Scream', 4, '2:15', '2021-01-15', 'Pop', 274771);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Michael Jackson', 'Scream', 5, '3:35', '2021-08-24', 'Pop', 516585);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Michael Jackson', 'Scream', 6, '2:24', '2021-09-16', 'Pop', 908147);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Michael Jackson', 'Scream', 7, '3:35', '2017-07-08', 'Pop', 582151);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Michael Jackson', 'Scream', 8, '2:26', '2019-03-11', 'Pop', 637085);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'M83', 'Hurry up, We re Dreaming', 1, '2:22', '2017-06-23', 'Ambient', 359251);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'M83', 'Hurry up, We re Dreaming', 2, '3:45', '2021-11-13', 'Ambient', 344719);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'M83', 'Hurry up, We re Dreaming', 3, '2:14', '2018-04-16', 'Ambient', 445381);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'M83', 'Hurry up, We re Dreaming', 4, '3:35', '2021-11-24', 'Ambient', 989133);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'M83', 'Hurry up, We re Dreaming', 5, '2:15', '2017-10-19', 'Ambient', 462521);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'M83', 'Hurry up, We re Dreaming', 6, '3:33', '2021-09-20', 'Ambient', 465745);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'M83', 'Hurry up, We re Dreaming', 7, '2:12', '2020-08-03', 'Ambient', 55428);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'N.W.A.', 'Straight Outta Compton', 1, '3:35', '2018-08-29', 'Rap', 312112);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'N.W.A.', 'Straight Outta Compton', 2, '2:45', '2017-06-08', 'Rap', 171181);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'N.W.A.', 'Straight Outta Compton', 3, '3:37', '2017-12-09', 'Rap', 353986);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'N.W.A.', 'Straight Outta Compton', 4, '2:48', '2020-10-28', 'Rap', 700241);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'N.W.A.', 'Straight Outta Compton', 5, '3:15', '2018-09-06', 'Rap', 798614);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'N.W.A.', 'Efil4zaggin', 1, '2:32', '2022-01-05', 'Rap', 377660);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'N.W.A.', 'Efil4zaggin', 2, '3:34', '2021-11-14', 'Rap', 540226);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'N.W.A.', 'Efil4zaggin', 3, '2:15', '2021-05-12', 'Rap', 193710);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'N.W.A.', 'Efil4zaggin', 4, '4:36', '2020-09-02', 'Rap', 954844);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'tha Supreme', '23 6451', 1, '2:15', '2018-08-24', 'Rap', 94427);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'tha Supreme', '23 6451', 2, '3:35', '2017-07-05', 'Rap', 895399);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'tha Supreme', '23 6451', 3, '2:22', '2019-09-19', 'Rap', 287197);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'tha Supreme', '23 6451', 4, '3:38', '2017-12-12', 'Rap', 935268);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'tha Supreme', '23 6451', 5, '2:45', '2019-08-24', 'Rap', 632821);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'tha Supreme', '23 6451', 6, '4:36', '2019-11-16', 'Rap', 502366);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'tha Supreme', '23 6451', 7, '2:55', '2020-05-03', 'Rap', 363141);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'tha Supreme', '23 6451', 8, '3:33', '2018-10-06', 'Rap', 221113);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'tha Supreme', '23 6451', 9, '2:35', '2021-01-23', 'Rap', 824460);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'tha Supreme', '23 6451', 10, '2:37', '2019-01-25', 'Rap', 949124);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Travis Scott', 'JACKBOYS', 1, '2:24', '2022-02-27', 'Trap', 635587);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Travis Scott', 'JACKBOYS', 2, '2:55', '2017-10-06', 'Trap', 54030);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Travis Scott', 'JACKBOYS', 3, '2:17', '2017-03-02', 'Trap', 617906);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Travis Scott', 'ASTROWORLD', 1, '2:35', '2019-11-15', 'Trap', 988243);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Travis Scott', 'ASTROWORLD', 2, '3:31', '2021-02-23', 'Trap', 591772);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Travis Scott', 'ASTROWORLD', 3, '2:25', '2020-12-21', 'Trap', 141680);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Travis Scott', 'ASTROWORLD', 4, '4:36', '2017-05-28', 'Trap', 282862);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Travis Scott', 'Rodeo', 1, '2:35', '2018-09-24', 'Trap', 778088);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Travis Scott', 'Rodeo', 2, '3:15', '2020-10-14', 'Trap', 159583);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Travis Scott', 'Rodeo', 3, '2:11', '2021-09-15', 'Trap', 247007);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Sting', 'The Bridge', 1, '2:35', '2022-02-22', 'Blues', 280808);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Sting', 'The Bridge', 2, '3:22', '2021-05-19', 'Blues', 603722);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Sting', 'The Bridge', 3, '2:44', '2018-01-13', 'Blues', 777603);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Sting', 'The Bridge', 4, '2:35', '2021-09-22', 'Blues', 188835);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Sting', 'My Songs', 1, '3:35', '2017-04-22', 'Blues', 776113);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Sting', 'My Songs', 2, '2:35', '2021-08-03', 'Blues', 815668);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Sting', 'My Songs', 3, '2:35', '2021-11-27', 'Blues', 196512);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Sting', 'My Songs', 4, '3:35', '2017-12-22', 'Blues', 148864);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Sting', 'My Songs', 5, '2:35', '2019-02-13', 'Blues', 372306);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Paky', 'Salvatore', 1, '2:35', '2019-06-18', 'Trap', 653156);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Paky', 'Salvatore', 2, '2:35', '2020-09-11', 'Trap', 643901);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Paky', 'Salvatore', 3, '3:35', '2018-03-25', 'Trap', 874698);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Paky', 'Salvatore', 4, '2:35', '2021-10-07', 'Trap', 901215);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Paky', 'Salvatore', 5, '2:35', '2018-07-07', 'Trap', 206139);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Paky', 'Salvatore', 6, '4:35', '2019-12-10', 'Trap', 986988);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Paky', 'Salvatore', 7, '2:35', '2021-06-30', 'Trap', 952903);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Paky', 'Salvatore', 8, '2:35', '2017-04-08', 'Trap', 277299);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Paky', 'Salvatore', 9, '3:35', '2018-08-10', 'Trap', 514086);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Paky', 'Salvatore', 10, '2:35', '2018-05-04', 'Trap', 298748);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'U2', 'Songs of Experience', 1, '2:35', '2022-05-04', 'Pop Rock', 518575);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'U2', 'Songs of Experience', 2, '2:35', '2018-04-14', 'Pop Rock', 115349);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'U2', 'Songs of Experience', 3, '3:35', '2021-09-08', 'Pop Rock', 896240);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'U2', 'Songs of Experience', 4, '2:35', '2019-04-16', 'Pop Rock', 719764);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'U2', 'Songs of Experience', 5, '4:35', '2020-01-17', 'Pop Rock', 390969);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'U2', 'Songs of Experience', 6, '2:35', '2021-11-16', 'Pop Rock', 356162);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'U2', 'Songs of Experience', 7, '2:35', '2019-05-27', 'Pop Rock', 537929);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Flexible Strategies', 1, '2:35', '2020-12-17', 'Rock', 549139);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Flexible Strategies', 2, '3:35', '2019-04-30', 'Rock', 508437);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Flexible Strategies', 3, '2:35', '2022-01-18', 'Rock', 852706);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Flexible Strategies', 4, '5:35', '2020-05-29', 'Rock', 912514);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Flexible Strategies', 5, '2:35', '2020-06-29', 'Rock', 104766);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Synchronicity', 1, '2:35', '2016-12-23', 'Punk Rock', 769782);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Synchronicity', 2, '4:35', '2019-09-17', 'Punk Rock', 633201);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Synchronicity', 3, '2:35', '2018-03-10', 'Punk Rock', 212808);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Zenyatta Mondatta', 1, '2:35', '2021-12-07', 'Indie Rock', 961866);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Zenyatta Mondatta', 2, '3:35', '2021-12-24', 'Indie Rock', 499257);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Zenyatta Mondatta', 3, '4:35', '2021-08-28', 'Indie Rock', 631841);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Police', 'Zenyatta Mondatta', 4, '2:35', '2020-05-31', 'Indie Rock', 333695);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Later Years', 1, '1:35', '2021-05-02', 'Rock', 190310);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Later Years', 2, '2:35', '2017-10-30', 'Rock', 304261);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Later Years', 3, '4:35', '2020-09-05', 'Rock', 775654);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Later Years', 4, '3:35', '2017-05-18', 'Rock', 369456);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Endless River', 1, '2:35', '2020-09-26', 'Rock', 986933);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Endless River', 2, '2:35', '2021-09-25', 'Rock', 177123);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Endless River', 3, '2:35', '2019-01-28', 'Rock', 431794);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Endless River', 4, '2:35', '2020-06-20', 'Rock', 216210);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'Pulse', 1, '2:35', '2017-08-13', 'Indie Rock', 646881);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'Pulse', 2, '2:35', '2018-11-13', 'Indie Rock', 354621);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Wall', 1, '2:35', '2020-11-03', 'Indie Rock', 796468);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Wall', 2, '2:35', '2017-12-28', 'Indie Rock', 936127);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Pink Floyd', 'The Wall', 3, '2:35', '2017-12-25', 'Indie Rock', 537984);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Dire Straits', 'On The Night', 1, '2:35', '2019-12-28', 'Rock', 949411);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Dire Straits', 'On The Night', 2, '3:35', '2018-03-22', 'Rock', 266487);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Dire Straits', 'On The Night', 3, '2:35', '2017-01-02', 'Rock', 982179);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Dire Straits', 'On The Night', 4, '3:35', '2019-10-06', 'Rock', 819215);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Dire Straits', 'Making Movies', 1, '2:35', '2017-04-02', 'Rock', 985808);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Dire Straits', 'Making Movies', 2, '3:35', '2020-09-10', 'Rock', 194933);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Dire Straits', 'Making Movies', 3, '2:35', '2020-03-23', 'Rock', 961311);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Dire Straits', 'Making Movies', 4, '2:35', '2016-12-22', 'Rock', 574257);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Dire Straits', 'Making Movies', 5, '2:35', '2020-02-23', 'Rock', 699194);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Dire Straits', 'Making Movies', 6, '2:35', '2021-06-28', 'Rock', 173571);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'FOUR', 1, '2:35', '2018-06-26', 'Hip-Hop', 939202);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'FOUR', 2, '3:35', '2017-12-20', 'Hip-Hop', 31968);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'FOUR', 3, '2:35', '2020-03-30', 'Hip-Hop', 651583);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'FOUR', 4, '2:35', '2020-07-15', 'Hip-Hop', 678174);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'FOUR', 5, '3:35', '2016-12-30', 'Hip-Hop', 635604);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'FOUR', 6, '2:35', '2017-06-25', 'Hip-Hop', 73154);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'Midnight Memories', 1, '2:35', '2021-11-14', 'Hip-Hop', 398370);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'Midnight Memories', 2, '3:35', '2019-12-12', 'Hip-Hop', 60925);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'Midnight Memories', 3, '2:35', '2020-03-22', 'Hip-Hop', 975824);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'Midnight Memories', 4, '2:35', '2018-12-19', 'Hip-Hop', 719543);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'Midnight Memories', 5, '3:35', '2020-04-30', 'Hip-Hop', 367639);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'One Direction', 'Midnight Memories', 6, '2:35', '2019-11-10', 'Hip-Hop', 587007);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Kamikaze', 1, '2:35', '2017-09-15', 'Rap', 556786);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Kamikaze', 2, '3:35', '2019-03-17', 'Rap', 851935);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Kamikaze', 3, '2:35', '2018-05-30', 'Rap', 530050);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Kamikaze', 4, '3:35', '2018-08-19', 'Rap', 488848);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Kamikaze', 5, '2:35', '2021-09-06', 'Rap', 217252);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Revival', 1, '3:35', '2019-12-17', 'Rap', 754344);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Revival', 2, '2:35', '2018-01-18', 'Rap', 929715);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Revival', 4, '3:35', '2017-08-15', 'Rap', 314333);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Recovery', 1, '2:35', '2019-08-28', 'Rap', 820205);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Recovery', 3, '3:35', '2018-06-13', 'Rap', 575939);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Eminem', 'Recovery', 4, '2:35', '2017-12-27', 'Rap', 282138);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Doors', 'L.A. Woman', 1, '2:35', '2017-10-31', 'Rock', 850769);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Doors', 'L.A. Woman', 2, '3:35', '2021-05-10', 'Rock', 72325);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Doors', 'L.A. Woman', 3, '2:35', '2019-11-25', 'Rock', 881731);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Doors', 'L.A. Woman', 4, '2:35', '2020-10-03', 'Rock', 265786);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Doors', 'L.A. Woman', 5, '4:35', '2019-07-12', 'Rock', 859315);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Doors', 'L.A. Woman', 6, '2:35', '2017-07-12', 'Rock', 538459);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Doors', 'L.A. Woman', 7, '2:35', '2017-07-12', 'Rock', 215167);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Doors', 'L.A. Woman', 8, '4:35', '2020-08-01', 'Rock', 580663);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'The Doors', 'L.A. Woman', 9, '3:35', '2021-01-23', 'Rock', 48406);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Hans Zimmer', 'Dune', 1, '12:35', '2017-04-29', 'Soundtrack', 543957);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Hans Zimmer', 'Dune', 2, '8:35', '2019-04-23', 'Soundtrack', 63180);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Hans Zimmer', 'Dune', 3, '14:35', '2017-08-06', 'Soundtrack', 640876);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Hans Zimmer', 'Dune', 4, '9:35', '2019-06-02', 'Soundtrack', 789891);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Hans Zimmer', 'No Time To Die', 1, '9:35', '2018-03-24', 'Soundtrack', 286709);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Hans Zimmer', 'No Time To Die', 2, '10:35', '2020-03-11', 'Soundtrack', 102682);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Hans Zimmer', 'No Time To Die', 3, '11:35', '2018-12-20', 'Soundtrack', 702790);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Hans Zimmer', 'No Time To Die', 4, '13:35', '2019-05-17', 'Soundtrack', 356510);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Hans Zimmer', 'No Time To Die', 5, '7:35', '2022-02-16', 'Soundtrack', 358625);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Ennio Morricone', 'The Maestro', 1, '12:35', '2017-09-22', 'Soundtrack', 876801);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Ennio Morricone', 'The Maestro', 2, '22:35', '2021-10-24', 'Soundtrack', 489971);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Ennio Morricone', 'The Maestro', 3, '13:35', '2017-02-27', 'Soundtrack', 449615);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Ennio Morricone', 'The Maestro', 4, '11:35', '2017-06-08', 'Soundtrack', 797918);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Ennio Morricone', 'The Maestro', 5, '14:35', '2018-03-22', 'Soundtrack', 223641);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Ennio Morricone', 'The Maestro', 6, '8:35', '2017-11-28', 'Soundtrack', 130356);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Ennio Morricone', 'The Maestro', 7, '9:35', '2017-10-07', 'Soundtrack', 87639);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Ennio Morricone', 'The Maestro', 8, '5:35', '2021-01-05', 'Soundtrack', 259777);
INSERT INTO brani (titolo, artista, album, traccia, durata, AnnoUscita, genere, riproduzioni) VALUES ('', 'Ennio Morricone', 'The Maestro', 9, '7:35', '2019-11-17', 'Soundtrack', 829843);




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
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (15759, 'FR85 1739 6990 20M8 B40W F3S5 I38', '$134560.39', 'Unicredit SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (54264, 'FR85 1739 6990 20M8 B40W F3S5 I38', '$187990.53', 'Unicredit SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (18559, 'FR85 1739 6990 20M8 B40W F3S5 I38', '$76935.79', 'Unicredit SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (34490, 'FR85 1739 6990 20M8 B40W F3S5 I38', '$96249.21', 'Unicredit SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (56596, 'FR85 1739 6990 20M8 B40W F3S5 I38', '$94034.61', 'Unicredit SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (77549, 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', '$197157.03', 'Credito Emiliano SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (69411, 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', '$176682.26', 'Credito Emiliano SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (58246, 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', '$102871.97', 'Credito Emiliano SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (89587, 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', '$148262.15', 'Credito Emiliano SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (69798, 'FR70 7720 2579 44OQ 0M4M ZFGZ N76', '$128313.85', 'Credito Emiliano SpA', '2021-05-01');
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
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (64773, 'PL95 3506 6134 4492 5495 8021 5877', '$104655.66', 'Banco di Sardegna SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (91676, 'PL95 3506 6134 4492 5495 8021 5877', '$17794.39', 'Banco di Sardegna SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (80510, 'PL95 3506 6134 4492 5495 8021 5877', '$103595.42', 'Banco di Sardegna SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (84908, 'PL95 3506 6134 4492 5495 8021 5877', '$85593.66', 'Banco di Sardegna SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (26018, 'PL95 3506 6134 4492 5495 8021 5877', '$20645.96', 'Banco di Sardegna SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (37789, 'MR37 2738 7388 1820 2464 1435 299', '$95601.02', 'Banco di Sardegna SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (47051, 'MR37 2738 7388 1820 2464 1435 299', '$77252.44', 'Banco di Sardegna SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (54780, 'MR37 2738 7388 1820 2464 1435 299', '$84190.17', 'Banco di Sardegna SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (15392, 'MR37 2738 7388 1820 2464 1435 299', '$27174.33', 'Banco di Sardegna SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (91734, 'MR37 2738 7388 1820 2464 1435 299', '$100128.61', 'Banco di Sardegna SpA', '2021-05-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (74509, 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', '$154976.20', 'Banco di Napoli SpA', '2021-01-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (64688, 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', '$84635.76', 'Banco di Napoli SpA', '2021-02-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (30629, 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', '$86987.50', 'Banco di Napoli SpA', '2021-03-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (46026, 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', '$101234.10', 'Banco di Napoli SpA', '2021-04-01');
INSERT INTO pagamenti (idTransazione, iban, importo, beneficiario, dataEsecuzione) VALUES (76018, 'AZ59 FNYT LZQS EJVW DBBS SAVR S2XS', '$89283.68', 'Banco di Napoli SpA', '2021-05-01');

/*
Unicredit SpA
Intesa Sanpaolo SpA
Banco di Napoli SpA
Banco di Sardegna SpA
Deutsche Bank SpA
Banca Popolare Bari SpA
Banca Adriatico SpA
Banca Sella SpA
Unipol Banca SpA
Credito Emiliano SpA
*/

--* ROBINE UTILI
-- IBAN di tutti gli artisti
/*
FR63 7167 7478 48MA 8DWH XZ7G 807,
SA52 25FB E7QU PBRE ST1N QJTO,
HR68 9944 1950 3043 0703 3,
RS03 7201 8004 3045 5248 23,
DK77 5379 4850 9758 03,
IS80 3391 4060 2478 2952 2940 60,
LB15 7107 V9ED IZUE ODJ6 WVWR WI6B,
FR74 9626 6814 426W AVTG OSQ1 N28,
FR85 1739 6990 20M8 B40W F3S5 I38,
FR70 7720 2579 44OQ 0M4M ZFGZ N76,
SA13 06LF 6MGT LDXO TF03 YPAI,
IT45 I433 6238 148O GK21 HBJK FCO,
ME11 8326 6137 7728 8656 40,
SM77 X624 8847 138I XOVU MQJX 0Y0,
BG07 MSOP 0287 68IY XW71 7B,
BG06 XMGU 6476 74C4 AUBY Q0,
GI44 HLYH JLEP SIVL PMD0 N6T,
FR37 1587 7806 71YF YPLR FOUC 324,
LU36 892V P2MA KKNQ IPGU,
RS11 6947 4908 0336 2189 15,
GI13 UPHJ 7Z4R H3RF CX8A K6Y,
AZ97 HOQL WLQF WTN3 WKMH WCLI QLNC,
PL95 3506 6134 4492 5495 8021 5877,
MR37 2738 7388 1820 2464 1435 299,
AZ59 FNYT LZQS EJVW DBBS SAVR S2XS
*/

-- NOMI DI TUTTI GLI UTENTI
/*
Ber Attfield,
Latrina Glawsop,
Burgess Baldam,
Mela Bratch,
Maurizia Antognoni,
Sayre Isworth,
Nesta Sawney,
Binky Boanas,
Adriena Leffek,
Dyana Mcinnery,
Libby Gumery,
Gusella Johnsee,
Rice Gopsell,
Bobby Tonry,
Hilary Boulds,
Dewey Lashbrook,
Meg Ruckhard,
Quill Greenley,
Fraze Postill,
Samantha Haycox,
Titus Swinyard,
Engelbert Potell,
Merv Van Der Weedenburg,
Giorgio Grimme,
Bathsheba Skeath,
Merv Garland,
Laurie Stanbridge,
Odie Tregust,
Drona Jaine,
Leela Druhan,
Carlynne Mcgiven,
Pegeen Andino,
Frans Seymark,
Austine Sleigh,
Tomasine Mclachlan,
Lotti Housin,
Noami Chipps,
Lemar Suttaby,
Winn Casado,
Pall Ralph,
Wendie Annear,
Elle Sloane,
Christine Parcell,
Richardo Burburough,
Bryna Morot,
Gaven Morando,
Perry Shepland,
Emmett Redmille,
Millie Brazener,
Brandon Rennicks,
Jenine Dalgliesh,
Cindra Mahady,
Evan Mcvitie,
Michal Wheatman,
Tabbie Mallen,
Perle Tatterton,
Paulo Slyme,
Jehanna Inchboard,
Lotty Stoaks,
Dare Dundendale,
Charin Vouls,
Libbey Freckleton,
Lotte Halpine,
Bernie Crudginton,
Ricki Layson,
Leesa Kausche,
Jacklyn Dumberell,
Aldus Pain,
Elysia Pawfoot,
Ema Pearcey,
Eliot Edgley,
Jacinda Geistbeck,
Drugi Mcmullen,
Ellyn Leggon,
Jaime Yarnley,
Jobey Perche,
Jocelin Kemitt,
Shelly Klein,
Roddie Freke,
Bernita Skypp,
Lenna Pullman,
Therine Mccurry,
Briggs Lindner,
Donn Pocknoll,
Ruthi Jauncey,
Merell Broadbent,
Gustie Glasspoole,
Hayden Prowse,
Deva Alcido,
Letisha Flanagan,
Fannie Minmagh,
Rayna Doget,
Sammy Murie,
Claudianus Bingall,
Damian Chesters,
Jessamyn Tenny,
Scarlet Mutter,
Frank Astupenas,
Alexina Titcumb,
Abner Playle
*/

--NOMI DI TUTTI GLI ARTISTI
/*
Radiohead
Oasis
Green Day
Billie Eilish
Michael Jackson
M83
N.W.A.
tha Supreme
Travis Scott
Sting
Paky
U2
The Police
Pink Floyd
Dire Straits
One Direction
Eminem
The Doors
Hans Zimmer
Ennio Morricone
Marco Montemagno
Alessandro Barbero
Oroscopo
Muschio Selvaggio
Joe Rogan
*/

--GENERI MUSICALI (non sono sicuro di averli messi tutti)
/*
Soundtrack
Rap
Trap
Pop Rock
Jazz
Indie Rock
Punk
Punk Rock
Blues
Hip-Hop
Ambient
*/

-- USERNAMES DI TUTTI GLI UTENTI
/*
battfield0,
lglawsop1,
bbaldam2,
mbratch3,
mantognoni4,
sisworth5,
nsawney6,
bboanas7,
aleffek8,
dmcinnery9,
lgumerya,
gjohnseeb,
rgopsellc,
btonryd,
hbouldse,
dlashbrookf,
mruckhardg,
qgreenleyh,
fpostilli,
shaycoxj,
tswinyardk,
epotelll,
mvanderweedenburgm,
ggrimmen,
bskeatho,
mgarlandp,
lstanbridgeq,
otregustr,
djaines,
ldruhant,
cmcgivenu,
pandinov,
fseymarkw,
asleighx,
tmclachlany,
lhousinz,
nchipps10,
lsuttaby11,
wcasado12,
pralph13,
wannear14,
esloane15,
cparcell16,
rburburough17,
bmorot18,
gmorando19,
pshepland1a,
eredmille1b,
mbrazener1c,
brennicks1d,
jdalgliesh1e,
cmahady1f,
emcvitie1g,
mwheatman1h,
tmallen1i,
ptatterton1j,
pslyme1k,
jinchboard1l,
lstoaks1m,
ddundendale1n,
cvouls1o,
lfreckleton1p,
lhalpine1q,
bcrudginton1r,
rlayson1s,
lkausche1t,
jdumberell1u,
apain1v,
epawfoot1w,
epearcey1x,
eedgley1y,
jgeistbeck1z,
dmcmullen20,
eleggon21,
jyarnley22,
jperche23,
jkemitt24,
sklein25,
rfreke26,
bskypp27,
lpullman28,
tmccurry29,
blindner2a,
dpocknoll2b,
rjauncey2c,
mbroadbent2d,
gglasspoole2e,
hprowse2f,
dalcido2g,
lflanagan2h,
fminmagh2i,
rdoget2j,
smurie2k,
cbingall2l,
dchesters2m,
jtenny2n,
smutter2o,
fastupenas2p,
atitcumb2q,
aplayle2r
*/

-- CARTE DI TUTTI GLI UTENTI
/*
6759642689777301564,
346475665414972,
5038592000771312,
4091698261471,
4017952707235243,
50389069269174638,
4041591159421,
374622274876035,
0604344144465236,
4616307499573,
5038222259806441,
5048371077548590,
4175009230426332,
4026875047072613,
4017952669315,
374288165617365,
67629664149070867,
06045501397442055,
4026392629263834,
379128699877199,
4175005090470741,
4041590424184151,
5048373937328809,
4405926849636419,
4026765974219685,
372301403195250,
4508539408080675,
4508904770665554,
4352948187401852,
4405053943092926,
6762432588492472825,
4405390719744987,
5112455892424607,
4017954063915582,
5100139851467492,
50207165182462785,
337941107502212,
4913165213518623,
372073916534222,
5010121503137326,
5485740792548723,
4844773590834820,
372301559328747,
4844237948303573,
5104459725390878,
343683713952363,
5007661032555329,
371430824750673,
5100141327562617,
379641305026910,
4917315888596737,
4017953988050525,
6762291214747622813,
4041591874464838,
5532690314080080,
4405683013184664,
4175001273147719,
4508147564439394,
4837200778232,
4026555721546476,
4041590118261,
67617138732098993,
4844915967622128,
4917138230514806,
4844508916295185,
374622320951642,
4041593201889836,
374288062438014,
4041595425703,
63049455595458511,
4041378491482801,
4175008287018661,
4026127367872515,
374622417030177,
6761648794046732,
4175002447616167,
5048376220068669,
5108755717191208,
5893952058462260000,
6759717517827035,
0604010361231480354,
4917181658344652,
5020364697566347452,
374622277123559,
4017950007294,
4175005610431017,
5145683001731452,
4917517547908951,
4026537772963966,
06041002787912074,
06042482624532708,
5497746627918649,
374288916199788,
337941244866116,
50387373872227979,
5018561737565192,
6762904986674479,
5893279803690937622,
4017951357418356,
372301387204805
*/


-- EMAIL DI TUTTI GLI UTENTI
/*
battfield0@dailymotion.com,
lglawsop1@paginegialle.it,
bbaldam2@about.me,
mbratch3@bluehost.com,
mantognoni4@de.vu,
sisworth5@cmu.edu,
nsawney6@storify.com,
bboanas7@istockphoto.com,
aleffek8@sogou.com,
dmcinnery9@wordpress.org,
lgumerya@japanpost.jp,
gjohnseeb@uol.com.br,
rgopsellc@yahoo.co.jp,
btonryd@ovh.net,
hbouldse@delicious.com,
dlashbrookf@nature.com,
mruckhardg@globo.com,
qgreenleyh@cdc.gov,
fpostilli@t-online.de,
shaycoxj@fda.gov,
tswinyardk@trellian.com,
epotelll@seattletimes.com,
mvanderweedenburgm@moonfruit.com,
ggrimmen@webeden.co.uk,
bskeatho@elegantthemes.com,
mgarlandp@trellian.com,
lstanbridgeq@xing.com,
otregustr@canalblog.com,
djaines@yale.edu,
ldruhant@umich.edu,
cmcgivenu@cafepress.com,
pandinov@npr.org,
fseymarkw@nifty.com,
asleighx@tmall.com,
tmclachlany@mayoclinic.com,
lhousinz@discuz.net,
nchipps10@behance.net,
lsuttaby11@github.com,
wcasado12@twitter.com,
pralph13@nationalgeographic.com,
wannear14@prweb.com,
esloane15@opera.com,
cparcell16@home.pl,
rburburough17@paypal.com,
bmorot18@berkeley.edu,
gmorando19@si.edu,
pshepland1a@thetimes.co.uk,
eredmille1b@symantec.com,
mbrazener1c@nps.gov,
brennicks1d@cocolog-nifty.com,
jdalgliesh1e@wiley.com,
cmahady1f@sciencedirect.com,
emcvitie1g@list-manage.com,
mwheatman1h@harvard.edu,
tmallen1i@va.gov,
ptatterton1j@yandex.ru,
pslyme1k@cbsnews.com,
jinchboard1l@hubpages.com,
lstoaks1m@123-reg.co.uk,
ddundendale1n@w3.org,
cvouls1o@4shared.com,
lfreckleton1p@ycombinator.com,
lhalpine1q@prnewswire.com,
bcrudginton1r@infoseek.co.jp,
rlayson1s@twitter.com,
lkausche1t@ted.com,
jdumberell1u@google.es,
apain1v@google.com.hk,
epawfoot1w@fastcompany.com,
epearcey1x@1und1.de,
eedgley1y@springer.com,
jgeistbeck1z@columbia.edu,
dmcmullen20@360.cn,
eleggon21@economist.com,
jyarnley22@xinhuanet.com,
jperche23@networksolutions.com,
jkemitt24@ehow.com,
sklein25@msn.com,
rfreke26@mlb.com,
bskypp27@opensource.org,
lpullman28@typepad.com,
tmccurry29@irs.gov,
blindner2a@taobao.com,
dpocknoll2b@fc2.com,
rjauncey2c@cpanel.net,
mbroadbent2d@nydailynews.com,
gglasspoole2e@uiuc.edu,
hprowse2f@fc2.com,
dalcido2g@japanpost.jp,
lflanagan2h@slideshare.net,
fminmagh2i@github.io,
rdoget2j@flavors.me,
smurie2k@soup.io,
cbingall2l@ca.gov,
dchesters2m@archive.org,
jtenny2n@gnu.org,
smutter2o@so-net.ne.jp,
fastupenas2p@china.com.cn,
atitcumb2q@so-net.ne.jp,
aplayle2r@hostgator.com
*/

-- links
-- https://mockaroo.com
-- https://tableconvert.com/sql-to-csv
-- https://txtformat.com/