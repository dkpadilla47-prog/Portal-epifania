# Portal Epifanía

Sitio estático (HTML/CSS/JS) de acompañamiento en salud mental.

## Formspree
En `index.html`, busca `FORMSPREE_URL` y reemplaza `mnpdjzpg` por tu ID de formspree.io
(ej. `https://formspree.io/f/abcdwxyz`). Si no lo cambias, los formularios abren el correo del visitante.

## GitHub
```
git init && git add . && git commit -m "Portal Epifanía"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/portal-epifania.git
git push -u origin main
```

## Vercel
vercel.com → Add New → Project → importa el repo → Framework "Other" → Deploy (sin build command).

## Muro de la comunidad (Supabase)
1. Supabase → SQL Editor → pega y ejecuta `supabase.sql`.
2. Moderar: Table Editor → tabla `mensajes` → cambia `estado` de `pendiente` a `aprobado` (o `rechazado`). Revisa primero las filas con `alerta = true`.
3. La clave `sb_publishable_...` es pública por diseño; la seguridad la dan las políticas RLS del SQL. Nunca pongas la clave secreta en el código.

## Encuesta de satisfacción
`encuesta.html` (en Vercel: `/encuesta`) envía las respuestas a Formspree, con el mismo endpoint de los formularios.
