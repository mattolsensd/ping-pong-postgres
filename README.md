# ping-pong-postgres

# BUILD
cd .../ping-pong-postgres
docker build -t pingpong/postgres .

# RUN
docker run -t -p 5432:5432  pingpong/postgres

# LOAD
psql ... < schema.ddl

