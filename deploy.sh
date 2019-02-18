docker build -t dreddko/fib-client:latest -t dreddko/fib-client:$SHA -f ./client/Dockerfile ./client
docker build -t dreddko/fib-server:latest -t dreddko/fib-server:$SHA -f ./server/Dockerfile ./server
docker build -t dreddko/fib-worker:latest -t dreddko/fib-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dreddko/fib-client:latest
docker push dreddko/fib-server:latest
docker push dreddko/fib-worker:latest

docker push dreddko/fib-client:$SHA
docker push dreddko/fib-server:$SHA
docker push dreddko/fib-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/client-deployment client=dreddko/fib-client:$SHA
kubectl set image deployments/server-deployment server=dreddko/fib-server:$SHA
kubectl set image deployments/worker-deployment worker=dreddko/fib-worker:$SHA