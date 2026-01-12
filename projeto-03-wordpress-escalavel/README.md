# Projeto 3: WordPress Escalável na Cloud

## Problema
Uma agência digital precisa hospedar múltiplos sites WordPress para clientes com requisitos de:
- Alta disponibilidade (99.9% uptime)
- Auto scaling baseado em tráfego
- Backup automatizado
- Ambiente multi-stage (dev/staging/prod)
- Custo otimizado (< $100/mês por site)

## Desafio Técnico
Implementar uma arquitetura WordPress escalável usando ECS, RDS Multi-AZ, EFS para arquivos compartilhados, e ALB com SSL termination.

## Arquitetura Proposta
```
Internet → CloudFront → ALB → ECS Fargate (WordPress)
                              ↓
                         RDS Multi-AZ (MySQL)
                              ↓
                         EFS (wp-content)
                              ↓
                         ElastiCache (Redis)
```

## Objetivos de Aprendizado
- Arquitetura multi-tier na AWS
- ECS ou EKS
- RDS Multi-AZ e read replicas
- EFS para storage compartilhado
- CloudFront para CDN
- Monitoramento com CloudWatch
- Backup strategies

## Componentes da Solução
1. **Compute**: ECS Fargate com auto scaling ou EKS
2. **Database**: RDS MySQL Multi-AZ
3. **Storage**: EFS para wp-content
4. **Cache**: ElastiCache Redis
5. **CDN**: CloudFront
6. **Load Balancer**: ALB com SSL
7. **Monitoring**: CloudWatch + SNS
8. **Backup**: RDS snapshots + EFS backup

## Métricas de Sucesso
- RTO < 15 minutos
- RPO < 1 hora
- Auto scaling funcional
- SSL A+ rating
- Performance score > 90
- Custo mensal documentado

## Cenários de Teste
1. Load testing com 1000 usuários simultâneos
2. Failover de AZ
3. Restore de backup
4. Deploy blue/green
5. Scaling up/down automático

## Próximos Passos
1. Revisar arquitetura proposta
2. Customizar configurações WordPress
4. Configurar monitoramento
5. Testar cenários de falha
6. Documentar runbooks operacionais
