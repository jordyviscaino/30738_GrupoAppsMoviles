const pool = require('../config/database');

const PlatoModel = {
  async obtenerTodos() {
    const result = await pool.query(
      'SELECT * FROM platos ORDER BY id ASC'
    );
    return result.rows;
  },

  async obtenerPorId(id) {
    const result = await pool.query(
      'SELECT * FROM platos WHERE id = $1',
      [id]
    );
    return result.rows[0];
  },

  async crear(plato) {
    const { nombre, descripcion, precio, disponible } = plato;

    const result = await pool.query(
      `INSERT INTO platos (nombre, descripcion, precio, disponible)
       VALUES ($1, $2, $3, $4)
       RETURNING *`,
      [nombre, descripcion, precio, disponible]
    );

    return result.rows[0];
  },

  async actualizar(id, plato) {
    const { nombre, descripcion, precio, disponible } = plato;

    const result = await pool.query(
      `UPDATE platos
       SET nombre = $1,
           descripcion = $2,
           precio = $3,
           disponible = $4
       WHERE id = $5
       RETURNING *`,
      [nombre, descripcion, precio, disponible, id]
    );

    return result.rows[0];
  },

  async eliminar(id) {
    const result = await pool.query(
      'DELETE FROM platos WHERE id = $1 RETURNING *',
      [id]
    );

    return result.rows[0];
  }
};

module.exports = PlatoModel;