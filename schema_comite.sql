-- =====================================================================
-- TURIAVIU · Módulo "Comité e informes" — Sprint 4 (parte 1)
-- Miembros del Comité Técnico-Científico, actas del comité (separadas
-- de las actas de trabajo del equipo) y seguimiento mediante compromisos.
-- El informe semestral automático (agregando indicadores + incidencias)
-- queda para una segunda fase de este mismo módulo.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. MIEMBROS DEL COMITÉ TÉCNICO-CIENTÍFICO
-- ---------------------------------------------------------------------
create type rol_comite as enum ('presidencia', 'secretaria', 'vocal');

create table if not exists comite_miembros (
  id uuid primary key default gen_random_uuid(),
  proyecto_id uuid not null references proyecto(id) on delete cascade,
  nombre text not null,
  perfil text,                    -- descripción del perfil / a quién representa
  entidad text,                   -- institución a la que pertenece
  rol rol_comite not null default 'vocal',
  fecha_alta date not null default current_date,
  fecha_baja date,
  activo boolean not null default true,
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------
-- 2. ACTAS DEL COMITÉ (tabla separada de actas_trabajo del equipo)
-- ---------------------------------------------------------------------
create type tipo_acta_comite as enum ('constitucion', 'seguimiento_semestral', 'extraordinaria');

create table if not exists actas_comite (
  id uuid primary key default gen_random_uuid(),
  proyecto_id uuid not null references proyecto(id) on delete cascade,
  fecha date not null default current_date,
  tipo tipo_acta_comite not null default 'seguimiento_semestral',
  orden_dia text,
  acuerdos text,
  documento_url text,              -- enlace al acta firmada (storage o externo)
  registrado_por uuid references auth.users(id),
  created_at timestamptz not null default now()
);

-- Asistentes de cada acta (N:M con los miembros del comité)
create table if not exists acta_comite_asistentes (
  acta_id uuid not null references actas_comite(id) on delete cascade,
  miembro_id uuid not null references comite_miembros(id) on delete cascade,
  primary key (acta_id, miembro_id)
);

-- ---------------------------------------------------------------------
-- 3. SEGUIMIENTO — compromisos derivados de las actas del comité
--    (misma filosofía que los compromisos de actas_trabajo, pero
--    vinculados a actas_comite)
-- ---------------------------------------------------------------------
-- Reutilizamos el tipo estado_compromiso ya creado en el Sprint 1
-- (pendiente / en_curso / cerrado). Si no existe todavía, se crea aquí
-- de forma segura.
do $$
begin
  if not exists (select 1 from pg_type where typname = 'estado_compromiso') then
    create type estado_compromiso as enum ('pendiente', 'en_curso', 'cerrado');
  end if;
end$$;

create table if not exists compromisos_comite (
  id uuid primary key default gen_random_uuid(),
  acta_id uuid not null references actas_comite(id) on delete cascade,
  descripcion text not null,
  responsable_id uuid references comite_miembros(id) on delete set null,
  responsable_nombre text,          -- fallback si el responsable no es miembro del comité
  fecha_limite date,
  estado estado_compromiso not null default 'pendiente',
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------
-- 4. RLS — mismo criterio provisional que el resto del Sprint 1:
--    cualquier autenticado, pendiente de roles definitivos.
-- ---------------------------------------------------------------------
alter table comite_miembros enable row level security;
alter table actas_comite enable row level security;
alter table acta_comite_asistentes enable row level security;
alter table compromisos_comite enable row level security;

create policy "autenticados_todo_comite_miembros" on comite_miembros
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_actas_comite" on actas_comite
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_acta_comite_asistentes" on acta_comite_asistentes
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_compromisos_comite" on compromisos_comite
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
