-- =====================================================================
-- TURIAVIU · Esquema Supabase · Sprint 1 (núcleo + incidencias + actas)
-- Proyecto: Brigada "Turia Viu" — AFEMPES — Fundación Biodiversidad F.S.P.
-- Región recomendada del proyecto Supabase: EU (Ireland o Frankfurt)
-- =====================================================================
-- Notas de protección de datos:
-- 1. Esta base NO debe alojar por ahora datos clínicos de los brigadistas
--    (eso se aborda en el Sprint 2 con RLS reforzada). Este sprint solo
--    cubre proyecto, objetivos, indicadores, actividades, incidencias
--    y actas de trabajo del equipo.
-- 2. Todas las tablas tienen RLS activada. Las políticas de este sprint
--    son "solo usuarios autenticados" porque los roles se definirán más
--    adelante — hay un TODO marcado donde habrá que sustituirlas por
--    políticas específicas por rol.
-- 3. auth.users ya vive en el esquema de Supabase Auth (EU) — no se
--    duplica aquí ninguna tabla de usuarios.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 0. Extensión necesaria para UUID
-- ---------------------------------------------------------------------
create extension if not exists "pgcrypto";

-- ---------------------------------------------------------------------
-- 1. PROYECTO
-- ---------------------------------------------------------------------
create table if not exists proyecto (
  id uuid primary key default gen_random_uuid(),
  acronimo text not null default 'TuriaViu',
  titulo text not null,
  entidad text not null default 'AFEMPES',
  convocatoria text not null,
  fecha_inicio date not null,
  fecha_fin date not null,
  presupuesto_total numeric(12,2),
  importe_subvencion numeric(12,2),
  aportacion_entidad numeric(12,2),
  created_at timestamptz not null default now()
);

comment on table proyecto is 'Ficha única del proyecto TuriaViu. Normalmente una sola fila.';

-- ---------------------------------------------------------------------
-- 2. OBJETIVOS ESPECÍFICOS (OE1-OE5)
-- ---------------------------------------------------------------------
create table if not exists objetivos (
  id uuid primary key default gen_random_uuid(),
  proyecto_id uuid not null references proyecto(id) on delete cascade,
  codigo text not null,              -- OE1, OE2...
  descripcion text not null,
  condicionantes text,               -- columna H del Marco Lógico
  created_at timestamptz not null default now(),
  unique (proyecto_id, codigo)
);

-- ---------------------------------------------------------------------
-- 3. INDICADORES (ligados a un objetivo)
-- ---------------------------------------------------------------------
create table if not exists indicadores (
  id uuid primary key default gen_random_uuid(),
  objetivo_id uuid not null references objetivos(id) on delete cascade,
  codigo text not null,               -- Indicador 1.1, 1.2...
  descripcion text not null,
  unidad_medida text,                 -- hectáreas, plantas, horas, personas, %...
  meta numeric,
  valor_actual numeric not null default 0,
  fecha_ultima_medicion date,
  desagregado_por_sexo boolean not null default false,
  meta_mujeres numeric,
  valor_actual_mujeres numeric,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------
-- 4. ACTIVIDADES (A1-A9) y ACCIONES (A1.1, A1.2...)
-- ---------------------------------------------------------------------
create table if not exists actividades (
  id uuid primary key default gen_random_uuid(),
  proyecto_id uuid not null references proyecto(id) on delete cascade,
  codigo text not null,                -- A1, A2...
  nombre text not null,
  resultado_esperado text,
  fuente_verificacion text,
  presupuesto_directo numeric(12,2),
  created_at timestamptz not null default now(),
  unique (proyecto_id, codigo)
);

create table if not exists acciones (
  id uuid primary key default gen_random_uuid(),
  actividad_id uuid not null references actividades(id) on delete cascade,
  codigo text not null,                 -- A1.1, A1.2...
  descripcion text not null,
  created_at timestamptz not null default now(),
  unique (actividad_id, codigo)
);

-- Relación N:M entre objetivos y actividades (un objetivo puede
-- vincularse a varias actividades, ej. OE1 -> A3, A4)
create table if not exists objetivo_actividad (
  objetivo_id uuid not null references objetivos(id) on delete cascade,
  actividad_id uuid not null references actividades(id) on delete cascade,
  primary key (objetivo_id, actividad_id)
);

-- ---------------------------------------------------------------------
-- 5. INCIDENCIAS
--    Trazabilidad de los "condicionantes" del proyecto: se vinculan
--    opcionalmente a una actividad, una persona y un indicador.
-- ---------------------------------------------------------------------
create type tipo_incidencia as enum (
  'salud_seguridad', 'tecnica', 'administrativa_permisos',
  'climatica', 'rrhh', 'brigadista', 'otra'
);

create type estado_incidencia as enum ('abierta', 'en_curso', 'cerrada');

create table if not exists incidencias (
  id uuid primary key default gen_random_uuid(),
  proyecto_id uuid not null references proyecto(id) on delete cascade,
  fecha date not null default current_date,
  tipo tipo_incidencia not null,
  descripcion text not null,
  gravedad smallint check (gravedad between 1 and 3) default 1, -- 1 leve, 2 moderada, 3 grave
  estado estado_incidencia not null default 'abierta',
  actividad_id uuid references actividades(id) on delete set null,
  indicador_id uuid references indicadores(id) on delete set null,
  persona_nombre text,                 -- referencia libre hasta que exista tabla RRHH (Sprint 2)
  accion_correctora text,
  fecha_cierre date,
  registrado_por uuid references auth.users(id),
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------
-- 6. ACTAS DE TRABAJO DEL EQUIPO
--    Distintas de las actas del Comité Técnico-Científico (semestrales,
--    perfil externo) — estas son de coordinación interna del equipo.
-- ---------------------------------------------------------------------
create table if not exists actas_trabajo (
  id uuid primary key default gen_random_uuid(),
  proyecto_id uuid not null references proyecto(id) on delete cascade,
  fecha date not null default current_date,
  asistentes text[],                    -- nombres; se normaliza a tabla RRHH en Sprint 2
  orden_dia text,
  acuerdos text,
  actividad_id uuid references actividades(id) on delete set null,
  incidencia_id uuid references incidencias(id) on delete set null,
  registrado_por uuid references auth.users(id),
  created_at timestamptz not null default now()
);

create type estado_compromiso as enum ('pendiente', 'en_curso', 'cerrado');

create table if not exists compromisos (
  id uuid primary key default gen_random_uuid(),
  acta_id uuid not null references actas_trabajo(id) on delete cascade,
  descripcion text not null,
  responsable text not null,            -- nombre; se normaliza a tabla RRHH en Sprint 2
  fecha_limite date,
  estado estado_compromiso not null default 'pendiente',
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------
-- 7. Trigger genérico para updated_at
-- ---------------------------------------------------------------------
create or replace function set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trg_indicadores_updated
before update on indicadores
for each row execute function set_updated_at();

-- =====================================================================
-- 8. ROW LEVEL SECURITY
--    TODO: sustituir por políticas específicas por rol cuando se
--    definan (coordinadora / técnico forestal / trabajador social /
--    psicosocial / educadora / administrativa / comité).
--    Por ahora: cualquier usuario autenticado de la app puede leer y
--    escribir. Esto es intencionalmente provisional.
-- =====================================================================
alter table proyecto enable row level security;
alter table objetivos enable row level security;
alter table indicadores enable row level security;
alter table actividades enable row level security;
alter table acciones enable row level security;
alter table objetivo_actividad enable row level security;
alter table incidencias enable row level security;
alter table actas_trabajo enable row level security;
alter table compromisos enable row level security;

create policy "autenticados_todo_proyecto" on proyecto
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_objetivos" on objetivos
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_indicadores" on indicadores
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_actividades" on actividades
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_acciones" on acciones
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_objetivo_actividad" on objetivo_actividad
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_incidencias" on incidencias
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_actas" on actas_trabajo
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "autenticados_todo_compromisos" on compromisos
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

-- =====================================================================
-- 9. Semilla inicial del proyecto (rellenar con datos reales del M8)
-- =====================================================================
insert into proyecto (titulo, convocatoria, fecha_inicio, fecha_fin, presupuesto_total, importe_subvencion, aportacion_entidad)
values (
  'Brigada "Turia Viu": Inserción sociolaboral y adaptación climática a través de la restauración ecológica participativa del Parque Natural del Turia',
  'Convocatoria de subvenciones de la Fundación Biodiversidad F.S.P. — proyectos de empleo y capacitación en municipios afectados por la DANA',
  '2026-06-01', '2028-05-30',
  324282.53, 308068.40, 16214.13
) on conflict do nothing;
