# Multi‑Cluster GitOps with Argo CD ApplicationSets (kind dev/staging/prod)
This project shows how to use Argo CD ApplicationSets with the Cluster generator to deploy a single Helm‑based application (myapp) to three kind clusters: dev, staging, and prod.

### It uses:
```console
    - one hub cluster: kind-dev (runs Argo CD)
    - two remote clusters: kind-staging, kind-prod
    - a Cluster generator that targets clusters by environment=dev|staging|prod label on Argo CD cluster 
    - secrets
```
## 1. High‑level approach
### Goals
```console
    . Stand up three local Kubernetes clusters with kind: dev, staging, prod.
    . Install Argo CD on the dev cluster as a central control plane.
    . Register all three clusters in Argo CD and label them with environment labels.
    . Use an ApplicationSet to generate one Argo CD Application per cluster:
            - myapp-dev-cluster
            - myapp-staging-cluster
            - myapp-prod-cluster
    . Drive everything via Makefile targets so a single command can:
            - reset state,
            - recreate clusters,
            - bootstrap Argo CD,
            - register/label clusters,
            - apply the ApplicationSet,
            - and sync all apps.
```
## Key building blocks
    1. **kind clusters:** kind-dev, kind-staging, kind-prod created via create-all-clusters-using-kind.
    2. **Argo CD:** installed on kind-dev (namespace argocd) using the official install manifest.
    3. **Argo CD cluster secrets:**
        - created by argocd cluster add kind-dev|kind-staging|kind-prod
        - labeled with environment=dev|staging|prod
        - used by the Cluster generator.
    4. **AppProject myapp-team:**
        - limits allowed sourceRepos and destinations
        - explicitly allows the three kind API servers and myapp-* namespaces.
    5. **ApplicationSet myapp-clusters:**
        - uses the Cluster generator with an environment label selector
        - templates a Helm chart + values for each environment.

## 2. Architecture (ASCII component diagram)
```markdown

                           +------------------------------+
                           |        Git Repositories      |
                           |------------------------------|
                           | 1) Helm OCI: ghcr.io/...     |
                           | 2) Values Git: myapp-gitops_1|
                           +---------------+--------------+
                                           |
                                           | ApplicationSet (myapp-clusters)
                                           v
                        +-------------------------+         kind-staging
                        |  kind-dev cluster       |       kind-prod clusters
                        |  (hub, runs Argo CD)   |       (workload clusters)
                        +-------------------------+       +------------------+
                        | Namespace: argocd       |       |                  |
                        |                         |       |                  |
                        | +---------------------+ |       | +--------------+ |
                        | | Argo CD Components | |       | | Kubernetes   | |
                        | |---------------------| |       | | API Servers  | |
                        | | argocd-server       | |       | | (6444/6445) | |
                        | | argocd-repo-server  | |       | +--------------+ |
                        | | argocd-controller   | |       |                  |
                        | | argocd-appset-ctrl  | |       |  myapp-*        |
                        | +----------+----------+ |       |  namespaces     |
                        |            |            |       +------------------+
                        |            |
                        |            | Cluster secrets (argocd.argoproj.io/secret-type=cluster)
                        |            |  - cluster-172.26.44.184-2811944750 (env=dev)
                        |            |  - cluster-172.26.44.184-2862277607 (env=staging)
                        |            |  - cluster-172.26.44.184-2845499988 (env=prod)
                        |            v
                        |    ApplicationSet (myapp-clusters)
                        |      generators:
                        |        - clusters:
                        |            matchLabels:
                        |              environment: [dev, staging, prod]
                        |      template:
                        |        myapp-{{.name}} Applications:
                        |          - myapp-dev-cluster
                        |          - myapp-staging-cluster
                        |          - myapp-prod-cluster
                        +---------------------------------+
    
    - Argo CD in kind-dev watches Git/OCI and drives all three clusters.
    - The ApplicationSet controller uses the cluster secrets + labels to decide where to create each myapp-*-cluster Application. 
```

## 3. Mind map (text form)

```markdown
    Multi-Cluster GitOps with Argo CD & kind
    |
    +-- Clusters
    |   |
    |   +-- kind-dev (hub)
    |   |   +-- Runs Argo CD
    |   |   +-- Namespace: argocd
    |   |
    |   +-- kind-staging
    |   |   +-- Workload cluster
    |   |
    |   +-- kind-prod
    |       +-- Workload cluster
    |
    +-- Argo CD Core
    |   |
    |   +-- AppProject: myapp-team
    |   |   +-- sourceRepos: Git + OCI Helm
    |   |   +-- destinations: (dev|staging|prod servers + myapp-* namespaces)
    |   |
    |   +-- Cluster registration
    |       +-- argocd cluster add kind-dev --name dev-cluster
    |       +-- argocd cluster add kind-staging --name staging-cluster
    |       +-- argocd cluster add kind-prod --name prod-cluster
    |       +-- Creates cluster secrets in argocd namespace
    |       +-- Secrets labeled: environment=dev|staging|prod
    |
    +-- ApplicationSet: myapp-clusters
    |   |
    |   +-- Generator: clusters
    |   |   +-- selector:
    |   |       - argocd.argoproj.io/secret-type=cluster
    |   |       - environment in [dev, staging, prod]
    |   |
    |   +-- Template
    |       +-- name: myapp-{{.name}}
    |       +-- project: myapp-team
    |       +-- destination:
    |       |   +-- server: {{.server}}
    |       |   +-- namespace: myapp-{{.values.environment}}
    |       +-- sources:
    |           +-- Helm OCI: chart myapp, revision 1.0.0
    |           +-- Git values: $values/envs/{{.values.environment}}/values.yaml
    |
    +-- Automation via Make
        |
        +-- create-all-clusters-using-kind
        +-- install-argocd-on-kind-dev
        +-- k8s-apply-myapp-team-project
        +-- register-dev-staging-prod-clusters-in-argocd
        +-- label-*-cluster-for-myapp
        +-- k8s-apply-myapp-multi-clusters-applicationset-to-cluster
        +-- argocd-sync-and-wait-myapp-all-clusters
        +-- reset & cleanup targets

    This mind‑map‑style breakdown is useful for onboarding teammates or explaining your portfolio project.
```

## 4. How to run the full environment
From inside t06-ArgoCD-ApplicationSets/myapp-gitops_1 in WSL:
```console
    make create-argocd-myapp-kind-multi-clusters-envs-applicationset-and-status-check
```
### This will:
    1. Optionally clean up existing Argo CD apps, ApplicationSets, and myapp namespaces.
    2. Recreate kind-dev, kind-staging, kind-prod.
    3. Install Argo CD on kind-dev.
    4. Apply the myapp-team AppProject.
    5. Register dev/staging/prod clusters in Argo CD.
    6. Label their cluster secrets with environment=dev|staging|prod.
    7. Apply the myapp-clusters ApplicationSet.
    8. Sync and wait for myapp-dev-cluster, myapp-staging-cluster, myapp-prod-cluster.

### Once this completes:
    1. Open the Argo CD UI via port‑forward (if not already running):
```console    
    kubectl port-forward svc/argocd-server -n argocd 8082:443
```
    2. Visit https://localhost:8082, log in as admin, and you should see three Applications, one per cluster.
   
## 5. Troubleshooting commands
    1. Check clusters and contexts
```console
        kubectl config get-contexts

        # Check that all three clusters exist in kind
        kind get clusters
```
    2. Verify Argo CD is healthy
```console
        # On hub cluster
        kubectl config use-context kind-dev
        kubectl -n argocd get pods

        # Verify argocd-server Service
        kubectl -n argocd get svc argocd-server
```
    1. Verify clusters are registered in Argo CD
```console
        # From the CLI
        bin/argocd cluster list
        
        You should see three entries with the servers:
            https://172.26.44.184:6443 (dev)
            https://172.26.44.184:6444 (staging)
            https://172.26.44.184:6445 (prod)
```
    1. Check cluster secrets and labels
```console
        kubectl get secrets -n argocd \
            -l argocd.argoproj.io/secret-type=cluster \
            -o custom-columns='NAME:.metadata.name,ENV:.metadata.labels.environment'
        
        You should see 3 secrets with ENV values dev, staging, prod. The names will look like cluster-172.26.44.184-2811944750, etc.
```
    1. Inspect the ApplicationSet
```console
        kubectl get applicationset myapp-clusters -n argocd -o yaml
            Check that:
            1. spec.generators[0].clusters.selector.matchExpressions select environment in [dev, staging, prod].
            2. spec.template.spec.project is myapp-team.
            3. spec.template.spec.sources point to your Helm OCI chart and Git values.
```
    1. List generated Applications
```console
        kubectl get applications -n argocd
            You should see:
            1. myapp-dev-cluster
            2. myapp-staging-cluster
            3. myapp-prod-cluster
```
    1. Sync and check status
```console
            bin/argocd app list
            bin/argocd app get myapp-dev-cluster
            bin/argocd app get myapp-staging-cluster
            bin/argocd app get myapp-prod-cluster

            # Manually sync one app if needed
            bin/argocd app sync myapp-dev-cluster
            bin/argocd app wait myapp-dev-cluster --sync --health --timeout 300
```

    1. Common issues and quick fixes
       1. Apps missing or degraded:
            . Check ApplicationSet status.conditions for errors about missing project or bad values 
              references.
            . Ensure myapp-team project destinations include your cluster servers and myapp-* namespaces.
       2. PermissionDenied on app sync (CLI):
          1. Check argocd-rbac-cm and ensure either:
                . policy.default: role:admin for lab use, or
                . a policy.csv that gives admin the applications, *, */*, allow permission.
       3. Cluster generator not finding clusters:
          1. Ensure cluster secrets have both:
               . argocd.argoproj.io/secret-type=cluster
               . environment=dev|staging|prod labels.
       4. Values file errors (Helm):
           1. Check the values repo and paths like:
                $values/envs/dev/values.yaml
                $values/envs/staging/values.yaml
                $values/envs/prod/values.yaml
           2. See argocd-repo-server logs if templating fails

## 6. Cleanup
If you want to tear everything down:
```console
        bash
        # Remove Argo CD Applications created by multi-cluster generator
        make -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator argocd-delete-all-myapp-apps-created-using-multi-clusters-generator

        # Remove the myapp-clusters ApplicationSet
        make -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator argocd-delete-all-myapp-applicationsets-using-multi-clusters-generator

        # Delete myapp dev/staging/prod namespaces and env-style apps (if used)
        make -f Makefile_Setup_ArgoCD_ApplicationSets_Using_Multi_Clusters_Generator reset-myapp-envs-applications-and-namespaces

        # Delete kind clusters (depends on your Makefile, e.g.)
        make -f Makefile_Kind_Clusters kind-recreate-all  # or kind delete cluster --name dev|staging|prod
```
This returns your environment to a clean slate so the full setup target can be run again.