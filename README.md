# Ollama

Kubernetes Helm chart to deploy Large Language Models with Ollama.

## How to use this chart

```bash
helm repo add ollama https://feisky.xyz/ollama-kubernetes
helm repo update
helm upgrade --install ollama ollama/ollama \
    --namespace=ollama \
    --create-namespace
```

After the deployment, you can access the Ollama UI by port-forwarding the service:

```bash
kubectl -n ollama port-forward service/ollama-webui 8080:80
```

Then open your browser and go to `http://localhost:8080`.

## Configuration

The following table lists the configurable parameters of the Ollama chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `image.repository` | Image repository of Ollama | `"ollama/ollama"` |
| `image.tag` | Image tag of Ollama | `0.2.3` |
| `replicaCount` | Number of replicas, need storge class support of multiple read when pvc enabled and replica > 1 | `1` |
| `llm.models` | List of models to be loaded | `["phi3", "llama3"]` |
| `persistentVolume.enabled` | Whether to enable persistent volume for Ollama | `true` |
| `persistentVolume.storageClass` | Storage class for Ollama persistent volume | `"default"` |
| `persistentVolume.accessModes` | Access mode for Ollama persistent volume | `["ReadWriteOnce"]` |
| `persistentVolume.size` | Storage size for Ollama persistent volume | `"30Gi"` |
| `persistentVolume.claimName` | Set to non-empty value to use an existing PVC for Ollama persistent volume | `""` |
| `resources.limits.cpu` | CPU limits for Ollama container | `4` |
| `resources.limits.memory` | Memory limits for Ollama container  | `"4Gi"` |
| `resources.limits.nvidia.com/gpu` | GPU limits for Ollama container  | `"1"` |
| `resources.requests.cpu` | CPU requests for Ollama container | `"100m"` |
| `resources.requests.memory` | Memory requests for Ollama container | `"128Mi"` |
| `resources.requests.nvidia.com/gpu` | GPU requests for Ollama container | `"1"` |
| `nodeSelector` | Node selector for Ollama Pod | `{}` |
| `tolerations` | Tolerations for Ollama Pod | `[{"key": "kubernetes.azure.com/scalesetpriority", "operator": "Exists"}]` |
| `affinity` | Affinity for Ollama Pod | `{}` |
| `ui.enabled` | Whether to enable WebUI | `true` |
| `ui.type` |  Supported UI types are "open-webui" and "lobe-chat"| `lobe-chat` |
| `ui.replicaCount` | Replica count for WebUI Pod | `1` |
| `ui.image.repository` | Image repository of WebUI Pod | `"ghcr.io/open-webui/open-webui"` |
| `ui.image.tag` | Image tag of WebUI Pod | `"latest"` |
| `ui.service.type` | Service type of WebUI | `"ClusterIP"` |
| `ui.service.port` | Service port of WebUI | `80` |
| `ui.nodeSelector` | Node selector for WebUI | `{}` |
| `ui.tolerations` | Tolerations for WebUI | `{}` |
| `ui.affinity` | Affinity for WebUI | `{}` |
| `ui.ingress.enabled` | Whether to enable Ingress for WebUI | `false` |
| `ui.ingress.className` | Ingress class name for WebUI | `""` |
| `ui.ingress.hosts` | Ingress hosts for WebUI | `[{"host": "chart-example.local", "paths": [{"path": "/", "pathType": "ImplementationSpecific"}]}]` |
| `ui.ingress.tls` | Ingress TLS for WebUI | `[]` |
| `ui.persistentVolume.enabled` | Whether to enable persistent volume for WebUI | `true` |
| `ui.persistentVolume.storageClass` | Storage class for WebUI persistent volume  | `"default"` |
| `ui.persistentVolume.accessModes` | Access mode for WebUI persistent volume | `["ReadWriteOnce"]` |
| `ui.persistentVolume.size` | Storage size for WebUI persistent volume | `"10Gi"` |
| `ui.persistentVolume.claimName` | Set to non-empty value to use an existing PVC for WebUI persistent volume | `""` |
