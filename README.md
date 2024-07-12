k8s-static-code-analysis-demo
=============================

## 用意したコード

- sample実行用に用意したコードで `helm create mywebapp` を実行して用意
- 異常を発生させるために適宜書き換える

## 参考

- https://v3-1-0.helm.sh/docs/helm/helm_lint/
- https://github.com/yannh/kubeconform
- https://polaris.docs.fairwinds.com/infrastructure-as-code/
- https://aquasecurity.github.io/trivy/v0.48/docs/coverage/iac/helm/
- https://github.com/helm/chart-testing
- https://github.com/helm/chart-testing-action
- https://github.com/helm/charts-repo-actions-demo
- https://helm.sh/docs/topics/charts/

## 手動実行サンプル

### Helm

#### helm lint

<details>

<summary>helm lint手動実行サンプル</summary>

```sh
% helm lint ./mywebapp 
==> Linting ./mywebapp
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
```

</details>

#### nova

TBD

### Kubernetes Manifest

#### kubeconform

<details>

<summary>kubeconform手動実行サンプル</summary>

```sh
% helm template mywebapp -f values/env/tes/values.yaml | kubeconform --summary -output json
{
  "resources": [],
  "summary": {
    "valid": 4,
    "invalid": 0,
    "errors": 0,
    "skipped": 0
  }
}
```

</details>

#### polaris

<details>

<summary>polaris手動実行サンプル</summary>

```
% polaris audit --helm-chart ./mywebapp --helm-values ./values/env/tes/values.yaml 
{
  "PolarisOutputVersion": "1.0",
  "AuditTime": "2024-05-08T12:14:20+09:00",
  "SourceType": "Path",
  "SourceName": "/var/folders/9c/l4hy_96j1zjd7yx5kblnh75w0000gn/T/916061587",
  "DisplayName": "/var/folders/9c/l4hy_96j1zjd7yx5kblnh75w0000gn/T/916061587",
  "ClusterInfo": {
    "Version": "unknown",
    "Nodes": 0,
    "Pods": 0,
    "Namespaces": 0,
    "Controllers": 2
  },
  "Results": [
    {
      "Name": "release-name-mywebapp",
      "Namespace": "",
      "Kind": "Service",
      "Results": {},
      "PodResult": null,
      "CreatedTime": "0001-01-01T00:00:00Z"
    },
    {
      "Name": "release-name-mywebapp",
      "Namespace": "",
      "Kind": "ServiceAccount",
      "Results": {},
      "PodResult": null,
      "CreatedTime": "0001-01-01T00:00:00Z"
    },
    {
      "Name": "release-name-mywebapp-test-connection",
      "Namespace": "",
      "Kind": "Pod",
      "Results": {
        "metadataAndInstanceMismatched": {
          "ID": "metadataAndInstanceMismatched",
          "Message": "Label app.kubernetes.io/instance must match metadata.name",
          "Details": null,
          "Success": false,
          "Severity": "warning",
          "Category": "Reliability",
          "Mutations": null
        }
      },
      "PodResult": {
        "Name": "",
        "Results": {
          "automountServiceAccountToken": {
            "ID": "automountServiceAccountToken",
            "Message": "The ServiceAccount will be automounted",
            "Details": null,
            "Success": false,
            "Severity": "warning",
            "Category": "Security",
            "Mutations": null
          },
          "hostIPCSet": {
            "ID": "hostIPCSet",
            "Message": "Host IPC is not configured",
            "Details": null,
            "Success": true,
            "Severity": "danger",
            "Category": "Security",
            "Mutations": null
          },
          "hostNetworkSet": {
            "ID": "hostNetworkSet",
            "Message": "Host network is not configured",
            "Details": null,
            "Success": true,
            "Severity": "danger",
            "Category": "Security",
            "Mutations": null
          },
          "hostPIDSet": {
            "ID": "hostPIDSet",
            "Message": "Host PID is not configured",
            "Details": null,
            "Success": true,
            "Severity": "danger",
            "Category": "Security",
            "Mutations": null
          },
          "missingNetworkPolicy": {
            "ID": "missingNetworkPolicy",
            "Message": "A NetworkPolicy should match pod labels and contain applied egress and ingress rules",
            "Details": null,
            "Success": false,
            "Severity": "warning",
            "Category": "Security",
            "Mutations": null
          },
          "priorityClassNotSet": {
            "ID": "priorityClassNotSet",
            "Message": "Priority class should be set",
            "Details": null,
            "Success": false,
            "Severity": "warning",
            "Category": "Reliability",
            "Mutations": null
          },
          "topologySpreadConstraint": {
            "ID": "topologySpreadConstraint",
            "Message": "Pod should be configured with a valid topology spread constraint",
            "Details": null,
            "Success": false,
            "Severity": "warning",
            "Category": "Reliability",
            "Mutations": null
          }
        },
        "ContainerResults": [
          {
            "Name": "wget",
            "Results": {
              "cpuLimitsMissing": {
                "ID": "cpuLimitsMissing",
                "Message": "CPU limits should be set",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Efficiency",
                "Mutations": null
              },
              "cpuRequestsMissing": {
                "ID": "cpuRequestsMissing",
                "Message": "CPU requests should be set",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Efficiency",
                "Mutations": null
              },
              "dangerousCapabilities": {
                "ID": "dangerousCapabilities",
                "Message": "Container does not have any dangerous capabilities",
                "Details": null,
                "Success": true,
                "Severity": "danger",
                "Category": "Security",
                "Mutations": null
              },
              "hostPortSet": {
                "ID": "hostPortSet",
                "Message": "Host port is not configured",
                "Details": null,
                "Success": true,
                "Severity": "warning",
                "Category": "Security",
                "Mutations": null
              },
              "insecureCapabilities": {
                "ID": "insecureCapabilities",
                "Message": "Container should not have insecure capabilities",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Security",
                "Mutations": null
              },
              "linuxHardening": {
                "ID": "linuxHardening",
                "Message": "Use one of AppArmor, Seccomp, SELinux, or dropping Linux Capabilities to restrict containers using unwanted privileges",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Security",
                "Mutations": null
              },
              "livenessProbeMissing": {
                "ID": "livenessProbeMissing",
                "Message": "Liveness probe should be configured",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Reliability",
                "Mutations": null
              },
              "memoryLimitsMissing": {
                "ID": "memoryLimitsMissing",
                "Message": "Memory limits should be set",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Efficiency",
                "Mutations": null
              },
              "memoryRequestsMissing": {
                "ID": "memoryRequestsMissing",
                "Message": "Memory requests should be set",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Efficiency",
                "Mutations": null
              },
              "notReadOnlyRootFilesystem": {
                "ID": "notReadOnlyRootFilesystem",
                "Message": "Filesystem should be read only",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Security",
                "Mutations": null
              },
              "privilegeEscalationAllowed": {
                "ID": "privilegeEscalationAllowed",
                "Message": "Privilege escalation should not be allowed",
                "Details": null,
                "Success": false,
                "Severity": "danger",
                "Category": "Security",
                "Mutations": null
              },
              "pullPolicyNotAlways": {
                "ID": "pullPolicyNotAlways",
                "Message": "Image pull policy should be \"Always\"",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Reliability",
                "Mutations": [
                  {
                    "Path": "/spec/containers/0/imagePullPolicy",
                    "Op": "add",
                    "Value": "Always",
                    "Comment": ""
                  }
                ]
              },
              "readinessProbeMissing": {
                "ID": "readinessProbeMissing",
                "Message": "Readiness probe should be configured",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Reliability",
                "Mutations": null
              },
              "runAsPrivileged": {
                "ID": "runAsPrivileged",
                "Message": "Not running as privileged",
                "Details": null,
                "Success": true,
                "Severity": "danger",
                "Category": "Security",
                "Mutations": null
              },
              "runAsRootAllowed": {
                "ID": "runAsRootAllowed",
                "Message": "Should not be allowed to run as root",
                "Details": null,
                "Success": false,
                "Severity": "danger",
                "Category": "Security",
                "Mutations": null
              },
              "sensitiveContainerEnvVar": {
                "ID": "sensitiveContainerEnvVar",
                "Message": "The container does not set potentially sensitive environment variables",
                "Details": null,
                "Success": true,
                "Severity": "danger",
                "Category": "Security",
                "Mutations": null
              },
              "tagNotSpecified": {
                "ID": "tagNotSpecified",
                "Message": "Image tag should be specified",
                "Details": null,
                "Success": false,
                "Severity": "danger",
                "Category": "Reliability",
                "Mutations": null
              }
            }
          }
        ]
      },
      "CreatedTime": "0001-01-01T00:00:00Z"
    },
    {
      "Name": "release-name-mywebapp",
      "Namespace": "",
      "Kind": "Deployment",
      "Results": {
        "deploymentMissingReplicas": {
          "ID": "deploymentMissingReplicas",
          "Message": "Multiple replicas are scheduled",
          "Details": null,
          "Success": true,
          "Severity": "warning",
          "Category": "Reliability",
          "Mutations": null
        },
        "metadataAndInstanceMismatched": {
          "ID": "metadataAndInstanceMismatched",
          "Message": "Label app.kubernetes.io/instance must match metadata.name",
          "Details": null,
          "Success": false,
          "Severity": "warning",
          "Category": "Reliability",
          "Mutations": null
        },
        "missingPodDisruptionBudget": {
          "ID": "missingPodDisruptionBudget",
          "Message": "Should have a PodDisruptionBudget",
          "Details": null,
          "Success": false,
          "Severity": "warning",
          "Category": "Reliability",
          "Mutations": null
        }
      },
      "PodResult": {
        "Name": "",
        "Results": {
          "automountServiceAccountToken": {
            "ID": "automountServiceAccountToken",
            "Message": "The ServiceAccount will be automounted",
            "Details": null,
            "Success": false,
            "Severity": "warning",
            "Category": "Security",
            "Mutations": null
          },
          "hostIPCSet": {
            "ID": "hostIPCSet",
            "Message": "Host IPC is not configured",
            "Details": null,
            "Success": true,
            "Severity": "danger",
            "Category": "Security",
            "Mutations": null
          },
          "hostNetworkSet": {
            "ID": "hostNetworkSet",
            "Message": "Host network is not configured",
            "Details": null,
            "Success": true,
            "Severity": "danger",
            "Category": "Security",
            "Mutations": null
          },
          "hostPIDSet": {
            "ID": "hostPIDSet",
            "Message": "Host PID is not configured",
            "Details": null,
            "Success": true,
            "Severity": "danger",
            "Category": "Security",
            "Mutations": null
          },
          "missingNetworkPolicy": {
            "ID": "missingNetworkPolicy",
            "Message": "A NetworkPolicy should match pod labels and contain applied egress and ingress rules",
            "Details": null,
            "Success": false,
            "Severity": "warning",
            "Category": "Security",
            "Mutations": null
          },
          "priorityClassNotSet": {
            "ID": "priorityClassNotSet",
            "Message": "Priority class should be set",
            "Details": null,
            "Success": false,
            "Severity": "warning",
            "Category": "Reliability",
            "Mutations": null
          },
          "topologySpreadConstraint": {
            "ID": "topologySpreadConstraint",
            "Message": "Pod should be configured with a valid topology spread constraint",
            "Details": null,
            "Success": false,
            "Severity": "warning",
            "Category": "Reliability",
            "Mutations": null
          }
        },
        "ContainerResults": [
          {
            "Name": "mywebapp",
            "Results": {
              "cpuLimitsMissing": {
                "ID": "cpuLimitsMissing",
                "Message": "CPU limits should be set",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Efficiency",
                "Mutations": null
              },
              "cpuRequestsMissing": {
                "ID": "cpuRequestsMissing",
                "Message": "CPU requests should be set",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Efficiency",
                "Mutations": null
              },
              "dangerousCapabilities": {
                "ID": "dangerousCapabilities",
                "Message": "Container does not have any dangerous capabilities",
                "Details": null,
                "Success": true,
                "Severity": "danger",
                "Category": "Security",
                "Mutations": null
              },
              "hostPortSet": {
                "ID": "hostPortSet",
                "Message": "Host port is not configured",
                "Details": null,
                "Success": true,
                "Severity": "warning",
                "Category": "Security",
                "Mutations": null
              },
              "insecureCapabilities": {
                "ID": "insecureCapabilities",
                "Message": "Container should not have insecure capabilities",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Security",
                "Mutations": null
              },
              "linuxHardening": {
                "ID": "linuxHardening",
                "Message": "Use one of AppArmor, Seccomp, SELinux, or dropping Linux Capabilities to restrict containers using unwanted privileges",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Security",
                "Mutations": null
              },
              "livenessProbeMissing": {
                "ID": "livenessProbeMissing",
                "Message": "Liveness probe is configured",
                "Details": null,
                "Success": true,
                "Severity": "warning",
                "Category": "Reliability",
                "Mutations": null
              },
              "memoryLimitsMissing": {
                "ID": "memoryLimitsMissing",
                "Message": "Memory limits should be set",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Efficiency",
                "Mutations": null
              },
              "memoryRequestsMissing": {
                "ID": "memoryRequestsMissing",
                "Message": "Memory requests should be set",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Efficiency",
                "Mutations": null
              },
              "notReadOnlyRootFilesystem": {
                "ID": "notReadOnlyRootFilesystem",
                "Message": "Filesystem should be read only",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Security",
                "Mutations": null
              },
              "privilegeEscalationAllowed": {
                "ID": "privilegeEscalationAllowed",
                "Message": "Privilege escalation should not be allowed",
                "Details": null,
                "Success": false,
                "Severity": "danger",
                "Category": "Security",
                "Mutations": null
              },
              "pullPolicyNotAlways": {
                "ID": "pullPolicyNotAlways",
                "Message": "Image pull policy should be \"Always\"",
                "Details": null,
                "Success": false,
                "Severity": "warning",
                "Category": "Reliability",
                "Mutations": [
                  {
                    "Path": "/spec/template/spec/containers/0/imagePullPolicy",
                    "Op": "add",
                    "Value": "Always",
                    "Comment": ""
                  }
                ]
              },
              "readinessProbeMissing": {
                "ID": "readinessProbeMissing",
                "Message": "Readiness probe is configured",
                "Details": null,
                "Success": true,
                "Severity": "warning",
                "Category": "Reliability",
                "Mutations": null
              },
              "runAsPrivileged": {
                "ID": "runAsPrivileged",
                "Message": "Not running as privileged",
                "Details": null,
                "Success": true,
                "Severity": "danger",
                "Category": "Security",
                "Mutations": null
              },
              "runAsRootAllowed": {
                "ID": "runAsRootAllowed",
                "Message": "Should not be allowed to run as root",
                "Details": null,
                "Success": false,
                "Severity": "danger",
                "Category": "Security",
                "Mutations": null
              },
              "sensitiveContainerEnvVar": {
                "ID": "sensitiveContainerEnvVar",
                "Message": "The container does not set potentially sensitive environment variables",
                "Details": null,
                "Success": true,
                "Severity": "danger",
                "Category": "Security",
                "Mutations": null
              },
              "tagNotSpecified": {
                "ID": "tagNotSpecified",
                "Message": "Image tag is specified",
                "Details": null,
                "Success": true,
                "Severity": "danger",
                "Category": "Reliability",
                "Mutations": null
              }
            }
          }
        ]
      },
      "CreatedTime": "0001-01-01T00:00:00Z"
    }
  ],
  "Score": 48
}

🚀 Upload your Polaris findings to Fairwinds Insights to see remediation advice, add teammates, integrate with Slack or Jira, and more:

❯ polaris audit --helm-chart ./mywebapp --helm-values ./values/env/tes/values.yaml --upload-insights --cluster-name=my-cluster
```

</details>

#### pluto

TBD

#### trivy

<details>

<summary>trivy手動実行サンプル</summary>

```
% trivy conf --helm-set-file environment=values/env/tes/values.yaml ./mywebapp/
2024-05-08T12:22:19+09:00       INFO    Misconfiguration scanning is enabled
2024-05-08T12:22:19+09:00       INFO    Need to update the built-in policies
2024-05-08T12:22:19+09:00       INFO    Downloading the built-in policies...
50.41 KiB / 50.41 KiB [------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% ? p/s 100ms
2024-05-08T12:22:20+09:00       INFO    Detected config files   num=3

templates/deployment.yaml (helm)

Tests: 139 (SUCCESSES: 125, FAILURES: 14, EXCEPTIONS: 0)
Failures: 14 (UNKNOWN: 0, LOW: 9, MEDIUM: 3, HIGH: 2, CRITICAL: 0)

MEDIUM: Container 'mywebapp' of Deployment 'mywebapp' should set 'securityContext.allowPrivilegeEscalation' to false
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
A program inside the container can elevate its own privileges and run as root, which might give the program control over the container and node.

See https://avd.aquasec.com/misconfig/ksv001
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


LOW: Container 'mywebapp' of Deployment 'mywebapp' should add 'ALL' to 'securityContext.capabilities.drop'
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
The container should drop all default capabilities and add only those that are needed for its execution.

See https://avd.aquasec.com/misconfig/ksv003
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


LOW: Container 'mywebapp' of Deployment 'mywebapp' should set 'resources.limits.cpu'
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Enforcing CPU limits prevents DoS via resource exhaustion.

See https://avd.aquasec.com/misconfig/ksv011
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


MEDIUM: Container 'mywebapp' of Deployment 'mywebapp' should set 'securityContext.runAsNonRoot' to true
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Force the running image to run as a non-root user to ensure least privileges.

See https://avd.aquasec.com/misconfig/ksv012
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


HIGH: Container 'mywebapp' of Deployment 'mywebapp' should set 'securityContext.readOnlyRootFilesystem' to true
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
An immutable root file system prevents applications from writing to their local disk. This can limit intrusions, as attackers will not be able to tamper with the file system or write foreign executables to disk.

See https://avd.aquasec.com/misconfig/ksv014
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


LOW: Container 'mywebapp' of Deployment 'mywebapp' should set 'resources.requests.cpu'
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
When containers have resource requests specified, the scheduler can make better decisions about which nodes to place pods on, and how to deal with resource contention.

See https://avd.aquasec.com/misconfig/ksv015
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


LOW: Container 'mywebapp' of Deployment 'mywebapp' should set 'resources.requests.memory'
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
When containers have memory requests specified, the scheduler can make better decisions about which nodes to place pods on, and how to deal with resource contention.

See https://avd.aquasec.com/misconfig/ksv016
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


LOW: Container 'mywebapp' of Deployment 'mywebapp' should set 'resources.limits.memory'
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Enforcing memory limits prevents DoS via resource exhaustion.

See https://avd.aquasec.com/misconfig/ksv018
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


LOW: Container 'mywebapp' of Deployment 'mywebapp' should set 'securityContext.runAsUser' > 10000
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Force the container to run with user ID > 10000 to avoid conflicts with the host’s user table.

See https://avd.aquasec.com/misconfig/ksv020
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


LOW: Container 'mywebapp' of Deployment 'mywebapp' should set 'securityContext.runAsGroup' > 10000
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Force the container to run with group ID > 10000 to avoid conflicts with the host’s user table.

See https://avd.aquasec.com/misconfig/ksv021
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


LOW: Either Pod or Container should set 'securityContext.seccompProfile.type' to 'RuntimeDefault'
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
According to pod security standard 'Seccomp', the RuntimeDefault seccomp profile must be required, or allow specific additional profiles.

See https://avd.aquasec.com/misconfig/ksv030
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


MEDIUM: container "mywebapp" of deployment "mywebapp" in "default" namespace should specify a seccomp profile
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
A program inside the container can bypass Seccomp protection policies.

See https://avd.aquasec.com/misconfig/ksv104
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


LOW: container should drop all
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Containers must drop ALL capabilities, and are only permitted to add back the NET_BIND_SERVICE capability.

See https://avd.aquasec.com/misconfig/ksv106
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 templates/deployment.yaml:28-46
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  28 ┌         - name: mywebapp
  29 │           securityContext:
  30 │             {}
  31 │           image: "nginx:1.16.0"
  32 │           imagePullPolicy: IfNotPresent
  33 │           ports:
  34 │             - name: http
  35 │               containerPort: 80
  36 └               protocol: TCP
  ..   
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


HIGH: deployment mywebapp in default namespace should not set spec.template.spec.containers.ports.containerPort to less than 1024
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
The ports which are lower than 1024 receive and transmit various sensitive and privileged data. Allowing containers to use them can bring serious implications.

See https://avd.aquasec.com/misconfig/ksv117
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

</details>

