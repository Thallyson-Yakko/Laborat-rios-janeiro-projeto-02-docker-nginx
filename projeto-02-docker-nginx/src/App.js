import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>🐳 React + Nginx + Docker</h1>
        <p>Aplicação otimizada para produção</p>
        
        <div className="stats">
          <div className="stat-card">
            <h3>Performance</h3>
            <p>Nginx Alpine</p>
          </div>
          <div className="stat-card">
            <h3>Segurança</h3>
            <p>Headers configurados</p>
          </div>
          <div className="stat-card">
            <h3>Compressão</h3>
            <p>Gzip + Brotli</p>
          </div>
        </div>

        <div className="actions">
          <button onClick={() => window.location.href = '/health'}>
            Health Check
          </button>
          <button onClick={() => console.log('Performance:', performance.now())}>
            Performance Test
          </button>
        </div>
      </header>
    </div>
  );
}

export default App;
