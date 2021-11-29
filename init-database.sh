#!/bin/bash
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE user_data (first_name VARCHAR(10), last_name VARCHAR(10), email VARCHAR(20), username VARCHAR(10), password VARCHAR(10), regdate date);

EOSQL