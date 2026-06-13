const express = require('express');
const cors = require('cors');
require('dotenv').config();

// Esto importa la conexión para probar que PostgreSQL conecte
require('./config/database');

const platoRoutes = require('./routes/plato.routes');
const pedidoRoutes = require('./routes/pedido.routes');

const app = express();

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    mensaje: 'API REST Restaurante funcionando correctamente'
  });
});

app.use('/api/platos', platoRoutes);
app.use('/api/pedidos', pedidoRoutes);

module.exports = app;