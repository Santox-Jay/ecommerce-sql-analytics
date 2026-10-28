
-- E-commerce SQL Analytics
-- 02 - Load sample data
-- Dados ficticios para fins de estudo

INSERT INTO customers (name, email, city, state, created_at)
VALUES
    ('Ana Silva', 'ana@email.com', 'São Paulo', 'SP', '2026-01-10'),
    ('Bruno Santos', 'bruno@email.com', 'Santo André', 'SP', '2026-01-15'),
    ('Carla Oliveira', 'carla@email.com', 'Rio de Janeiro', 'RJ', '2026-02-02'),
    ('Diego Costa', 'diego@email.com', 'Curitiba', 'PR', '2026-02-20'),
    ('Eduarda Lima', 'eduarda@email.com', 'São Paulo', 'SP', '2026-03-05'),
    ('Felipe Rocha', 'felipe@email.com', 'Belo Horizonte', 'MG', '2026-03-12'),
    ('Gabriela Alves', 'gabi@email.com', 'Santos', 'SP', '2026-04-01'),
    ('Henrique Souza', 'henrique@email.com', 'Campinas', 'SP', '2026-04-15');

INSERT INTO products (product_name, category, price)
VALUES
    ('Notebook', 'Eletrônicos', 3500.00),
    ('Mouse sem fio', 'Acessórios', 120.00),
    ('Teclado mecânico', 'Acessórios', 280.00),
    ('Monitor 27 polegadas', 'Eletrônicos', 1200.00),
    ('Cadeira ergonômica', 'Móveis', 950.00),
    ('Webcam HD', 'Eletrônicos', 230.00),
    ('Headset', 'Acessórios', 180.00),
    ('Mesa para escritório', 'Móveis', 750.00);

INSERT INTO orders (customer_id, order_date, status)
VALUES
    (1, '2026-04-01 10:00:00', 'delivered'),
    (2, '2026-04-02 11:30:00', 'delivered'),
    (1, '2026-04-10 14:00:00', 'delivered'),
    (3, '2026-04-12 09:15:00', 'shipped'),
    (4, '2026-04-15 16:20:00', 'cancelled'),
    (5, '2026-04-20 13:00:00', 'paid'),
    (2, '2026-05-02 10:45:00', 'delivered'),
    (6, '2026-05-08 15:10:00', 'pending'),
    (7, '2026-05-12 12:00:00', 'delivered'),
    (1, '2026-05-20 17:30:00', 'delivered'),
    (8, '2026-05-25 08:50:00', 'cancelled'),
    (3, '2026-06-03 11:00:00', 'delivered');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 3500.00),
    (1, 2, 2, 120.00),
    (2, 3, 1, 280.00),
    (2, 7, 1, 180.00),
    (3, 4, 1, 1200.00),
    (3, 2, 1, 120.00),
    (4, 6, 2, 230.00),
    (5, 5, 1, 950.00),
    (6, 8, 1, 750.00),
    (6, 2, 2, 120.00),
    (7, 1, 1, 3400.00),
    (7, 7, 2, 180.00),
    (8, 3, 1, 280.00),
    (9, 5, 1, 950.00),
    (9, 6, 1, 230.00),
    (10, 4, 2, 1150.00),
    (10, 2, 1, 120.00),
    (11, 8, 1, 750.00),
    (12, 1, 1, 3500.00),
    (12, 3, 1, 280.00);
