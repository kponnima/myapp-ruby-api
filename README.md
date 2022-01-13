# myapp-ruby-api
Ruby Sinatra Rest API application deployed to kubernetes cluster

## Install Ruby
* Run `brew install rbenv`
* Run `rbenv install <version>`

-- verify using  
`ruby -v`  
`gem --version`

---
## Run the app
`cd src`  
`bundle install`
`ruby src/app.rb -s puma`  
`bundle exec ruby app.rb`  
`rerun 'ruby src/app.rb'` #for development

---

## Docker/Kubernetes build

1. Build and Run the app without docker compose

   `docker build -t myapp-ruby-api .`
   `docker run --rm -p 8081:80 myapp-ruby-api`

2. Docker Hub

  `docker tag myapp-ruby-api kponnima86/myapp-ruby-api:latest` to tag the image with hostname & port of docker registry(docker hub).  
  `docker login` to connect to docker registry.  
  `docker push kponnima86/myapp-ruby-api:latest` to push the image to local docker registry.

2. For single host(localhost), use `Docker Compose` to spin up multiple containers
   `docker-compose build`  
   `docker-compose build --no-cache` # preferred  
   `docker-compose up`  
   `docker-compose up -d` # preferred to run services in background  
   `docker-compose ps`  
   `docker-compose down`

   For multiples host(cloud clusters), use `Kubernetes` to spin up multiple containers
   `kubectl apply -f kubernetes/deployment.yaml`

3. To connect to the API routes (NodePort on minikube)

* Run `minikube service myapp-ruby-api --url` to get the deployed service url.
Note: Since we are using Docker driver on darwin, the terminal needs to be open to run it.
* Navigate to `deployed service url` to view the application in browser.
-- Alt
* Run `kubectl port-forward svc/myapp-ruby-api 8080:8080` to map the service to localhost
* Navigate to `http://localhost:8080` to view the application in browser.

4. View list of containers and images

   `docker container ls`  
   `docker image ls`

5. Get container logs

   `docker logs -f <appContainerID>`

6. Troubleshoot container

   `docker exec -it <appContainerID> bash`  
   `ping mongo1`

7. Inspect the image(Optional)

   `docker run -it myapp-ruby-api sh`  
   `docker inspect <appContainerID>`

8. Inspect the network(Optional)

   `docker network ls`

9. Clean up networks

   `docker network prune`

10. Remove dangling images

   `docker rmi $(docker images -f "dangling=true" -q)`

11. Remove all stopped containers

`docker rm $(docker ps -a -q)`

12. Delete all containers

`docker rm -vf $(docker ps -a -q)`

13. Delete all images

`docker rmi -f $(docker images -a -q)`

14. Remove all unused containers, volumes, networks and images

`docker system prune -a --volumes`
`docker-compose rm -f`

---

## Execute Rake tasks

`docker exec rake spec`