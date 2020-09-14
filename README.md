# installation

### Install Ruby

Download from https://rubyinstaller.org/ and run the .exe file

verify using  
`ruby -v`  
`gem --version`

## create a rail project

`rails new todos-api --api`

---

## Run the app

`cd src`  
`bundle install`  
`ruby src/app.rb -s puma`  
`bundle exec ruby app.rb`  
`rerun 'ruby src/app.rb'` #for development

---

## Docker build

1. For single host(localhost), use Docker Compose to spin up multiple containers

   `docker-compose build`  
   `docker-compose build --no-cache` # preferred  
   `docker-compose up`  
   `docker-compose up -d` #preferred to run services in background  
   `docker-compose ps`  
   `docker-compose down`

2. Build and Run the app without docker compose

   `docker build -t myapp-ruby-api .`
   `docker run --rm -p 8081:80 myapp-ruby-api`

3. View list of containers and images

   `docker container ls`  
   `docker image ls`

4. Get container logs

   `docker logs -f <appContainerID>`

5. Troubleshoot container

   `docker exec -it <appContainerID> bash`  
   `ping mongo1`

6. Inspect the image(Optional)

   `docker run -it myapp-ruby-api sh`  
   `docker inspect <appContainerID>`

7. Inspect the network(Optional)

   `docker network ls`

8. Clean up networks

   `docker network prune`

9. Remove dangling images

   `docker rmi $(docker images -f "dangling=true" -q)`

10. Remove all stopped containers

`docker rm $(docker ps -a -q)`

11. Delete all containers

`docker rm -vf $(docker ps -a -q)`

12. Delete all images

`docker rmi -f $(docker images -a -q)`

13. Remove all unused containers, volumes, networks and images

`docker system prune -a --volumes`
`docker-compose rm -f`

---

### For multiples host(cloud clusters), use Kubernetes to spin up multiple containers

`kubectl create -f kubernetes/deployment.yaml`

### Use Minikube, for local orchestration of Kubernetes linux containers and deployment

`minikube status`  
`minikube start`  
`eval $(minikube docker-env)`

---

## Execute Rake tasks

`docker exec rake spec`
