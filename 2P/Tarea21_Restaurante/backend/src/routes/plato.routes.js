const express = require('express');
const PlatoController = require('../controllers/plato.controller');

const router = express.Router();

router.get('/', PlatoController.obtenerPlatos);
router.get('/:id', PlatoController.obtenerPlatoPorId);
router.post('/', PlatoController.crearPlato);
router.put('/:id', PlatoController.actualizarPlato);
router.delete('/:id', PlatoController.eliminarPlato);

module.exports = router;