const express = require('express');
const session = require('express-session');
const path = require('path');
const db = require('./config/database');

const app = express();
const PORT = process.env.PORT || 4000;

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
    secret: 'secret-key-vulnerable',
    resave: false,
    saveUninitialized: false
}));

// Middleware de autenticación
const requireAuth = (req, res, next) => {
    if (!req.session.userId) {
        return res.redirect('/login');
    }
    next();
};

// Ruta principal
app.get('/', requireAuth, (req, res) => {
    res.redirect('/dashboard');
});

// Login
app.get('/login', (req, res) => {
    res.render('login', { error: null });
});

app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    
    // VULNERABILIDAD: SQL Injection - Concatenación directa
    const query = `SELECT * FROM usuarios WHERE username = '${username}' AND password = '${password}'`;
    
    try {
        const [rows] = await db.query(query);
        
        if (rows.length > 0) {
            req.session.userId = rows[0].id;
            req.session.username = rows[0].username;
            return res.redirect('/dashboard');
        }
        
        res.render('login', { error: 'Usuario o contraseña incorrectos' });
    } catch (error) {
        res.render('login', { error: 'Error en la consulta: ' + error.message });
    }
});

// Registro
app.get('/registro', (req, res) => {
    res.render('registro', { error: null, success: null });
});

app.post('/registro', async (req, res) => {
    const { username, password, email } = req.body;
    
    // VULNERABILIDAD: SQL Injection en INSERT
    const query = `INSERT INTO usuarios (username, password, email) VALUES ('${username}', '${password}', '${email}')`;
    
    try {
        await db.query(query);
        res.render('registro', { 
            error: null, 
            success: 'Usuario registrado exitosamente. Puedes iniciar sesión.' 
        });
    } catch (error) {
        res.render('registro', { 
            error: 'Error al registrar: ' + error.message, 
            success: null 
        });
    }
});

// Dashboard principal
app.get('/dashboard', requireAuth, async (req, res) => {
    const { id } = req.query;
    let estudiantes = [];
    let cursos = [];
    let notas = [];
    let error = null;
    
    try {
        if (id) {
            // VULNERABILIDAD: SQL Injection en múltiples consultas
            const queryEstudiantes = `SELECT * FROM estudiantes WHERE id = ${id}`;
            [estudiantes] = await db.query(queryEstudiantes);
            
            const queryCursos = `SELECT * FROM cursos WHERE id = ${id}`;
            [cursos] = await db.query(queryCursos);
            
            const queryNotas = `
                SELECT n.*, e.nombres as estudiante_nombre, e.apellidos as estudiante_apellido, 
                       c.nombre_asignatura as curso_nombre 
                FROM notas n 
                JOIN estudiantes e ON n.estudiante_id = e.id 
                JOIN cursos c ON n.curso_id = c.id 
                WHERE n.id = ${id}
            `;
            [notas] = await db.query(queryNotas);
        } else {
            [estudiantes] = await db.query('SELECT * FROM estudiantes LIMIT 10');
            [cursos] = await db.query('SELECT * FROM cursos');
            [notas] = await db.query(`
                SELECT n.*, e.nombres as estudiante_nombre, e.apellidos as estudiante_apellido, 
                       c.nombre_asignatura as curso_nombre 
                FROM notas n 
                JOIN estudiantes e ON n.estudiante_id = e.id 
                JOIN cursos c ON n.curso_id = c.id
            `);
        }
    } catch (err) {
        error = err.message;
    }
    
    res.render('dashboard', { 
        estudiantes, 
        cursos, 
        notas, 
        error, 
        username: req.session.username 
    });
});

// Logout
app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/login');
});

app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
