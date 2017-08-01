Houseapp Api
================

Ruby on Rails
-------------

This application requires:

- Ruby 2.4.1
- Rails 5.0.2

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Development
-----------

- [Install Docker](https://docs.docker.com/engine/installation/)
- Run `docker-componse -p houseapp up -d` to start docker containers
- Run `docker-componse -p houseapp down` to stop docker containers
- Execute `docker exec -it houseapp_app_1 bash` to open bash console 
    + Execute `rake db:migrate` to migrate DB
    + Execute `rake swagger:docs` to generate api docs
- Path:
    + Rails app: `http://localhost:3000`
    + Admin: `http://localhost:3000/admin`
    + API Docs:  `http://localhost:3000/api_docs`
    + PgAdmin:  `http://localhost:5050`


Production
---------- 

- Use heroku

Contributing
------------

Vu Huan (huanvn@gmail.com)

Credits
-------

License
-------

