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
    iban char(27) NOT NULL,
    email varchar(50) NOT NULL,
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


-- TODO: pagamenti, preferiti, playlist, episodi, brani, artisti, digitali, metodidipagamento
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

-- carte
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5519446037502083', 'mastercard', '2025-04-23', 911, 'Ricky Addison');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017952047553', 'visa', '2025-08-23', 763, 'Leigha Sirl');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175003675795384', 'visa-electron', '2029-11-29', 901, 'Merrile Keepe');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041370977116565', 'visa', '2029-08-30', 842, 'Wileen Gosselin');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('676143307987429838', 'maestro', '2028-03-29', 790, 'Hercule Stooders');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5002356202571769', 'mastercard', '2027-12-06', 132, 'Fernande Regan');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5048374242568568', 'mastercard', '2027-08-19', 879, 'Lolly Jubert');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4508315603481442', 'visa-electron', '2029-05-26', 656, 'Evvie Blunt');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4060023901531', 'visa', '2029-11-17', 378, 'Oralle Wooffitt');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4508854968495050', 'visa-electron', '2029-11-06', 644, 'Kary Freak');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041375770908084', 'visa', '2027-07-03', 536, 'Mickie Muzzollo');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4844702031382404', 'visa-electron', '2028-04-29', 642, 'Tana Charters');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5100133264628287', 'mastercard', '2029-05-27', 166, 'Karen Pallant');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5893657478193838', 'maestro', '2028-04-18', 507, 'Urbano Drewet');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('676357414468348650', 'maestro', '2029-01-29', 450, 'Jacques Akers');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4917790175369875', 'visa-electron', '2025-01-01', 108, 'Heall Henriksson');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5518102588304541', 'mastercard', '2025-10-08', 504, 'Reinold Saville');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4913807138571472', 'visa-electron', '2027-07-30', 335, 'Chrissy Rook');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('50208019679564216', 'maestro', '2029-03-05', 233, 'Nadiya Molian');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017956643399', 'visa', '2027-08-04', 225, 'Melitta Leverton');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4508976150929057', 'visa-electron', '2028-12-08', 130, 'Cobb Marcome');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5370289904884939', 'mastercard', '2027-03-02', 836, 'Riannon Siviter');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5020342142784975', 'maestro', '2029-09-30', 944, 'Elonore Fley');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('675999150865276492', 'maestro', '2028-01-20', 580, 'Shir Sage');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5100177637050968', 'mastercard', '2025-07-27', 941, 'Pippy Vyel');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5100174146369104', 'mastercard', '2026-07-16', 861, 'Robinet Planke');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('50189318292461641', 'maestro', '2028-07-01', 196, 'Nettle Hayto');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5299498739348428', 'mastercard', '2028-07-01', 550, 'Padraic Bwy');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374288758265036', 'americanexpress', '2028-03-21', 217, 'Jorie Minocchi');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041598935217741', 'visa', '2025-06-26', 623, 'Petunia Caseley');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5893166908067562', 'maestro', '2027-10-26', 239, 'Sheff Pallister');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5048372148177294', 'mastercard', '2026-06-18', 220, 'Klemens Draysay');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374288494865768', 'americanexpress', '2029-03-21', 683, 'Alyss Brosoli');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041597622133', 'visa', '2027-03-31', 655, 'Wendi Pilbeam');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5048371405182831', 'mastercard', '2028-02-17', 804, 'Dorthy Camble');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('67636047822243871', 'maestro', '2026-09-19', 511, 'Frieda Lindstedt');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4405833484666000', 'visa-electron', '2029-12-10', 116, 'Sherwin Woodfin');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5100135653301129', 'mastercard', '2029-10-04', 930, 'Jandy Northley');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4913507683869723', 'visa-electron', '2029-03-17', 195, 'Gonzales Gerb');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('379571073279427', 'americanexpress', '2028-09-05', 492, 'Katharina Orpyne');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5100179330098559', 'mastercard', '2028-09-27', 802, 'Arvie Twallin');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026480906114760', 'visa-electron', '2029-03-13', 453, 'Genia Kordovani');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5020461062205884', 'maestro', '2027-06-25', 528, 'Sibelle Beldam');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4913301716040787', 'visa-electron', '2028-08-08', 132, 'Lucie Sharpless');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041377087436734', 'visa', '2029-05-28', 563, 'Perle Flatley');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('370563770354800', 'americanexpress', '2025-04-13', 434, 'Kamila Boggs');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026113467330034', 'visa-electron', '2028-09-29', 797, 'Lynnett Morshead');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175001831134118', 'visa-electron', '2025-01-04', 998, 'Lutero Dracey');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4016575655024', 'visa', '2025-12-14', 286, 'Tiffanie Kidsley');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4913460926077011', 'visa-electron', '2027-01-07', 310, 'Kikelia Pabel');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017957385404', 'visa', '2027-07-04', 445, 'Petrina Lutzmann');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374288682275135', 'americanexpress', '2028-11-07', 353, 'Jerry Hillborne');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4917284573509134', 'visa-electron', '2029-07-31', 548, 'Neal Buckney');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('503802985826809985', 'maestro', '2026-12-08', 104, 'Gerick Daniells');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175001074727016', 'visa-electron', '2026-07-22', 191, 'Ursula Ruprechter');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5100138591078460', 'mastercard', '2029-09-27', 814, 'Seth Baddoe');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('06048505056650772', 'maestro', '2025-02-15', 742, 'Frannie Grzelczak');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374622708417950', 'americanexpress', '2026-08-12', 969, 'Bancroft Lenard');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('6763565344375866', 'maestro', '2028-07-27', 887, 'Reg Cammidge');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5020112484788854', 'maestro', '2025-03-11', 514, 'Zorah Klisch');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4917072237248193', 'visa-electron', '2027-01-26', 918, 'Janenna Geertz');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026513203147644', 'visa-electron', '2027-05-09', 794, 'Fern Bernhardi');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026804148432039', 'visa-electron', '2026-12-04', 322, 'Marchall Basek');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374622603088799', 'americanexpress', '2027-12-30', 395, 'Myra Fishbie');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('348687843486411', 'americanexpress', '2026-09-26', 746, 'Noah Manford');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('372301247674320', 'americanexpress', '2029-01-03', 680, 'Kathie MacInnes');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5038097887217463602', 'maestro', '2026-11-21', 290, 'Whitney Letson');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('337941832895808', 'americanexpress', '2029-01-24', 495, 'Cati Duddell');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041372065733178', 'visa', '2025-02-08', 375, 'Marquita Strangeway');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('343135032133621', 'americanexpress', '2027-11-20', 531, 'Jazmin Stranks');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('343840586962321', 'americanexpress', '2025-07-27', 948, 'Boycie Schlagh');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('675967021364465597', 'maestro', '2025-08-18', 414, 'Itch Pratt');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('501800248093936528', 'maestro', '2028-07-28', 615, 'Violetta Hought');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('589352333981268114', 'maestro', '2027-04-17', 226, 'Herbie Aylmore');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175004781855245', 'visa-electron', '2028-06-10', 268, 'Lorne Coomber');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041595010570', 'visa', '2025-12-28', 827, 'Shamus Beran');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('348355810819416', 'americanexpress', '2027-10-14', 826, 'Ange Webben');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5893620545915724', 'maestro', '2025-07-04', 921, 'Noe Alexandrescu');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4175002320921411', 'visa-electron', '2026-04-16', 773, 'Marya Shadrack');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('0604849361601388', 'maestro', '2029-03-01', 113, 'Eadie Matusov');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('374288585343451', 'americanexpress', '2027-09-30', 601, 'Thornie Mcwhinney');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5018002019496327', 'maestro', '2028-08-30', 871, 'Babara Marcus');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5538581771235941', 'mastercard', '2028-09-21', 651, 'Nil Tabourier');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4635752739499', 'visa', '2025-08-02', 503, 'Ring Reddyhoff');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041370407926', 'visa', '2025-05-31', 303, 'Jewelle Glading');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4421682001080', 'visa', '2026-02-27', 993, 'Marlena Le Maitre');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017959404625', 'visa', '2028-05-10', 542, 'Maddy Pretsel');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('372301593927256', 'americanexpress', '2026-04-17', 264, 'Ricardo Orpwood');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4913104511816751', 'visa-electron', '2027-04-15', 656, 'Papagena Karlqvist');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5427061559785130', 'mastercard', '2025-05-30', 179, 'Chickie Birnie');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('50385923537504212', 'maestro', '2026-09-16', 277, 'Scarlet Huckerby');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4041597372739', 'visa', '2029-07-20', 795, 'Rhetta Leftbridge');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('337941467635511', 'americanexpress', '2029-06-30', 317, 'Oriana Skacel');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5007660626058252', 'mastercard', '2025-11-29', 955, 'Kip Roncelli');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4684066103456360', 'visa', '2029-01-16', 354, 'Adam Hamshar');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('676375638584341763', 'maestro', '2027-08-20', 794, 'Deloria Pinder');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4026062879642900', 'visa-electron', '2026-09-02', 143, 'Ursala Dyott');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('341540844147804', 'americanexpress', '2025-09-30', 849, 'Abbe Fahrenbach');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('5595049373532487', 'mastercard', '2029-06-13', 684, 'Chaunce Ceeley');
INSERT INTO carte (numeroCarta, circuito, scadenza, ccv, intestatario) VALUES ('4017955269578983', 'visa', '2025-05-18', 306, 'Marcelia Hugnet');

-- digitali
INSERT INTO digitali (email, password, tipo) VALUES ('mcockshutt0@wsj.com', 'QnTOC4e', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('gcaltera1@toplist.cz', 'x4xasvmzo', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('neveral2@time.com', 'lazK9XI', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('gdearden3@woothemes.com', '0hxjnu8dP', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('mproughten4@pen.io', 'P4phj7v3', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('sbladder5@dailymail.co.uk', 'uFcocHS0t', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('radenet6@tiny.cc', 'DPHTIOD', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('ichasney7@diigo.com', 'DW3PKufE', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('gjenik8@flickr.com', 'cF4JZMs4O', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('ahayward9@multiply.com', 'T1BRDROaq5wB', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('jseala@vkontakte.ru', 'Pu9Fbq', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('bringeb@macromedia.com', 'm2GvKU', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('cmcquillinc@ftc.gov', 'eAPTMM', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('krivardd@cocolog-nifty.com', 'zFUQDuhlAFr', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('rskelchere@cocolog-nifty.com', 'vTMB4B', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('cwebbyf@columbia.edu', 'k44gh9ubF1s', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('gkaremang@hexun.com', '1osWeYu6d8OZ', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('mairdsh@eepurl.com', 'JqYucZGU', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('dvanderbeeki@topsy.com', 'SbdpMsULU', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('aciciuraj@booking.com', 'pZu0emKWCvc', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('cswyersexeyk@flavors.me', '4Yr57j', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('bhuguevillel@wired.com', 'UK2Rw5a', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('odigwoodm@g.co', 'dAuAebr1j7', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('glonghornn@dyndns.org', 'mY8wz4lgI', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('earmouro@sitemeter.com', 'jg9z4eR9ArpF', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('tjadczakp@microsoft.com', '8KNJUZ', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('mpresdeeq@marketwatch.com', 'K2bEbhyFvH5d', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('sswalower@walmart.com', '5oHCUhVN', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('kdewitts@parallels.com', 'F2OM4CnJRTdH', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('ecoulthurstt@sciencedaily.com', 'qRNwNlBAsY', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('ebeckenhamu@usnews.com', 'OPDeH4G7', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('smacenteev@usatoday.com', 'kSE9NGQJYMT', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('scarverw@spiegel.de', 'ME2u8bkQ', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('pbrabinx@time.com', '8CRxFY', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('walfordy@seattletimes.com', 'hwrvck9q', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('alegatez@admin.ch', 'xSIcHiKsn5W', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('epadbury10@dailymotion.com', 'Uf1ea25V8', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('vdurrance11@google.cn', 'BAQaKH8IXeK', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('igrimme12@xinhuanet.com', 'wdXFW7', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('kgally13@studiopress.com', 'LOmINligDreJ', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('rcolquyte14@yellowpages.com', 'iUx79rQMXY1k', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('cplanke15@accuweather.com', 'tedSNn94cTG', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('rhourston16@theglobeandmail.com', 'x0EFawCeLahb', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('bbeelby17@rambler.ru', 'q4LVlB66L', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('hwoodthorpe18@globo.com', 'm2gkiWAR10', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('jvincent19@e-recht24.de', 'p4t9rAg', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('fbixley1a@princeton.edu', '6s7tWV25vpP', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('nlyddiatt1b@bloomberg.com', 'vmah8jKe', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('bmollison1c@buzzfeed.com', '3Fk3I9gTj', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('dmuselli1d@gizmodo.com', 'jVsvFTn', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('wdarragh1e@technorati.com', 'HYAQ9NWzFQl5', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('tshills1f@nationalgeographic.com', 'XcgOTnzioyLn', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('eclashe1g@lulu.com', 'E82ofISzT2P', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('aneedham1h@opensource.org', '1wqJOepah', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('ebathow1i@alibaba.com', 'fQKioTFohswr', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('awillimont1j@domainmarket.com', 'WBmBfLJARmN', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('boroan1k@apache.org', 'lkRiNRgY', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('bcartmel1l@seesaa.net', 'ZpRB6Sq4', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('eburnes1m@amazonaws.com', 'eoGlzfJ2', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('hdrivers1n@cloudflare.com', 'oytHpC', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('hlangthorn1o@ft.com', '2xBrxe', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('ljanikowski1p@networkadvertising.org', 'Ez9d7exsccx', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('thebdon1q@sphinn.com', '7PaDcfCu', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('ccase1r@bing.com', 'twiCN8I', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('hbramble1s@smh.com.au', 'WG5gvPyC', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('kpillington1t@mapy.cz', 'EV9CfGT', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('ptippell1u@intel.com', 'nxeIMb', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('scoldham1v@springer.com', 'sVgeVYlgy', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('letteridge1w@amazonaws.com', 'Gyz6xwD', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('bfarmar1x@canalblog.com', '6IKaILc', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('wstrathe1y@facebook.com', 'p7JAqOBq', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('rellett1z@cloudflare.com', 'Rz9AhBRDjs', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('jdullard20@sciencedirect.com', '4dqsj2GnB', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('mmcalarney21@a8.net', 'UlSIFy', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('eweavill22@google.fr', 'TXfmVK0Eqa', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('lklimko23@hatena.ne.jp', 'aE9lVuN6', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('jsherar24@fotki.com', 'av4FRyzB', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('pmacpadene25@senate.gov', 'N0Gv6dprRQkH', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('anoddings26@php.net', 'EUgWiK', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('inozzolii27@newsvine.com', 'EZ36p7rSZ', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('imeconi28@home.pl', 'yrzd5P1n9ju', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('creveland29@go.com', '6oJ4wL', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('jpaddison2a@disqus.com', 'mA2smsKd', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('dwoolward2b@bravesites.com', 'CBA9XzsrWBFw', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('qkyle2c@slideshare.net', 'EL4fK65sZC', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('esonner2d@unc.edu', 'sLKscE', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('bremington2e@nationalgeographic.com', 'oVWsSgLqfX5k', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('efahy2f@qq.com', 'VdEUegaAzzc', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('ccamin2g@huffingtonpost.com', 'UL6Npr', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('fbrundall2h@paginegialle.it', 'qq9GEuxrYPg', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('oponder2i@pen.io', '0NcdMf', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('hollerhad2j@hao123.com', 'AFoducKSXC', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('brobillart2k@google.com.br', 'sxcKnA', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('dspoward2l@ning.com', 'BkxcOly', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('labramowitz2m@dedecms.com', 'd22VKCdmU', 'A');
INSERT INTO digitali (email, password, tipo) VALUES ('otoffel2n@clickbank.net', 'wtEjLWL', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('wissit2o@dmoz.org', '3vN6DMxSfjwi', 'G');
INSERT INTO digitali (email, password, tipo) VALUES ('tslixby2p@oakley.com', '1BAzhhFCp', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('killston2q@edublogs.org', '9QenH6', 'P');
INSERT INTO digitali (email, password, tipo) VALUES ('rhaslegrave2r@privacy.gov.au', 'xpc2VsqdyW', 'G');

-- boh