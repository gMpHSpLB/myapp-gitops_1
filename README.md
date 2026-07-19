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

## Why ApplicationSets Exist (and when they're the wrong tool)
our previous GitOps repo (Gitops-Argocd_1) has three hand-written Application manifests. That's fine at 3 environments. It falls apart at:
•	15 microservices × 3 environments = 45 manifests to keep in sync by hand
•	A new environment (say, qa2) means copy-pasting a whole Application block and hoping you didn't typo a namespace
•	Any cross-cutting change (e.g., adding a new notification subscriber to every app) means N manual edits

### An ApplicationSet is a generator + template: 
The generator produces a list of parameters (environment name, cluster URL, values file path...), and the template stamps out one Application per parameter set.

### When NOT to use ApplicationSets: 
If you have exactly one or two environments and no plan to scale, the extra indirection layer (debugging why an Application wasn't generated is a step removed from debugging the Application itself) isn't worth it yet.

# Generator:
In ApplicationSets, a generator is the component that produces the “set of parameters” (like name, cluster, path, env) which the template then turns into one or more ArgoCD Application resources. 

Think of the generator as “where do we read environment/cluster data from?” and 
the template as “how do we turn that data into actual Applications.”

## What a generator does
    • A generator discovers targets (environments, clusters, directories, config files, etc.).
    • For each match, it outputs a parameter set (e.g. name=myapp-dev, env=dev, cluster=prod-cluster, path=envs/dev).
    • The ApplicationSet controller renders your template: using those parameters to create/update one Application per parameter set.

## Key generator types and use cases
##### 1. List generator
##### 2. Git generator (directory & file modes)
##### 3. Cluster generator
##### 4. Matrix generator (combining Git + Cluster)
##### 5. Merge generator

## 1. List generator
### What it is:
A simple inline list of environments or configs defined directly in the ApplicationSet YAML.

### Use cases:
Small, static sets like dev, staging, prod when you don’t want to involve Git structure yet.

### Quick prototypes or “hello ApplicationSet” examples.
Example:
text
```console
spec:
  generators:
    - list:
        elements:
          - name: myapp-dev
            env: dev
            cluster: in-cluster
          - name: myapp-staging
            env: staging
            cluster: in-cluster
          - name: myapp-prod
            env: prod
            cluster: in-cluster
  template:
    metadata:
      name: '{{name}}'
    spec:
      destination:
        name: '{{cluster}}'
        namespace: 'myapp-{{env}}'
      source:
        repoURL: https://github.com/your-org/myapp-gitops.git
        path: 'envs/{{env}}'
```
This is good for your first ApplicationSet before you move the environment definition fully into Git

## 2. Git generator (directory & file modes)
### What it is:
A generator that scans a Git repo (your GitOps repo) and derives parameters from either directories or files.

### Two subtypes:
    A. Git directory generator: Uses directory names/paths as parameters.
       Perfect for envs/dev, envs/staging, envs/prod layout.

    B. Git file generator: Reads JSON/YAML files (e.g. envs/dev/config.yaml) and turns their contents into parameters.

### Use cases for you:

“A Git generator reading environment config from directories in myapp-gitops.”

One directory per environment: envs/dev, envs/staging, envs/prod.

If you later add per‑env metadata files (e.g. envs/dev/appset-env.yaml), you can switch to the file generator.

### Directory example:
text
```console
spec:
  generators:
    - git:
        repoURL: https://github.com/your-org/myapp-gitops.git
        revision: main
        directories:
          - path: envs/*
  template:
    metadata:
      name: 'myapp-{{path.basename}}'
    spec:
      destination:
        name: in-cluster
        namespace: 'myapp-{{path.basename}}'
      source:
        repoURL: https://github.com/your-org/myapp-gitops.git
        path: '{{path}}'
```
This gives you myapp-dev, myapp-staging, myapp-prod automatically from envs/dev, envs/staging, envs/prod.

## 3. Cluster generator
### What it is:
A generator that reads ArgoCD’s registered clusters (stored as Secrets labeled argocd.argoproj.io/secret-type: cluster) and produces one parameter set per matching cluster.

### Use cases:
   • Multi‑cluster: dev, staging, prod in different physical/logical clusters (your “true multi‑cluster case”).
   • When you want “one Application per cluster that matches some labels,” e.g. env=prod, region=eu.

### Example:

text
```console
spec:
  generators:
    - cluster:
        selector:
          matchLabels:
            env: dev
  template:
    metadata:
      name: 'myapp-{{name}}'
    spec:
      destination:
        name: '{{name}}'        # ArgoCD cluster name from the Secret
        namespace: myapp
      source:
        repoURL: https://github.com/your-org/myapp-gitops.git
        path: envs/dev
```
For your plan:
You’d label your cluster secrets with env=dev, env=staging, env=prod.
Use cluster generator to automatically target the right clusters for each env

## 4. Matrix generator (combining Git + Cluster)
### What it is:
A generator that takes two generators (e.g. Git + Cluster) and produces the Cartesian product (N environments × M clusters). Each combination becomes one parameter set for the template.

### Use cases:
   • “Matrix generator combining Git + Cluster to fan out N environments × M clusters.”
   • Multi‑region + multi‑env scenarios like: dev in cluster A/B, staging in cluster C, prod in cluster D/E.

Progressive rollouts per wave or region.

### Example:

text
```console
spec:
  generators:
    - matrix:
        generators:
          - git:
              repoURL: https://github.com/your-org/myapp-gitops.git
              revision: main
              directories:
                - path: envs/*
          - cluster:
              selector:
                matchLabels:
                  app: myapp
  template:
    metadata:
      name: 'myapp-{{path.basename}}-{{name}}'
    spec:
      destination:
        name: '{{name}}'                     # cluster name
        namespace: 'myapp-{{path.basename}}'
      source:
        repoURL: https://github.com/your-org/myapp-gitops.git
        path: '{{path}}'
```
Now, for each envs/dev, envs/staging, envs/prod and each cluster labeled app=myapp, you get an Application like myapp-dev-cluster1, myapp-dev-cluster2, etc.

## 5. Merge generator
### What it is:
A generator that merges parameter sets from two or more generators, where later generators can override values from earlier ones.

### Use cases:

Base generator for “global defaults” plus a second generator for per‑env overrides (e.g. different syncPolicy, ignoreDifferences, notifications).

When you want environment‑specific tuning without copy‑pasting large blocks.


## Important Details:
### 1. Environment config : Config file per environment 
A Git generator reading environment config from directories in myapp-gitops_1.

#### This env-config.yaml pattern is deliberate: 
Rather than encoding environment-specific policy (auto-sync? self-heal? who gets paged?) inside the ApplicationSet template as conditionals, you push it into data the Git generator reads. The template stays generic; the data varies. This is the single biggest maintainability win ApplicationSets offer over hand-written Applications, and it's also the detail most tutorials skip.

## 1. The Git Generator: Directories:
A Git generator reading environment config from directories in myapp-gitops_1.

Problem with this so far: it generates all three Applications with identical syncPolicy — no automated sync anywhere, which is wrong for dev (you want auto-sync there) and would be dangerously wrong in the other direction for prod if you flipped it.

This is exactly what the env-config.yaml files are for — read them in a second generator merged via a Matrix. 

Understanding why the single-generator version is insufficient is the point of building it first.

## 2. The Cluster Generator (True Multi-Cluster):

A Cluster generator variant for the true multi-cluster case (separate physical/logical clusters per environment, not just namespaces)

If dev/staging/prod are separate physical clusters (not just namespaces on one cluster — the more realistic enterprise setup), you register each cluster as a Kubernetes Secret with ArgoCD, then generate off cluster metadata instead of directories.

The clusters generator's key value over the directory generator: the destination server itself becomes templated data. This is what "true multi-cluster GitOps"

## 3. The Matrix Generator: Combining Git Config + Cluster Targets
A Matrix generator combining Git + Cluster to fan out N environments × M clusters.

This is the piece that actually solves Section 3's problem — per-environment sync policy driven by data, not hardcoded per-Application YAML.