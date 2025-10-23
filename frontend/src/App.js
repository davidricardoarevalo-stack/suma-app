import React, { useState } from 'react';
import axios from 'axios';
import './App.css';

function App() {
  const [num1, setNum1] = useState('');
  const [num2, setNum2] = useState('');
  const [resultado, setResultado] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  // URL base de la API
  const API_URL = process.env.REACT_APP_API_URL || 
    (process.env.NODE_ENV === 'production' ? '' : 'http://localhost:5000');

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    setResultado(null);

    try {
      // Convertir a números
      const numero1 = parseFloat(num1);
      const numero2 = parseFloat(num2);

      // Validar que sean números válidos
      if (isNaN(numero1) || isNaN(numero2)) {
        setError('Por favor, ingresa números válidos');
        setLoading(false);
        return;
      }

      // Hacer petición al backend
      const response = await axios.post(`${API_URL}/api/sum`, {
        num1: numero1,
        num2: numero2
      });

      setResultado(response.data);
    } catch (err) {
      setError('Error al conectar con el servidor');
      console.error('Error:', err);
    } finally {
      setLoading(false);
    }
  };

  const limpiarFormulario = () => {
    setNum1('');
    setNum2('');
    setResultado(null);
    setError('');
  };

  return (
    <div className="App">
      <div className="container">
        <h1>🧮 Calculadora de Suma</h1>
        <p>Ingresa dos números y obtén el resultado de su suma</p>
        
        <form onSubmit={handleSubmit} className="suma-form">
          <div className="input-group">
            <label htmlFor="num1">Primer número:</label>
            <input
              type="number"
              id="num1"
              value={num1}
              onChange={(e) => setNum1(e.target.value)}
              placeholder="Ej: 5"
              required
              step="any"
            />
          </div>

          <div className="input-group">
            <label htmlFor="num2">Segundo número:</label>
            <input
              type="number"
              id="num2"
              value={num2}
              onChange={(e) => setNum2(e.target.value)}
              placeholder="Ej: 3"
              required
              step="any"
            />
          </div>

          <div className="button-group">
            <button type="submit" disabled={loading} className="btn-primary">
              {loading ? 'Calculando...' : 'Sumar'}
            </button>
            <button type="button" onClick={limpiarFormulario} className="btn-secondary">
              Limpiar
            </button>
          </div>
        </form>

        {error && (
          <div className="error">
            ❌ {error}
          </div>
        )}

        {resultado && (
          <div className="resultado">
            <h2>✅ Resultado</h2>
            <div className="operacion">
              <span className="numero">{resultado.num1}</span>
              <span className="operador">+</span>
              <span className="numero">{resultado.num2}</span>
              <span className="igual">=</span>
              <span className="resultado-valor">{resultado.resultado}</span>
            </div>
            <p className="mensaje">{resultado.mensaje}</p>
          </div>
        )}
      </div>
    </div>
  );
}

export default App;