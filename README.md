# GKE Resource

Deploys to a Kubernetes cluster running on Google Cloud.

## Behavior

### Source configuration
* `service_account.key`: Base64 encoded JSON certificate of a service account
* `service_account.email`: Email address of the service account
* `project_id`: Project ID of the service account / cluster
* `zone`: Compute zone where the cluster is located
* `cluster`: Name of the cluster

### check
Noop

### In
Noop

### Out
Deploy a given docker image to a GKE cluster.

Parameters:
* `namespace`: Namespace of the resources
* `type`: Kubernetes resource, will used as given (e.g. `deployment`, `statefulset`, ..)
* `name`: Name of the Kubernetes resource
* `container`: Name of the container in the pod
* `image_file`: Path to a file containing the image name
* `tag_file`: Path to a file containing the tag
* `deploy_hook`: Path to an executable which will be run after the image has been changed


## Example

```yaml
resource_types:
- name: gke-deployment
  type: docker-image
  source:
    repository: rschmid/concourse-gke-resource

resources:
  - name: gke
    type: gke-deployment
    source:
      service_account:
        key: **redacted**
        email: concourse@project.iam.gserviceaccount.com
      project_id: project-id-1234
      zone: us-east1-d
      cluster: staging
jobs:
  - name: Release
    plan:
      - put: version
        params:
          repo: code
      - put: gke
        params:
          namespace: default
          type: deployment
          name: web
          container: web
          image_file: container/image
          tag_file: version/revision
          deploy_hook: code/ci/db_migrate.sh
```
