# 🎓 SPEC: CI/CD Completo - GitHub Actions + GCP + ArgoCD

> **Tech Lead para Junior:** Vou te ensinar passo a passo como funciona nosso pipeline de CI/CD

---

## 📚 Índice

1. [Visão Geral](#visão-geral)
2. [Conceitos Fundamentais](#conceitos-fundamentais)
3. [Arquitetura do Pipeline](#arquitetura-do-pipeline)
4. [Workflows Terraform](#workflows-terraform)
5. [Workflow de Deploy](#workflow-de-deploy)
6. [Configuração Inicial](#configuração-inicial)
7. [Troubleshooting](#troubleshooting)

---

## 🎯 Visão Geral

### O que vamos construir?

Um sistema automatizado que:
1. **Gerencia infraestrutura** (Terraform) com botões no GitHub
2. **Faz build de imagens Docker** automaticamente
3. **Envia imagens para GCP** (Artifact Registry)
4. **Deploya no Kubernetes** via ArgoCD

### Por que separar em workflows?

**Analogia:** É como ter controles separados no carro:
- **Terraform Init** = Ligar o motor
- **Terraform Plan** = Ver o mapa antes de dirigir
- **Terraform Apply** = Acelerar e ir
- **Terraform Destroy** = Desligar tudo

**Vantagem:** Você tem controle total e pode revisar antes de aplicar mudanças.

---

## 💡 Conceitos Fundamentais

### 1. GitHub Actions

**O que é?**
- Robô que executa tarefas automaticamente no GitHub
- Você escreve instruções em arquivos YAML
- Ele executa quando você pede (ou quando algo acontece)

**Analogia:**
```
GitHub Actions = Assistente pessoal
Workflow = Lista de tarefas
Job = Tarefa específica
Step = Passo da tarefa
```

### 2. Workflow Dispatch

**O que é?**
- Botão manual para executar workflow
- Você clica e escolhe opções

**Exemplo visual:**
```
┌─────────────────────────────────┐
│  Run workflow                   │
├─────────────────────────────────┤
│  Environment: [dev ▼]           │
│  Confirm: [_________]           │
│                                 │
│  [Run workflow]                 │
└─────────────────────────────────┘
```

### 3. Artifact Registry (GCP)

**O que é?**
- "Prateleira" onde guardamos imagens Docker
- Fica no Google Cloud
- Kubernetes pega imagens daqui

**Analogia:**
```
Docker Hub = Biblioteca pública
Artifact Registry = Sua biblioteca privada
```

**Formato do endereço:**
```
us-central1-docker.pkg.dev/meu-projeto/react-nginx/app:v1.0.0
│                          │              │            │    │
└─ Região                  └─ Projeto     └─ Repo      └─ Imagem:Tag
```

### 4. ArgoCD

**O que é?**
- Robô que monitora Git e atualiza Kubernetes
- Você muda arquivo no Git → ArgoCD aplica no cluster

**Analogia:**
```
Git = Planta da casa
ArgoCD = Construtor que segue a planta
Kubernetes = Casa sendo construída
```

**Fluxo:**
```
1. Você muda deployment.yaml no Git
2. ArgoCD vê a mudança (a cada 3 min)
3. ArgoCD aplica no Kubernetes
4. Kubernetes atualiza os pods
```

---

## 🏗️ Arquitetura do Pipeline

### Visão Completa

```
┌─────────────────────────────────────────────────────────────────┐
│                    DESENVOLVEDOR                                │
│  1. Escreve código                                              │
│  2. Faz commit e push                                           │
└─────────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────────┐
│                    GITHUB ACTIONS                               │
│                                                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Terraform    │  │ Build Image  │  │ Push Image   │         │
│  │ (Manual)     │  │ (Automático) │  │ (Automático) │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
└─────────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────────┐
│                    GOOGLE CLOUD                                 │
│                                                                 │
│  ┌──────────────────┐         ┌──────────────────┐            │
│  │ Artifact Registry│         │ GKE Cluster      │            │
│  │ (Imagens Docker) │────────▶│ (Kubernetes)     │            │
│  └──────────────────┘         └──────────────────┘            │
└─────────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────────┐
│                    ARGOCD                                       │
│                                                                 │
│  1. Monitora Git (deployment.yaml)                             │
│  2. Detecta nova tag de imagem                                 │
│  3. Aplica mudança no Kubernetes                               │
│  4. Kubernetes faz rolling update                              │
└─────────────────────────────────────────────────────────────────┘
```

### Fluxo Detalhado

#### Cenário 1: Criar Infraestrutura (Primeira vez)

```
Você → GitHub Actions → GCP
│
├─ 1. Clica "Terraform Init"
│   └─ Baixa providers (google, kubernetes, helm)
│
├─ 2. Clica "Terraform Plan"
│   └─ Mostra o que vai criar (VPC, GKE, etc)
│
└─ 3. Clica "Terraform Apply"
    └─ Cria tudo no GCP (demora ~15min)
```

#### Cenário 2: Deploy de Aplicação (Dia a dia)

```
Você → Git → GitHub Actions → GCP → ArgoCD → Kubernetes
│
├─ 1. Altera código da aplicação
│   └─ Ex: muda cor do botão
│
├─ 2. Faz commit e push
│   └─ git push origin main
│
├─ 3. GitHub Actions detecta push
│   ├─ Faz build da imagem Docker
│   ├─ Testa a imagem
│   └─ Envia para Artifact Registry
│
├─ 4. GitHub Actions atualiza deployment.yaml
│   └─ Muda tag: app:v1.0.0 → app:v1.0.1
│
├─ 5. ArgoCD detecta mudança (3 min)
│   └─ "Opa, deployment.yaml mudou!"
│
└─ 6. ArgoCD aplica no Kubernetes
    ├─ Kubernetes baixa nova imagem
    ├─ Cria novos pods
    ├─ Testa se estão saudáveis
    └─ Remove pods antigos
```

---

## 🔧 Workflows Terraform

### Por que 4 workflows separados?

**Analogia com carro:**
```
Init    = Ligar o motor (preparar)
Plan    = Ver GPS (planejar rota)
Apply   = Dirigir (executar)
Destroy = Desligar tudo (limpar)
```

**Vantagem:**
- ✅ Você revisa antes de aplicar
- ✅ Pode cancelar se algo estiver errado
- ✅ Logs separados (fácil debugar)
- ✅ Segurança (confirmação obrigatória)

### Workflow 1: Terraform Init

**Quando usar?**
- Primeira vez que vai usar Terraform
- Depois de adicionar novo provider
- Se apagar pasta `.terraform`

**O que faz?**
```yaml
1. Checkout do código
   └─ Baixa seu repositório

2. Autentica no GCP
   └─ Usa service account (chave JSON)

3. Instala Terraform
   └─ Versão específica (ex: 1.5.0)

4. Executa terraform init
   ├─ Baixa provider do Google
   ├─ Baixa provider do Kubernetes
   └─ Baixa provider do Helm

5. Salva .terraform como artifact
   └─ Para usar nos próximos workflows
```

**Exemplo prático:**
```bash
# O que o workflow faz internamente:
cd terraform/
terraform init

# Output:
Initializing provider plugins...
- Finding hashicorp/google versions...
- Installing hashicorp/google v5.45.0...
✓ Success!
```

**Artifact gerado:**
```
terraform-dev/
└─ .terraform/
   └─ providers/
      └─ registry.terraform.io/
         └─ hashicorp/
            └─ google/
               └─ 5.45.0/
                  └─ terraform-provider-google_v5.45.0
```

### Workflow 2: Terraform Plan

**Quando usar?**
- Antes de aplicar mudanças
- Para revisar o que vai acontecer
- Em code review (PR)

**O que faz?**
```yaml
1. Baixa artifact do Init
   └─ Pega .terraform/ salvo

2. Executa terraform plan
   ├─ Lê arquivos .tf
   ├─ Compara com estado atual
   └─ Gera plano de execução

3. Salva plano como artifact
   └─ Arquivo tfplan

4. (Opcional) Comenta no PR
   └─ Mostra preview das mudanças
```

**Exemplo de output:**
```
Terraform will perform the following actions:

  # google_container_cluster.primary will be created
  + resource "google_container_cluster" "primary" {
      + name     = "gke-cluster"
      + location = "us-central1"
      + node_config {
          + machine_type = "e2-medium"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

**Interpretando o plano:**
```
+ = Vai criar
~ = Vai modificar
- = Vai deletar
```

### Workflow 3: Terraform Apply

**Quando usar?**
- Depois de revisar o plan
- Quando tiver certeza das mudanças

**O que faz?**
```yaml
1. Verifica confirmação
   └─ Você digitou "apply"?

2. Baixa artifact do Plan
   └─ Pega arquivo tfplan

3. Executa terraform apply
   └─ Aplica mudanças no GCP

4. Notifica sucesso/erro
```

**Segurança:**
```yaml
if: ${{ inputs.confirm == 'apply' }}
```
- Se você não digitar "apply", não executa
- Previne acidentes

**Tempo de execução:**
```
VPC: ~2 min
GKE Cluster: ~10-15 min
Artifact Registry: ~1 min
Total: ~15-20 min
```

### Workflow 4: Terraform Destroy

**Quando usar?**
- Fim do dia (ambiente dev)
- Deletar ambiente de teste
- Economizar custos

**⚠️ CUIDADO:**
- Deleta TUDO
- Não tem volta
- Use apenas em dev/staging

**O que faz?**
```yaml
1. Verifica confirmação
   └─ Você digitou "destroy"?

2. Executa terraform destroy
   ├─ Deleta GKE cluster
   ├─ Deleta VPC
   ├─ Deleta tudo criado
   └─ Libera IPs

3. Notifica conclusão
```

---

## 📦 Workflow de Deploy (Aplicação)

### Trigger: Push na main

**Quando executa?**
```yaml
on:
  push:
    branches: [main]
```
- Toda vez que você faz push na branch main
- Automático (não precisa clicar)

### Steps Detalhados

#### Step 1: Checkout
```yaml
- uses: actions/checkout@v3
```

**O que faz:**
- Baixa seu código do GitHub
- Coloca na máquina virtual do Actions

**Analogia:**
- É como fazer `git clone` do seu repo

#### Step 2: Autenticação GCP
```yaml
- uses: google-github-actions/auth@v1
  with:
    credentials_json: ${{ secrets.GCP_SA_KEY }}
```

**O que faz:**
- Faz login no Google Cloud
- Usa service account (robô do GCP)

**Por que precisa:**
- Para enviar imagem ao Artifact Registry
- Para acessar recursos do GCP

**Service Account:**
```json
{
  "type": "service_account",
  "project_id": "meu-projeto",
  "private_key": "-----BEGIN PRIVATE KEY-----\n...",
  "client_email": "github-actions@meu-projeto.iam.gserviceaccount.com"
}
```

#### Step 3: Configurar Docker
```yaml
- run: gcloud auth configure-docker us-central1-docker.pkg.dev
```

**O que faz:**
- Configura Docker para usar Artifact Registry
- Adiciona credenciais no Docker

**Analogia:**
- É como fazer login no Docker Hub
- Mas para o Artifact Registry do GCP

#### Step 4: Build da Imagem
```yaml
- run: |
    docker build -t $IMAGE:$TAG .
```

**O que faz:**
- Lê o Dockerfile
- Cria imagem Docker
- Adiciona tag (versão)

**Exemplo:**
```bash
docker build -t us-central1-docker.pkg.dev/meu-projeto/react-nginx/app:v1.0.0 .
```

**Processo interno:**
```
1. FROM node:18 AS builder
   └─ Baixa imagem base do Node

2. COPY package*.json ./
   └─ Copia arquivos de dependências

3. RUN npm install
   └─ Instala dependências

4. RUN npm run build
   └─ Faz build do React

5. FROM nginx:alpine
   └─ Imagem final (pequena)

6. COPY --from=builder /app/build /usr/share/nginx/html
   └─ Copia build para nginx
```

#### Step 5: Push da Imagem
```yaml
- run: docker push $IMAGE:$TAG
```

**O que faz:**
- Envia imagem para Artifact Registry
- Fica disponível para Kubernetes

**Processo:**
```
1. Comprime imagem em layers
2. Envia cada layer
3. Artifact Registry armazena
4. Gera URL da imagem
```

**Resultado:**
```
us-central1-docker.pkg.dev/meu-projeto/react-nginx/app:v1.0.0
└─ Imagem disponível para pull
```

#### Step 6: Atualizar Manifesto K8s
```yaml
- run: |
    sed -i "s|image:.*|image: $IMAGE:$TAG|" k8s/deployment.yaml
    git add k8s/deployment.yaml
    git commit -m "Update image to $TAG"
    git push
```

**O que faz:**
- Abre deployment.yaml
- Troca tag antiga por nova
- Faz commit e push

**Antes:**
```yaml
spec:
  containers:
  - name: app
    image: us-central1-docker.pkg.dev/.../app:v1.0.0
```

**Depois:**
```yaml
spec:
  containers:
  - name: app
    image: us-central1-docker.pkg.dev/.../app:v1.0.1
```

**Por que fazer isso:**
- ArgoCD monitora Git
- Vê mudança no deployment.yaml
- Aplica automaticamente no cluster

---

Continua na próxima parte...
