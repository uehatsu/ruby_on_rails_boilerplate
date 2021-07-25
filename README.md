# Docker files for Ruby on Rails

## How to use

### Build the project

1. Create .env file
```
cp .env.example .env
```

2. Build image
```
docker-compose build
```

3. Create new rails project
```
docker-compose run --no-deps web rails new . -d mysql
```

4. Edit .env file
```
vi .env
```

```
RAILS_VERSION=6.1.4
BUILD_TYPE=rebuild
```

5. Rebuild docker image

```
docker-compose build
```

6. Change database configuration
```
vi src/config/database.yml
```

```
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password: password
  host: db

development:
  <<: *default
  database: src_development

test:
  <<: *default
  database: src_test
```

7. Create databases
```
docker-compose up -d db
docker-compose run web rails db:create
docker-compose stop
```

8. Run rails server

```
docker-compose up
```

http://localhost:3000/

9. Stop rails server

```
docker-compose stop
```
