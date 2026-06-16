const express = require('express');
const PedidoController = require('../controllers/pedido.controller');

const router = express.Router();

router.get('/', PedidoController.obtenerPedidos);
router.get('/:id', PedidoController.obtenerPedidoPorId);
router.post('/', PedidoController.crearPedido);
router.put('/:id', PedidoController.actualizarPedido);
router.delete('/:id', PedidoController.eliminarPedido);

module.exports = router;