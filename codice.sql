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


-- TODO: pagamenti, preferiti, playlist, episodi, brani, digitali, metodidipagamento
-- TODO: rivedere carte e digitali per coerenza e artisti nome/mail/ecc
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
INSERT INTO digitali (email, password, tipo) VALUES ('email', 'tZ46K8', 'P');
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

-- boh




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