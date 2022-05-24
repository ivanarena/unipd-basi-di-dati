--1
SELECT a.nome, p.importo, p.dataesecuzione AS data
FROM artisti AS a, pagamenti AS p
WHERE a.iban = p.iban AND p.dataesecuzione = (SELECT MAX(p.dataesecuzione) FROM pagamenti AS p)
ORDER BY p.importo DESC

--2

--3
SELECT u.username, u.nome, u.cognome, d.tipo
FROM utenti AS u, digitali AS d, metodidipagamento AS m
WHERE u.username = m.username AND m.email = d.email AND d.tipo = 'G'

--4

--5
SELECT DISTINCT u.nome, u.cognome, u.email, p.nome
FROM utenti AS u, playlist AS p
WHERE u.username = p.autore
ORDER BY u.cognome

--6

