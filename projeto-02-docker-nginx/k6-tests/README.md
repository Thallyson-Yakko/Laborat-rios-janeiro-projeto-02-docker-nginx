# Testes de Carga com k6 - React Nginx

Testes de performance e stress realizados em aplicação React servida por Nginx em cluster Kubernetes local.

## 📊 Resultados dos Testes

### Teste 1: Básico (2 minutos)
- **VUs:** 20 → 50
- **Requisições:** 3.149
- **Taxa:** 26 req/s
- **P95:** 4.89ms
- **Erros:** 0%

### Teste 2: Stress (5 minutos)
- **VUs:** 100 → 200
- **Requisições:** 71.208
- **Taxa:** 237 req/s
- **P95:** 9.55ms
- **Erros:** 0%

### Teste 3: Extremo (9 minutos)
- **VUs:** 500 → 1000
- **Requisições:** 3.043.345
- **Taxa:** 5.634 req/s
- **P95:** 8.91ms
- **Erros:** 0%

## 🚀 Como Executar

### Pré-requisitos
```bash
# Instalar k6
brew install k6

# Cluster Kubernetes rodando
kubectl get nodes

# Port-forward para aplicação
kubectl port-forward -n app svc/react-nginx 8080:80
```

### Executar Testes

```bash
# Teste básico
k6 run load-test.js

# Teste de stress
k6 run load-test-stress.js

# Teste extremo
k6 run load-test-extreme.js
```

## 📈 Monitoramento

```bash
# Ver HPA
kubectl get hpa -n app

# Ver uso de recursos
kubectl top pods -n app

# Monitorar em tempo real
watch -n 2 'kubectl get hpa -n app && kubectl top pods -n app'
```

## 🎯 Conclusões

- Aplicação suportou **1000 VUs simultâneos** sem erros
- CPU manteve-se em **1%** durante todos os testes
- HPA não foi acionado (threshold: 50% CPU)
- Nginx estático é extremamente eficiente
- Cluster pode suportar **10x+ mais carga**

## 💡 Recomendações

1. HPA baseado em CPU não é adequado para nginx estático
2. Considerar métricas customizadas (RPS, latência)
3. Recursos atuais estão super dimensionados
4. Aplicação pronta para produção

## 📁 Arquivos

- `load-test.js` - Teste básico
- `load-test-stress.js` - Teste de stress
- `load-test-extreme.js` - Teste extremo
- `load-test-report.md` - Relatório teste básico
- `extreme-test-report.md` - Relatório teste extremo
