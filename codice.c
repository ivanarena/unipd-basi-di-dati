#include <stdio.h>
#include <stdlib.h>
#include "dependencies/include/libpq-fe.h"

#define PG_HOST "127.0.0.1" // oppure "localhost" o "postgresql"
#define PG_USER "postgres"  // il vostro nome utente
#define PG_DB "progetto"    // il nome del database
#define PG_PASS "" // la vostra password
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
        if(i==0) {printf("%20s", PQfname(res, i));}
        else{printf("%35s", PQfname(res, i));} 
    }
    puts("\n========================================================================================================================================================================================================");

    // Stampo i valori selezionati
    for (int i = 0; i < tuple; ++i)
    {
        for (int j = 0; j < campi; ++j)
        {
            if(j != 0) {printf("%35s", PQgetvalue(res, i, j));}
            else{printf("%20s", PQgetvalue(res, i, j));}
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

    // QUERIES
    const char *descr[6] = {
        "1. Mostrare il nome di ogni artista e l'importo dell'ultimo bonifico effettuato a loro favore, con la rispettiva data di esecuzione, in ordine decrescente di importo",
        "2. Mostrare tutti gli artisti con più di 5 milioni di ascolti totali.",
        "3. Mostrare username, nome e cognome di tutti gli utenti che pagano l'abbonamento con Google Pay e ordinarli per cognome.",
        "4. Mostrare il profitto totale per ogni tipo di abbonamento esistente.",
        "5. Mostrare username, nome, cognome ed e-mail di tutti gli utenti che hanno creato una playlist ed ordinarli per cognome.",
        "6. Mostrare il musicista con almeno 10 brani prodotti e il podcaster con almeno 10 episodi registrati più pagati di sempre."};

    const char *queries[6] = {
        "SELECT u.username, u.email, u.nome, u.cognome, d.tipo \
        FROM utenti AS u \
        JOIN metodidipagamento AS m \
        ON u.username = m.username \
        JOIN digitali AS d \
        ON m.email = d.email \
        WHERE d.tipo = 'G' \
        ORDER BY u.cognome ASC;",

        "(SELECT a.nome as artista, SUM(b.riproduzioni) AS ascolti \
        FROM artisti AS a \
        JOIN brani AS b \
        ON a.nome = b.artista \
        GROUP BY a.nome \
        HAVING SUM(b.riproduzioni) > 5000000) \
        UNION \
        (SELECT a.nome as artista, SUM(e.riproduzioni) AS ascolti \
        FROM artisti AS a \
        JOIN episodi AS e \
        ON a.nome = e.podcaster \
        GROUP BY a.nome \
        HAVING SUM(e.riproduzioni) > 5000000);",

        "SELECT u.username, u.email, u.nome, u.cognome, d.tipo \
        FROM utenti AS u \
        JOIN metodidipagamento AS m \
        ON u.username = m.username \
        JOIN digitali AS d \
        ON m.email = d.email \
        WHERE d.tipo = 'G' \
        ORDER BY u.cognome ASC;",

        "SELECT u1.abbonamento, SUM(introiti) \
        FROM ((SELECT u2.abbonamento, SUM(a.prezzoMensile) AS introiti \
        FROM utenti AS u2 \
        JOIN abbonamenti AS a \
        ON u2.abbonamento = a.id \
        WHERE u2.frequenzaaddebito = 'M' \
        GROUP BY u2.abbonamento) \
        UNION \
        (SELECT u3.abbonamento, SUM(a.prezzoAnnuale) AS introiti \
        FROM utenti AS u3 \
        JOIN abbonamenti AS a \
        ON u3.abbonamento = a.id \
        WHERE u3.frequenzaaddebito = 'A' \
        GROUP BY u3.abbonamento)) \
        AS r, utenti AS u1 \
        GROUP BY u1.abbonamento;",

        "SELECT DISTINCT u.username, u.nome, u.cognome, u.email, p.nome \
        FROM utenti AS u \
        JOIN playlist AS p \
        ON u.username = p.creatore \
        ORDER BY u.cognome ASC;",

        "(SELECT m.artista, SUM(p.importo) \
        FROM \
        (SELECT b.artista FROM brani AS b \
        GROUP BY b.artista \
        HAVING COUNT(b.titolo) >= 10) AS m \
        JOIN artisti AS a \
        ON a.nome = m.artista \
        JOIN pagamenti AS p \
        ON p.iban = a.iban \
        GROUP BY m.artista \
        ORDER BY SUM(p.importo) DESC \
        LIMIT 1) \
        UNION \
        (SELECT pc.artista, SUM(p.importo) \
        FROM \
        (SELECT e.podcaster AS artista \
        FROM episodi AS e \
        GROUP BY e.podcaster \
        HAVING COUNT(e.titolo) >= 10) AS pc \
        JOIN artisti AS a \
        ON a.nome = pc.artista \
        JOIN pagamenti AS p \
        ON p.iban = a.iban \
        GROUP BY pc.artista \
        ORDER BY SUM(p.importo) DESC \
        LIMIT 1);"};

    for (int i = 0; i < 6; i++)
    {
        printf("%s\n\n", descr[i]);
        printResults(conn, queries[i]);
        printf("\n\n\n");
    }

    int stop = 0;
    while (!stop)
    {

        int n;
        puts("\nScegli la query da eseguire (1-6) o digita 0 per uscire.\n");
        for (int i = 0; i < 6; i++)
        {
            printf("%s\n", descr[i]);
        }
        puts("\n");
        scanf("%d", &n);
        if (n == 0)
            stop = 1;
        else if (n > 0 && n <= 6)
        {
            if (n == 3)
            {
                int ok = 0;
                int tipo;
                const char *tipiCompleti[3] = {"PayPal", "Google Pay", "Apple Pay"};
                const char *queryModificate[3] = {
                    "SELECT u.username, u.email, u.nome, u.cognome, d.tipo \
                    FROM utenti AS u \
                    JOIN metodidipagamento AS m \
                    ON u.username = m.username \
                    JOIN digitali AS d \
                    ON m.email = d.email \
                    WHERE d.tipo = 'P' \
                    ORDER BY u.cognome ASC;",

                    "SELECT u.username, u.email, u.nome, u.cognome, d.tipo \
                    FROM utenti AS u \
                    JOIN metodidipagamento AS m \
                    ON u.username = m.username \
                    JOIN digitali AS d \
                    ON m.email = d.email \
                    WHERE d.tipo = 'G' \
                    ORDER BY u.cognome ASC;",

                    "SELECT u.username, u.email, u.nome, u.cognome, d.tipo \
                    FROM utenti AS u \
                    JOIN metodidipagamento AS m \
                    ON u.username = m.username \
                    JOIN digitali AS d \
                    ON m.email = d.email \
                    WHERE d.tipo = 'A' \
                    ORDER BY u.cognome ASC;"};

                printf("\nInserisci un metodo di pagamento tra:\n1. PayPal\n2. Google Pay\n3. Apple Pay\n\n");
                while (!ok)
                {
                    scanf("%d", &tipo);
                    if (tipo > 0 && tipo <= 3)
                    {
                        ok = 1;
                    }
                    else
                    {
                        tipo = 0;
                        puts("Inserire un metodo di pagamento valido.");
                    }
                }
                printf("Mostrare username, nome e cognome di tutti gli utenti che pagano l'abbonamento con %s e ordinarli per cognome.\n\n", tipiCompleti[tipo - 1]);
                printResults(conn, queryModificate[tipo - 1]);
                printf("\n\n\n");
            }
            else
            {
                printf("%s\n\n", descr[n - 1]);
                printResults(conn, queries[n - 1]);
                printf("\n\n\n");
            }
        }
    }

    PQfinish(conn);
    return 0;
}
