#include <stdio.h>
#include "dependencies/include/libpq-fe.h"
#include <stdlib.h>

#define PG_HOST "127.0.0.1" // oppure " localhost " o " postgresql "
#define PG_USER "postgres"  // il vostro nome utente
#define PG_DB "soundexp"    // il nome del database
#define PG_PASS "Abc280102" // la vostra password
#define PG_PORT 5432

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
    else
    {
        printf("Connessione al database riuscita\n");
    }

    // TODO: QUERIES

    PQfinish(conn);

    return 0;
}