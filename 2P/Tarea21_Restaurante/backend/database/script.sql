DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS platos;

CREATE TABLE platos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio NUMERIC(10, 2) NOT NULL CHECK (precio > 0),
    disponible BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente VARCHAR(100) NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    total NUMERIC(10, 2) NOT NULL CHECK (total >= 0),
    plato_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_plato
        FOREIGN KEY (plato_id)
        REFERENCES platos(id)
        ON DELETE RESTRICT
);

INSERT INTO platos (nombre, descripcion, precio, disponible)
VALUES
('Hamburguesa clásica', 'Hamburguesa con carne, queso, lechuga y tomate', 3.50, TRUE),
('Pizza personal', 'Pizza pequeña con queso y pepperoni', 4.25, TRUE),
('Ensalada César', 'Ensalada con pollo, lechuga, crutones y aderezo César', 3.00, TRUE),
('Jugo natural', 'Jugo de fruta natural del día', 1.50, TRUE),
('Lasagna', 'Porción de lasagna de carne con queso', 4.75, FALSE);