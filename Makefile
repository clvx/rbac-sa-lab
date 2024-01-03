#ENV = dev stage
ENV = dev

# ==============================================================================
# For full Kind v0.12 release notes: https://github.com/kubernetes-sigs/kind/releases/tag/v0.12.0
# Running from within k8s/kind
KIND_CLUSTER ?= rbac-manager

kind-up:
	for i in $(ENV); do kind create cluster \
		--image kindest/node:v1.27.2 \
		--name $(KIND_CLUSTER)-$$i \
		--config kind/kind-config.yaml; done

kind-down:
	for i in $(ENV); do kind delete cluster --name $(KIND_CLUSTER)-$$i; done

bootstrap:
	kubectl apply -f templates/

create:
	@echo "THIS WORKS AS THE ROLEBINDING GRANTS edit TO hub/hub-sa"
	kubectl -n target-1 run -i runner --tty --image bash:latest --as=system:serviceaccount:hub:hub-sa -- bash
                        
view:                   
	@echo "!!! - THIS WILL FAIL"
	kubectl -n target-1 run -i runner-view --rm=true --tty --image bash:latest --as=system:serviceaccount:hub:hub-view-sa -- bash

list:
	@echo "THIS WORKS AS THE ROLEBINDING GRANTS view TO hub/hub-view-sa"
	kubectl -n target-1 get pods  --as=system:serviceaccount:hub:hub-view-sa

purge:
	kubectl -n target-1 delete pod runner 
	kubectl delete -f templates/
