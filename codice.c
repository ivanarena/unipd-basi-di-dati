#include <stdio.h>
#include "dependencies/include/libpq-fe.h"
#include <stdlib.h>

#define PG_HOST "127.0.0.1" // oppure " localhost " o " postgresql "
#define PG_USER "postgres"  // il vostro nome utente
#define PG_DB "soundexp"    // il nome del database
#define PG_PASS "Abc280102" // la vostra password
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
        printf("%s\t\t\t\t\t", PQfname(res, i));
    }
    puts("\n==============================================================================================================");

    // Stampo i valori selezionati
    for (int i = 0; i < tuple; ++i)
    {
        for (int j = 0; j < campi; ++j)
        {
            printf("%s\t\t\t\t\t", PQgetvalue(res, i, j));
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
    const char *queries[6] = {
        "SELECT u.username, u.email, u.nome, u.cognome, d.tipo FROM utenti AS u JOIN metodidipagamento AS m ON u.username = m.username JOIN digitali AS d ON m.email = d.email WHERE d.tipo = 'G' ORDER BY u.cognome ASC;",
        "",
        "",
        "",
        "",
        ""};

    for (int i = 0; i < 6; i++)
    {
        printResults(conn, queries[i]);
    }
    PQfinish(conn);

    return 0;
}