# JAYA Data Repository

Ce repository ne concerne que les fichier liés au système de data de la plateforme.

Une image docker contenant postgresql est disponible et utilisable via la commande:

`docker run --name test_postgres -e POSTGRESS_PASSWORD=test -p 5423:4000 postgres`

La BDD est alors accessible:
* Hostname: localhost
* Port: 4000
* User: postgres
* Password: test