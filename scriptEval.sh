docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)

sudo service docker start

#Creation fichier dockerServer et écriture du fichier
mkdir dockerEval
cd dockerEval
touch dockerServer
echo "FROM httpd:latest" >> dockerServer
echo "WORKDIR /usr/local/apache2/htdocs" >> dockerServer
echo "EXPOSE 80" >> dockerServer

# Initialisation du conteneur Apache
docker build -f dockerServer -t apache .

# Installation de rancher
docker run -d --restart=always -p 8080:8080 rancher/server:stable

# Installation de MySQL
docker run --name mysql -e MYSQL_ROOT_PASSWORD=0000 -d mysql:latest

# Installation de adminer et lien avec mySQL
docker run -d -p 80:80 --link $(docker ps -aqf "name=mysql") clue/adminer

# Affichage de lid du seveur mysql
echo "_________________" 
echo "_________________" 
echo "_________________" 
echo "Serveur : "
docker ps --filter "name=mysql" -q




