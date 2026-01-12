# Projeto 2: Dockerizando Aplicação Estática com Nginx

## Problema
Uma equipe de desenvolvimento precisa containerizar uma aplicação web estática para:
- Padronizar o ambiente de desenvolvimento e produção
- Facilitar deploys em qualquer infraestrutura
- Otimizar performance com Nginx
- Reduzir o tamanho da imagem Docker para menos de 50MB

## Desafio Técnico
Criar uma imagem Docker otimizada usando multi-stage build e Nginx Alpine que sirva arquivos estáticos com máxima performance.

## Assets Fornecidos
- `src/` - Aplicação React buildada (HTML, CSS, JS)
- `nginx.conf` - Configuração otimizada do Nginx
- `Dockerfile` - Template para multi-stage build
- `docker-compose.yml` - Orquestração local
- `.dockerignore` - Arquivos a serem ignorados
- `scripts/` - Scripts de build e deploy

## Objetivos de Aprendizado
- Multi-stage Docker builds
- Otimização de imagens Docker
- Configuração do Nginx
- Compressão gzip
- Security headers
- Health checks em containers

## Cenários de Teste
1. Build local da imagem
2. Teste de performance com k6
3. Verificação de security headers
4. Teste de health check
5. Deploy em ambiente de staging