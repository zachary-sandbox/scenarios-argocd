# Step2 GitOps 与传统交付模式对比

## 传统CI流水线模式

CI流水线完成源代码编译、构建容器镜像，之后流水线执行命令式的 `kubectl apply` / `kubectl patch`，**直接修改Kubernetes集群资源**。
CI任务中会保存 `kubeconfig`，拥有访问目标Kubernetes集群的完整权限。

>
> **缺点**
>
>
> - 配置变更历史不会保存在Git中，部署变更仅记录在CI任务日志，没有版本化管理。
> - 在集群内临时手动修改的内容无法被追踪；运维执行`kubectl edit`紧急修复问题，这些运行时改动只存在集群内部，Git没有留存记录。
> - 回滚操作容易出错：回滚需要重新运行旧的CI任务，无法保证重新生成的资源清单和上一版完全一致。
> - 凭证泄露风险：CI执行器携带集群访问凭证，一旦CI执行器被攻破，攻击者可接管整个集群。
> - 极易出现环境配置漂移：集群实际运行状态会慢慢和代码仓库中的配置产生差异。

## GitOps模式

1. CI流水线**仅负责构建、推送容器镜像**，不会直接调用Kubernetes API。CI只去更新**Git配置仓库内的镜像标签**，然后将修改提交并推送到Git仓库。
2. Argo‑CD组件（Repo‑Server + Application‑Controller）持续读取Git配置仓库，对比Git中的期望状态和Kubernetes集群的实际运行状态。
3. 检测到差异后，Argo‑CD下发资源清单，让集群向Git定义的期望状态收敛。
4. 所有配置变更都以Git提交形式留存，完整记录修改人、修改时间、变更内容，具备完整审计链路。

>
> **核心优势总结**
>
> - Git作为Kubernetes资源清单的唯一可信源。
> - CI流水线不再保存集群凭证，缩小安全攻击面。
> - 回滚简单高效：执行Git提交回滚，Argo‑CD自动完成集群状态同步。
> - 所有配置变更可以先经过Pull Request评审，再落地到集群。

## 思考题

### 1. CI流水线完全不直接操作Kubernetes API，可以带来哪些好处？

<details>
<summary>参考答案</summary>

1. **提升安全性**：CI执行器不需要Kubernetes的kubeconfig凭证。即便CI流水线或执行器被入侵，攻击者也无法修改Kubernetes集群，大幅缩小攻击面。
2. **职责清晰分离**：CI专注制品构建（编译代码、构建推送镜像）；CD交付能力完全交给集群内部运行的Argo‑CD，构建和部署逻辑解耦。
3. **完整审计追溯**：所有配置修改必须提交到Git，变更记录保存在Git提交历史，而不是分散在各个CI任务日志中。
4. **回滚机制统一可靠**：通过Git回滚提交即可完成业务回滚，不再依赖重新执行旧CI任务，避免重新构建带来的制品不一致问题。
5. **保障多环境一致性**：开发、测试、生产环境全部使用Git仓库的资源清单，避免各个环境写独立的CI部署逻辑。

</details>

### 2. 如果用户直接在集群内手动编辑资源，Argo‑CD开启`self‑heal`（自修复）时会发生什么？

<details>
<summary>参考答案</summary>

当`syncPolicy`中配置 `selfHeal: true`：
1. Argo‑CD协调循环会检测到配置漂移：集群真实资源与Git定义的期望状态不一致，将Application应用标记为`OutOfSync`（不同步）。
2. Argo‑CD会**自动覆盖集群内的手动修改**，把资源恢复为Git清单定义的状态。
3. 用户在集群上手动做的修改会直接丢失。

> 补充说明：如果关闭自修复`selfHeal: false`，Argo‑CD依旧会上报`OutOfSync`状态，但**不会自动撤销集群的手动改动**，需要运维手动触发同步操作，才会恢复为Git中的期望状态。

</details>

参考文档：[https://argo-cd.readthedocs.io/en/stable/user-guide/gitops/](https://argo-cd.readthedocs.io/en/stable/user-guide/gitops/)
