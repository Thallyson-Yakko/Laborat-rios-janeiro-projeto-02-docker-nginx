# Projeto 4: Criação de Grupos e Permissões (IAM RBAC)

## Problema
Uma empresa de tecnologia com 50+ funcionários precisa implementar um sistema de controle de acesso baseado em funções (RBAC) na AWS. Os requisitos são:
- Separação clara de responsabilidades por departamento
- Princípio do menor privilégio
- Auditoria completa de acessos
- Compliance com SOC2 e ISO27001

## Desafio Técnico
Implementar uma estrutura IAM robusta com roles, policies, grupos e usuários que atenda aos requisitos de segurança corporativa.

## Assets Fornecidos
- `policies/` - Policies customizadas por função
- `groups/` - Estrutura de grupos organizacionais
- `docs/` - Documentação de governança

## Estrutura Organizacional
```
Empresa
├── Desenvolvimento
│   ├── Frontend Developers
│   ├── Backend Developers
│   └── DevOps Engineers
├── Operações
│   ├── SysAdmins
│   ├── Database Admins
│   └── Security Team
├── Negócios
│   ├── Product Managers
│   ├── Data Analysts
│   └── Finance Team
└── Terceiros
    ├── Contractors
    └── Auditors
```

## Objetivos de Aprendizado
- IAM best practices
- Policy design patterns
- Service-linked roles
- Permission boundaries
- Access Analyzer
- CloudTrail integration
- Automated compliance checking

## Roles e Responsabilidades

### Desenvolvimento
- **Frontend**: S3, CloudFront, Route53
- **Backend**: Lambda, API Gateway, DynamoDB
- **DevOps**: EC2, ECS, RDS, CloudFormation

### Operações
- **SysAdmin**: EC2, VPC, CloudWatch
- **DBA**: RDS, ElastiCache, backup
- **Security**: IAM, GuardDuty, Config

### Negócios
- **PM**: Read-only em recursos de produto
- **Analyst**: QuickSight, S3 analytics
- **Finance**: Cost Explorer, Billing

## Cenários de Segurança
1. **Onboarding**: Novo funcionário
2. **Role Change**: Mudança de departamento
3. **Offboarding**: Saída de funcionário
4. **Incident Response**: Acesso emergencial
5. **Audit**: Revisão de permissões
6. **Compliance**: Relatórios automáticos

## Métricas de Sucesso
- Zero permissões desnecessárias
- 100% dos acessos auditados
- Tempo de onboarding < 30 minutos
- Compliance score > 95%
- Zero credenciais hardcoded

## Ferramentas de Auditoria
- AWS Access Analyzer
- IAM Policy Simulator
- CloudTrail analysis
- Custom compliance scripts
- Automated reporting

## Próximos Passos
1. Mapear estrutura organizacional atual
2. Definir policies por função
3. Implementar grupos e roles
4. Configurar auditoria e monitoramento
5. Testar cenários de acesso
6. Documentar procedimentos operacionais
