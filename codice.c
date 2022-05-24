#include <stdio.h>
#include "dependencies/include/libpq-fe.h"
#include <stdlib.h>

#define PG_HOST "127.0.0.1" // oppure " localhost " o " postgresql "
#define PG_USER "postgres"  // il vostro nome utente
#define PG_DB "progetto"    // il nome del database
#define PG_PASS "pippoipop" // la vostra password
#define PG_PORT 5432

void checkResults(PGresult *res, const PGconn *conn)
{
    if (PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        printf("Errori nei risultati. %s\n", PQerrorMessage(conn));
        PQclear(res);
        exit(1);
    }
}

void printResults(PGconn *conn, const char *query)
{
    PGresult *res;
    res = PQexec(conn, query);
    checkResults(res, conn);

    int tuple = PQntuples(res);
    int campi = PQnfields(res);

    // Stampo intestazioni
    for (int i = 0; i < campi; ++i)
    {
        printf("%s\t\t\t", PQfname(res, i));
        
    }
    puts("\n==============================================================================================================");

    // Stampo i valori selezionati
    for (int i = 0; i < tuple; ++i)
    {
        for (int j = 0; j < campi; ++j)
        {
            printf("%s\t\t\t", PQgetvalue(res, i, j));
        }
        printf("\n");
    }

    PQclear(res);
}

int main()
{
    char conninfo[250];

    sprintf(conninfo, "user=%s password=%s dbname=%s hostaddr=%s port=%d",
            PG_USER, PG_PASS, PG_DB, PG_HOST, PG_PORT);

    PGconn *conn = PQconnectdb(conninfo);

    if (PQstatus(conn) == CONNECTION_BAD)
    {
        fprintf(stderr, "Connessione al database fallita: %s\n",
                PQerrorMessage(conn));
        PQfinish(conn);
        exit(1);
    }

    // TODO: QUERIES
    const char *stringhe[6] = {
        "1. Mostrare l'importo dell'ultimo bonfico effettuato agli artisti, oltretutto mostrarlo in ordine decrescente",
        "2. Mostrare l'artista (musicista e podcaster) con più di 5M ascolti totali",
        "3. Mostrare l'username, Nome e Cognome degli utenti che pagano l'abbonamento con Google Pay",
        "4. Mostrare il profitto totale per ogni tipo di abbonamento esistente",
        "5. Mostrare Nome, Cognome e email degli utenti che hanno creato una playlist",
        "6. Mostrare il musicista con almeno 10 brani prodotti e il podcaster almeno 10 episodi registrati più pagati di sempre"
    };

    const char *queries[6] = {
        "SELECT u.username, u.email, u.nome, u.cognome, d.tipo FROM utenti AS u JOIN metodidipagamento AS m ON u.username = m.username JOIN digitali AS d ON m.email = d.email WHERE d.tipo = 'G' ORDER BY u.cognome ASC;",
        "(SELECT a.nome as artista, SUM(b.riproduzioni) AS ascolti FROM artisti AS a JOIN brani AS b ON a.nome = b.artista GROUP BY a.nome HAVING SUM(b.riproduzioni) > 5000000) UNION (SELECT a.nome as artista, SUM(e.riproduzioni) AS ascolti FROM artisti AS a JOIN episodi AS e ON a.nome = e.podcaster GROUP BY a.nome HAVING SUM(e.riproduzioni) > 5000000);",
        "SELECT u.username, u.email, u.nome, u.cognome, d.tipo FROM utenti AS u JOIN metodidipagamento AS m ON u.username = m.username JOIN digitali AS d ON m.email = d.email WHERE d.tipo = 'G' ORDER BY u.cognome ASC;",
        "SELECT u1.abbonamento, SUM(introiti) FROM (SELECT u2.abbonamento, SUM(a.prezzoMensile) AS introiti FROM utenti AS u2 JOIN abbonamenti AS a ON u2.abbonamento = a.id WHERE u2.frequenzaaddebito = 'M' GROUP BY u2.abbonamento UNION SELECT u3.abbonamento, SUM(a.prezzoAnnuale) AS introiti FROM utenti AS u3 JOIN abbonamenti AS a ON u3.abbonamento = a.id WHERE u3.frequenzaaddebito = 'A' GROUP BY u3.abbonamento) AS r, utenti AS u1 GROUP BY u1.abbonamento;",
        "SELECT DISTINCT u.nome, u.cognome, u.email, p.nome FROM utenti AS u JOIN playlist AS p ON u.username = p.autore ORDER BY u.cognome ASC;",
        "(SELECT m.artista, SUM(p.importo) FROM (SELECT b.artista FROM brani AS b GROUP BY b.artista HAVING COUNT(b.titolo) >= 10) AS m JOIN artisti AS a ON a.nome = m.artista JOIN pagamenti AS p ON p.iban = a.iban GROUP BY m.artista ORDER BY SUM(p.importo) DESC LIMIT 1) UNION (SELECT pc.artista, SUM(p.importo) FROM (SELECT e.podcaster AS artista FROM episodi AS e GROUP BY e.podcaster HAVING COUNT(e.titolo) >= 10) AS pc JOIN artisti AS a ON a.nome = pc.artista JOIN pagamenti AS p ON p.iban = a.iban GROUP BY pc.artista ORDER BY SUM(p.importo) DESC LIMIT 1);"
    };

    for (int i = 0; i < 6; i++)
    {
        printf("%s\n\n", stringhe[i]);
        printResults(conn, queries[i]);
        printf("\n\n\n");
    }
    PQfinish(conn);

    return 0;
}