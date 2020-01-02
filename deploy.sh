# Build all our images, tag each one, push each to docker hub
docker build -t sey1000/multi-client:latest -t sey1000/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sey1000/multi-server:latest -t sey1000/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sey1000/multi-worker:latest -t sey1000/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sey1000/multi-client:latest
docker push sey1000/multi-server:latest
docker push sey1000/multi-worker:latest

docker push sey1000/multi-client:$SHA
docker push sey1000/multi-server:$SHA
docker push sey1000/multi-worker:$SHA

# Apply all configs in the 'k8s' folder
kubectl apply -f k8s

# Imperatively set latest images on each deployment
kubectl set image deployments/client-deployment client=sey1000/multi-client:$SHA
kubectl set image deployments/server-deployment server=sey1000/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=sey1000/multi-worker:$SHA
