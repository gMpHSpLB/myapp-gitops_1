# Project Title: "Multi-Environment GitOps at Scale: ArgoCD ApplicationSets with Progressive RollingSync"
# ArgoCD ApplicationSets : Generating dev/staging/prod from a Single Template

## Tool versions
```console
ArgoCD 3.4.x (GA),
Kubernetes 1.34+,
Helm 4.2.x (chart apiVersion v2),
argocd CLI 3.4.x
```
Note: ArgoCD 3.5 (RC as of June 2026, GA targeted Aug 4, 2026) adds native ApplicationSet management to the UI and Git commit signature verification for sources — mentioned inline below where relevant, but this tutorial targets the 3.4 GA feature set so it works today.

## What You Will Build
•	A single ApplicationSet that generates myapp-dev, myapp-staging, and myapp-prod Applications from one template — replacing the three hand-written Application manifests from other learning
•	A Git generator reading environment config from directories in myapp-gitops
•	A Cluster generator variant for the true multi-cluster case (separate physical/logical clusters per environment, not just namespaces)
•	A Matrix generator combining Git + Cluster to fan out N environments × M clusters
•	Progressive rollout via RollingSync strategy — the senior-level piece most tutorials skip — so a bad template change doesn't blast all three environments simultaneously
•	Templated syncPolicy, ignoreDifferences, and notification subscriptions that vary per environment without three copy-pasted blocks



