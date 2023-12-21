docker build -t okitsnotok/multi-client:latest -t okitsnotok/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t okitsnotok/multi-server:latest -t okitsnotok/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t okitsnotok/multi-worker:latest -t okitsnotok/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push okitsnotok/multi-client:latest
docker push okitsnotok/multi-server:latest
docker push okitsnotok/multi-worker:latest
docker push okitsnotok/multi-client:$SHA
docker push okitsnotok/multi-server:$SHA
docker push okitsnotok/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=okitsnotok/multi-server:$SHA
kubectl set image deployments/client-deployment client=okitsnotok/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=okitsnotok/multi-worker:$SHA