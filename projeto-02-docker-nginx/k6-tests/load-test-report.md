# Relatório de Teste de Carga - React Nginx

## Resumo do Teste

**Data:** 26/02/2026  
**Duração:** 2 minutos  
**Ferramenta:** k6

## Configuração do Teste

- **Ramp-up:** 30s até 20 VUs
- **Pico:** 1min com 50 VUs
- **Ramp-down:** 30s até 0 VUs

## Resultados

### Performance
- **Total de requisições:** 3.149
- **Taxa de requisições:** 26.15 req/s
- **Duração média:** 2.59ms
- **P95:** 4.89ms
- **P90:** 3.99ms
- **Máximo:** 20.7ms

### Thresholds
✅ **P95 < 500ms:** PASSOU (4.89ms)  
✅ **Taxa de erro < 10%:** PASSOU (0%)

### Checks
✅ **Status 200:** 100% (3.149/3.149)  
✅ **Tempo de resposta < 500ms:** 100% (3.149/3.149)

### Recursos
- **CPU por pod:** 1m (muito baixo)
- **Memória por pod:** 5Mi
- **Réplicas ativas:** 3/3
- **HPA configurado:** Sim (min: 3, max: 10, target: 50% CPU)

## Análise

### Pontos Positivos
- Aplicação respondeu com 0% de erros
- Latência extremamente baixa (P95: 4.89ms)
- Recursos bem dimensionados
- HPA configurado e pronto para escalar

### Observações
- CPU muito baixa (1m) indica que a aplicação suporta muito mais carga
- HPA não foi acionado durante o teste (CPU target: 50%)
- Aplicação estática (nginx) tem performance excelente

## Próximos Passos

1. **Aumentar carga:** Testar com 200-500 VUs para verificar limite
2. **Testar HPA:** Aumentar carga para acionar autoscaling
3. **Teste de duração:** Executar teste de 10-30min (soak test)
4. **Teste de spike:** Simular picos súbitos de tráfego
