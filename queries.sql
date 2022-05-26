--1 Mostrare l'importo dell'ultimo bonfico effettuato agli artisti, oltretutto mostrarlo in ordine decrescente
SELECT a.nome, p.importo, p.dataesecuzione AS data
FROM artisti AS a 
JOIN pagamenti AS p
	ON a.iban = p.iban
WHERE p.dataesecuzione = (SELECT MAX(p.dataesecuzione) FROM pagamenti AS p)
ORDER BY p.importo DESC;

--2 Mostrare l'artista (musicista e podcaster) con più di 5M ascolti totali 
(SELECT a.nome as artista, SUM(b.riproduzioni) AS ascolti
FROM artisti AS a
JOIN brani AS b
	ON a.nome = b.artista
GROUP BY a.nome
	HAVING SUM(b.riproduzioni) > 5000000)
UNION
(SELECT a.nome as artista, SUM(e.riproduzioni) AS ascolti
FROM artisti AS a
JOIN episodi AS e
	ON a.nome = e.podcaster
GROUP BY a.nome
	HAVING SUM(e.riproduzioni) > 5000000);

--3 Mostrare l'username, Nome e Cognome degli utenti che pagano l'abbonamento con Google Pay
SELECT u.username, u.email, u.nome, u.cognome, d.tipo
FROM utenti AS u
JOIN metodidipagamento AS m
	ON u.username = m.username
JOIN digitali AS d
	ON m.email = d.email
WHERE d.tipo = 'G'
ORDER BY u.cognome ASC;

--4 Mostrare il profitto totale per ogni tipo di abbonamento esistente
SELECT u1.abbonamento, SUM(introiti)
FROM (
	SELECT u2.abbonamento, SUM(a.prezzoMensile) AS introiti
	FROM utenti AS u2
	JOIN abbonamenti AS a
		ON u2.abbonamento = a.id
	WHERE u2.frequenzaaddebito = 'M'
	GROUP BY u2.abbonamento
	UNION
	SELECT u3.abbonamento, SUM(a.prezzoAnnuale) AS introiti
	FROM utenti AS u3
	JOIN abbonamenti AS a
		ON u3.abbonamento = a.id
	WHERE u3.frequenzaaddebito = 'A'
	GROUP BY u3.abbonamento
) AS r, utenti AS u1
GROUP BY u1.abbonamento;

--5 Mostrare Nome, Cognome e email degli utenti che hanno creato una playlist
SELECT DISTINCT u.username, u.nome, u.cognome, u.email, p.nome
FROM utenti AS u
JOIN playlist AS p
	ON u.username = p.creatore
ORDER BY u.cognome ASC;

--6 Mostrare il musicista con almeno 10 brani prodotti e il podcaster almeno 10 episodi registrati più pagati di sempre
(SELECT m.artista, SUM(p.importo)
FROM (SELECT b.artista
	FROM brani AS b
	GROUP BY b.artista 
		HAVING COUNT(b.titolo) >= 10) AS m
JOIN artisti AS a
	ON a.nome = m.artista
JOIN pagamenti AS p
	ON p.iban = a.iban
GROUP BY m.artista
ORDER BY SUM(p.importo) DESC
LIMIT 1)
UNION
(SELECT pc.artista, SUM(p.importo)
FROM (SELECT e.podcaster AS artista
		FROM episodi AS e
		GROUP BY e.podcaster
			HAVING COUNT(e.titolo) >= 10) AS pc
JOIN artisti AS a
	ON a.nome = pc.artista
JOIN pagamenti AS p
	ON p.iban = a.iban
GROUP BY pc.artista
ORDER BY SUM(p.importo) DESC
LIMIT 1);

-- artisti con il maggior numero di brani per ogni playlist (cambiare perche cosi non e' signifricativa)