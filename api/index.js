const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');

const app = express();
const PORT = 3000;

// Configuração do MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', 
    database: 'product_db'
});

// Conexão com o banco de dados
db.connect(err => {
    if (err) {
        console.error('Erro ao conectar ao MySQL:', err.message);
        return;
    }
    console.log('Conectado ao banco de dados MySQL.');
});

// Middleware
app.use(cors({
    origin: '*', // Permitir qualquer origem
}));
app.use(express.json());

// Endpoint para listar produtos
app.get('/products', (req, res) => {
    console.log('Recebendo requisição para /products');
    const query = 'SELECT * FROM products';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Erro ao consultar produtos:', err.message);
            res.status(500).send('Erro no servidor');
        } else {
            console.log('Produtos retornados:', results);
            res.json(results);
        }
    });
});

// Iniciar o servidor
app.listen(PORT, () => {
    console.log(`API rodando em http://localhost:${PORT}`);
});
