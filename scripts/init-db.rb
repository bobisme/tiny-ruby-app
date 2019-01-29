require_relative '../db'

DB.conn.query(%{
  SET GLOBAL time_zone = 'UTC';
})

DB.conn.query(%{
  CREATE DATABASE IF NOT EXISTS thedb;
})

DB.conn.query(%{
  USE thedb;
})

DB.conn.query(%{
  CREATE TABLE IF NOT EXISTS things (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(128),
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
  )
})
