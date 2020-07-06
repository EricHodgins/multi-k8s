docker build -t erichodgins/multi-client:latest -t erichodgins/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t erichodgins/multi-server:latest -t erichodgins/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t erichodgins/multi-worker:latest -t erichodgins/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push erichodgins/multi-client:latest
docker push erichodgins/multi-server:latest
docker push erichodgins/multi-worker:latest

docker push erichodgins/multi-client:$SHA
docker push erichodgins/multi-server:$SHA
docker push erichodgins/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=erichodgins/multi-server:$SHA
kubectl set image deployments/client-deployment client=erichodgins/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=erichodgins/multi-worker:$SHA