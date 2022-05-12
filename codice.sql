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
    email varchar(25) NOT NULL,
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
    password varchar(12) NOT NULL,
    tipo varchar(10) NOT NULL,
    PRIMARY KEY (email)
);

CREATE TABLE metodiDiPagamento (
    username varchar(25),
    numeroCarta char(16),
    email varchar(25),
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


-- TODO: pagamenti, preferiti, playlist, episodi, brani, artisti, carte, digitali, metodidipagamento
-- inserimento dati
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('M', 'Music', 4.99, 49.99);
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('P', 'Podcast', 2.99, 29.99);
INSERT INTO abbonamenti (id, nome, prezzoMensile, prezzoAnnuale) VALUES ('F', 'Full', 7.99, 79.99);

INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('battfield0', 'Ber', 'Attfield', 'battfield0@dailymotion.com', 'wwWK7C4', 'P', 'M', '2023-03-15');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lglawsop1', 'Latrina', 'Glawsop', 'lglawsop1@paginegialle.it', '0WmnzxnXw', 'P', 'M', '2022-10-31');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('bbaldam2', 'Burgess', 'Baldam', 'bbaldam2@about.me', 'm9xRM68qoQGq', 'P', 'A', '2023-02-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('mbratch3', 'Mela', 'Bratch', 'mbratch3@bluehost.com', 'BFF8AfjFZ3t', 'F', 'A', '2023-07-23');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('mantognoni4', 'Maurizia', 'Antognoni', 'mantognoni4@de.vu', 'EUc93TnR', 'P', 'M', '2023-11-23');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('sisworth5', 'Sayre', 'Isworth', 'sisworth5@cmu.edu', 'iGuohPtAm', 'F', 'M', '2022-08-19');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('nsawney6', 'Nesta', 'Sawney', 'nsawney6@storify.com', '3CM6LElBd2', 'P', 'M', '2023-06-12');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('bboanas7', 'Binky', 'Boanas', 'bboanas7@istockphoto.com', 'vjT8zWIe4L3w', 'P', 'A', '2023-10-23');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('aleffek8', 'Adriena', 'Leffek', 'aleffek8@sogou.com', 'RrF2Wvs5qG', 'P', 'A', '2022-12-10');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('dmcinnery9', 'Dyana', 'McInnery', 'dmcinnery9@wordpress.org', 'Dy9Rl9wvg', 'M', 'A', '2022-08-15');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lgumerya', 'Libby', 'Gumery', 'lgumerya@japanpost.jp', 'DYDD9HyU1', 'M', 'M', '2022-12-20');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('gjohnseeb', 'Gusella', 'Johnsee', 'gjohnseeb@uol.com.br', 'DLG2WV', 'M', 'A', '2022-08-22');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('rgopsellc', 'Rice', 'Gopsell', 'rgopsellc@yahoo.co.jp', '8hNkXJQ2Rh', 'P', 'A', '2023-12-16');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('btonryd', 'Bobby', 'Tonry', 'btonryd@ovh.net', 'gHfwTF2', 'F', 'A', '2023-09-30');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('hbouldse', 'Hilary', 'Boulds', 'hbouldse@delicious.com', 'tZoWYdVazA', 'M', 'M', '2022-11-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('dlashbrookf', 'Dewey', 'Lashbrook', 'dlashbrookf@nature.com', 'eBUHK1ut', 'F', 'M', '2023-10-28');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('mruckhardg', 'Meg', 'Ruckhard', 'mruckhardg@globo.com', 'HeTCXRRB', 'P', 'M', '2023-07-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('qgreenleyh', 'Quill', 'Greenley', 'qgreenleyh@cdc.gov', 'Au7Dr6KQ', 'F', 'M', '2022-09-27');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('fpostilli', 'Fraze', 'Postill', 'fpostilli@t-online.de', 'LoNmvpaU0JC', 'M', 'M', '2023-10-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('shaycoxj', 'Samantha', 'Haycox', 'shaycoxj@fda.gov', 'lm3VFJmPweZ', 'P', 'A', '2023-01-08');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('tswinyardk', 'Titus', 'Swinyard', 'tswinyardk@trellian.com', 'pjO767HaL5wX', 'F', 'M', '2022-09-27');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('epotelll', 'Engelbert', 'Potell', 'epotelll@seattletimes.com', 'WsVzkfcMu0X', 'F', 'A', '2023-06-04');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('mvanderweedenburgm', 'Merv', 'Van Der Weedenburg', 'mvanderweedenburgm@moonfruit.com', '7iYW3D8dQRiR', 'P', 'M', '2023-07-22');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('ggrimmen', 'Giorgio', 'Grimme', 'ggrimmen@webeden.co.uk', 'G0v5Q7M', 'P', 'M', '2023-10-23');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('bskeatho', 'Bathsheba', 'Skeath', 'bskeatho@elegantthemes.com', 'JkYgYL7qc', 'F', 'A', '2023-11-20');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('mgarlandp', 'Merv', 'Garland', 'mgarlandp@trellian.com', 'v6FHW3h', 'F', 'A', '2022-10-19');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lstanbridgeq', 'Laurie', 'Stanbridge', 'lstanbridgeq@xing.com', 'VAM7TcBoWBs', 'P', 'M', '2023-11-22');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('otregustr', 'Odie', 'Tregust', 'otregustr@canalblog.com', 'gSAi6hsTDQ1', 'M', 'A', '2023-03-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('djaines', 'Drona', 'Jaine', 'djaines@yale.edu', 'U12n0MJrz', 'F', 'A', '2023-05-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('ldruhant', 'Leela', 'Druhan', 'ldruhant@umich.edu', 'TtgXIf', 'M', 'A', '2023-05-09');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('cmcgivenu', 'Carlynne', 'McGiven', 'cmcgivenu@cafepress.com', 'ASpbPbRp1x', 'F', 'M', '2023-11-18');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('pandinov', 'Pegeen', 'Andino', 'pandinov@npr.org', 'cr41uS', 'F', 'M', '2022-08-26');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('fseymarkw', 'Frans', 'Seymark', 'fseymarkw@nifty.com', 'xem816UC7xAU', 'P', 'M', '2022-08-03');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('asleighx', 'Austine', 'Sleigh', 'asleighx@tmall.com', 'xZ5Fca3l4mSx', 'P', 'M', '2023-07-10');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('tmclachlany', 'Tomasine', 'McLachlan', 'tmclachlany@mayoclinic.com', 'SrD6o3f3', 'F', 'M', '2023-06-28');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lhousinz', 'Lotti', 'Housin', 'lhousinz@discuz.net', 'JEZtUhVIz7O3', 'M', 'A', '2022-06-27');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('nchipps10', 'Noami', 'Chipps', 'nchipps10@behance.net', 'FUGfrQvkwki', 'F', 'M', '2023-01-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lsuttaby11', 'Lemar', 'Suttaby', 'lsuttaby11@github.com', 'yNGcJzzKK', 'P', 'M', '2023-04-01');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('wcasado12', 'Winn', 'Casado', 'wcasado12@twitter.com', 'ZiXK5une4V', 'P', 'A', '2023-05-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('pralph13', 'Pall', 'Ralph', 'pralph13@nationalgeographic.com', 'tg0pR1lcK', 'F', 'A', '2023-03-26');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('wannear14', 'Wendie', 'Annear', 'wannear14@prweb.com', 'Ql81lxN', 'P', 'M', '2022-07-06');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('esloane15', 'Elle', 'Sloane', 'esloane15@opera.com', 'QoCm9Jv', 'M', 'M', '2022-08-16');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('cparcell16', 'Christine', 'Parcell', 'cparcell16@home.pl', 'YjEbXdR', 'P', 'A', '2023-11-12');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('rburburough17', 'Richardo', 'Burburough', 'rburburough17@paypal.com', 'g7WpTS7VW', 'M', 'A', '2022-11-12');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('bmorot18', 'Bryna', 'Morot', 'bmorot18@berkeley.edu', 's66ij9in37E', 'M', 'M', '2023-01-28');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('gmorando19', 'Gaven', 'Morando', 'gmorando19@si.edu', 'dpIa41j6I87', 'M', 'M', '2022-10-08');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('pshepland1a', 'Perry', 'Shepland', 'pshepland1a@thetimes.co.uk', 'XmEv1R', 'F', 'A', '2023-01-31');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('eredmille1b', 'Emmett', 'Redmille', 'eredmille1b@symantec.com', 'rQf2FzAq', 'F', 'A', '2023-12-19');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('mbrazener1c', 'Millie', 'Brazener', 'mbrazener1c@nps.gov', '90pI022t0p', 'P', 'M', '2023-06-29');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('brennicks1d', 'Brandon', 'Rennicks', 'brennicks1d@cocolog-nifty.com', 'tNcOZFQKmxAh', 'P', 'M', '2023-09-28');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('jdalgliesh1e', 'Jenine', 'Dalgliesh', 'jdalgliesh1e@wiley.com', 'bIeCZbPsHn', 'F', 'A', '2022-07-18');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('cmahady1f', 'Cindra', 'Mahady', 'cmahady1f@sciencedirect.com', 'q1rzwQDBt', 'F', 'M', '2023-06-26');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('emcvitie1g', 'Evan', 'McVitie', 'emcvitie1g@list-manage.com', 'cCJkUxaZ0', 'F', 'M', '2023-04-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('mwheatman1h', 'Michal', 'Wheatman', 'mwheatman1h@harvard.edu', 'KNL3XA0SR', 'M', 'A', '2023-01-14');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('tmallen1i', 'Tabbie', 'Mallen', 'tmallen1i@va.gov', 'D2o3my', 'P', 'M', '2022-07-14');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('ptatterton1j', 'Perle', 'Tatterton', 'ptatterton1j@yandex.ru', 'bxBSfhDCi1V', 'M', 'A', '2022-12-25');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('pslyme1k', 'Paulo', 'Slyme', 'pslyme1k@cbsnews.com', 'MwV2OAw00Y0V', 'P', 'A', '2023-05-07');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('jinchboard1l', 'Jehanna', 'Inchboard', 'jinchboard1l@hubpages.com', 'xNeNt9EAqUU', 'M', 'M', '2022-12-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lstoaks1m', 'Lotty', 'Stoaks', 'lstoaks1m@123-reg.co.uk', 'He9hsfhd', 'F', 'A', '2023-11-17');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('ddundendale1n', 'Dare', 'Dundendale', 'ddundendale1n@w3.org', 'jWFeo7x', 'P', 'M', '2023-05-15');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('cvouls1o', 'Charin', 'Vouls', 'cvouls1o@4shared.com', 'YRZewt', 'M', 'M', '2022-11-20');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lfreckleton1p', 'Libbey', 'Freckleton', 'lfreckleton1p@ycombinator.com', 'irjqCR6', 'P', 'M', '2023-10-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lhalpine1q', 'Lotte', 'Halpine', 'lhalpine1q@prnewswire.com', '86UrMTear', 'F', 'M', '2023-08-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('bcrudginton1r', 'Bernie', 'Crudginton', 'bcrudginton1r@infoseek.co.jp', 'ltLBWVx', 'P', 'M', '2023-02-16');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('rlayson1s', 'Ricki', 'Layson', 'rlayson1s@twitter.com', 'c8eUpTe1k', 'F', 'A', '2023-09-09');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lkausche1t', 'Leesa', 'Kausche', 'lkausche1t@ted.com', 'aF8ufPlUYsTy', 'M', 'A', '2023-07-07');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('jdumberell1u', 'Jacklyn', 'Dumberell', 'jdumberell1u@google.es', 'JwjS1Ne8', 'P', 'A', '2022-07-30');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('apain1v', 'Aldus', 'Pain', 'apain1v@google.com.hk', '9sB0FGtF', 'P', 'A', '2022-07-05');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('epawfoot1w', 'Elysia', 'Pawfoot', 'epawfoot1w@fastcompany.com', 'dARpdp54e', 'P', 'A', '2023-11-10');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('epearcey1x', 'Ema', 'Pearcey', 'epearcey1x@1und1.de', 'XSCN12ZS', 'P', 'M', '2022-10-07');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('eedgley1y', 'Eliot', 'Edgley', 'eedgley1y@springer.com', 'BDUIp92Gx', 'P', 'A', '2023-03-08');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('jgeistbeck1z', 'Jacinda', 'Geistbeck', 'jgeistbeck1z@columbia.edu', 'bSCHakDLU', 'P', 'M', '2022-08-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('dmcmullen20', 'Drugi', 'McMullen', 'dmcmullen20@360.cn', 'R61TTFMO3Q9', 'P', 'M', '2023-07-16');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('eleggon21', 'Ellyn', 'Leggon', 'eleggon21@economist.com', 'SGzipq', 'P', 'M', '2022-07-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('jyarnley22', 'Jaime', 'Yarnley', 'jyarnley22@xinhuanet.com', 'ABf2NAn2H1b', 'F', 'M', '2023-12-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('jperche23', 'Jobey', 'Perche', 'jperche23@networksolutions.com', 'Xj8xxMS', 'M', 'A', '2023-02-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('jkemitt24', 'Jocelin', 'Kemitt', 'jkemitt24@ehow.com', 'rV40VxvBkxi', 'F', 'M', '2023-11-08');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('sklein25', 'Shelly', 'Klein', 'sklein25@msn.com', '6z6PDVLtT', 'M', 'A', '2023-09-04');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('rfreke26', 'Roddie', 'Freke', 'rfreke26@mlb.com', '7F7lXk97UF', 'P', 'A', '2022-10-05');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('bskypp27', 'Bernita', 'Skypp', 'bskypp27@opensource.org', '6pPeLIL5l9', 'P', 'A', '2022-09-30');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lpullman28', 'Lenna', 'Pullman', 'lpullman28@typepad.com', 'PN2XMpJVJr', 'F', 'A', '2023-09-25');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('tmccurry29', 'Therine', 'McCurry', 'tmccurry29@irs.gov', 'urDlM4w', 'F', 'M', '2022-08-09');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('blindner2a', 'Briggs', 'Lindner', 'blindner2a@taobao.com', 'pxW3HKVSzmu', 'M', 'A', '2023-11-07');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('dpocknoll2b', 'Donn', 'Pocknoll', 'dpocknoll2b@fc2.com', 'ZAuGp73Z1UmR', 'M', 'M', '2022-07-23');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('rjauncey2c', 'Ruthi', 'Jauncey', 'rjauncey2c@cpanel.net', 'vvRnyUSJ69MY', 'M', 'M', '2023-01-15');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('mbroadbent2d', 'Merell', 'Broadbent', 'mbroadbent2d@nydailynews.com', 'Yjnia0jwOr', 'F', 'M', '2023-10-30');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('gglasspoole2e', 'Gustie', 'Glasspoole', 'gglasspoole2e@uiuc.edu', 'YVcwok', 'M', 'M', '2023-09-20');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('hprowse2f', 'Hayden', 'Prowse', 'hprowse2f@fc2.com', 'CRcEVzvR', 'F', 'M', '2023-04-04');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('dalcido2g', 'Deva', 'Alcido', 'dalcido2g@japanpost.jp', 'cjm6Gi', 'P', 'A', '2023-04-26');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('lflanagan2h', 'Letisha', 'Flanagan', 'lflanagan2h@slideshare.net', 'YPTB8pzY', 'M', 'M', '2022-09-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('fminmagh2i', 'Fannie', 'Minmagh', 'fminmagh2i@github.io', 'DN34uU', 'M', 'A', '2023-11-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('rdoget2j', 'Rayna', 'Doget', 'rdoget2j@flavors.me', 'LXTjCej6eB', 'P', 'A', '2023-02-08');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('smurie2k', 'Sammy', 'Murie', 'smurie2k@soup.io', 'id1TtvsFG5t', 'P', 'A', '2022-10-21');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('cbingall2l', 'Claudianus', 'Bingall', 'cbingall2l@ca.gov', 'yMBmKC', 'M', 'A', '2023-12-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('dchesters2m', 'Damian', 'Chesters', 'dchesters2m@archive.org', 'CcFy40A410', 'M', 'M', '2023-04-17');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('jtenny2n', 'Jessamyn', 'Tenny', 'jtenny2n@gnu.org', 'sK3iTZg46Y5', 'M', 'A', '2023-05-24');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('smutter2o', 'Scarlet', 'Mutter', 'smutter2o@so-net.ne.jp', 'ApOqiDI1', 'M', 'M', '2022-12-13');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('fastupenas2p', 'Frank', 'Astupenas', 'fastupenas2p@china.com.cn', 'pUP0Y3jw', 'P', 'A', '2023-11-28');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('atitcumb2q', 'Alexina', 'Titcumb', 'atitcumb2q@so-net.ne.jp', 'Vt4MJuduhv', 'P', 'M', '2022-12-11');
INSERT INTO utenti (username, nome, cognome, email, password, abbonamento, frequenzaAbbonamento, scadenzaAbbonamento) VALUES ('aplayle2r', 'Abner', 'Playle', 'aplayle2r@hostgator.com', 'N4kDCcNssSF', 'F', 'M', '2022-06-27');
