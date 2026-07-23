Hi there, I'm Jules! I have shifted focus to pure CLI and command-line tooling based on your request. Here is Set 1 (Questions 1 - 50) of the CLI Mastery series, covering kubectl, Helm, ArgoCD, and Docker basics:
# DevOps / Platform Engineering CLI Mastery - Set 1 (Questions 1 - 50)

## Section 1: Kubernetes & `kubectl` Foundations

**1. Which command retrieves a list of all Pods in the current namespace along with their IP addresses and the nodes they are running on?**
A) `kubectl get pods --all`
B) `kubectl get pods -o wide`
C) `kubectl list pods --detailed`
D) `kubectl describe pods`
Answer: B

**2. You want to see the detailed events and status history for a specific pod named `web-server`. Which command should you use?**
A) `kubectl get pod web-server -o yaml`
B) `kubectl logs web-server`
C) `kubectl describe pod web-server`
D) `kubectl inspect pod web-server`
Answer: C

**3. Which command tails the logs of a container named `nginx` inside a multi-container pod named `frontend`?**
A) `kubectl logs frontend nginx -f`
B) `kubectl logs frontend -c nginx -f`
C) `kubectl tail frontend nginx`
D) `kubectl get logs frontend --container nginx`
Answer: B

**4. A deployment named `api-backend` was updated, but the new pods are crashing. Which command instantly rolls the deployment back to the previous revision?**
A) `kubectl revert deployment api-backend`
B) `kubectl rollout undo deployment/api-backend`
C) `kubectl reset deployment api-backend HEAD~1`
D) `kubectl scale deployment api-backend --replicas=previous`
Answer: B

**5. How do you open an interactive shell inside a running pod named `db-pod`?**
A) `kubectl run db-pod --bash`
B) `kubectl attach db-pod -it`
C) `kubectl exec -it db-pod -- /bin/sh`
D) `kubectl ssh db-pod`
Answer: C

**6. Which command securely maps port 5432 on your local machine to port 5432 on a pod named `postgres-0` in the cluster without exposing it externally via a Service?**
A) `kubectl map-port postgres-0 5432:5432`
B) `kubectl expose pod postgres-0 --port=5432`
C) `kubectl port-forward pod/postgres-0 5432:5432`
D) `kubectl tunnel postgres-0 5432`
Answer: C

**7. You want to apply a directory of YAML manifests (`./k8s-manifests/`) to the cluster. Which command accomplishes this?**
A) `kubectl apply -d ./k8s-manifests/`
B) `kubectl apply -f ./k8s-manifests/`
C) `kubectl create --dir ./k8s-manifests/`
D) `kubectl push ./k8s-manifests/`
Answer: B

**8. Which command lists all services in the `kube-system` namespace?**
A) `kubectl get svc -n kube-system`
B) `kubectl get services --system`
C) `kubectl list svc namespace=kube-system`
D) `kubectl get all -n kube-system`
Answer: A

**9. You need to temporarily mark a node named `worker-01` as unschedulable so no new pods are placed on it, but you don't want to evict existing pods yet. What is the correct command?**
A) `kubectl drain worker-01`
B) `kubectl taint node worker-01 NoSchedule`
C) `kubectl cordon worker-01`
D) `kubectl block worker-01`
Answer: C

**10. After successfully cordoning `worker-01`, which command safely evicts all pods from the node to prepare it for maintenance?**
A) `kubectl evict worker-01`
B) `kubectl delete pods --field-selector spec.nodeName=worker-01`
C) `kubectl drain worker-01 --ignore-daemonsets`
D) `kubectl empty worker-01`
Answer: C

**11. How do you quickly scale a deployment named `cache-tier` to 5 replicas via the CLI?**
A) `kubectl scale --replicas=5 deployment/cache-tier`
B) `kubectl update deployment cache-tier replicas=5`
C) `kubectl set replicas deployment/cache-tier 5`
D) `kubectl patch deployment cache-tier -p '{"spec":{"replicas":5}}'`
Answer: A

**12. You want to see the live resource usage (CPU and Memory) of all pods in the current namespace. Which command provides this?**
A) `kubectl usage pods`
B) `kubectl top pods`
C) `kubectl get pods --metrics`
D) `kubectl monitor pods`
Answer: B

**13. Which command extracts the base64-decoded value of a specific key (`password`) from a Kubernetes Secret named `db-credentials`?**
A) `kubectl get secret db-credentials --key=password --decode`
B) `kubectl describe secret db-credentials | awk '/password/'`
C) `kubectl get secret db-credentials -o jsonpath='{.data.password}' | base64 --decode`
D) `kubectl view-secret db-credentials password`
Answer: C

**14. A pod named `zombie-pod` is stuck in the `Terminating` state for hours. How do you force Kubernetes to delete it immediately?**
A) `kubectl delete pod zombie-pod --force --grace-period=0`
B) `kubectl kill pod zombie-pod`
C) `kubectl delete pod zombie-pod --immediate`
D) `kubectl remove pod zombie-pod -f`
Answer: A

**15. You are managing multiple clusters. How do you view your current active Kubernetes context?**
A) `kubectl config current-context`
B) `kubectl get context`
C) `kubectl cluster-info`
D) `kubectl context show`
Answer: A

**16. How do you switch your `kubectl` context to a cluster named `prod-cluster`?**
A) `kubectl switch prod-cluster`
B) `kubectl use-context prod-cluster`
C) `kubectl config use-context prod-cluster`
D) `kubectl login prod-cluster`
Answer: C

**17. You want to find all pods that have the label `env=production` across *all* namespaces. Which command is correct?**
A) `kubectl get pods --all-namespaces --selector=env=production`
B) `kubectl get pods -A -l env=production`
C) Both A and B are correct
D) `kubectl get pods --global -L env=production`
Answer: C

**18. You need to test if your current credentials have permission to delete deployments in the `default` namespace. Which command quickly checks this?**
A) `kubectl check-permissions delete deployments`
B) `kubectl auth can-i delete deployments -n default`
C) `kubectl verify delete deployments`
D) `kubectl get rbac --test delete deployments`
Answer: B

**19. How do you dynamically watch for new events happening in the cluster in real-time?**
A) `kubectl get events -w`
B) `kubectl tail events`
C) `kubectl logs events -f`
D) `kubectl watch-cluster`
Answer: A

**20. Which command generates the exact YAML required to create a namespace named `test-ns` without actually creating it in the cluster?**
A) `kubectl create namespace test-ns --dry-run=client -o yaml`
B) `kubectl generate namespace test-ns --yaml`
C) `kubectl export namespace test-ns`
D) `kubectl create namespace test-ns --yaml-only`
Answer: A

## Section 2: Helm CLI – Packaging & Releases

**21. You need to install a Helm chart named `redis` from the `bitnami` repository. Which command does this?**
A) `helm create bitnami/redis`
B) `helm apply bitnami/redis`
C) `helm install my-redis bitnami/redis`
D) `helm fetch bitnami/redis`
Answer: C

**22. How do you pass a custom values file (`custom-values.yaml`) when upgrading an existing Helm release named `my-redis`?**
A) `helm upgrade my-redis bitnami/redis --values custom-values.yaml`
B) `helm upgrade my-redis bitnami/redis -f custom-values.yaml`
C) Both A and B are correct
D) `helm upgrade my-redis bitnami/redis --config custom-values.yaml`
Answer: C

**23. You want to see the history of upgrades and rollbacks for a Helm release named `web-app`. What is the command?**
A) `helm logs web-app`
B) `helm history web-app`
C) `helm revisions web-app`
D) `helm get history web-app`
Answer: B

**24. A recent `helm upgrade` caused the application to break. You want to roll back `web-app` to revision 3. What is the command?**
A) `helm revert web-app 3`
B) `helm undo web-app --revision 3`
C) `helm rollback web-app 3`
D) `helm downgrade web-app 3`
Answer: C

**25. Which command lists all installed Helm releases across all namespaces?**
A) `helm list -A` (or `helm ls -A`)
B) `helm get all`
C) `helm releases --all-namespaces`
D) `helm show releases`
Answer: A

**26. You want to see what YAML manifests Helm *would* generate if you ran an install, but without actually installing it on the cluster. Which command accomplishes this?**
A) `helm inspect my-chart`
B) `helm template my-chart`
C) `helm show yaml my-chart`
D) `helm build my-chart`
Answer: B

**27. You need to completely remove a Helm release named `old-db` and all of its associated Kubernetes resources. Which command do you use?**
A) `helm delete old-db`
B) `helm uninstall old-db`
C) Both A and B are correct (`delete` is an alias for `uninstall` in Helm 3)
D) `helm remove old-db`
Answer: C

**28. How do you override a specific value (e.g., `image.tag`) inline from the command line during a `helm install` without editing the `values.yaml` file?**
A) `helm install my-app ./chart --override image.tag=v2`
B) `helm install my-app ./chart --set image.tag=v2`
C) `helm install my-app ./chart -v image.tag=v2`
D) `helm install my-app ./chart --env image.tag=v2`
Answer: B

**29. You want to add the official Bitnami Helm repository to your local Helm client so you can search and install their charts. What is the command?**
A) `helm repo add bitnami https://charts.bitnami.com/bitnami`
B) `helm add-repo bitnami https://charts.bitnami.com/bitnami`
C) `helm source https://charts.bitnami.com/bitnami`
D) `helm registry add bitnami https://charts.bitnami.com/bitnami`
Answer: A

**30. After adding a new repository, which command ensures your local cache has the latest list of available charts from all added repositories?**
A) `helm fetch --all`
B) `helm repo update`
C) `helm sync`
D) `helm refresh`
Answer: B

## Section 3: ArgoCD CLI & GitOps Operations

**31. How do you log into the ArgoCD CLI using a username and password?**
A) `argocd auth login <argocd-server-url>`
B) `argocd login <argocd-server-url>`
C) `argocd authenticate <argocd-server-url>`
D) `argocd connect <argocd-server-url>`
Answer: B

**32. Which command forces ArgoCD to immediately synchronize an application named `guestbook` with the state in Git?**
A) `argocd app apply guestbook`
B) `argocd sync guestbook`
C) `argocd app sync guestbook`
D) `argocd update guestbook`
Answer: C

**33. You want to see the detailed health and sync status of the `guestbook` application via the CLI. What is the command?**
A) `argocd app get guestbook`
B) `argocd app status guestbook`
C) `argocd describe app guestbook`
D) `argocd get guestbook`
Answer: A

**34. An ArgoCD sync operation is stuck and you need to abort it. Which command terminates the currently running operation on the `guestbook` app?**
A) `argocd app abort guestbook`
B) `argocd app stop guestbook`
C) `argocd app terminate-op guestbook`
D) `argocd app cancel guestbook`
Answer: C

**35. How do you add a new target Kubernetes cluster to ArgoCD so you can deploy applications to it? (Assuming your kubeconfig has the context `remote-cluster`)**
A) `argocd cluster add remote-cluster`
B) `argocd add-cluster remote-cluster`
C) `argocd register remote-cluster`
D) `argocd config add remote-cluster`
Answer: A

**36. You want to see a unified diff between the live Kubernetes state and the desired Git state for the `guestbook` app using the ArgoCD CLI. What is the command?**
A) `argocd app compare guestbook`
B) `argocd app diff guestbook`
C) `argocd diff guestbook`
D) `argocd check guestbook`
Answer: B

**37. How do you view the ArgoCD logs for a specific Application named `guestbook` via the CLI to debug a failing PreSync hook?**
A) `argocd logs guestbook`
B) `argocd app logs guestbook`
C) `kubectl logs -n argocd deploy/argocd-server | awk '/guestbook/'`
D) Both B and C are valid approaches, though B uses the native CLI
Answer: D

**38. Which command creates a new ArgoCD application imperatively via the CLI?**
A) `argocd create app myapp --repo <url> --path <path> --dest-server <server> --dest-namespace <ns>`
B) `argocd app create myapp --repo <url> --path <path> --dest-server <server> --dest-namespace <ns>`
C) `argocd new app myapp --repo <url>`
D) `argocd init myapp --repo <url>`
Answer: B

**39. You want to list all clusters currently registered with your ArgoCD instance. What is the command?**
A) `argocd list clusters`
B) `argocd get clusters`
C) `argocd cluster list`
D) `argocd config clusters`
Answer: C

**40. In a CI/CD pipeline script, how can you make the script pause and wait until an ArgoCD application named `guestbook` reaches a `Healthy` and `Synced` state?**
A) `argocd app wait guestbook`
B) `argocd app watch guestbook`
C) `argocd sleep until-synced guestbook`
D) `sleep 60`
Answer: A

## Section 4: Docker & Container CLI Basics

**41. Which command builds a Docker image from a Dockerfile in the current directory and tags it as `api-service:v1.2`?**
A) `docker create api-service:v1.2 .`
B) `docker build -t api-service:v1.2 .`
C) `docker make api-service:v1.2 .`
D) `docker compile -t api-service:v1.2 .`
Answer: B

**42. How do you list all running Docker containers on your host machine?**
A) `docker list`
B) `docker containers`
C) `docker ps`
D) `docker show`
Answer: C

**43. You want to run a container named `redis-test` in the background (detached mode) and map host port 6379 to container port 6379. What is the command?**
A) `docker run -d -p 6379:6379 --name redis-test redis`
B) `docker start -b -port 6379:6379 --name redis-test redis`
C) `docker run --background --map 6379:6379 redis-test redis`
D) `docker exec -d -p 6379:6379 redis`
Answer: A

**44. Which command opens an interactive bash shell inside an already running container named `db-backend`?**
A) `docker shell db-backend`
B) `docker run -it db-backend /bin/bash`
C) `docker attach db-backend /bin/bash`
D) `docker exec -it db-backend /bin/bash`
Answer: D

**45. How do you continuously stream the logs of a running container named `web-frontend`?**
A) `docker logs web-frontend -f`
B) `docker tail web-frontend`
C) `docker stream web-frontend`
D) `docker watch web-frontend`
Answer: A

**46. Your disk is full. Which command safely removes all stopped containers, dangling images, and unused networks to free up space?**
A) `docker clean all`
B) `docker system prune`
C) `docker rm --all`
D) `docker wipe`
Answer: B

**47. You need to inspect the real-time CPU and Memory usage of all running Docker containers on your host. What is the command?**
A) `docker top`
B) `docker monitor`
C) `docker stats`
D) `docker usage`
Answer: C

**48. How do you download the latest Ubuntu image from Docker Hub without running it?**
A) `docker download ubuntu`
B) `docker get ubuntu`
C) `docker fetch ubuntu`
D) `docker pull ubuntu`
Answer: D

**49. Which command displays the low-level JSON configuration and metadata of a container or image?**
A) `docker view`
B) `docker info`
C) `docker inspect`
D) `docker details`
Answer: C

**50. You want to push a local image tagged `myrepo/myapp:v1` to a remote Docker registry. What is the command?**
A) `docker upload myrepo/myapp:v1`
B) `docker publish myrepo/myapp:v1`
C) `docker push myrepo/myapp:v1`
D) `docker send myrepo/myapp:v1`
Answer: C
# DevOps / Platform Engineering CLI Mastery - Set 2 (Questions 51 - 100)

## Section 5: Git CLI & Change Management

**51. You made several changes to files but haven't staged them yet. Which command undoes all local, unstaged changes in tracked files, reverting them to the last commit?**
A) `git reset HEAD`
B) `git checkout .` (or `git restore .`)
C) `git revert HEAD`
D) `git clean -fd`
Answer: B

**52. You just committed a change locally but realize you forgot to include a file or made a typo in the commit message. Which command allows you to amend the *most recent* local commit?**
A) `git commit --replace`
B) `git update-commit`
C) `git commit --amend`
D) `git rebase -i HEAD~1`
Answer: C

**53. A deployment broke production. You found the exact commit (`abc1234`) that introduced the bad YAML. Which command creates a *new* commit that perfectly reverses the changes of the bad commit, preserving history?**
A) `git reset --hard abc1234`
B) `git checkout abc1234`
C) `git revert abc1234`
D) `git drop abc1234`
Answer: C

**54. What is the danger of using `git reset --hard` on a branch that has already been pushed to a shared remote repository?**
A) It deletes the remote repository.
B) It rewrites history. If you push it (requiring `--force`), it will break the local repositories of other developers who have already pulled the original commits.
C) It permanently bans you from the repository.
D) It creates a merge conflict that cannot be resolved.
Answer: B

**55. You want to see the commit history, but only as a concise, one-line summary per commit. Which command do you use?**
A) `git log --short`
B) `git log --oneline`
C) `git status --history`
D) `git show --brief`
Answer: B

**56. You want to see exactly *what* changed (the line-by-line diff) in a specific commit (`xyz987`). Which command is best?**
A) `git show xyz987`
B) `git log xyz987`
C) `git diff xyz987`
D) `git inspect xyz987`
Answer: A

**57. You are on the `feature-a` branch. You need to incorporate the latest changes from the `main` branch into your current branch, creating a merge commit. Which command do you run?**
A) `git pull feature-a main`
B) `git merge main`
C) `git rebase main`
D) `git fetch main`
Answer: B

**58. How do you create a new branch named `bugfix/yaml-typo` and immediately switch to it in one command?**
A) `git branch -c bugfix/yaml-typo`
B) `git checkout -b bugfix/yaml-typo`
C) `git switch -n bugfix/yaml-typo`
D) Both B and `git switch -c bugfix/yaml-typo` are correct
Answer: D

**59. You have some unstaged changes that you aren't ready to commit, but you need to switch branches quickly to fix a critical bug. Which command safely temporarily stores your modified tracked files?**
A) `git stash`
B) `git save`
C) `git hold`
D) `git pause`
Answer: A

**60. Which command shows you which files are staged, unstaged, and untracked in your working directory?**
A) `git diff`
B) `git inspect`
C) `git state`
D) `git status`
Answer: D

## Section 6: Linux/WSL & Supportive CLI Tools (Medium Level)

**61. You run `kubectl get pods`. Which command pipes that output and filters it to only show lines containing the word `CrashLoopBackOff`?**
A) `kubectl get pods | awk 'CrashLoopBackOff'`
B) `kubectl get pods > rg CrashLoopBackOff`
C) `kubectl get pods | rg CrashLoopBackOff`
D) `kubectl get pods -f CrashLoopBackOff`
Answer: C

**62. You have a file `values.yaml`. You want to dynamically replace all occurrences of `imageTag: v1` with `imageTag: v2` from the command line. Which tool is best suited for this stream editing?**
A) `awk`
B) `sed`
C) `rg`
D) `curl`
Answer: B

**63. You are writing a bash script to parse JSON output from the Kubernetes API (e.g., `kubectl get secret my-secret -o json`). Which command-line tool is the industry standard for parsing and filtering JSON strings?**
A) `yq`
B) `sed`
C) `awk`
D) `jq`
Answer: D

**64. You try to start a local development server on port 8080, but it fails with "Port already in use." Which command helps you find the Process ID (PID) of the application currently using port 8080?**
A) `lsof -i :8080`
B) `ps aux | rg 8080`
C) `top -p 8080`
D) `netstat -p 8080`
Answer: A

**65. A runaway process is consuming 100% CPU. You found its PID is 4598. How do you forcibly terminate it?**
A) `stop 4598`
B) `kill -9 4598`
C) `exit 4598`
D) `rm -rf /proc/4598`
Answer: B

**66. You need to see the real-time, dynamically updating list of processes consuming the most CPU and RAM on your Linux VM. Which command do you use?**
A) `free -m`
B) `df -h`
C) `top` (or `htop`)
D) `ps -ef`
Answer: C

**67. You are running WSL (Windows Subsystem for Linux). How do you cleanly shut down the entire WSL Ubuntu instance from your Windows PowerShell/CMD terminal?**
A) `wsl --shutdown`
B) `wsl --stop Ubuntu`
C) `exit`
D) `taskkill /IM wsl.exe`
Answer: A

**68. You need to securely download a script from `https://example.com/install.sh` directly in your terminal. Which command does this?**
A) `wget https://example.com/install.sh` (or `curl -O https://example.com/install.sh`)
B) `fetch https://example.com/install.sh`
C) `download https://example.com/install.sh`
D) `pull https://example.com/install.sh`
Answer: A

**69. You want to run a long-running script `build.sh` in the background so it doesn't terminate if your SSH session disconnects. Which command prefix/tool should you use?**
A) `bg ./build.sh`
B) `nohup ./build.sh &`
C) `run ./build.sh --detached`
D) `exec ./build.sh`
Answer: B

**70. You have a `Makefile` with dozens of targets. Which command lists all the available targets (assuming the Makefile doesn't have a custom `help` target)?**
A) `make --list`
B) `make -help`
C) `cat Makefile | rg "^[a-zA-Z]"` (or similar parsing)
D) `make show-targets`
Answer: C

## Section 7: Observability CLI – Prometheus/Grafana/Loki

**71. You want to verify that a specific `ServiceMonitor` Custom Resource exists in the `monitoring` namespace. What is the command?**
A) `kubectl get servicemonitor -n monitoring`
B) `promtool get servicemonitor -n monitoring`
C) `helm list servicemonitor -n monitoring`
D) `kubectl describe prom-config -n monitoring`
Answer: A

**72. You suspect the Prometheus server pod is crash-looping due to a bad configuration file. How do you view the logs of the Prometheus container? (Assume the pod is `prometheus-k8s-0` in the `monitoring` namespace).**
A) `kubectl logs prometheus-k8s-0 -n monitoring -c prometheus`
B) `promtool logs prometheus-k8s-0`
C) `kubectl describe pod prometheus-k8s-0 -n monitoring | rg Error`
D) `kubectl get events -n monitoring --field-selector reason=Crash`
Answer: A

**73. You are using the Prometheus Operator. Dashboards are provisioned into Grafana automatically via ConfigMaps. How do you find all ConfigMaps in the `monitoring` namespace that have the label `grafana_dashboard=1`?**
A) `kubectl get configmap -n monitoring --filter=grafana_dashboard=1`
B) `kubectl get cm -n monitoring -l grafana_dashboard=1`
C) `kubectl find cm -n monitoring --label=grafana_dashboard=1`
D) `kubectl describe cm -n monitoring | rg grafana_dashboard`
Answer: B

**74. You want to check if the `metrics` endpoint of a pod named `api-server` is actually serving data. Assuming you are inside the cluster (or port-forwarded), which CLI tool is best to fetch the raw HTTP response?**
A) `ping <pod-ip>:8080/metrics`
B) `curl -s http://<pod-ip>:8080/metrics`
C) `telnet <pod-ip> 8080`
D) `nslookup <pod-ip>`
Answer: B

**75. You are running a Promtail DaemonSet to ship logs to Loki. You want to see the raw logs of the Promtail pod on `worker-node-1` to debug why logs aren't shipping. How do you find the specific Promtail pod name on that node?**
A) `kubectl get pods -n logging -l app=promtail -o wide | rg worker-node-1`
B) `kubectl find pod -n logging --node worker-node-1`
C) `promtail cli get-pod worker-node-1`
D) `kubectl logs daemonset/promtail --node worker-node-1`
Answer: A

**76. Which CLI tool is officially provided by Prometheus to check the syntax and validity of Prometheus configuration files and rules files locally before applying them?**
A) `prom-check`
B) `promtool check config prometheus.yml`
C) `kubectl test -f prometheus.yml`
D) `helm lint prometheus.yml`
Answer: B

**77. You want to manually trigger a scrape configuration reload on a Prometheus server running in Kubernetes without restarting the pod. What is the standard way to do this via CLI (assuming the lifecycle API is enabled)?**
A) `kubectl restart pod prometheus-0`
B) `kubectl exec prometheus-0 -- systemctl reload prometheus`
C) `curl -X POST http://<prometheus-pod-ip>:9090/-/reload`
D) `kubectl patch prometheus prometheus-0 -p '{"spec":{"reload":true}}'`
Answer: C

**78. You need to extract a Grafana API key stored in a Kubernetes Secret named `grafana-admin-credentials` to use in a local curl script. Which one-liner does this?**
A) `kubectl get secret grafana-admin-credentials -o yaml | rg admin-password`
B) `kubectl get secret grafana-admin-credentials -o jsonpath="{.data.admin-password}" | base64 -d`
C) `kubectl describe secret grafana-admin-credentials --show-passwords`
D) `kubectl export secret grafana-admin-credentials`
Answer: B

**79. How do you verify the exact version of the Loki container image running in the `loki-0` pod?**
A) `kubectl get pod loki-0 -o jsonpath="{.spec.containers[*].image}"`
B) `kubectl describe pod loki-0 | rg Image:`
C) Both A and B are correct.
D) `loki --version`
Answer: C

**80. You have port-forwarded your local machine to the Alertmanager pod on port 9093. How do you use `curl` to view the currently active alerts in JSON format?**
A) `curl -s http://localhost:9093/api/v1/alerts`
B) `curl -s http://localhost:9093/api/v2/alerts`
C) `curl -s http://localhost:9093/alerts.json`
D) `curl -s http://localhost:9093/metrics`
Answer: B

## Section 8: Medium/Senior Scenarios – Combined Tooling

**81. *Scenario:* A deployment `payment-api` is failing. You run `kubectl get pods` and see `ImagePullBackOff`. You suspect the image tag in Git is wrong. What is the fastest CLI workflow to verify the deployed tag and compare it to the Git commit?**
A) `kubectl describe deployment payment-api | rg Image`, then `git log` to find the last changed tag in the manifests.
B) Delete the deployment and redeploy from Git.
C) Run `docker images` on the worker node.
D) Check the ArgoCD UI.
Answer: A

**82. *Scenario:* You are using ArgoCD. You merged a PR fixing a typo in a ConfigMap, but ArgoCD hasn't synced it yet because the auto-sync interval is 3 minutes. How do you force ArgoCD to fetch the latest Git commit and apply it *immediately* via CLI?**
A) `argocd app sync <app-name>`
B) `argocd app get <app-name> --refresh && argocd app sync <app-name>`
C) `git push --force`
D) `kubectl apply -k .`
Answer: B

**83. *Scenario:* A pod is stuck terminating. You run `kubectl describe pod` and see it is waiting on a `finalizer` named `kubernetes.io/pvc-protection`. How do you aggressively force the pod to delete by patching out the finalizer via CLI?**
A) `kubectl delete pod <pod-name> --force-finalizers`
B) `kubectl patch pod <pod-name> -p '{"metadata":{"finalizers":null}}'`
C) `kubectl edit pod <pod-name>` and delete the line manually.
D) Both B and C work, but B is the preferred scriptable CLI method.
Answer: D

**84. *Scenario:* You need to update a Helm chart deployment named `frontend`, but you only want to change `replicaCount` to 10 without affecting any other existing values that were set previously. Which flag is crucial?**
A) `helm upgrade frontend ./chart --set replicaCount=10 --reuse-values`
B) `helm upgrade frontend ./chart --set replicaCount=10 --keep-history`
C) `helm upgrade frontend ./chart --set replicaCount=10 --merge`
D) `helm update frontend ./chart --set replicaCount=10`
Answer: A

**85. *Scenario:* You want to restart all pods in a Deployment named `auth-service` gracefully (rolling restart) because a backing ConfigMap changed (and you aren't using a tool like Reloader). Which command is correct?**
A) `kubectl delete pods -l app=auth-service`
B) `kubectl scale deployment auth-service --replicas=0 && kubectl scale deployment auth-service --replicas=3`
C) `kubectl rollout restart deployment/auth-service`
D) `kubectl reboot deployment auth-service`
Answer: C

**86. *Scenario:* You need to extract the raw YAML of an existing secret, remove its creation metadata, and save it to a file to commit to a Git repository. Which command pipeline best achieves this?**
A) `kubectl get secret my-secret -o yaml > secret.yaml` (Requires manual cleanup)
B) `kubectl get secret my-secret -o json | jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid,.metadata.creationTimestamp)' > secret.json`
C) `kubectl export secret my-secret > secret.yaml`
D) `kubectl dump secret my-secret -f secret.yaml`
Answer: B

**87. *Scenario:* You need to find which Kubernetes node is consuming the most Memory overall. How do you do this quickly via CLI?**
A) `kubectl get nodes -o wide`
B) `kubectl top nodes`
C) `kubectl describe nodes | rg Memory`
D) `docker stats` on every node
Answer: B

**88. *Scenario:* ArgoCD shows an Application as `OutOfSync`. You want to see exactly which Kubernetes resource is drifted and what the specific YAML differences are via the CLI. What command do you run?**
A) `argocd app diff <app-name>`
B) `argocd app status <app-name> --detailed`
C) `kubectl diff -k .`
D) `git diff HEAD`
Answer: A

**89. *Scenario:* You are deploying a new version of an app. You want to watch the pods transition from `ContainerCreating` to `Running` in real-time, clearing the screen on every update. Which Linux/kubectl combo is best?**
A) `watch -n 2 kubectl get pods -l app=myapp`
B) `kubectl get pods -l app=myapp -w`
C) Both A and B are excellent real-time monitoring strategies.
D) `tail -f kubectl get pods`
Answer: C

**90. *Scenario:* You accidentally applied a giant YAML file containing 50 resources (`disaster.yaml`), and you need to immediately undo it. Which command cleanly removes all resources defined in that file?**
A) `kubectl undo -f disaster.yaml`
B) `kubectl delete -f disaster.yaml`
C) `kubectl revert -f disaster.yaml`
D) `kubectl destroy -f disaster.yaml`
Answer: B

**91. *Scenario:* You need to create a Kubernetes TLS Secret from two local files (`tls.crt` and `tls.key`). Which imperative command does this?**
A) `kubectl create secret generic my-tls --from-file=tls.crt --from-file=tls.key`
B) `kubectl create secret tls my-tls --cert=tls.crt --key=tls.key`
C) `kubectl apply secret tls my-tls < tls.crt < tls.key`
D) `kubectl generate secret tls my-tls -c tls.crt -k tls.key`
Answer: B

**92. *Scenario:* A developer wants to know why their pod was OOMKilled. They run `kubectl logs <pod>`, but the pod is already restarted and it only shows the new logs. Which flag retrieves the logs from the *previous* crashed instance of the container?**
A) `kubectl logs <pod> --previous` (or `-p`)
B) `kubectl logs <pod> --crashed`
C) `kubectl logs <pod> --history=1`
D) `kubectl logs <pod> --old`
Answer: A

**93. *Scenario:* You are troubleshooting a network issue. You want to spin up a temporary, interactive Alpine Linux pod in the cluster, run `curl`, and have the pod automatically delete itself when you exit the shell. What is the command?**
A) `kubectl run -it --rm debug-pod --image=alpine -- sh`
B) `kubectl debug --image=alpine --rm`
C) `kubectl exec -it alpine --rm -- sh`
D) `kubectl attach debug-pod --image=alpine -- sh`
Answer: A

**94. *Scenario:* You need to update the Docker image of a deployment named `worker` to `myrepo/worker:v2.0` urgently via CLI without modifying the Git repository (e.g., during a P0 incident response). Which command does this?**
A) `kubectl update deployment worker --image=myrepo/worker:v2.0`
B) `kubectl set image deployment/worker worker=myrepo/worker:v2.0`
C) `kubectl patch deployment worker --image myrepo/worker:v2.0`
D) `kubectl scale deployment worker --image=myrepo/worker:v2.0`
Answer: B

**95. *Scenario:* You want to list all Kubernetes ConfigMaps, Secrets, and Services in the `default` namespace using a single command. How?**
A) `kubectl get configmaps,secrets,services -n default`
B) `kubectl get all -n default` (Note: 'all' usually excludes Secrets and ConfigMaps by default)
C) `kubectl get cm,secret,svc -n default`
D) Both A and C are correct.
Answer: D

**96. *Scenario:* You are cleaning up a cluster. You want to delete all pods in the `testing` namespace that have the status `Evicted`. Which command pipeline works best?**
A) `kubectl get pods -n testing | rg Evicted | awk '{print $1}' | xargs kubectl delete pod -n testing`
B) `kubectl delete pods --all -n testing --status=Evicted`
C) `kubectl clean pods -n testing --evicted`
D) `kubectl remove pods -n testing | rg Evicted`
Answer: A

**97. *Scenario:* You are reviewing a PR that modifies a Helm chart. You want to render the templates locally using the values in `values-prod.yaml` to ensure no syntax errors exist. What command do you use?**
A) `helm render ./mychart -f values-prod.yaml`
B) `helm template my-release ./mychart -f values-prod.yaml`
C) `helm build ./mychart --values values-prod.yaml`
D) `helm dry-run ./mychart -f values-prod.yaml`
Answer: B

**98. *Scenario:* You suspect a Docker container is not using the timezone environment variable correctly. How do you use the Docker CLI to view all environment variables passed to a running container named `my-app`?**
A) `docker env my-app`
B) `docker exec my-app env`
C) `docker inspect my-app | jq '.[0].Config.Env'`
D) Both B and C will display the environment variables.
Answer: D

**99. *Scenario:* You need to securely copy a local file (`dump.sql`) into a running Kubernetes pod (`db-0`) located in the `/tmp` directory. What is the command?**
A) `kubectl copy dump.sql db-0:/tmp/dump.sql`
B) `kubectl cp dump.sql db-0:/tmp/dump.sql`
C) `kubectl scp dump.sql db-0:/tmp/dump.sql`
D) `kubectl transfer dump.sql db-0:/tmp/dump.sql`
Answer: B
**100. *Scenario:* In an enterprise GitOps workflow with ArgoCD, you notice a massive drift caused by manual `kubectl` edits. You want ArgoCD to immediately replace all live resources with the definitions in Git, deleting anything extra. What CLI command do you run?**
A) `argocd app sync <app-name> --prune --force`
B) `argocd app clean <app-name>`
C) `kubectl apply -f . --force`
D) `argocd sync <app-name> --hard`
Answer: A
# DevOps / Platform Engineering CLI Mastery - Set 3 (Questions 101 - 150)

## Section 8: Senior/Enterprise Scenarios – Combined Tooling (Continued)

**101. *Scenario:* You are managing a multi-tenant Kubernetes cluster. A developer's runaway deployment is eating all the CPU on the nodes. You need to quickly list all pods in the cluster, sorted by CPU usage from highest to lowest, to identify the culprit. Which command does this?**
A) `kubectl top pods --all-namespaces --sort-by=cpu`
B) `kubectl get pods -A --sort-by=.status.cpu`
C) `docker stats --all`
D) `kubectl describe pods -A | awk '/CPU/' | sort -r`
Answer: A

**102. *Scenario:* A node is marked as `NotReady`. You want to SSH into the underlying EC2 instance/VM to check the `kubelet` service logs, but you don't have direct SSH access. You decide to spin up a privileged "node-shell" pod that mounts the host's `/` filesystem to inspect `journalctl`. Which plugin or command is best for this?**
A) `kubectl node-shell <node-name>` (via krew plugin) or a custom privileged DaemonSet.
B) `kubectl exec -it <node-name> -- bash`
C) `kubectl attach node/<node-name>`
D) `kubectl ssh <node-name>`
Answer: A

**103. *Scenario:* You have a Helm release named `monitoring-stack` deployed in the `monitoring` namespace. You want to see the exact default values that were packaged inside the chart (not your overrides). Which command retrieves this?**
A) `helm get values monitoring-stack -n monitoring`
B) `helm show values prometheus-community/kube-prometheus-stack` (assuming this is the chart name)
C) `helm extract values monitoring-stack -n monitoring`
D) `kubectl get secret sh.helm.release.v1.monitoring-stack.v1 -o yaml`
Answer: B

**104. *Scenario:* You suspect a memory leak in an application running in Docker. You want to see a live stream of the container's memory usage mapped against its limit. What is the precise command?**
A) `docker top <container-id>`
B) `docker stats <container-id>`
C) `docker inspect <container-id> | awk '/Memory/'`
D) `docker mem-watch <container-id>`
Answer: B

**105. *Scenario:* A developer pushed a bad Git commit (`HEAD~1`) that completely deleted a critical directory. They haven't pushed to origin yet. They want to completely wipe out the bad commit and revert the files back to `HEAD~2` as if the bad commit never happened. Which command sequence accomplishes this destructively?**
A) `git reset --hard HEAD~2`
B) `git revert HEAD~1`
C) `git checkout HEAD~2 .`
D) `git clean -df`
Answer: A

**106. *Scenario:* You are debugging a network policy. You need to see if a pod `app-a` can resolve the DNS name and connect to port 80 of `app-b`. You run a temporary pod to test this using `netcat` (nc). Which command is correct?**
A) `kubectl run test --image=busybox -it --rm -- nc -zv app-b 80`
B) `kubectl exec app-a -- ping app-b`
C) `kubectl run test --image=busybox -it --rm -- curl app-b:80`
D) `kubectl port-forward app-b 80:80`
Answer: A

**107. *Scenario:* Your cluster uses Role-Based Access Control (RBAC). You want to check what permissions a specific ServiceAccount named `ci-runner` has in the `default` namespace. Which command provides a summary?**
A) `kubectl auth can-i --list --as=system:serviceaccount:default:ci-runner`
B) `kubectl get permissions serviceaccount ci-runner`
C) `kubectl describe serviceaccount ci-runner`
D) `kubectl describe rolebinding -n default | awk '/ci-runner/'`
Answer: A

**108. *Scenario:* You are reviewing ArgoCD application sync statuses across 50 applications. You want to use the CLI to list *only* the applications that are currently `OutOfSync`. What is the command?**
A) `argocd app list --sync-status OutOfSync`
B) `argocd app list | awk '/OutOfSync/'`
C) `argocd get apps --status=OutOfSync`
D) Both A and B work, but A uses native filtering.
Answer: D

**109. *Scenario:* You are upgrading a critical database StatefulSet using Helm. The upgrade is taking a long time. You want Helm to wait up to 15 minutes for all pods to be ready before marking the release as `deployed` (to prevent silent failures). Which flags do you add?**
A) `helm upgrade db ./db-chart --wait --timeout 15m`
B) `helm upgrade db ./db-chart --sync --duration 900s`
C) `helm upgrade db ./db-chart --verify --timeout 15`
D) `helm upgrade db ./db-chart --block 15m`
Answer: A

**110. *Scenario:* A node's disk is at 99% capacity due to hundreds of old, unused Docker images. You want to aggressively clean up all images that do not have a container currently running against them. Which command safely accomplishes this?**
A) `docker rmi $(docker images -q)`
B) `docker image prune -a`
C) `docker system prune --volumes`
D) `rm -rf /var/lib/docker/overlay2/*`
Answer: B

**111. *Scenario:* You applied a Deployment, but no Pods were created. You suspect an issue with the ReplicaSet controller or resource quotas. Where is the first place you should check for controller-level errors?**
A) `kubectl get events --sort-by='.metadata.creationTimestamp'`
B) `kubectl logs deployment/my-app`
C) `kubectl describe pod my-app` (Note: the pod doesn't exist yet)
D) `docker logs kubelet`
Answer: A

**112. *Scenario:* You are managing a GitOps repository. You have two branches, `main` and `feature`. You want to see a concise list of commits that are in `feature` but have *not* yet been merged into `main`. Which Git command does this?**
A) `git log main..feature --oneline`
B) `git diff main feature`
C) `git status feature --compare main`
D) `git show main..feature`
Answer: A

**113. *Scenario:* An ArgoCD application is stuck deleting. The namespace is in a `Terminating` state, waiting on ArgoCD finalizers, but the ArgoCD controller was restarted and lost track. How do you manually remove the `resources-finalizer.argocd.argoproj.io` from the Application object via CLI to force deletion?**
A) `kubectl patch application my-app -n argocd -p '{"metadata":{"finalizers":[]}}' --type=merge`
B) `argocd app delete my-app --force`
C) `kubectl delete application my-app -n argocd --grace-period=0`
D) `argocd app remove-finalizer my-app`
Answer: A

**114. *Scenario:* You want to generate a `kubeconfig` file for a specific ServiceAccount `deployer` so your external CI/CD pipeline can authenticate to the cluster. What is the fundamental process using CLI tools?**
A) Use `kubectl create token deployer`, capture the JWT token, and embed it into the `users.user.token` section of a kubeconfig YAML structure.
B) Run `kubectl export kubeconfig --user=deployer`.
C) Use `kubectl get secret deployer-token -o yaml > kubeconfig`.
D) Run `kubeadm alpha phase kubeconfig user --client-name=deployer`.
Answer: A

**115. *Scenario:* You are troubleshooting a PromQL query that is taking too long to execute in Grafana. You want to hit the Prometheus HTTP API directly using `curl` to see the raw response time and JSON payload for the query `up`. How do you structure the curl command?**
A) `curl -g 'http://<prometheus-ip>:9090/api/v1/query?query=up'`
B) `curl http://<prometheus-ip>:9090/promql?q=up`
C) `curl http://<prometheus-ip>:9090/query -d "up"`
D) `curl http://<prometheus-ip>:9090/metrics | awk '/up/'`
Answer: A

## Section 1: Kubernetes & `kubectl` Foundations (Continued)

**116. How do you format the output of `kubectl get pods` to show only the pod names, completely omitting the headers and status columns?**
A) `kubectl get pods -o name`
B) `kubectl get pods --no-headers | awk '{print $1}'`
C) `kubectl get pods -o custom-columns=':.metadata.name'`
D) All of the above are valid ways to achieve this.
Answer: D

**117. You need to create a Kubernetes ConfigMap named `app-config` from an entire local directory named `./config-files/`. Which command achieves this?**
A) `kubectl create configmap app-config --from-dir=./config-files/`
B) `kubectl create configmap app-config --from-file=./config-files/`
C) `kubectl apply configmap app-config < ./config-files/`
D) `kubectl generate cm app-config -d ./config-files/`
Answer: B

**118. Which command describes a specific node named `worker-1` to inspect its allocated CPU and memory capacity versus its actual current requests/limits?**
A) `kubectl inspect node worker-1`
B) `kubectl get node worker-1 -o yaml`
C) `kubectl describe node worker-1`
D) `kubectl top node worker-1 --details`
Answer: C

**119. You want to extract the currently deployed image tag of a deployment named `backend`. Which command uses JSONPath to achieve this elegantly?**
A) `kubectl get deployment backend -o jsonpath='{.spec.template.spec.containers[0].image}'`
B) `kubectl describe deployment backend | awk '/Image/'`
C) `kubectl get deployment backend -o yaml | awk '/image:/ {print $2}'`
D) `kubectl view deployment backend image`
Answer: A

**120. A pod `nginx-pod` has two containers: `nginx` and `sidecar`. You want to execute an `ls -l` command specifically inside the `sidecar` container. What is the command?**
A) `kubectl exec nginx-pod -c sidecar -- ls -l`
B) `kubectl exec sidecar@nginx-pod -- ls -l`
C) `kubectl exec nginx-pod --container=sidecar ls -l`
D) Both A and C are valid syntax.
Answer: D

## Section 2: Helm CLI – Packaging & Releases (Continued)

**121. You have a locally developed Helm chart in `./my-chart/`. You want to test if it renders correctly and passes all basic Helm linting rules. What command do you run?**
A) `helm test ./my-chart`
B) `helm lint ./my-chart`
C) `helm check ./my-chart`
D) `helm validate ./my-chart`
Answer: B

**122. You are packaging a Helm chart. You want to automatically update the chart version to `1.2.3` and the app version to `v2.0` during the packaging process, regardless of what is in `Chart.yaml`. Which command does this?**
A) `helm package ./my-chart --version 1.2.3 --app-version v2.0`
B) `helm build ./my-chart -v 1.2.3 -a v2.0`
C) `helm pack ./my-chart --chart-version 1.2.3 --app-version v2.0`
D) You cannot do this via CLI; you must edit `Chart.yaml` manually.
Answer: A

**123. You want to completely remove a Helm repository named `stable` from your local configuration. What is the command?**
A) `helm repo remove stable`
B) `helm repo rm stable`
C) Both A and B are aliases for the same command.
D) `helm repo delete stable`
Answer: C

**124. How do you view all the user-supplied values (overrides) that were provided when a specific release named `my-release` was installed?**
A) `helm get values my-release`
B) `helm show values my-release`
C) `helm extract overrides my-release`
D) `helm inspect my-release --overrides`
Answer: A

**125. You want to see the status of all Helm releases, including those that have failed or are currently pending an upgrade. Which flag must you add to `helm list`?**
A) `helm list --all`
B) `helm list --all-namespaces`
C) `helm list --failed --pending`
D) `helm list --show-all`
Answer: A

## Section 3: ArgoCD CLI & GitOps Operations (Continued)

**126. You want to configure ArgoCD via CLI to automatically sync an application `demo-app` and automatically prune resources that are removed from Git. Which command does this?**
A) `argocd app set demo-app --sync-policy automated --auto-prune`
B) `argocd app update demo-app --prune=true --sync=auto`
C) `argocd app config demo-app auto-sync true auto-prune true`
D) `argocd set demo-app sync auto prune auto`
Answer: A

**127. You need to completely delete an application `demo-app` from ArgoCD AND delete all the Kubernetes resources it deployed to the cluster. What command do you use?**
A) `argocd app delete demo-app` (Wait, this might just delete the ArgoCD definition)
B) `argocd app rm demo-app --cascade`
C) `argocd app delete demo-app` (By default, this implies cascading deletion unless `--cascade=false` is used).
D) `argocd app destroy demo-app`
Answer: C

**128. An ArgoCD Application is stuck in `Syncing` state because a PreSync hook job is hanging. You want to delete just the specific Job resource managed by ArgoCD. What is the CLI approach?**
A) `argocd app delete-resource demo-app --kind Job --resource-name my-presync-job`
B) Use standard `kubectl delete job my-presync-job` in the target namespace.
C) `argocd app clean demo-app`
D) Both A and B work.
Answer: D

**129. How do you view the history of synchronization events (successes, failures, commit SHAs) for an application named `backend`?**
A) `argocd app history backend`
B) `argocd app sync-history backend`
C) `argocd history backend`
D) `argocd app logs backend --history`
Answer: A

**130. You want to update the target Git revision (e.g., from `main` to a specific branch `feature-branch`) for an existing ArgoCD application `web-ui`. What is the command?**
A) `argocd app set web-ui --revision feature-branch`
B) `argocd app update web-ui --branch feature-branch`
C) `argocd set revision web-ui feature-branch`
D) `argocd app config web-ui --git-ref feature-branch`
Answer: A

## Section 4: Docker & Container CLI Basics (Continued)

**131. You want to start a new container from the `nginx` image and map the container's `/usr/share/nginx/html` directory to the host's `/var/www/` directory. Which flag do you use?**
A) `docker run -v /var/www/:/usr/share/nginx/html nginx`
B) `docker run -m /var/www/:/usr/share/nginx/html nginx`
C) `docker run --mount /var/www/:/usr/share/nginx/html nginx`
D) `docker run --bind /var/www/ /usr/share/nginx/html nginx`
Answer: A

**132. You are debugging an image build. The `docker build` command fails on Step 4. You want to inspect the intermediate container created just before the failure. How do you find its ID?**
A) It is printed in the terminal output right before the failing step (e.g., `---> Running in a1b2c3d4e5f6`).
B) `docker history --failed`
C) `docker images --intermediate`
D) `docker inspect build`
Answer: A

**133. Which command forces Docker to pull the latest version of the `node:18` image from the registry, even if you already have a version cached locally?**
A) `docker pull --force node:18`
B) `docker update node:18`
C) `docker pull node:18` (Pulls newer layers if the digest has changed remotely).
D) `docker fetch node:18 --latest`
Answer: C

**134. You need to pass an environment variable `DB_PASS=secret` to a container named `api` when starting it. What is the command?**
A) `docker run --env DB_PASS=secret --name api my-image`
B) `docker run -e DB_PASS=secret --name api my-image`
C) Both A and B are correct.
D) `docker run --var DB_PASS=secret --name api my-image`
Answer: C

**135. You want to save an existing Docker image `ubuntu:latest` to a `.tar` archive file so you can transfer it to an air-gapped machine. Which command do you use?**
A) `docker export ubuntu:latest > ubuntu.tar`
B) `docker save -o ubuntu.tar ubuntu:latest`
C) `docker backup ubuntu:latest ubuntu.tar`
D) `docker archive ubuntu:latest`
Answer: B

## Section 5: Git CLI & Change Management (Continued)

**136. You have committed multiple small typos (e.g., 5 commits) on your local feature branch. Before opening a Pull Request, you want to squash them all into a single, clean commit. Which interactive command is standard for this?**
A) `git squash HEAD~5`
B) `git merge --squash HEAD~5`
C) `git rebase -i HEAD~5`
D) `git compress HEAD~5`
Answer: C

**137. You accidentally added a 500MB log file to your repository and pushed it. To completely remove it from the Git history to reduce clone sizes, which tool/command is highly recommended?**
A) `git rm --cached large_file.log` and commit again.
B) `git clean -df large_file.log`
C) `git filter-repo` or `git filter-branch` (or BFG Repo-Cleaner).
D) `git revert <commit-id>`
Answer: C

**138. You want to temporarily switch back to the branch you were previously working on before your current branch. What is the fastest shortcut command?**
A) `git checkout previous`
B) `git checkout -`
C) `git switch back`
D) `git branch --last`
Answer: B

**139. You cloned a repository, but you want to grab the specific tags (e.g., `v1.0.0`) from the remote repository. Which command ensures you fetch all tags?**
A) `git fetch --tags`
B) `git pull --all`
C) `git clone --tags`
D) `git update-tags`
Answer: A

**140. You want to see the remote URL that your local `origin` points to. What is the command?**
A) `git remote show`
B) `git url origin`
C) `git remote -v`
D) `git status --remote`
Answer: C

## Section 6: Linux/WSL & Supportive CLI Tools (Continued)

**141. You are parsing a large log file. You want to find all lines containing `ERROR`, but you also want to print the 2 lines *before* and 2 lines *after* the match for context. Which `rg` (ripgrep) flag accomplishes this?**
A) `rg -B 2 -A 2 ERROR file.log` (or `rg -C 2 ERROR file.log`)
B) `rg --context=2 ERROR file.log`
C) Both A and B are correct.
D) `rg -w 2 ERROR file.log`
Answer: C

**142. You want to safely format and pretty-print a chaotic, minified JSON response from an API curl command. Which tool pipeline is standard?**
A) `curl http://api.com/data | rg pretty`
B) `curl http://api.com/data | awk json`
C) `curl http://api.com/data | jq .`
D) `curl http://api.com/data | sed 's/,/,\n/g'`
Answer: C

**143. You need to securely transfer a file `config.yaml` from your local Linux/WSL machine to a remote server at `10.0.0.5` into the `/home/user/` directory using SSH protocols. Which command is used?**
A) `scp config.yaml user@10.0.0.5:/home/user/`
B) `cp config.yaml user@10.0.0.5:/home/user/`
C) `transfer config.yaml user@10.0.0.5:/home/user/`
D) `ftp config.yaml user@10.0.0.5:/home/user/`
Answer: A

**144. You want to monitor the end of a log file `/var/log/syslog` as new lines are written to it in real-time. Which command do you use?**
A) `cat /var/log/syslog -w`
B) `tail -f /var/log/syslog`
C) `watch /var/log/syslog`
D) `less -f /var/log/syslog`
Answer: B

**145. A directory contains thousands of files. You want to find all files ending in `.yaml` that contain the string `replicas: 5`. Which powerful command combination achieves this?**
A) `find . -name "*.yaml" -exec rg -l "replicas: 5" {} +`
B) `rg -rl "replicas: 5" *.yaml`
C) Both A and B are valid approaches.
D) `search .yaml "replicas: 5"`
Answer: C

## Section 7: Observability CLI – Prometheus/Grafana/Loki (Continued)

**146. You are using `logcli` (the CLI tool for Loki). You want to query logs for the label `{app="frontend"}` over the last 1 hour. What is the basic syntax?**
A) `logcli query '{app="frontend"}' --since=1h`
B) `logcli get '{app="frontend"}' -t 1h`
C) `loki-cli fetch app=frontend --time=1h`
D) `kubectl logs -l app=frontend --since=1h` (This uses Kubernetes logs, not Loki logcli)
Answer: A

**147. You want to use `logcli` to filter the frontend logs and only return lines containing the word `timeout`. What is the LogQL syntax passed to the CLI?**
A) `logcli query '{app="frontend"} |~ "timeout"'`
B) `logcli query '{app="frontend"} | rg timeout'`
C) `logcli query '{app="frontend", text="timeout"}'`
D) `logcli query '{app="frontend"} += "timeout"'`
Answer: A

**148. You are troubleshooting Alertmanager. You want to manually trigger a test alert via the CLI to ensure PagerDuty integration is working. How is this typically executed?**
A) `alertmanager trigger --name="TestAlert"`
B) By using `curl -X POST` to send a crafted JSON payload matching the Alertmanager API specification to `http://<alertmanager-ip>:9093/api/v1/alerts`.
C) `promtool send-alert "TestAlert"`
D) `kubectl create alert TestAlert`
Answer: B

**149. You need to find the Prometheus internal TSDB status (e.g., head block size, min/max time) via CLI for debugging storage issues. How do you query this?**
A) `curl -s http://<prometheus-ip>:9090/api/v1/status/tsdb`
B) `promtool tsdb status /path/to/data`
C) Both A (API) and B (local tool) can be used depending on if you are hitting the server or inspecting the raw disk files.
D) `kubectl describe pvc prometheus-data`
Answer: C

**150. You want to safely clear all "silences" currently active in Alertmanager using the `amtool` CLI. What is the command sequence?**
A) `amtool silence query -q | xargs amtool silence expire`
B) `amtool clear silences`
C) `alertmanager reset silences`
D) You cannot clear silences via CLI; it must be accomplished in the UI.
Answer: A
# DevOps / Platform Engineering CLI Mastery - Set 4 (Questions 151 - 200)

## Section 8: Senior/Enterprise Scenarios – Combined Tooling (Continued)

**151. *Scenario:* You are investigating a node `worker-3` that went `NotReady`. You want to see the exact time the `kubelet` service stopped reporting status. Which command gives you the most direct view of node-level events?**
A) `kubectl describe node worker-3 | ack -A 10 Conditions`
B) `kubectl get events --field-selector involvedObject.name=worker-3`
C) `kubectl logs daemonset/kube-proxy --node worker-3`
D) Both A and B are effective ways to check node conditions and events.
Answer: D

**152. *Scenario:* A developer complains their pod `my-pod` cannot resolve external DNS names. You want to execute a DNS lookup for `google.com` *from within* their running pod using `nslookup`. Which command is correct?**
A) `kubectl exec my-pod -- nslookup google.com`
B) `kubectl dns my-pod google.com`
C) `kubectl run --attach my-pod nslookup google.com`
D) `kubectl ping my-pod --host google.com`
Answer: A

**153. *Scenario:* You need to create a Kubernetes secret containing a generic API token. However, you want to avoid leaving the token in your bash history. How can you securely create the secret via CLI using standard input (stdin)?**
A) `kubectl create secret generic api-token --from-literal=token=$(cat /dev/stdin)`
B) `read -s TOKEN; kubectl create secret generic api-token --from-literal=token=$TOKEN`
C) `kubectl create secret generic api-token --from-literal=token=- <(echo secret123)`
D) Both B and a piped approach (`echo -n "secret123" | kubectl create secret generic api-token --from-file=token=/dev/stdin`) prevent history leaks.
Answer: D

**154. *Scenario:* You are auditing cluster security. You want to list all Kubernetes ServiceAccounts in the `kube-system` namespace and output only their names. Which command does this cleanly?**
A) `kubectl get sa -n kube-system -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'`
B) `kubectl get sa -n kube-system -o name`
C) `kubectl get sa -n kube-system | awk '{print $1}'`
D) All of the above work, but A and B are native Kubernetes formatting.
Answer: D

**155. *Scenario:* You are writing an automation script. You need to wait until a specific job `db-migration` completes successfully before proceeding. Which command blocks the script until the job is finished?**
A) `kubectl wait --for=condition=complete job/db-migration --timeout=300s`
B) `kubectl watch job db-migration --until=complete`
C) `kubectl sleep job db-migration --condition=ready`
D) `sleep 300`
Answer: A

**156. *Scenario:* A junior engineer accidentally deleted the `default` namespace. Oh wait, that's impossible. Why?**
A) The `default` namespace is protected by an immutable webhook.
B) The `default`, `kube-system`, and `kube-public` namespaces cannot be deleted by design in Kubernetes.
C) Only the cluster administrator can delete namespaces.
D) You must use the `--force` flag.
Answer: B

**157. *Scenario:* You are debugging a memory leak in a Java application running in a container. You need to trigger a heap dump and copy it to your local machine. Assume the container has the `jmap` tool. What is the workflow?**
A) `kubectl exec my-pod -- jmap -dump:format=b,file=/tmp/heap.hprof 1` followed by `kubectl cp my-pod:/tmp/heap.hprof ./heap.hprof`
B) `kubectl dump memory my-pod > heap.hprof`
C) `docker memory-dump my-pod`
D) `kubectl port-forward my-pod 8080:8080` and use JConsole.
Answer: A

**158. *Scenario:* You suspect an ArgoCD Application named `core-infra` has drifted due to manual changes, but you don't want to sync it yet. You just want to see the difference between Git and the live cluster state via CLI. What is the command?**
A) `argocd app diff core-infra`
B) `argocd app check core-infra`
C) `argocd app status core-infra --show-diff`
D) `kubectl diff -f <git-repo-path>`
Answer: A

**159. *Scenario:* You are deploying a Helm chart that requires a very large `values.yaml` file (e.g., 5MB). You notice `helm install` fails, complaining about a ConfigMap size limit. Why does this happen and how do you fix it?**
A) Helm stores release state in Secrets/ConfigMaps, which have a 1MB limit. You should switch the Helm storage backend (e.g., to an SQL database) or refactor the chart to mount large configs separately.
B) Helm has a hardcoded 1MB limit. You must use `kubectl apply`.
C) The Kubernetes API server is overloaded. You must increase its RAM.
D) You need to use the `--compress` flag with `helm install`.
Answer: A

**160. *Scenario:* You are managing a large GitOps repository. A developer opens a PR that modifies 15 different ArgoCD Application manifests. You want to quickly validate that the YAML syntax is correct for all of them before reviewing the logic. Which command-line tool is best for this?**
A) `kubeval .` or `yamllint .`
B) `argocd app validate .`
C) `helm lint .`
D) `kubectl apply --dry-run=server -f .`
Answer: A

**161. *Scenario:* A pod `my-pod` is failing its liveness probe. You want to view the output of the `kubelet` executing the probe to see exactly what failed. Where do you look?**
A) `kubectl describe pod my-pod` (Look under the "Events" section for "Liveness probe failed").
B) `kubectl logs my-pod`
C) `docker logs my-pod`
D) `journalctl -u kubelet | ack my-pod`
Answer: A

**162. *Scenario:* You are migrating an application from an old namespace `legacy-ns` to a new namespace `modern-ns`. You want to export a specific ConfigMap `app-config`, change its namespace, and apply it. Which one-liner does this?**
A) `kubectl get cm app-config -n legacy-ns -o yaml | sed 's/namespace: legacy-ns/namespace: modern-ns/' | kubectl apply -f -`
B) `kubectl mv cm app-config legacy-ns modern-ns`
C) `kubectl export cm app-config -n legacy-ns --to-namespace modern-ns`
D) `kubectl get cm app-config -n legacy-ns -o yaml > config.yaml && kubectl apply -f config.yaml -n modern-ns`
Answer: A

**163. *Scenario:* You are troubleshooting a complex Helm chart with dozens of templates and nested `_helpers.tpl`. You want to see exactly how a specific file (`templates/deployment.yaml`) renders with your custom `values.yaml`. Which command does this?**
A) `helm template my-release ./my-chart -f values.yaml -s templates/deployment.yaml`
B) `helm render my-release ./my-chart -f values.yaml --target templates/deployment.yaml`
C) `helm inspect template ./my-chart/templates/deployment.yaml`
D) `helm install my-release ./my-chart --dry-run --show-only templates/deployment.yaml`
Answer: A

**164. *Scenario:* A deployment is stuck scaling up because the cluster has hit a ResourceQuota limit in the namespace. Which command shows you the current usage versus the hard limits defined in the quota?**
A) `kubectl describe quota -n <namespace>` (or `kubectl get quota -n <namespace>`)
B) `kubectl top namespace <namespace>`
C) `kubectl get limits -n <namespace>`
D) `kubectl describe namespace <namespace>`
Answer: A

**165. *Scenario:* You are setting up a new CI runner. You need to authenticate Docker to a private Google Cloud Artifact Registry (GCR) using a service account key file `key.json`. Which command does this?**
A) `cat key.json | docker login -u _json_key --password-stdin https://gcr.io`
B) `docker login gcr.io -k key.json`
C) `docker auth https://gcr.io --key-file key.json`
D) `gcloud docker --login key.json`
Answer: A

**166. *Scenario:* You are using Git. You accidentally committed a massive binary file (e.g., `database.dump`) three commits ago. It's too late for `git commit --amend`. What interactive command allows you to go back, edit that specific past commit, remove the file, and continue?**
A) `git rebase -i HEAD~4` (Change the action on the bad commit from `pick` to `edit`, then `git rm --cached database.dump`, `git commit --amend`, `git rebase --continue`).
B) `git reset --hard HEAD~4`
C) `git revert HEAD~3`
D) `git clean -df`
Answer: A

**167. *Scenario:* You want to list all Kubernetes resources (Deployments, StatefulSets, DaemonSets, Services, Pods) that share a specific label `tier=frontend` across all namespaces. Which command is most comprehensive?**
A) `kubectl get all -A -l tier=frontend` (Note: 'all' misses some resources, but it's the closest built-in shorthand).
B) `kubectl get deployments,statefulsets,daemonsets,services,pods -A -l tier=frontend` (More exhaustive).
C) Both A and B are common approaches, though B guarantees no missing types.
D) `kubectl find resources -A --label tier=frontend`
Answer: C

**168. *Scenario:* A pod is writing logs to a file inside its container at `/var/log/app.log` instead of `stdout`. `kubectl logs` shows nothing. How do you view those logs continuously from your local terminal?**
A) `kubectl exec my-pod -- tail -f /var/log/app.log`
B) `kubectl logs my-pod --path=/var/log/app.log`
C) `kubectl attach my-pod --file=/var/log/app.log`
D) You cannot; logs must be sent to `stdout`.
Answer: A

**169. *Scenario:* You are managing a cluster where developers keep creating pods without memory limits, causing nodes to crash. You want to apply a `LimitRange` to the `dev` namespace to enforce default limits. After creating the YAML file `limitrange.yaml`, what command applies it?**
A) `kubectl apply -f limitrange.yaml -n dev`
B) `kubectl enforce limits -f limitrange.yaml -n dev`
C) `kubectl set limits -f limitrange.yaml -n dev`
D) `kubectl config limits dev --file=limitrange.yaml`
Answer: A

**170. *Scenario:* You are reviewing a Git repository containing Kubernetes manifests. You want to see who last modified a specific line in `deployment.yaml`. Which Git command provides this line-by-line annotation?**
A) `git blame deployment.yaml`
B) `git log -p deployment.yaml`
C) `git show line deployment.yaml`
D) `git annotate deployment.yaml` (Synonymous with `git blame`)
Answer: A

**171. *Scenario:* You are troubleshooting a complex Bash script used in your CI pipeline. You want the script to print every command it executes before running it to help you debug where it's failing. Which command do you add to the top of the script?**
A) `set -x` (or `set -o xtrace`)
B) `set -e`
C) `export DEBUG=true`
D) `echo "Debug mode on"`
Answer: A

**172. *Scenario:* You are using `jq` to parse a Kubernetes Secret JSON output. The secret contains a key `api-key`. How do you extract just the raw value of `api-key` without quotes?**
A) `kubectl get secret my-secret -o json | jq -r '.data["api-key"]'`
B) `kubectl get secret my-secret -o json | jq '.data.api-key'`
C) `kubectl get secret my-secret -o json | jq raw '.data.api-key'`
D) `kubectl get secret my-secret -o json | ack api-key`
Answer: A

**173. *Scenario:* You need to find all files modified in the last 24 hours in a directory `/var/log/pods`. Which Linux command does this?**
A) `find /var/log/pods -mtime -1`
B) `ls -l --recent 24h /var/log/pods`
C) `ack -r "last 24 hours" /var/log/pods`
D) `stat /var/log/pods --time=24h`
Answer: A

**174. *Scenario:* You want to securely copy an entire directory `/local/charts` to a remote server at `10.0.0.10` under `/opt/charts`. Which command is most efficient, especially if you need to re-run it later and only want to copy changed files?**
A) `rsync -avz /local/charts/ user@10.0.0.10:/opt/charts/`
B) `scp -r /local/charts/ user@10.0.0.10:/opt/charts/`
C) `cp -R /local/charts/ user@10.0.0.10:/opt/charts/`
D) `tar -cvf charts.tar /local/charts && scp charts.tar user@10.0.0.10:/opt/`
Answer: A

**175. *Scenario:* You are running a local Kubernetes cluster using `minikube`. You want to point your local Docker CLI to the Docker daemon running *inside* the Minikube VM so you can build images directly into the cluster's cache. What is the command?**
A) `eval $(minikube docker-env)`
B) `minikube docker connect`
C) `export DOCKER_HOST=minikube`
D) `docker context use minikube`
Answer: A

**176. *Scenario:* You deployed a new application version via Helm. Users are reporting errors. You want to immediately rollback to the previous release (revision 2) while you investigate. What is the fastest command?**
A) `helm rollback my-release 2`
B) `helm revert my-release --version 2`
C) `kubectl rollout undo deployment/my-app`
D) `helm upgrade my-release my-chart --version 2.0.0`
Answer: A

**177. *Scenario:* A pod named `db-backup` completed its task successfully. You want to view its logs, but the pod has already been deleted by a cleanup script. Can you retrieve the logs?**
A) Yes, if you use a centralized logging solution (like Loki or Elasticsearch) that scrapes logs from the node, you can query it there. Native `kubectl logs` cannot retrieve logs for deleted pods.
B) Yes, using `kubectl logs db-backup --deleted`.
C) No, the logs are permanently gone once the pod is deleted.
D) Yes, by SSHing into the node and checking `/var/log/messages`.
Answer: A

**178. *Scenario:* You are debugging a network issue between two pods. You want to capture all network traffic on port 8080 on a specific worker node (`node-1`) using `tcpdump`. How do you execute this?**
A) SSH into `node-1` and run `sudo tcpdump -i any port 8080`
B) `kubectl tcpdump node-1 --port 8080`
C) `docker exec node-1 tcpdump port 8080`
D) `kubectl capture node-1 8080`
Answer: A

**179. *Scenario:* You want to update the `kube-proxy` ConfigMap in the `kube-system` namespace. You prefer to edit the YAML definition interactively in your default terminal editor (like Vim or Nano) and have it apply automatically when you save and exit. Which command does this?**
A) `kubectl edit configmap kube-proxy -n kube-system`
B) `kubectl update configmap kube-proxy -n kube-system`
C) `kubectl modify configmap kube-proxy -n kube-system`
D) `kubectl patch configmap kube-proxy -n kube-system --interactive`
Answer: A

**180. *Scenario:* A developer wants to know why their pod is not scheduling. You run `kubectl get pods` and see status `Pending`. What is the *very first* command you should run to diagnose why the scheduler is rejecting the pod?**
A) `kubectl describe pod <pod-name>` (Look at the "Events" section at the bottom for scheduler messages like "Insufficient cpu" or "No nodes match node selector").
B) `kubectl logs <pod-name>`
C) `kubectl get events --sort-by='.metadata.creationTimestamp'`
D) `kubectl top nodes`
Answer: A

**181. *Scenario:* You are managing a cluster with hundreds of namespaces. You want to set your default `kubectl` context to always use the `production` namespace so you don't have to keep typing `-n production`. Which command configures this?**
A) `kubectl config set-context --current --namespace=production`
B) `kubectl default-namespace production`
C) `kubectl use-namespace production`
D) `export KUBECTL_NAMESPACE=production`
Answer: A

**182. *Scenario:* You are writing a deployment script. You need to extract the exact IP address of a Service named `api-gateway` in the `prod` namespace. Which command pipeline is most robust?**
A) `kubectl get svc api-gateway -n prod -o jsonpath='{.spec.clusterIP}'`
B) `kubectl describe svc api-gateway -n prod | ack IP:`
C) `kubectl get svc api-gateway -n prod | awk '{print $3}'`
D) All work, but A is the most robust and programmable method.
Answer: D

**183. *Scenario:* You are troubleshooting a failed ArgoCD sync. The UI is slow, so you turn to the CLI. You want to see the detailed error message for why the application `billing-service` failed to sync. What is the command?**
A) `argocd app get billing-service` (The output includes the Sync Status and any error messages from the last operation).
B) `argocd sync-status billing-service`
C) `argocd logs billing-service`
D) `kubectl describe application billing-service -n argocd`
Answer: A

**184. *Scenario:* A node is acting erratically. You want to restart the `kubelet` service on that specific Linux node. Assuming you have SSH access and are using systemd, what is the command?**
A) `sudo systemctl restart kubelet`
B) `sudo service kubelet reload`
C) `kubectl restart node <node-name>`
D) `docker restart kubelet`
Answer: A

**185. *Scenario:* You are managing an Elasticsearch cluster on Kubernetes using StatefulSets. You need to gracefully scale down the cluster from 5 nodes to 3. Which command initiates the scale-down, ensuring pods are terminated in reverse ordinal order (e.g., pod-4, then pod-3)?**
A) `kubectl scale statefulset elasticsearch --replicas=3` (StatefulSets natively handle ordered termination).
B) `kubectl delete pod elasticsearch-4 elasticsearch-3`
C) `kubectl scale down statefulset elasticsearch 3`
D) `kubectl resize statefulset elasticsearch 3`
Answer: A

**186. *Scenario:* You need to create a Kubernetes Job from a CronJob template immediately (e.g., to run a nightly backup right now for testing). Which command does this?**
A) `kubectl create job --from=cronjob/my-backup-job manual-backup-test`
B) `kubectl run manual-backup-test --from=cronjob/my-backup-job`
C) `kubectl trigger cronjob my-backup-job`
D) `kubectl execute cronjob my-backup-job`
Answer: A

**187. *Scenario:* You are using Git. You want to temporarily stash your changes, but you *also* want to include untracked files (new files you haven't `git add`ed yet). Which flag do you need?**
A) `git stash -u` (or `git stash --include-untracked`)
B) `git stash --all`
C) `git stash --new`
D) `git stash save --untracked`
Answer: A

**188. *Scenario:* You want to apply a Kubernetes manifest, but only if the namespace `test-env` exists. If it doesn't, the command should fail gracefully. Which bash construct achieves this?**
A) `kubectl get namespace test-env && kubectl apply -f manifest.yaml -n test-env`
B) `kubectl apply -f manifest.yaml -n test-env --require-namespace`
C) `kubectl apply -f manifest.yaml -n test-env || bash -c "exit 0"`
D) `if-namespace test-env then kubectl apply -f manifest.yaml`
Answer: A

**189. *Scenario:* You are using Helm. You want to upgrade a release, but you want to ensure that if the upgrade fails, Helm automatically rolls back to the previous successful release. Which flag do you use?**
A) `helm upgrade my-release ./chart --atomic`
B) `helm upgrade my-release ./chart --auto-rollback`
C) `helm upgrade my-release ./chart --safe`
D) `helm upgrade my-release ./chart --revert-on-fail`
Answer: A

**190. *Scenario:* You need to find which pod is serving traffic for a specific Kubernetes Service `web-svc`. How do you find the underlying endpoints (IP addresses of the pods) using `kubectl`?**
A) `kubectl get endpoints web-svc` (or `kubectl get ep web-svc`)
B) `kubectl describe service web-svc | ack Endpoints`
C) Both A and B provide this information.
D) `kubectl get pods --service=web-svc`
Answer: C

**191. *Scenario:* You are writing a Dockerfile. You want to ensure that the container runs as a non-root user for security. Which instruction achieves this?**
A) `USER 1000` (or `USER myuser` if the user was created earlier in the Dockerfile)
B) `RUN as user 1000`
C) `NON_ROOT true`
D) `SET_USER 1000`
Answer: A

**192. *Scenario:* A pod is failing to start because it cannot mount a PersistentVolumeClaim (PVC). You want to check the status of the PVC and the underlying PersistentVolume (PV). Which commands do you run?**
A) `kubectl get pvc` and `kubectl get pv`
B) `kubectl describe pvc <pvc-name>` to see events explaining why it's not binding.
C) Both A and B are the standard troubleshooting workflow for storage issues.
D) `kubectl storage list`
Answer: C

**193. *Scenario:* You want to output the logs of a pod and simultaneously save them to a file on your local machine. Which Linux command pipeline achieves this?**
A) `kubectl logs my-pod | tee pod-logs.txt`
B) `kubectl logs my-pod > pod-logs.txt` (This only saves to file, doesn't output to terminal)
C) `kubectl logs my-pod >> pod-logs.txt`
D) `kubectl logs my-pod --output-file=pod-logs.txt`
Answer: A

**194. *Scenario:* You are auditing ArgoCD configuration. You want to view the ArgoCD `argocd-cm` ConfigMap to see the configured custom health checks and status badge settings. Which command retrieves it?**
A) `kubectl get cm argocd-cm -n argocd -o yaml`
B) `argocd config get`
C) `argocd admin settings view`
D) `kubectl describe configmap argocd-cm -n argocd`
Answer: A

**195. *Scenario:* You are using GitOps. You need to deploy an emergency hotfix to production immediately. The standard CI pipeline takes 20 minutes. What is the *least* disruptive way to bypass the pipeline but maintain GitOps principles?**
A) Manually update the image tag in the Git repository manifest, commit, push, and force ArgoCD to sync.
B) Use `kubectl set image` directly on the cluster.
C) Edit the deployment via the ArgoCD UI.
D) Delete the ArgoCD application and apply manually.
Answer: A

**196. *Scenario:* You want to monitor the network traffic entering a specific pod `web-frontend`. You decide to use `ephemeral containers` (a feature introduced in k8s 1.23+). Which command adds a debug container running `nicolaka/netshoot` to the running pod?**
A) `kubectl debug -it web-frontend --image=nicolaka/netshoot --target=web-frontend`
B) `kubectl attach debug web-frontend --image=nicolaka/netshoot`
C) `kubectl run debug --target=web-frontend --image=nicolaka/netshoot`
D) `kubectl sidecar add web-frontend --image=nicolaka/netshoot`
Answer: A

**197. *Scenario:* A developer provides a Kubernetes manifest file `app.yaml` but is unsure if it complies with the cluster's API versions (e.g., they might be using an old `extensions/v1beta1` for an Ingress). Which command validates the manifest against the server's API without applying it?**
A) `kubectl apply -f app.yaml --dry-run=server`
B) `kubectl validate -f app.yaml`
C) `kubectl check -f app.yaml`
D) `kubectl diff -f app.yaml`
Answer: A

**198. *Scenario:* You want to completely delete a Git branch named `experimental` both locally and on the remote repository `origin`. Which two commands achieve this?**
A) `git branch -d experimental` and `git push origin --delete experimental`
B) `git rm branch experimental` and `git push origin -d experimental`
C) `git delete experimental` and `git remove origin/experimental`
D) `git branch -D experimental` and `git push origin :experimental` (Both A and D work, D is older syntax for remote deletion).
Answer: A

**199. *Scenario:* You are using `curl` to test an API endpoint. You only want to see the HTTP response headers (like Status Code, Content-Type), not the response body. Which flag do you use?**
A) `curl -I https://api.example.com` (or `curl --head`)
B) `curl -H https://api.example.com`
C) `curl -X HEAD https://api.example.com`
D) Both A and C achieve a similar result by making a HEAD request.
Answer: A

**200. *Scenario:* You are a Platform Engineer tasked with writing a script to automate ArgoCD cluster onboarding. You need the command to run non-interactively without prompting for confirmation. Which flag is universally used in ArgoCD CLI (and many others) for automation?**
A) `--yes` (or `-y`)
B) `--force`
C) `--auto-confirm`
D) `--no-prompt`
Answer: A
# DevOps / Platform Engineering CLI Mastery - Set 5 (Questions 201 - 250)

## Section 8: Senior/Enterprise Scenarios – Combined Tooling (Continued)

**201. *Scenario:* You have a running deployment `billing-processor`. You want to update a specific environment variable `LOG_LEVEL` to `DEBUG` temporarily to capture more logs, without modifying the Git repository (e.g., during a live incident). Which CLI command does this directly?**
A) `kubectl set env deployment/billing-processor LOG_LEVEL=DEBUG`
B) `kubectl patch deployment billing-processor --env LOG_LEVEL=DEBUG`
C) `kubectl update deployment billing-processor -e LOG_LEVEL=DEBUG`
D) `kubectl edit env deployment/billing-processor`
Answer: A

**202. *Scenario:* A junior developer accidentally deployed a pod in the `default` namespace instead of `dev`. You want to quickly extract the exact YAML of that running pod, but you want to strip out the cluster-injected status and metadata so you can apply it cleanly to the `dev` namespace. Which command pipeline is best?**
A) `kubectl get pod my-app -n default -o yaml --export > app.yaml` (Note: `--export` is deprecated/removed in newer versions).
B) `kubectl get pod my-app -n default -o yaml | kubectl neat > app.yaml` (Assuming the popular `krew` plugin `neat` is installed).
C) `kubectl get pod my-app -n default -o clean-yaml > app.yaml`
D) `kubectl dump pod my-app -n default > app.yaml`
Answer: B

**203. *Scenario:* You are managing a cluster with multiple worker nodes. You want to see the capacity and allocatable resources for all nodes formatted as JSON so a script can parse it. Which command produces this output?**
A) `kubectl get nodes -o json`
B) `kubectl describe nodes -o json`
C) `kubectl get nodes --format=json`
D) `kubectl top nodes -o json`
Answer: A

**204. *Scenario:* A StatefulSet named `kafka` has 3 replicas (`kafka-0`, `kafka-1`, `kafka-2`). You need to run a maintenance script specifically on `kafka-1`. How do you execute `maintenance.sh` interactively on that exact pod?**
A) `kubectl exec -it statefulset/kafka -- pod=1 -- ./maintenance.sh`
B) `kubectl exec -it kafka-1 -- ./maintenance.sh`
C) `kubectl run maintenance --attach kafka-1`
D) `kubectl exec -it statefulset/kafka/1 -- ./maintenance.sh`
Answer: B

**205. *Scenario:* You are reviewing ArgoCD logs and see "Permission denied" when it tries to sync to a cluster. You suspect the ArgoCD ServiceAccount lacks the necessary `ClusterRoleBinding`. Which `kubectl` command helps you quickly verify if the `argocd-application-controller` ServiceAccount has cluster-admin rights?**
A) `kubectl auth can-i '*' '*' --as=system:serviceaccount:argocd:argocd-application-controller -A`
B) `kubectl get permissions sa/argocd-application-controller -n argocd`
C) `kubectl describe clusterrolebinding argocd-application-controller`
D) Both A and C are valid ways to investigate, but A provides a direct boolean answer.
Answer: D

**206. *Scenario:* A developer wants to see the raw metrics exposed by the `kube-state-metrics` service. You port-forward the service to local port 8080. Which `curl` command fetches the metrics and counts the number of lines (metrics)?**
A) `curl -s http://localhost:8080/metrics | wc -l`
B) `curl -s http://localhost:8080/stats | count`
C) `curl -s http://localhost:8080/data | awk '/metric/' | wc -l`
D) `wget -qO- http://localhost:8080/metrics | lines`
Answer: A

**207. *Scenario:* You are troubleshooting a failed Helm installation that left a release in a `pending-install` state, preventing subsequent updates. How do you force Helm to unlock the release and try the upgrade again?**
A) `helm upgrade my-app ./chart --force`
B) `helm rollback my-app 0`
C) Delete the specific Kubernetes Secret holding the Helm state for that release version (e.g., `sh.helm.release.v1.my-app.v1`), then run `helm upgrade` or `helm uninstall`.
D) `helm release unlock my-app`
Answer: C

**208. *Scenario:* You need to find all Kubernetes Secrets in a cluster that are of type `kubernetes.io/tls` (TLS certificates). Which command filters by type?**
A) `kubectl get secrets -A --field-selector type=kubernetes.io/tls`
B) `kubectl get secrets -A -o jsonpath='{range .items[?(@.type=="kubernetes.io/tls")]}{.metadata.name}{"\n"}{end}'`
C) `kubectl get secrets -A --type=tls`
D) Both A and B are valid, but A relies on field selectors which may be limited depending on the API server version, making B the more robust JSONPath approach.
Answer: D

**209. *Scenario:* You are migrating from Docker to `containerd` on your worker nodes. You want to use the CLI tool specifically designed to interact with `containerd` for debugging (similar to the `docker` CLI). Which tool do you use?**
A) `crictl` or `ctr` (or `nerdctl`)
B) `kubectl-containerd`
C) `docker-shim`
D) `k8s-cri-cli`
Answer: A

**210. *Scenario:* You need to extract the exact container image digest (SHA256) currently running in a pod named `api-server` to verify it against a vulnerability scan report. Which JSONPath query does this?**
A) `kubectl get pod api-server -o jsonpath='{.status.containerStatuses[0].imageID}'`
B) `kubectl get pod api-server -o jsonpath='{.spec.containers[0].image}'`
C) `kubectl describe pod api-server | awk '/SHA/'`
D) `docker inspect api-server | awk '/Digest/'`
Answer: A

**211. *Scenario:* You have a local directory `my-chart/` containing a Helm chart. You want to package it and immediately push it to an OCI registry (e.g., `ghcr.io/my-org/charts`). What is the correct sequence of commands in Helm 3.8+?**
A) `helm package my-chart/` followed by `helm push my-chart-0.1.0.tgz oci://ghcr.io/my-org/charts`
B) `helm publish my-chart/ ghcr.io/my-org/charts`
C) `docker build -t ghcr.io/my-org/charts/my-chart:0.1.0 .` followed by `docker push`
D) `helm push my-chart/ oci://ghcr.io/my-org/charts`
Answer: A

**212. *Scenario:* You are managing ArgoCD and want to list all applications that are syncing from a specific Git repository URL (`https://github.com/my-org/my-repo.git`). Which command filters this?**
A) `argocd app list --repo https://github.com/my-org/my-repo.git`
B) `argocd app find --source https://github.com/my-org/my-repo.git`
C) `argocd get apps | awk '/https:\/\/github.com\/my-org\/my-repo.git/'`
D) Both A and C work, but A uses native filtering.
Answer: D

**213. *Scenario:* A developer provides a patch file `fix.json` containing `{"spec":{"replicas":5}}`. You want to apply this JSON patch to a deployment named `web` via CLI. Which command does this?**
A) `kubectl patch deployment web --patch-file fix.json`
B) `kubectl apply -f fix.json --target=deployment/web`
C) `kubectl update deployment web < fix.json`
D) `kubectl edit deployment web --file fix.json`
Answer: A

**214. *Scenario:* You want to tail the logs of *all* pods associated with a deployment named `backend-api` simultaneously. Which command achieves this?**
A) `kubectl logs deployment/backend-api -f`
B) `kubectl logs -l app=backend-api -f`
C) `kubectl get pods -l app=backend-api | xargs kubectl logs -f`
D) Both A and B are common approaches, though A explicitly targets the deployment object.
Answer: D

**215. *Scenario:* You are using Git. You want to find the commit that introduced a specific string (e.g., a hardcoded password `hunter2`) anywhere in the repository's history. Which command searches the commit contents?**
A) `git log -S "hunter2"` (the "pickaxe" search)
B) `git fetch` and then use `awk`
C) `git find "hunter2"`
D) `git search "hunter2"`
Answer: A

**216. *Scenario:* You have a Kubernetes cluster running on AWS EKS. You want to use the AWS CLI to update your local `kubeconfig` file to connect to the cluster named `prod-cluster` in `us-east-1`. Which command does this?**
A) `aws eks update-kubeconfig --name prod-cluster --region us-east-1`
B) `aws configure set cluster prod-cluster`
C) `kubectl config set-cluster prod-cluster --aws`
D) `aws eks connect prod-cluster us-east-1`
Answer: A

**217. *Scenario:* You are troubleshooting a pod that cannot reach an external database. You want to view the DNS resolution configuration *inside* the pod. Which file do you need to `cat` via `kubectl exec`?**
A) `/etc/resolv.conf`
B) `/etc/hosts`
C) `/etc/dns.conf`
D) `/etc/kubernetes/dns`
Answer: A

**218. *Scenario:* You want to apply a Kubernetes manifest, but you want `kubectl` to validate the fields against the OpenAPI schema *and* warn you about any unknown/deprecated fields. Which flag do you use?**
A) `kubectl apply -f app.yaml --validate=strict` (or `--server-dry-run`)
B) `kubectl apply -f app.yaml --strict`
C) `kubectl apply -f app.yaml --warn-only`
D) `kubectl check -f app.yaml`
Answer: A

**219. *Scenario:* You are using `jq` to process a JSON list of ArgoCD applications. You want to extract the names of all applications where the sync status is `OutOfSync`. Which `jq` filter does this?**
A) `.items[] | select(.status.sync.status == "OutOfSync") | .metadata.name`
B) `filter(.status == "OutOfSync") | .name`
C) `awk '/OutOfSync/' | jq .name`
D) `select(OutOfSync) | .items.name`
Answer: A

**220. *Scenario:* A developer accidentally pushed a commit containing sensitive data to `main`. You run `git revert <commit-sha>`. What does this actually do?**
A) It deletes the commit from the remote repository permanently.
B) It creates a *new* commit that undoes the changes introduced by the target commit, leaving the original bad commit in the history.
C) It resets the branch pointer back one step.
D) It deletes the local repository.
Answer: B

**221. *Scenario:* You are using Helm to deploy an application, but it is failing because a pre-install hook job is failing. You want to install the chart but tell Helm to ignore all hooks (pre-install, post-install, etc.) for debugging purposes. Which flag do you use?**
A) `helm install my-app ./chart --no-hooks`
B) `helm install my-app ./chart --skip-hooks`
C) `helm install my-app ./chart --ignore-jobs`
D) `helm install my-app ./chart --dry-run`
Answer: A

**222. *Scenario:* You want to cleanly drain a node named `worker-2` for maintenance, but there are pods on it that use local `emptyDir` volumes (which will lose data upon eviction). Which flag tells `kubectl drain` to proceed anyway?**
A) `kubectl drain worker-2 --delete-emptydir-data` (or `--delete-local-data` in older versions)
B) `kubectl drain worker-2 --force`
C) `kubectl drain worker-2 --ignore-volumes`
D) `kubectl drain worker-2 --bypass-emptydir`
Answer: A

**223. *Scenario:* You need to create a Kubernetes Namespace, set a ResourceQuota on it, and create a ServiceAccount inside it. Which imperative command sequence achieves this fastest in a script?**
A) `kubectl create namespace new-ns && kubectl create quota my-quota --hard=cpu=2,memory=2Gi -n new-ns && kubectl create sa my-sa -n new-ns`
B) `kubectl new namespace new-ns --quota cpu=2 --sa my-sa`
C) `kubectl init namespace new-ns`
D) You cannot do this imperatively; you must write YAML files.
Answer: A

**224. *Scenario:* You are using ArgoCD's ApplicationSet controller. You want to manually trigger the ApplicationSet to immediately regenerate applications without waiting for the sync interval. Which command does this?**
A) There is no native `argocd appset sync` command; you typically trigger regeneration by adding an annotation/label to the ApplicationSet or modifying it slightly (e.g., `kubectl patch applicationset <name> -n argocd --type merge -p '{"metadata":{"annotations":{"requeue":"now"}}}'`)
B) `argocd appset sync <name>`
C) `argocd trigger appset <name>`
D) `argocd appset apply <name>`
Answer: A

**225. *Scenario:* You are troubleshooting a Docker image build process that is failing on `apt-get install`. You want to run a container from the image state *exactly one step before* the failure to debug it manually. What command do you run using the image ID of the last successful intermediate layer?**
A) `docker run -it <intermediate-image-id> /bin/bash`
B) `docker debug <failed-image-name>`
C) `docker exec -it <failed-image-name> /bin/bash`
D) `docker history --interactive <failed-image-name>`
Answer: A

**226. *Scenario:* A Kubernetes Service of type `NodePort` is not routing traffic to your pod. The Service selector is `app: my-web`. The pod label is `app: myWeb`. How do you quickly add the correct label to the existing pod via CLI to fix the routing instantly?**
A) `kubectl label pod <pod-name> app=my-web --overwrite`
B) `kubectl set label pod <pod-name> app=my-web`
C) `kubectl tag pod <pod-name> app=my-web`
D) `kubectl patch pod <pod-name> -p '{"metadata":{"labels":{"app":"my-web"}}}'` (Both A and D work, A is the intended CLI shortcut).
Answer: A

**227. *Scenario:* You want to view the default StorageClass in your Kubernetes cluster. Which command does this?**
A) `kubectl get sc` (Look for the one marked `(default)`).
B) `kubectl describe storageclass default`
C) `kubectl get storageclass --default`
D) `kubectl view default-storage`
Answer: A

**228. *Scenario:* You are configuring a CI pipeline to push an image to Docker Hub. The script runs `docker build`, then `docker login`, then `docker push`. The pipeline fails with "access denied". What is the most likely issue with the `docker push` command syntax?**
A) You must tag the image with your Docker Hub username/repository before pushing (e.g., `docker tag myapp myusername/myapp`, then `docker push myusername/myapp`).
B) You must use `docker upload` instead.
C) You must push the Dockerfile, not the image.
D) You must provide the password inline with the push command.
Answer: A

**229. *Scenario:* You need to find the total number of pods running across all namespaces in your cluster via a single CLI command pipeline. Which command does this?**
A) `kubectl get pods -A --no-headers | wc -l`
B) `kubectl count pods --all-namespaces`
C) `kubectl describe cluster | awk '/Total Pods/'`
D) `docker ps -q | wc -l`
Answer: A

**230. *Scenario:* You want to apply a YAML file `deployment.yaml`, but you want to record the exact `kubectl` command that was used to apply it in the resource's annotations (specifically `kubectl.kubernetes.io/last-applied-configuration`). Which command does this by default in modern Kubernetes?**
A) `kubectl apply -f deployment.yaml` (The `apply` command inherently records this annotation for declarative management).
B) `kubectl create -f deployment.yaml --record`
C) `kubectl save -f deployment.yaml`
D) `kubectl commit -f deployment.yaml`
Answer: A

**231. *Scenario:* You are investigating an issue where an application is OOMKilled only on specific days. You want to see the long-term trend of memory usage for a specific pod. Which tool is appropriate?**
A) `kubectl top pod`
B) Querying Prometheus (via Grafana or PromQL) for `container_memory_working_set_bytes` over the desired time range.
C) `docker stats`
D) `kubectl get events`
Answer: B

**232. *Scenario:* You are writing a script that needs to wait until a specific Kubernetes Deployment named `web-app` has all of its updated replicas available before continuing. What is the command?**
A) `kubectl rollout status deployment/web-app`
B) `kubectl wait deployment web-app --ready`
C) `kubectl watch deployment web-app --status=available`
D) `sleep 120`
Answer: A

**233. *Scenario:* You need to update a Kubernetes secret with a new base64-encoded TLS certificate. You have the raw certificate in `cert.pem`. How do you convert it to a single-line base64 string suitable for a YAML file via Linux CLI?**
A) `cat cert.pem | base64 -w 0` (or `base64 --wrap=0`)
B) `base64 encode cert.pem`
C) `certutil --encode cert.pem`
D) `openssl base64 -in cert.pem`
Answer: A

**234. *Scenario:* You are using Git. You want to discard all local changes to tracked files *and* remove all untracked files and directories, completely resetting your working directory to match the remote repository. Which combination of commands achieves this?**
A) `git reset --hard HEAD` and `git clean -xfd`
B) `git revert HEAD` and `git rm -r .`
C) `git checkout .` and `git stash clear`
D) `git format-patch` and `git apply`
Answer: A

**235. *Scenario:* A developer wants to run a specific CronJob manually via CLI immediately, without waiting for the schedule, but wants to pass a specific environment variable to this manual run. How is this achieved?**
A) You cannot inject environment variables into `kubectl create job --from=cronjob`. You must download the job YAML, modify the env vars, and apply it.
B) `kubectl trigger cronjob my-job --env VAR=val`
C) `kubectl run my-job --from=cronjob/my-job --env VAR=val`
D) `helm upgrade my-job --set env.VAR=val`
Answer: A

**236. *Scenario:* You are managing a massive Kubernetes cluster. You want to find all namespaces that *do not* have a specific label (e.g., `environment=prod`). Which `kubectl` command filters this?**
A) `kubectl get namespaces -l 'environment!=prod'`
B) `kubectl get namespaces --exclude-label environment=prod`
C) `kubectl get namespaces | awk '!/prod/'`
D) `kubectl find namespaces --not-label environment=prod`
Answer: A

**237. *Scenario:* You are troubleshooting a Docker container that immediately exits with status code 1. You run `docker logs <container_id>` but nothing is printed. How do you find the exact command the container attempted to run?**
A) `docker inspect <container_id>` and look at the `Cmd` or `Entrypoint` fields.
B) `docker command <container_id>`
C) `docker run <container_id> /bin/sh`
D) `kubectl get pod <container_id> -o yaml`
Answer: A

**238. *Scenario:* You are configuring a CI pipeline. You need the pipeline script to exit immediately and fail the build if *any* command within the script returns a non-zero exit code. Which bash command enforces this?**
A) `set -e`
B) `set -x`
C) `trap ERR`
D) `exit 1`
Answer: A

**239. *Scenario:* You want to apply a Kubernetes manifest `app.yaml`, but the namespace specified inside the file doesn't exist yet. You want `kubectl` to create the namespace automatically if it's missing during the apply process. How?**
A) `kubectl apply` does not natively auto-create namespaces specified inside resources. You must run `kubectl create namespace <ns>` first, or include the Namespace definition resource at the top of the `app.yaml` file.
B) `kubectl apply -f app.yaml --create-namespace`
C) `kubectl apply -f app.yaml --auto-ns`
D) `helm apply -f app.yaml`
Answer: A

**240. *Scenario:* You are using `sed` to edit a configuration file in-place (saving the changes back to the original file) during a CI build step. Which flag is required?**
A) `sed -i` (or `--in-place`)
B) `sed -e`
C) `sed -w`
D) `sed -s`
Answer: A

**241. *Scenario:* You want to list all Kubernetes API resources that are available in your cluster (e.g., to see if CustomResourceDefinitions for ArgoCD or Prometheus Operator are installed). What is the command?**
A) `kubectl api-resources`
B) `kubectl get all-resources`
C) `kubectl list apis`
D) `kubectl describe api`
Answer: A

**242. *Scenario:* You are investigating a performance issue. You want to see the real-time disk I/O usage of a specific process on a Linux worker node. Which tool provides a `top`-like interface specifically for disk I/O?**
A) `iotop`
B) `iostat`
C) `df -h`
D) `du -sh`
Answer: A

**243. *Scenario:* You are writing a Helm chart. You want to generate a random 16-character alphanumeric password for a database if one is not provided in `values.yaml`. Which Helm template function generates this?**
A) `{{ randAlphaNum 16 }}`
B) `{{ generatePassword 16 }}`
C) `{{ randomString 16 }}`
D) `{{ uuid 16 }}`
Answer: A

**244. *Scenario:* An ArgoCD Application is stuck in an `Unknown` health state. You want to manually trigger an evaluation of its health via the CLI. What command forces this?**
A) `argocd app get <app-name> --hard-refresh` (Forces a refresh from the cache and Git, triggering health evaluation).
B) `argocd app evaluate <app-name>`
C) `argocd health check <app-name>`
D) `kubectl describe application <app-name> -n argocd`
Answer: A

**245. *Scenario:* You need to extract the raw, unformatted payload of a Git commit message (e.g., for parsing in a CI script) for the last commit on the current branch. Which command is best?**
A) `git log -1 --pretty=format:"%B"` (or `%s` for just the subject).
B) `git show --message-only`
C) `git extract message HEAD`
D) `git status --commit-message`
Answer: A

**246. *Scenario:* A developer wants to debug a network policy issue by testing connectivity from their pod to an external API (`api.stripe.com`). The pod doesn't have `curl` or `ping` installed. How do you inject an ephemeral debug container with network tools into their running pod?**
A) `kubectl debug -it <pod-name> --image=curlimages/curl --target=<container-name>`
B) `kubectl run debug --attach <pod-name> --image=curl`
C) `kubectl exec <pod-name> -- apt-get install curl`
D) `docker exec <pod-name> curl api.stripe.com`
Answer: A

**247. *Scenario:* You are using ArgoCD and have defined a `SyncWindow` to prevent deployments during the weekend. A critical hotfix needs to bypass this window immediately. How do you trigger the sync via CLI, ignoring the sync window?**
A) `argocd app sync <app-name> --force` (Wait, this forces sync, but bypassing windows might require deleting the window definition or using specific admin overrides if configured).
B) `argocd app sync <app-name> --ignore-sync-window` (Wait, this flag doesn't exist natively. The standard practice is to temporarily comment out the window in the AppProject Git config).
C) True Answer: You must modify the `AppProject` or `Application` definition in Git to remove/suspend the `SyncWindow` block, or use a cluster-admin account if RBAC allows overriding.
D) `argocd bypass-window <app-name>`
Answer: C

**248. *Scenario:* You are troubleshooting a Linux server and want to see the last 100 lines of the system journal specifically for the `docker.service`. Which command achieves this?**
A) `journalctl -u docker.service -n 100` (or `--tail 100`)
B) `tail -n 100 /var/log/docker.log`
C) `systemctl logs docker -n 100`
D) `docker logs daemon -n 100`
Answer: A

**249. *Scenario:* You need to list all Helm releases that are in a `failed` status across the entire cluster, and you want the output in JSON format for a script. What is the command pipeline?**
A) `helm list -A -f 'failed' -o json`
B) `helm list --all-namespaces --status failed --output json`
C) `helm get failed -A --format json`
D) `kubectl get releases.helm -A -o json | jq '.[] | select(.status=="failed")'`
Answer: B

**250. *Scenario:* You are writing the final step of a complex Bash script for a CI/CD pipeline. You want to output a summary message and ensure the script exits with a success code (`0`), but you need to do it without using the literal word "exit" because a linter blocks it. Which alternative command returns a zero exit status?**
A) `echo "Pipeline finished." && true` (or `return 0` if in a function)
B) `end 0`
C) `quit 0`
D) `completed`
Answer: A


