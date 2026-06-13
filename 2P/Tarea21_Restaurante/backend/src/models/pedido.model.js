const pool = require('../config/database');

const PedidoModel = {
  async obtenerTodos() {
    const result = await pool.query(
      `SELECT 
          pedidos.id,
          pedidos.cliente,
          pedidos.fecha,
          pedidos.cantidad,
          pedidos.total,
          pedidos.plato_id,
          platos.nombre AS plato_nombre,
          platos.precio AS plato_precio
       FROM pedidos
       INNER JOIN platos ON pedidos.plato_id = platos.id
       ORDER BY pedidos.id ASC`
    );

    return result.rows;
  },

  async obtenerPorId(id) {
    const result = await pool.query(
      `SELECT 
          pedidos.id,
          pedidos.cliente,
          pedidos.fecha,
          pedidos.cantidad,
          pedidos.total,
          pedidos.plato_id,
          platos.nombre AS plato_nombre,
          platos.precio AS plato_precio
       FROM pedidos
       INNER JOIN platos ON pedidos.plato_id = platos.id
       WHERE pedidos.id = $1`,
      [id]
    );

    return result.rows[0];
  },

  async crear(pedido) {
    const { cliente, cantidad, plato_id } = pedido;

    const platoResult = await pool.query(
      'SELECT * FROM platos WHERE id = $1',
      [plato_id]
    );

    const plato = platoResult.rows[0];

    if (!plato) {
      throw new Error('El plato seleccionado no existe');
    }

    if (!plato.disponible) {
      throw new Error('No se puede pedir un plato no disponible');
    }

    const total = Number(plato.precio) * Number(cantidad);

    const result = await pool.query(
      `INSERT INTO pedidos (cliente, cantidad, total, plato_id)
       VALUES ($1, $2, $3, $4)
       RETURNING *`,
      [cliente, cantidad, total, plato_id]
    );

    return result.rows[0];
  },

  async actualizar(id, pedido) {
    const { cliente, cantidad, plato_id } = pedido;

    const platoResult = await pool.query(
      'SELECT * FROM platos WHERE id = $1',
      [plato_id]
    );

    const plato = platoResult.rows[0];

    if (!plato) {
      throw new Error('El plato seleccionado no existe');
    }

    if (!plato.disponible) {
      throw new Error('No se puede pedir un plato no disponible');
    }

    const total = Number(plato.precio) * Number(cantidad);

    const result = await pool.query(
      `UPDATE pedidos
       SET cliente = $1,
           cantidad = $2,
           total = $3,
           plato_id = $4
       WHERE id = $5
       RETURNING *`,
      [cliente, cantidad, total, plato_id, id]
    );

    return result.rows[0];
  },

  async eliminar(id) {
    const result = await pool.query(
      'DELETE FROM pedidos WHERE id = $1 RETURNING *',
      [id]
    );

    return result.rows[0];
  }
};

module.exports = PedidoModel;