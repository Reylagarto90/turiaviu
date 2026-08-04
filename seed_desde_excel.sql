-- =====================================================================
-- TURIAVIU · Función de carga/recarga de datos desde el M8 (Marco Lógico)
-- Contiene los 5 objetivos, 21 indicadores, 7 actividades y sus acciones
-- extraídos directamente del Excel M8__Formulario_excel_Modificado_DEF.
--
-- Es re-ejecutable: cada vez que se llama, borra objetivos, indicadores,
-- actividades y acciones existentes y los vuelve a insertar desde cero.
-- Así, el botón "Recargar desde el Excel" de la app siempre deja los
-- datos en el estado original del M8, útil si algo se descuadra o si
-- se actualiza el Excel más adelante y hay que regenerar esta función.
--
-- Uso manual (SQL Editor de Supabase): select cargar_seed_nucleo();
-- Uso desde la app: supabase.rpc('cargar_seed_nucleo')
-- =====================================================================

create or replace function cargar_seed_nucleo()
returns void as $function$
begin
  -- Limpieza previa (en orden por las claves foráneas)
  delete from objetivo_actividad;
  delete from acciones;
  delete from indicadores;
  delete from objetivos;
  delete from actividades;

  insert into actividades (proyecto_id, codigo, nombre, resultado_esperado, fuente_verificacion, presupuesto_directo)
  select id, 'A1', 'ACTIVIDAD 1. Plan de comunicación y transferibilidad del modelo', 'R1.1: 1 Estrategia de comunicación ejecutada, con u mínimo de 50 publicaciones en redes sociales (#TuriaViu), 1 blog activo, 1 serie de vídeos “Diario de la Brigada) y 1 vídeo divulgativo de resultados. 
R1.2: 1 Guía de Replicabilidad del Modelo TURIAVIU editada y publicada, que incluya un capítulo específico sobre la integración de la perspectiva de género.
R1.3: 1 Seminario Final de Transferencia celebrado, con al menos 50 asistentes, que incluya una ponencia específica sobre los resultados de género del proyecto.', 'Informe de ejecución de la estrategia digital con pantallazos o enlaces a las 50 publicaciones en redes sociales, al blog con sus entradas y a los vídeos de la serie "Diario de la Brigada".  Enlace al video reportaje final documental alojado en plataforma pública', 15477.12
  from proyecto limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A.1.', 'Acción 1.1. Actualización periódica en redes sociales #TuriaViu Acción 1.2. Elaboración de un video divulgativo de resultado.
Acción 1.3. Al menos unanota de prensa. 
Acción 1.4. Publicación en web con logotipos del programa. 
Acción 1,5, Cartel A3 en la sede. 
Acción 1,6, Resumen ejecutivo divulgativo final 
Acción 1.7. Sistematización y transferencia del modelo en una guía de replicabilidad de "turiaViu"'
  from actividades where codigo = 'A1' limit 1;

  insert into actividades (proyecto_id, codigo, nombre, resultado_esperado, fuente_verificacion, presupuesto_directo)
  select id, 'A2', 'Actividad 2. Coordinación gestión técnica y seguimiento científico.', 'R2.1: 1 Sistema de Gobernanza operativo, evidenciado por el acta de constitución del Comité Técnico-Científico Asesor y las 4 actas de reunión semestral celebradas a lo largo del proyecto.
R2.2: 1 Carpeta completa de permisos y autorizaciones en vigor, emitidos por el Parque Natural del Turia y la Confederación Hidrográfica del Júcar, que habilita legalmente todas las actuaciones in situ.
R2.3: 4 Informes semestrales de monitorización y 1 informe final de evaluación, con datos consolidados de todos los indicadores y su desagregación por sexo, que documentan el progreso y los resultados globales del proyecto, incluyendo el análisis del impacto de género.', 'Actas de constitución y de las cuatro reuniones semestrales del Comité Técnico-Científico Asesor, firmadas por sus miembros.', 29480.24
  from proyecto limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A2.1', 'Acción 2.1. Coordinación administrativa, financiera y de permisos.'
  from actividades where codigo = 'A2' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A2.2', 'Acción 2.2. Constitución y coordinación del Comité Técnico-Científico Asesor.'
  from actividades where codigo = 'A2' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A.2.3', 'Acción 2.3. Implementación del sistema de monitorización y evaluación continua.'
  from actividades where codigo = 'A2' limit 1;

  insert into actividades (proyecto_id, codigo, nombre, resultado_esperado, fuente_verificacion, presupuesto_directo)
  select id, 'A3', 'Actividad 3. Selección, formación integral y acompañamiento sociolaboral de la brigada.', 'R3.1: 1 Brigada operativa y estable de 5 personas con trastorno mental, con una composición que promueva la paridad de género, lista verificable a través del listado nominal de participantes con sus contratos o acuerdos de incorporación.
R3.2: 1 Plan formativo ejecutado al 100%, que incluye módulos específicos sobre igualdad y corresponsabilidad, acreditado mediante el registro de asistencia, los materiales pedagógicos desarrollados y el programa de sesiones impartidas (mínimo 300 horas de formación técnica por participante y 120 horas de habilidades socio-laborales, incluidas las competencias clave y digitales).
R3.3: 5 Certificados individuales de capacitación emitidos, detallando las competencias técnicas y transversales adquiridas, sin distinción de género.
R3.4: 5 Portfolios profesionales individualizados finalizados, que incluyen CV, certificados y evidencias del trabajo realizado, diseñados para destacar las competencias sin sesgo de género y facilitar la inserción laboral en condiciones de igualdad.', 'Listado nominal de los 5 integrantes de la brigada, con sus correspondientes contratos o acuerdos de incorporación, donde se especifique el género.', 117920.92
  from proyecto limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A3.1', 'Acción 3.1. Desarrollo y ejecución del proceso de selección con enfoque de género y acogida de los 5 participantes.'
  from actividades where codigo = 'A3' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A3.2', 'Acción 3.2. Impartición del programa formativo teórico-práctico continuo, incluyendo módulos técnicos, transversales y de igualdad.'
  from actividades where codigo = 'A3' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A3.3', 'Acción 3.3. Tutorización psicosocial individualizada y orientación laboral activa para la inserción, incluyendo la elaboración de portfolios profesionales.'
  from actividades where codigo = 'A3' limit 1;

  insert into actividades (proyecto_id, codigo, nombre, resultado_esperado, fuente_verificacion, presupuesto_directo)
  select id, 'A4', 'Actividad 4. Apoyo psicosocia y promoción de hábitos saldables', 'R4.1: 40 sesiones de Taller de Gestión del Estrés y Mindfulness realizadas (2 al mes), con registros de asistencia desagregados por sexo.
R4.2: 21 sesiones de Grupo de Apoyo Mutuo y Psicoeducación realizadas (1 al mes), que incluirán contenidos sobre autoestima y empoderamiento con perspectiva de género, documentadas mediante actas resumen anónimas.
R4.3: 21 sesiones de Taller de Deporte y Vida Activa realizadas (1 al mes), con actividades adaptadas e inclusivas y registros de participación.
R4.4: 7 Actividades de Ocio Inclusivo realizadas (1 cada trimestre), verificables mediante listas de asistencia y reportajes fotográficos que reflejen la participación equitativa.', 'Registros de asistencia desagregados por sexo a cada una de las 40 sesiones de taller de gestión del estrés y las 21 sesiones de deporte.', 8107.06
  from proyecto limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A4.1', 'Acción 4.1. Ejecución regular de talleres de gestión del estrés, mindfulness y deporte adaptado para el equipo.'
  from actividades where codigo = 'A4' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A4.2', 'Acción 4.2. Desarrollo de sesiones mensuales de grupo de apoyo mutuo y psicoeducación, con contenidos específicos sobre autoestima y perspectiva de género.'
  from actividades where codigo = 'A4' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A4.3', 'Acción 4.3. Organización periódica de actividades de ocio inclusivo y participación en eventos comunitarios para fomentar la integración social.'
  from actividades where codigo = 'A4' limit 1;

  insert into actividades (proyecto_id, codigo, nombre, resultado_esperado, fuente_verificacion, presupuesto_directo)
  select id, 'A5', 'Actividad 5. Producción sostenible de planta autóctona en viverol.', 'R5.1: 1 Vivero forestal optimizado y operativo, acreditado con fotografías antes/después de las mejoras realizadas en infraestructura.
R5.2: Mínimo 3.000 plantas autóctonas de ribera de calidad producidas en dos ciclos anuales, verificable mediante el registro de producción digitalizado que especifique especies, número de ejemplares, fechas y tasas de éxito.
R5.3: 1 Banco de datos genético y de producción creado, en formato digital, que documente la procedencia del material y el historial de cada lote.', 'Reportaje fotográfico que documente el estado del vivero antes y después de su optimización.', 33902.26
  from proyecto limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A5.1', 'Acción 5.1. Acondicionamiento de la infraestructura del vivero y obtención del material genético local certificado.'
  from actividades where codigo = 'A5' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A5.2', 'Acción5.2. Producción, cultivo y manejo integral de más de 3,000 plantas autóctonas a lo largo de dos ciclos anuales.'
  from actividades where codigo = 'A5' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A5.3', 'Acción 5.3. Mantenimiento del registro digitalizado de la producción y creación de un banco de datos para futuras repoblaciones.'
  from actividades where codigo = 'A5' limit 1;

  insert into actividades (proyecto_id, codigo, nombre, resultado_esperado, fuente_verificacion, presupuesto_directo)
  select id, 'A6', 'Actividad 6. Restauración ecológica activa y adaptativa en el Parque Natural del Turia.', 'R6.1: Mínimo 5 hectáreas de cañaveral invasor (Arundo donax) sometidas a control mecánico continuado, verificable mediante mapas cartográficos georreferenciados y fotografías seriadas.
R6.2: Mínimo 2.500 plantas autóctonas establecidas en el Parque Natural, resultado de la plantación. Verificable mediante censos físicos realizados a los 3, 12 y 18 meses post-plantación.
R6.3: Tasa de supervivencia media de la plantación superior al 60% a los 18 meses, calculada a partir de los datos de los censos.
R6.4: 1 Protocolo de Manejo Adaptativo documentado, que sintetice las lecciones aprendidas, incluyendo observaciones sobre la equidad en la ejecución de tareas.', 'Mapas cartográficos georreferenciados (en formato shapefile o similar) que delimiten las más de 5 hectáreas intervenidas, con capas de información sobre las actuaciones realizadas. Serie fotográfica temporal (fotos desde puntos fijos) que muestre la evolución de las zonas antes, durante y después de las intervenciones.', 70752.55
  from proyecto limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A6.1', 'Acción 6.1. Control mecánico y manejo adaptativo del cañaveral invasor en un mínimo de 5 hectáreas.'
  from actividades where codigo = 'A6' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A6.2', 'Acción 6.2. Preparación del terreno, plantación con técnicas de alta supervivencia y manejo del sistema de riego de apoyo.'
  from actividades where codigo = 'A6' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A6.3', 'Acción 6.3. Mantenimiento continuado, seguimiento científico de los resultados (supervivencia, crecimiento) y aplicación de ajustes bajo el enfoque de manejo adaptativo.'
  from actividades where codigo = 'A6' limit 1;

  insert into actividades (proyecto_id, codigo, nombre, resultado_esperado, fuente_verificacion, presupuesto_directo)
  select id, 'A7', 'Actividad 7. Sensibilización y transferencia del modelo al cierre', 'R7.1: Mínimo 6 sesiones de Ecoaulas y Brigada-Escuela realizadas, con la participación de al menos 200 alumnos, donde las mujeres brigadistas tengan un rol protagónico como referentes. Verificable mediante convenios, programas y listas de asistencia.
R7.2: Mínimo 3 jornadas de Voluntariado Corporativo y Alianzas realizadas, implicando a al menos 120 personas. Verificable mediante acuerdos, programas y listas de asistencia que promuevan la participación paritaria.
R7.3: Tasa de inserción sociolaboral positiva del 40% de los miembros de la brigada (2 personas) al finalizar el proyecto, con el objetivo de que al menos una inserción sea de una mujer, acreditada mediante contratos, acuerdos de prácticas o inscripciones en programas de
empleo protegido.', 'Informe de ejecución de la estrategia digital con pantallazos o enlaces a las 50 publicaciones en redes sociales, al blog con sus entradas y a los vídeos de la serie "Diario de la Brigada".', 19162.15
  from proyecto limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A7.1', 'Acción 7.1. Diseño de identidad corporativa y ejecución de la estrategia digital (web, redes sociales con #TuriaVivo) y producción de contenido audiovisual seriado.'
  from actividades where codigo = 'A7' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A7.2', 'Acción 7.2. Organización y ejecución del programa de "Ecoaulas y Brigada-Escuela" para centros educativos.'
  from actividades where codigo = 'A7' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A7.3', 'Acción 7.3. Organización y ejecución de jornadas de "Voluntariado Corporativo y Alianzas" con empresas y ciudadanía.'
  from actividades where codigo = 'A7' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A7.4', 'Acción 7.4. Documentación del modelo metodológico en la "Guía de Replicabilidad TURIAVIVO" y producción del vídeo reportaje final documental.'
  from actividades where codigo = 'A7' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A7.5', 'Acción 7.5. Organización y celebración de la Jornada Final de Puertas Abiertas para presentar resultados.'
  from actividades where codigo = 'A7' limit 1;

  insert into acciones (actividad_id, codigo, descripcion)
  select id, 'A7.6', 'Acción 7.5. Ejecución de las acciones finales de difusión: instalación de señalética, envío de comunicado de prensa y publicación de memorias en la web y bases de datos oficiales.'
  from actividades where codigo = 'A7' limit 1;

  insert into objetivos (proyecto_id, codigo, descripcion, condicionantes)
  select id, 'OE1', '1. Formar, capacitar y consolidar profesionalmente a una brigada estable de 5 personas con trastorno mental grave, garantizando una composición paritaria o que incremente significativamente la presencia de mujeres en el sector. Este objetivo se centra en la transformación personal y profesional, con un enfoque específico en reducir la brecha de género en empleos técnico-ambientales. Se establecerán criterios de selección y acompañamiento que fomenten activamente la participación de mujeres, identificando y eliminando barreras específicas. La formación, impartida por especialistas, incluirá módulos de competencias técnicas (identificación de flora, viverismo, control de invasoras, restauración) y transversales (competencias clave, digitales, prevención de riesgos laborales), integrando siempre una mirada de género que promueva la igualdad en el equipo. Se fomentará el liderazgo y la visibilidad de las mujeres de la brigada en todas las fases. El resultado será un grupo cohesionado, competente y con mayor equidad de género, dotado de un certificado que acredite su cualificación.', 'El objetivo de formar y consolidar la brigada profesionalmente se ve condicionado por la disponibilidad de candidatos con el perfil adecuado, especialmente mujeres, para lograr una composición con equidad de género. Además, la estabilidad del grupo puede verse afectada por circunstancias personales de los participantes, lo que incide en la continuidad formativa y la cohesión del equipo. La obtención de los permisos para acceder al espacio natural es también un prerrequisito indispensable para la formación práctica en el campo.'
  from proyecto limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 1.1', 'Número de personas formadas y consolidadas en la brigada', 'personas', 5.0, 0
  from objetivos where codigo = 'OE1' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 1.2', 'Composición de la brigada', 'Composición que favorezca la equidad de género', null, 0
  from objetivos where codigo = 'OE1' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 1.3', 'Horas de formación técnica impartidas por participante', 'horas', 300.0, 0
  from objetivos where codigo = 'OE1' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 1.4', 'Horas de formación en habilidades socio-laborales, competencias clave e igualdad por participante', 'horas', 120.0, 0
  from objetivos where codigo = 'OE1' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 1.5', 'Número de certificados de capacitación individual emitidos', 'certificados', 5.0, 0
  from objetivos where codigo = 'OE1' limit 1;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE1' and a.codigo = 'A3'
  on conflict do nothing;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE1' and a.codigo = 'A4'
  on conflict do nothing;

  insert into objetivos (proyecto_id, codigo, descripcion, condicionantes)
  select id, 'OE2', '2. Ejecutar un programa de restauración ecológica activa y adaptativa en el Parque Natural del Turia, actuando sobre al menos 5 hectáreas mediante el control de especies exóticas invasoras, la revegetación con flora autóctona y su mantenimiento. Este objetivo traslada la capacitación a la acción directa, con un alcance físico medible. Las actuaciones, supervisadas técnicamente y ejecutadas por la brigada (con composición paritaria reforzada), serán secuenciales: diagnosis, control manual/mecánico de cañaveral invasor sin herbicidas, producción de más de 3.000 plantas autóctonas en vivero propio, y repoblación con técnicas que maximicen la supervivencia (hidrogel, acolchado, riego de apoyo por goteo). El mantenimiento continuo durante los dos años asegurará el establecimiento del nuevo bosque ripario. El proyecto garantizará que las condiciones de trabajo y el equipamiento sean adecuados y equitativos para todos los miembros, fomentando un entorno seguro e inclusivo.', 'El objetivo de ejecutar el programa de restauración ecológica está sujeto a la obtención y renovación de las autorizaciones ambientales, factor externo crítico que habilita toda intervención en el territorio. Su éxito depende igualmente de factores climáticos, como sequías o inundaciones, que pueden alterar el calendario y comprometer la supervivencia de la vegetación. Paralelamente, la productividad del vivero propio, condicionada por la calidad de la semilla y posibles incidencias fitosanitarias, determina la disponibilidad del material vegetal necesario para la revegetación.'
  from proyecto limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 2.1', 'Superficie de cañaveral invasor sometida a control mecánico continuado', 'hectáreas', 5.0, 0
  from objetivos where codigo = 'OE2' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 2.2', 'Número de plantas autóctonas producidas en vivero propio', 'plantas', 3.0, 0
  from objetivos where codigo = 'OE2' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 2.3', 'Número de plantas autóctonas establecidas en el Parque Natural', 'plantas', 2.5, 0
  from objetivos where codigo = 'OE2' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 2.4', 'Tasa de supervivencia media de la plantación a los 18 meses', null, 75.0, 0
  from objetivos where codigo = 'OE2' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 2.5', 'Existencia de un sistema de riego de apoyo operativo', 'sistema instalado', 1.0, 0
  from objetivos where codigo = 'OE2' limit 1;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE2' and a.codigo = 'A2'
  on conflict do nothing;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE2' and a.codigo = 'A5'
  on conflict do nothing;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE2' and a.codigo = 'A6'
  on conflict do nothing;

  insert into objetivos (proyecto_id, codigo, descripcion, condicionantes)
  select id, 'OE3', '3. Promover la inserción sociolaboral efectiva de las cinco personas participantes, con especial atención a las mujeres, facilitando su transición al mercado laboral (ordinario o protegido) con un objetivo mínimo del 40% de inserciones positivas (al menos 2 personas). Este objetivo persigue que la experiencia culmine en una mejora real de las condiciones de vida, priorizando la igualdad de oportunidades en los resultados. Se fortalecerán alianzas con empresas y administraciones, promoviendo la contratación con criterios de diversidad una vez terminado el proyecto. El portfolio profesional de cada participante destacará las competencias adquiridas sin sesgo de género. La meta es que al menos 2 integrantes (40%) logren una inserción positiva (contrato, formación reglada vinculada, cooperativa social), con un objetivo explícito de que al menos una de ellas sea mujer, contribuyendo a romper estereotipos laborales.', 'El objetivo de promover la inserción sociolaboral efectiva depende en gran medida de la disposición del mercado laboral verde y de la capacidad para establecer alianzas con empresas y administraciones que valoren la diversidad. La evolución personal y profesional de cada participante, junto con la persistencia de estereotipos de género en el sector, condicionan las oportunidades reales de inserción, especialmente para las mujeres de la brigada.'
  from proyecto limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 3.1', 'Tasa de inserción sociolaboral positiva de los miembros de la brigada', '( personas)', 40.0, 0
  from objetivos where codigo = 'OE3' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 3.2', 'Inserción con perspectiva de género', 'de las inserciones corresponde a una mujer brigadista', 1.0, 0
  from objetivos where codigo = 'OE3' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 3.3', 'Número de portfolios profesionales individualizados finalizados', 'portfolios', 5.0, 0
  from objetivos where codigo = 'OE3' limit 1;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE3' and a.codigo = 'A2'
  on conflict do nothing;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE3' and a.codigo = 'A3'
  on conflict do nothing;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE3' and a.codigo = 'A7'
  on conflict do nothing;

  insert into objetivos (proyecto_id, codigo, descripcion, condicionantes)
  select id, 'OE4', '4. Desarrollar un programa de sensibilización, educación ambiental y participación ciudadana que fomente la corresponsabilidad ambiental, el voluntariado y la reducción del estigma asociado a la salud mental y a los roles de género en el sector ambiental. Este objetivo busca tejer vínculos entre la brigada y la comunidad, creando una narrativa positiva que desafíe estereotipos. En las "Ecoaulas" para centros educativos y en las jornadas de "Voluntariado Corporativo y Ciudadano", los miembros de la brigada, con especial protagonismo de las mujeres brigadistas, actuarán como referentes y monitores auxiliares, visibilizando modelos femeninos en roles técnicos ambientales. La estrategia de comunicación (blog, reportajes, redes sociales con el hashtag #TuriaVivo) destacará la diversidad del equipo y su trabajo, promoviendo una imagen inclusiva y no estereotipada tanto de la salud mental como de las profesiones verdes.', 'El objetivo de sensibilizar, educar y reducir el estigma está condicionado por la respuesta y disponibilidad de centros educativos y empresas para colaborar en las actividades de educación ambiental y voluntariado, lo que determina su alcance y frecuencia. La efectividad de estas acciones también depende de la confianza y el protagonismo que los propios miembros de la brigada, en especial las mujeres, puedan asumir como referentes.'
  from proyecto limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 4.1', 'Número de personas alcanzadas directamente en actividades de sensibilización y educación ambiental', 'personas', 500.0, 0
  from objetivos where codigo = 'OE4' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 4.2', 'Número de sesiones educativas ("Ecoaulas") realizadas con protagonismo de la brigada', 'sesiones', 10.0, 0
  from objetivos where codigo = 'OE4' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 4.3', 'Número de jornadas de voluntariado corporativo/ciudadano realizadas', 'jornadas', 6.0, 0
  from objetivos where codigo = 'OE4' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 4.4', 'Ejecución de una estrategia de comunicación narrativa', 'publicaciones en redes sociales  blog con  entradas y  vídeo documental', 50.0, 0
  from objetivos where codigo = 'OE4' limit 1;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE4' and a.codigo = 'A4'
  on conflict do nothing;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE4' and a.codigo = 'A7'
  on conflict do nothing;

  insert into objetivos (proyecto_id, codigo, descripcion, condicionantes)
  select id, 'OE5', '5. Documentar, evaluar y transferir el modelo metodológico de Brigada de Inserción para la Restauración Ecológica, incorporando un análisis de género que permita su replicabilidad en otros espacios naturales y con otros colectivos vulnerables. Para maximizar el impacto, el proyecto se convertirá en un caso de estudio transferible. La evaluación continua y final incluirá indicadores desagregados por sexo para medir el impacto diferencial en la capacitación, el bienestar y la empleabilidad. Los manuales técnicos y la "Guía de Replicabilidad" incorporarán un capítulo específico sobre cómo integrar la perspectiva de género y garantizar la igualdad en cada fase de futuros proyectos similares, desde la selección hasta la inserción. El seminario final de difusión dirigido a gestores y entidades sociales destacará esta dimensión como un pilar fundamental del éxito del modelo TURIAVIVO.', 'El objetivo de documentar, evaluar y transferir el modelo está vinculado a la calidad y sistematicidad del proceso de monitorización y evaluación a lo largo del proyecto, que permite generar un aprendizaje sólido. La capacidad de adaptación ante imprevistos y de documentar las lecciones aprendidas es crucial para elaborar una guía de replicabilidad con valor práctico. El impacto de la transferencia dependerá, en última instancia, del interés y compromiso que el modelo genere entre gestores de otros espacios naturales y entidades sociales.'
  from proyecto limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 5.1', 'Existencia de un sistema de gobernanza y evaluación operativo con perspectiva de género', 'Comité Técnico-Científico constituido y  informes semestrales con datos desagregados por sexo', 1.0, 0
  from objetivos where codigo = 'OE5' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 5.2', 'Elaboración y publicación de una Guía de Replicabilidad que incluya perspectiva de género', 'Guía publicada con un capítulo específico sobre género', 1.0, 0
  from objetivos where codigo = 'OE5' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 5.3', 'Celebración de un seminario final de transferencia', 'seminario con al menos  asistentes y una ponencia sobre resultados de género', 1.0, 0
  from objetivos where codigo = 'OE5' limit 1;

  insert into indicadores (objetivo_id, codigo, descripcion, unidad_medida, meta, valor_actual)
  select id, 'Indicador 5.4', 'Documentación de un Protocolo de Manejo Adaptativo con lecciones aprendidas sobre equidad', 'protocolo documentado', 1.0, 0
  from objetivos where codigo = 'OE5' limit 1;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE5' and a.codigo = 'A1'
  on conflict do nothing;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE5' and a.codigo = 'A2'
  on conflict do nothing;

  insert into objetivo_actividad (objetivo_id, actividad_id)
  select o.id, a.id from objetivos o, actividades a
  where o.codigo = 'OE5' and a.codigo = 'A7'
  on conflict do nothing;

end;
$function$ language plpgsql;

-- Permite que cualquier usuario autenticado pueda ejecutar la recarga.
-- TODO: cuando se definan roles, restringir a coordinadora/administrativa.
grant execute on function cargar_seed_nucleo() to authenticated;
