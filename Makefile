SHELL := /bin/bash
# Default target
.DEFAULT_GOAL := help

RED    := \033[1;31m
YELLOW := \033[1;33m
GREEN  :="\033[1;32m"
CYAN   := \033[1;36m
RESET  := \033[0m

.PHONY: help #- Show targets
.PHONY: setup-minikube #- Ensure Minikube cluster is running with correct profile
.PHONY: setup-argocd 


# Self-documenting help: list targets with "##" comments
help: ## Show all available targets with short descriptions.
	# This target reads the Makefile and prints any line ending with ##.
	# Use this when you want to discover available commands quickly.
	# Expected output: a list of targets and one-line descriptions.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <target>\n\nTargets:\n"} /^[a-zA-Z0-9_.-]+:.*##/ { printf "  %-28s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

# Convenience wrapper to call setup Makefile targets
setup-minikube: ## Ensure Minikube cluster is running with correct profile
	@echo -e "$(CYAN) Ensure Minikube cluster is running with correct profile $(RESET)"; \
	$(MAKE) -f Makefile_Setup ensure-minikube
	$(MAKE) -f Makefile_Setup enable-minikube-addons
	$(MAKE) -f Makefile_Setup check-clusterinfo
	$(MAKE) -f Makefile_Setup kubectl-get-nodes

setup-argocd: ## 
	@printf '$(CYAN) %s $(RESET) \n' \
		' What will we do to setup ArgoCD: ' \
		' 		- Step 1. Setup Minikube ' \
		' 		- Step 2. Create Namespace and Install ArgoCD on minikube ' \
		' 		- Step 3. ArgoCD Initial Setup (CLI install, Server Access, CLI login, Update Password ) ' \
		' 		- Step 4. Make ArgoCD installation production ready by hardening installation' \
		' 		- Step 5. Register the public Helm OCI repo as a source for hel chart with ArgoCD'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to continue..."; \
	read -r _

	@printf '$(CYAN) %s $(RESET) \n' "Step 1. Setup Minikube"; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 1...";  \
	read -r _; \
	$(MAKE) setup-minikube; \
	echo " --------------------------------------------------------------------------------"

	@printf '$(CYAN) %s $(RESET) \n' "Step 2. Install ArgoCD on minikube"; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 2..."; \
	read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_GitOps_Platform_Engineering install_argocd_on_minikube; \
	echo " --------------------------------------------------------------------------------"

	@printf '$(CYAN) %s $(RESET) \n' \
		' Step 3. ArgoCD Initial Setup: ' \
		' 		- Access Argocd server UI ' \
		' 		- Get Initial Argocd Server Admin Password ' \
		' 		- Install Argocd CLI tool ' \
		' 		- Change UI Admin Password ' \
		'		- Login into Argocd Server UI ' \
		' 		- Optional: Delete Initial Adming Password '; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 3..."; \
	read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_GitOps_Platform_Engineering access-argocd-server-ui-and-do-initial-configuration

	@printf '$(CYAN) %s $(RESET) \n' \
		' Step 4. Make ArgoCD installation production ready by hardening installation: ' \
		' 		- Disable-insecure-mode-of-argocd-server-by-applying-patch ' \
		' 		- Set-resource-tracking-method-to-annotation-by-applying-patch ' \
		' 		- Configure-resource-health-checks-timeout-by-applying-patch ' \
		' 		- Restart-argocd-server-to-pick-up-config-changes-by-applying-patch '; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 4..."; \
	read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_GitOps_Platform_Engineering make-argocd-installation-production-ready-by-hardening-installation

	@printf '$(CYAN) %s $(RESET) \n' \
		' Step 5. Register the public Helm OCI repo as a source for hel chart with ArgoCD'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 5..."; \
	read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_GitOps_Platform_Engineering k8s-apply-argocd-oci-helm-lab-repo-secret
	$(MAKE) -f Makefile_Setup_ArgoCD_GitOps_Platform_Engineering register-public-helm-oci-repo-as-source-for-helm-chart-with-argocd

# ------------------------------------------------------------------------------------------------------------
# 												Git Generator - Directories
# ------------------------------------------------------------------------------------------------------------
.PHONY: create-argocd-myapp-envs-applicationset-and-status-check
create-argocd-myapp-envs-applicationset-and-status-check: ## Create ApplicationSet for myapp envs and check status
	@printf '$(CYAN) %s $(RESET) \n' \
		' An ArgoCD ApplicationSet is a Kubernetes custom resource that declares:' \
		'       - How to generate many Applications (generators: Git Directory)' \
		'       - A shared template for those Applications (sources, destination, syncPolicy)' \
		'       - One desired state per combination of env/cluster/region, etc.'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to continue..."; \
	read -r _

	@printf '$(CYAN) %s $(RESET) \n' \
		' What will we do to setup the ApplicationSet for myapp envs:' \
		'       - Step 1. Apply the myapp-environments ApplicationSet to the argocd namespace' \
		'       - Step 2. Watch status of generated myapp-dev/staging/prod Applications (Healthy + Synced, with timeout)' \
		'       - Step 3. Get detailed status for myapp-dev/staging/prod Applications' \
		'       - Step 4. See resources ArgoCD created for each myapp env Application' \
		'       - Step 5. See diff between desired and actual for each myapp env Application'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to continue..."; \
	read -r _

	@printf '$(CYAN) %s $(RESET) \n' \
		'Step 1. Apply the myapp-environments ApplicationSet to the argocd namespace'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 1..."; \
	read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator check-myapp-envs-applicationset-and-apps-exist
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator k8s-apply-myapp-envs-applicationset-to-cluster

	@printf '$(CYAN) %s $(RESET) \n' 'Step 1.2. Sync myapp-dev and wait for Synced+Healthy'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 2..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator argocd-sync-and-wait-myapp-dev

	@printf '$(CYAN) %s $(RESET) \n' 'Step 1.3. Sync myapp-staging and wait for Synced+Healthy (once env values are ready)'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 3..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator argocd-sync-and-wait-myapp-staging || true
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator apply-staging-secret

	@printf '$(CYAN) %s $(RESET) \n' 'Step 1.4. Sync myapp-prod and wait for Synced+Healthy (once env values are ready)'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 4..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator argocd-sync-and-wait-myapp-prod || true
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator apply-prod-secret

	@printf '$(CYAN) %s $(RESET) \n' \
		'Step 2. Watch status of myapp-dev/staging/prod Applications until Healthy + Synced (timeout enforced)'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 2..."; \
	read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator argocd-watch-status-of-myapp-envs-applications

	@printf '$(CYAN) %s $(RESET) \n' \
		'Step 3. Get detailed status of myapp-dev/staging/prod Applications'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 3..."; \
	read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator argocd-get-detailed-status-of-myapp-envs-applications

	@printf '$(CYAN) %s $(RESET) \n' \
		'Step 4. See resources ArgoCD created for myapp-dev/staging/prod Applications'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 4..."; \
	read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator argocd-see-resources-of-myapp-envs-applications

	@printf '$(CYAN) %s $(RESET) \n' \
		'Step 5. See diff between desired and actual for myapp-dev/staging/prod Applications'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 5..."; \
	read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Git_Generator argocd-see-diff-of-myapp-envs-applications

# ------------------------------------------------------------------------------------------------------------
# 												Single Cluster
# ------------------------------------------------------------------------------------------------------------
.PHONY: create-argocd-myapp-single-cluster-envs-applicationset-and-status-check
create-argocd-myapp-single-cluster-envs-applicationset-and-status-check: ## Single cluster myapp via cluster generator
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Single_Cluster_Generator test-myapp-cluster-generator-as-dev
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Single_Cluster_Generator test-myapp-cluster-generator-as-staging
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Single_Cluster_Generator test-myapp-cluster-generator-as-prod	

# ------------------------------------------------------------------------------------------------------------
# 												Multi Clusters
#								Using: kind, 3 clusters dev/staging/prod
# ------------------------------------------------------------------------------------------------------------
.PHONY: create-argocd-myapp-kind-multi-clusters-envs-applicationset-and-status-check
create-argocd-myapp-kind-multi-clusters-envs-applicationset-and-status-check: ## Register env clusters, label them, apply myapp-clusters, sync+wait dev/staging/prod
	@printf '$(CYAN) %s $(RESET) \n' \
		' This will:' \
		'       - Step 1. Spin up kind-dev, kind-staging, kind-prod.' \
		'       - Step 2. Install Argo CD on kind-dev.' \
		'       - Step 3. Register all three clusters in Argo CD.' \
		'       - Step 4. Label them with environment=dev|staging|prod.' \
		'       - Step 5. Apply applicationsets/myapp-clusters.yaml.' \
		'       - Step 6. Sync and wait for myapp-dev-cluster, myapp-staging-cluster, myapp-prod-cluster.'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to continue..."; \
	read -r _

	@printf '$(CYAN) %s $(RESET) \n' 'Step 0. Optional cleanup of existing myapp apps and ApplicationSets'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 0 (or Ctrl+C to skip)..."; \
	read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator argocd-delete-all-myapp-apps-created-using-multi-clusters-generator
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator argocd-delete-all-myapp-applicationsets-using-multi-clusters-generator
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator reset-myapp-envs-applications-and-namespaces

	@printf '$(CYAN) %s $(RESET) \n' 'Step 1. Create kind dev/staging/prod clusters'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 1..."; read -r _
	$(MAKE) -f Makefile_Setup create-all-clusters-using-kind

	@printf '$(CYAN) %s $(RESET) \n' 'Step 2. Install Argo CD on kind-dev (hub)'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 2..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator install-argocd-on-kind-dev

	@printf '$(CYAN) %s $(RESET) \n' 'Step 2.1. Apply myapp-team AppProject (project definition)'; \
    printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 2b..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator k8s-apply-myapp-team-project

	@printf '$(CYAN) %s $(RESET) \n' 'Step 3. Register dev/staging/prod clusters in ArgoCD (if needed)'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 3..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator register-dev-staging-prod-clusters-in-argocd

	@printf '$(CYAN) %s $(RESET) \n' 'Step 4. Label dev/staging/prod cluster secrets with environment=dev/staging/prod'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 4..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator label-dev-cluster-for-myapp
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator label-staging-cluster-for-myapp
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator label-prod-cluster-for-myapp

	@printf '$(CYAN) %s $(RESET) \n' 'Step 5. Apply myapp-clusters ApplicationSet to argocd namespace'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 5..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator k8s-apply-myapp-multi-clusters-applicationset-to-cluster

	@printf '$(CYAN) %s $(RESET) \n' 'Step 6. Sync myapp across dev/staging/prod clusters'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 6..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator argocd-sync-and-wait-myapp-all-clusters

# ------------------------------------------------------------------------------------------------------------
#                                   Matrix Generator (Git + Cluster)
#                           Using: kind, 3 clusters dev/staging/prod
#                      Envs: dev / staging / prod driven by env-config.yaml
# ------------------------------------------------------------------------------------------------------------
.PHONY: create-argocd-myapp-kind-matrix-multi-clusters-multi-envs-and-status-check
create-argocd-myapp-kind-matrix-multi-clusters-multi-envs-and-status-check: ## Full setup for matrix (Git+Cluster) generator
	@printf '$(CYAN) %s $(RESET) \n' \
		' This will:' \
		'       - Step 1. Spin up kind-dev, kind-staging, kind-prod.' \
		'       - Step 2. Install Argo CD on kind-dev.' \
		'       - Step 3. Apply myapp-team AppProject.' \
		'       - Step 4. Register all three clusters in Argo CD.' \
		'       - Step 5. Label clusters with environment=dev|staging|prod.' \
		'       - Step 6. Apply applicationsets/myapp-matrix.yaml (Git+Cluster matrix).' \
		'       - Step 7. Sync and wait for all myapp-* Applications generated by the matrix.'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to continue..."; \
	read -r _

	@printf '$(CYAN) %s $(RESET) \n' 'Step 0. Optional cleanup of existing myapp apps and ApplicationSets'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 0 (or Ctrl+C to skip)..."; \
	read -r _; \
	printf '$(CYAN) %s $(RESET) \n' 'Only run argocd CLI cleanup if Argo CD is reachable' ; \
	if $(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator argocd-is-up >/dev/null 2>&1; then \
	  printf '$(CYAN) %s $(RESET) \n' 'Argo CD is up, running CLI-based cleanup...'; \
	  $(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator argocd-delete-all-myapp-apps-created-using-matrix-generator; \
	  $(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator argocd-delete-all-myapp-applicationsets-using-matrix-generator; \
	  $(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator argocd-delete-all-myapp-apps-created-using-multi-clusters-generator; \
	  $(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator argocd-delete-all-myapp-applicationsets-using-multi-clusters-generator; \
	else \
	  printf '$(CYAN) %s $(RESET) \n' 'Argo CD not reachable; skipping argocd CLI cleanup and only doing k8s namespace reset...'; \
	fi; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator reset-myapp-envs-applications-and-namespaces

	@printf '$(CYAN) %s $(RESET) \n' 'Step 1. Create kind dev/staging/prod clusters'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 1..."; read -r _; \
	$(MAKE) -f Makefile_Setup create-all-clusters-using-kind

	@printf '$(CYAN) %s $(RESET) \n' 'Step 2. Install Argo CD on kind-dev (hub)'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 2..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator install-argocd-on-kind-dev

	@printf '$(CYAN) %s $(RESET) \n' 'Step 3. Apply myapp-team AppProject'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 3..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator k8s-apply-myapp-team-project

	@printf '$(CYAN) %s $(RESET) \n' 'Step 4. Register dev/staging/prod clusters in ArgoCD'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 4..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator register-dev-staging-prod-clusters-in-argocd

	@printf '$(CYAN) %s $(RESET) \n' 'Step 5. Label dev/staging/prod cluster secrets with environment=dev/staging/prod'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 5..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator label-dev-cluster-for-myapp; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator label-staging-cluster-for-myapp; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator label-prod-cluster-for-myapp

	@printf '$(CYAN) %s $(RESET) \n' 'Step 6. Apply myapp-matrix-auto-sync ApplicationSet (Git + Cluster matrix)'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 6..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator k8s-apply-myapp-matrix-auto-sync-applicationset-to-cluster; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator k8s-describe-myapp-matrix-auto-sync-applicationset

	@printf '$(CYAN) %s $(RESET) \n' 'Step 7. Apply myapp-matrix-manual-sync ApplicationSet (Git + Cluster matrix)'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 7..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator k8s-apply-myapp-matrix-prod-manual-sync-applicationset-to-cluster; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator k8s-describe-myapp-matrix-manual-sync-applicationset

	@printf '$(CYAN) %s $(RESET) \n' 'Step 8. Sync all myapp-* Applications generated by matrix and wait for them'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 8..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator argocd-sync-and-wait-myapp-matrix-all


# ------------------------------------------------------------------------------------------------------------
#                    Progressive Delivery (RollingSync) for Matrix ApplicationSet
#                    Using: kind, 3 clusters dev/staging/prod
#           Envs: dev / staging / prod driven by env-config.yaml + environment labels
# ------------------------------------------------------------------------------------------------------------
.PHONY: create-argocd-myapp-kind-matrix-rollingsync-progressive-delivery-and-status-check
create-argocd-myapp-kind-matrix-rollingsync-progressive-delivery-and-status-check: ## Full setup for matrix RollingSync progressive delivery
	@printf '$(CYAN) %s $(RESET) \n' \
		' This will:' \
		'       - Step 1. Spin up kind-dev, kind-staging, kind-prod.' \
		'       - Step 2. Install Argo CD on kind-dev and expose it locally.' \
		'       - Step 3. Enable Progressive Syncs (RollingSync) in Argo CD.' \
		'       - Step 4. Apply myapp-team AppProject.' \
		'       - Step 5. Register all three clusters in Argo CD.' \
		'       - Step 6. Label clusters with environment=dev|staging|prod.' \
		'       - Step 7. Apply applicationsets/myapp-matrix-rollingsync.yaml (Git+Cluster matrix with RollingSync).' \
		'       - Step 8. Force refresh and show RollingSync status & fleet health.'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to continue..."; \
	read -r _

	@printf '$(CYAN) %s $(RESET) \n' 'Step 0. Optional cleanup of existing myapp apps and ApplicationSets'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 0 (or Ctrl+C to skip)..."; \
	read -r _; \
	printf '$(CYAN) %s $(RESET) \n' 'Only run argocd CLI cleanup if Argo CD is reachable'; \
	if $(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator argocd-is-up >/dev/null 2>&1; then \
	  printf '$(CYAN) %s $(RESET) \n' 'Argo CD is up, running CLI-based cleanup for matrix and rolling labs...'; \
	  $(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator argocd-delete-all-myapp-apps-created-using-matrix-generator; \
	  $(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Matrix_Multi_Clusters_Multi_Envs_Generator argocd-delete-all-myapp-applicationsets-using-matrix-generator || true; \
	else \
	  printf '$(CYAN) %s $(RESET) \n' 'Argo CD not reachable; skipping argocd CLI cleanup and only doing k8s namespace reset...'; \
	fi; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator reset-myapp-envs-applications-and-namespaces

	@printf '$(CYAN) %s $(RESET) \n' 'Step 1. Create kind dev/staging/prod clusters'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 1..."; read -r _; \
	$(MAKE) -f Makefile_Setup create-all-clusters-using-kind

	@printf '$(CYAN) %s $(RESET) \n' 'Step 2. Install Argo CD on kind-dev (hub) and expose API'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 2..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator install-argocd-on-kind-dev; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator k8s-argocd-expose-argocd-server-to-localaccess

	@printf '$(CYAN) %s $(RESET) \n' 'Step 3. Enable Progressive Syncs (RollingSync) in Argo CD'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 3 (you may need to edit the ConfigMap manually once)..."; read -r _; \
	echo "Ensure applicationsetcontroller.enable.progressive.syncs: \"true\" is set in argocd-cmd-params-cm"; \
	printf '$(YELLOW) %s $(RESET) \n' "Opening config map in your editor (kubectl edit) – save & exit when done."; \
	kubectl edit cm -n argocd argocd-cmd-params-cm; \
	printf '$(CYAN) %s $(RESET) \n' "Restarting ApplicationSet controller to apply progressive syncs flag..."; \
	kubectl rollout restart deployment argocd-applicationset-controller -n argocd || true

	@printf '$(CYAN) %s $(RESET) \n' 'Step 4. Apply myapp-team AppProject'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 4..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator k8s-apply-myapp-team-project

	@printf '$(CYAN) %s $(RESET) \n' 'Step 5. Register dev/staging/prod clusters in ArgoCD'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 5..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator register-dev-staging-prod-clusters-in-argocd

	@printf '$(CYAN) %s $(RESET) \n' 'Step 6. Label dev/staging/prod cluster secrets with environment=dev/staging/prod'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 6..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator label-dev-cluster-for-myapp; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator label-staging-cluster-for-myapp; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator label-prod-cluster-for-myapp

	@printf '$(CYAN) %s $(RESET) \n' 'Step 7. Apply myapp-matrix-rollingsync ApplicationSet (Git + Cluster matrix + RollingSync)'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 7..."; read -r _; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator k8s-apply-myapp-matrix-rollingsync-applicationset-to-cluster; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator k8s-describe-myapp-matrix-rollingsync-applicationset

	@printf '$(CYAN) %s $(RESET) \n' 'Step 8. Force refresh of RollingSync ApplicationSet and show fleet status'; \
	printf '$(CYAN) %s $(RESET) \n' "Press ENTER to run Step 8..."; read -r _; \
	kubectl annotate applicationset myapp-matrix-rollingsync -n argocd \
	  argocd.argoproj.io/refresh=hard --overwrite; \
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator k8s-status-myapp-matrix-rollingsync

	@printf '$(GREEN) %s $(RESET) \n' \
		'RollingSync matrix progressive delivery lab is now set up. Use Argo CD UI or argocd CLI to watch dev → staging → prod rollout.';\
		'You can call verify-myapp-fleet-under-rollingsync now'; \
		'make -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Rollingsync_Progessive_Delivery_Matrix_Multi_Clusters_Multi_Envs_Generator verify-myapp-fleet-under-rollingsync';
	

.PHONY: cleanup-myapp-argocd-lab
cleanup-myapp-argocd-lab: ## Clean all myapp ArgoCD apps + ApplicationSets
	@printf '$(RED) %s $(RESET) \n' 'WARNING: This will delete all myapp-* ArgoCD apps and their resources (cascade).'; \
	printf '$(RED) %s $(RESET) \n' "Press ENTER to continue, or Ctrl+C to abort..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Git_Generator argocd-delete-all-myapp-apps-created-using-git-generator
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Single_Cluster_Generator argocd-delete-all-myapp-apps-created-using-single-cluster-generator
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator argocd-delete-all-myapp-apps-created-using-multi-clusters-generator	

	@printf '$(RED) %s $(RESET) \n' 'WARNING: This will delete all myapp-* ArgoCD appsets and their resources (cascade).'; \
	printf '$(RED) %s $(RESET) \n' "Press ENTER to continue, or Ctrl+C to abort..."; read -r _
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Git_Generator argocd-delete-all-myapp-applicationsets-using-git-generator
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Single_Cluster_Generator argocd-delete-all-myapp-applicationsets-using-single-cluster-generator
	$(MAKE) -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator argocd-delete-all-myapp-applicationsets-using-multi-clusters-generator

# Example: safe usage pattern
# Start from a clean shell.
# Run:
# bash
# make setup-minikube
# This ensures k8s-learning profile is up and configured.

# Then run:
# bash
# make setup-argocd
