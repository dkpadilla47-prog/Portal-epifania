-- Ejecuta esto en Supabase → SQL Editor → New query → Run
create table if not exists public.mensajes (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  seudonimo text not null check (char_length(seudonimo) between 2 and 30),
  mensaje text not null check (char_length(mensaje) between 10 and 1000),
  estado text not null default 'pendiente' check (estado in ('pendiente','aprobado','rechazado')),
  alerta boolean not null default false,
  reportes int not null default 0
);
alter table public.mensajes enable row level security;
grant select, insert on public.mensajes to anon;

create policy "leer aprobados" on public.mensajes
  for select to anon using (estado = 'aprobado');
create policy "enviar pendientes" on public.mensajes
  for insert to anon with check (estado = 'pendiente' and reportes = 0);

-- Reportar: a los 3 reportes el mensaje vuelve a "pendiente" para que lo revises
create or replace function public.reportar(p_id uuid) returns void
language sql security definer set search_path = public as $$
  update public.mensajes
  set reportes = reportes + 1,
      estado = case when reportes + 1 >= 3 then 'pendiente' else estado end
  where id = p_id and estado = 'aprobado';
$$;
revoke all on function public.reportar(uuid) from public;
grant execute on function public.reportar(uuid) to anon;
