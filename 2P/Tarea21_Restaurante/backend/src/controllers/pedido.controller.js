const PedidoModel = require('../models/pedido.model');

const PedidoController = {
  async obtenerPedidos(req, res) {
    try {
      const pedidos = await PedidoModel.obtenerTodos();
      res.json(pedidos);
    } catch (error) {
      res.status(500).json({
        mensaje: 'Error al obtener los pedidos',
        error: error.message
      });
    }
  },

  async obtenerPedidoPorId(req, res) {
    try {
      const { id } = req.params;
      const pedido = await PedidoModel.obtenerPorId(id);

      if (!pedido) {
        return res.status(404).json({
          mensaje: 'Pedido no encontrado'
        });
      }

      res.json(pedido);
    } catch (error) {
      res.status(500).json({
        mensaje: 'Error al obtener el pedido',
        error: error.message
      });
    }
  },

  async crearPedido(req, res) {
    try {
      const { cliente, cantidad, plato_id } = req.body;

      if (!cliente || !cantidad || !plato_id) {
        return res.status(400).json({
          mensaje: 'El cliente, la cantidad y el plato_id son obligatorios'
        });
      }

      if (cantidad <= 0) {
        return res.status(400).json({
          mensaje: 'La cantidad debe ser mayor a 0'
        });
      }

      const nuevoPedido = await PedidoModel.crear({
        cliente,
        cantidad,
        plato_id
      });

      res.status(201).json({
        mensaje: 'Pedido creado correctamente',
        pedido: nuevoPedido
      });
    } catch (error) {
      res.status(400).json({
        mensaje: 'Error al crear el pedido',
        error: error.message
      });
    }
  },

  async actualizarPedido(req, res) {
    try {
      const { id } = req.params;
      const { cliente, cantidad, plato_id } = req.body;

      if (!cliente || !cantidad || !plato_id) {
        return res.status(400).json({
          mensaje: 'El cliente, la cantidad y el plato_id son obligatorios'
        });
      }

      if (cantidad <= 0) {
        return res.status(400).json({
          mensaje: 'La cantidad debe ser mayor a 0'
        });
      }

      const pedidoActualizado = await PedidoModel.actualizar(id, {
        cliente,
        cantidad,
        plato_id
      });

      if (!pedidoActualizado) {
        return res.status(404).json({
          mensaje: 'Pedido no encontrado'
        });
      }

      res.json({
        mensaje: 'Pedido actualizado correctamente',
        pedido: pedidoActualizado
      });
    } catch (error) {
      res.status(400).json({
        mensaje: 'Error al actualizar el pedido',
        error: error.message
      });
    }
  },

  async eliminarPedido(req, res) {
    try {
      const { id } = req.params;
      const pedidoEliminado = await PedidoModel.eliminar(id);

      if (!pedidoEliminado) {
        return res.status(404).json({
          mensaje: 'Pedido no encontrado'
        });
      }

      res.json({
        mensaje: 'Pedido eliminado correctamente',
        pedido: pedidoEliminado
      });
    } catch (error) {
      res.status(500).json({
        mensaje: 'Error al eliminar el pedido',
        error: error.message
      });
    }
  }
};

module.exports = PedidoController;