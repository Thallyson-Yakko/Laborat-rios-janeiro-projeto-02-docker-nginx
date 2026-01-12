# Laboratório DevOps & Cloud AWS
## Baseado no AWS Well-Architected Framework

Este laboratório contém 4 projetos práticos que desenvolvem competências essenciais em DevOps e Cloud AWS, seguindo os 6 pilares do AWS Well-Architected Framework para formar profissionais completos em infraestrutura moderna.

## Projetos do Laboratório

### [Projeto 1: Landing Page Estática de Alta Performance](./projeto-01-landing-page-estatica/)
**Pilares:** Segurança, Performance, Custos, Sustentabilidade  
**Competências Técnicas:**
- S3 static hosting com security headers
- CloudFront CDN global com cache otimizado
- Certificate Manager para SSL/TLS
- Cost optimization para sites estáticos

### [Projeto 2: Dockerizando Aplicação com Nginx](./projeto-02-docker-nginx/)
**Pilares:** Confiabilidade, Performance, Custos, Sustentabilidade, Excelência Operacional  
**Competências Técnicas:**
- Multi-stage Docker builds otimizados
- Nginx performance tuning
- Container security e non-root users
- Health checks e graceful shutdowns
- Image optimization

### [Projeto 3: WordPress Escalável na Cloud](./projeto-03-wordpress-escalavel/)
**Pilares:** Todos os 6 pilares  
**Competências Técnicas:**
- EC2 com ASG para auto scaling
- RDS Multi-AZ
- EFS para storage compartilhado
- ALB com SSL termination

### [Projeto 4: IAM Role-Based Access Control](./projeto-04-iam-rbac/)
**Pilares:** Segurança, Custos, Excelência Operacional  
**Competências Técnicas:**
- IAM policies com least privilege
- CloudTrail para auditoria completa
- Automated compliance checking


## Critérios de Avaliação Well-Architected

Cada projeto será avaliado usando as lentes do Well-Architected:

### **Security Scorecard**
- [ ] Encryption in transit e at rest
- [ ] Least privilege access
- [ ] Security monitoring
- [ ] Incident response plan

### **Reliability Scorecard**
- [ ] Multi-AZ deployment
- [ ] Automated backup/restore
- [ ] Health monitoring
- [ ] Failure testing

### **Performance Scorecard**
- [ ] Load testing results
- [ ] Monitoring dashboards
- [ ] Optimization evidence
- [ ] Scalability validation

### **Cost Scorecard**
- [ ] Resource right-sizing
- [ ] Cost monitoring setup
- [ ] Optimization recommendations
- [ ] Budget alerts configured

### **Sustainability Scorecard**
- [ ] Resource efficiency metrics
- [ ] Serverless adoption
- [ ] Lifecycle policies
- [ ] Carbon impact awareness

### **Operational Excellence Scorecard**
- [ ] IaC implementation
- [ ] Automated deployments
- [ ] Comprehensive monitoring
- [ ] Documentation quality