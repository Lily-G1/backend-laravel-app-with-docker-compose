# backend-laravel-app-with-docker-compose  
## containerize backend laravel application with docker compose  

To run application:  
Clone repo and rename directory () to 'laravel':  
$ git clone https://github.com/f1amy/laravel-realworld-example-app.git laravel  

Create/Copy Dockerfile, .env, docker-compose.yml $ laravel_vhost.conf files in laravel directory. Then run the following commands:  

To pull and build images & run containers:  
$ docker compose build  
$ docker compose up -d  

To run composer, generate database key & migrate data in 'app' container:  
$ docker compose ps  
$ docker compose exec app composer install  
$ docker compose exec app php artisan key:generate  
$ docker compose exec app php artisan migrate --seed  
