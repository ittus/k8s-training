docker build -t ittus/multi-client:latest -t ittus/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ittus/multi-server -t ittus/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ittus/multi-worker -t ittus/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ittus/multi-client:latest
docker push ittus/multi-server:latest
docker push ittus/multi-worker:latest

docker push ittus/multi-client:$SHA
docker push ittus/multi-server:$SHA
docker push ittus/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ittus/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ittus/multi-worker:$SHA
kubectl set image deployments/client-deployment client=ittus/multi-client:$SHA