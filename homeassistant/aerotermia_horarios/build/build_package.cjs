// Genera packages/aerotermia_horarios.yaml y dashboard/vista_horarios.yaml
// a partir de un Home Assistant donde ya existen los scripts y los sensores MQTT de horarios.
// Uso (desde la raiz del repo): node homeassistant/aerotermia_horarios/build/build_package.cjs /ruta/config_ha
const fs = require('fs'), path = require('path'), Y = require('yaml');
const ha = process.argv[2] || '/docker/homeassistant';
const out = path.join(__dirname, '..');
const DIAS = ['Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo'];
const slug = s => s.normalize('NFD').replace(/[̀-ͯ]/g,'').toLowerCase();
const dump = o => Y.stringify(o, {lineWidth: 0, singleQuote: false});

// --- sensores MQTT (lectura de las franjas publicadas por ebusd) ---
const mqtt = Y.parse(fs.readFileSync(path.join(ha,'mqtt.yaml'),'utf8'));
const pkgFile = path.join(out,'packages','aerotermia_horarios.yaml');
const pkgPrevio = fs.existsSync(pkgFile) ? Y.parse(fs.readFileSync(pkgFile,'utf8')) : {};
const esHorario = x => /^(acs|refrigeracion|calefaccion|ruido)_horario_/.test(x.unique_id);
let sens = (mqtt.sensor || mqtt.mqtt?.sensor || []).filter(esHorario);
if (!sens.length) sens = (pkgPrevio.mqtt?.sensor || []).filter(esHorario); // HA ya migrado: partir del package existente
const dev = {identifiers:['aerotermia_horarios'], name:'Horarios aerotermia', manufacturer:'ebusd', model:'Programas horarios del termostato (b555)'};
for (const x of sens) { x.device = JSON.parse(JSON.stringify(dev)); x.entity_category = 'diagnostic'; }
if (sens.length !== 147) throw new Error('se esperaban 147 sensores, hay '+sens.length);

// --- scripts ---
let scr = Y.parse(fs.readFileSync(path.join(ha,'scripts.yaml'),'utf8')) || {};
if (!scr.acs_aplicar_horario) scr = pkgPrevio.script || {}; // HA ya migrado: partir del package existente
const claves = ['acs_aplicar_horario','acs_cargar_horario_dia','acs_seleccionar_y_cargar','acs_leer_todos_horarios',
  'calefaccion_aplicar_horario','calefaccion_cargar_horario_dia','calefaccion_seleccionar_y_cargar','calefaccion_leer_todos_horarios'];
const scripts = {}; for (const k of claves) { if (!scr[k]) throw new Error('falta '+k); scripts[k] = JSON.parse(JSON.stringify(scr[k]).replace(/de la vista pruebas/g,'de la vista Aerotermia Horarios').replace(/la vista pruebas/g,'la vista Aerotermia Horarios').replace(/la tabla de la vista/g,'las listas de la vista')); }

// --- helpers ---
const input_select = {
  acs_horario_dia: {name:'ACS horario día', icon:'mdi:calendar-week', options: [...DIAS]},
  acs_horario_programa: {name:'ACS horario programa', icon:'mdi:timetable', options:['ACS','Refrigeración','Reducción de ruido']},
  calefaccion_horario_dia: {name:'Calefaccion horario dia', icon:'mdi:calendar-week', options: [...DIAS]},
};
const dt = (name, icon) => ({name, icon, has_date:false, has_time:true});
const input_datetime = {
  acs_horario_desde: dt('ACS horario franja 1 desde','mdi:clock-start'),
  acs_horario_hasta: dt('ACS horario franja 1 hasta','mdi:clock-end'),
  acs_horario_franja_2_desde: dt('ACS horario franja 2 desde','mdi:clock-start'),
  acs_horario_franja_2_hasta: dt('ACS horario franja 2 hasta','mdi:clock-end'),
  acs_horario_franja_3_desde: dt('ACS horario franja 3 desde','mdi:clock-start'),
  acs_horario_franja_3_hasta: dt('ACS horario franja 3 hasta','mdi:clock-end'),
};
const input_text = {calefaccion_horario_texto: {name:'Calefaccion horario texto', icon:'mdi:text-box-edit', min:0, max:255, mode:'text', initial:''}};

// --- sensores de resumen (plantilla) ---
const progs = [['acs','ACS',[1,2,3]],['refrigeracion','Refrigeracion',[1,2,3]],['calefaccion','Calefaccion',null],['ruido','Ruido',[1,2,3]]];
const resumen = [];
for (const [p, label, idx] of progs) for (const d of DIAS) {
  const rng = idx ? `[1, 2, 3]` : `range(1, 13)`;
  const compacto = p === 'calefaccion';
  resumen.push({
    name: `${label} resumen ${slug(d).replace(/^./,c=>c.toUpperCase())}`,
    unique_id: `${p}_resumen_${slug(d)}`,
    state: compacto ? `{% set ns = namespace(n=0, t=[]) %}{% for i in range(1, 13) %}{% set v = states('sensor.${p}_horario_${slug(d)}_' ~ i) %}{% if v not in ['sin franja', 'unknown', 'unavailable'] and '@' in v %}{% set ns.n = ns.n + 1 %}{% set ns.t = ns.t + [v.split('@')[1] | float(0)] %}{% endif %}{% endfor %}{{ (ns.n ~ (' franja' if ns.n == 1 else ' franjas') ~ ' · ' ~ ns.t | min ~ '–' ~ ns.t | max ~ ' °C') if ns.n else '—' }}` : `{% set ns = namespace(l=[]) %}{% for i in ${rng} %}{% set v = states('sensor.${p}_horario_${slug(d)}_' ~ i) %}{% if v not in ['sin franja', 'unknown', 'unavailable'] %}{% set ns.l = ns.l + [v] %}{% endif %}{% endfor %}{{ ns.l | join(' · ') if ns.l else '—' }}`,
  });
}

const cab = `# Aerotermia Vaillant (ebusd) - programas horarios del termostato desde Home Assistant
# Package generado con build/build_package.cjs. Ver README.md (requisitos, instalacion, avisos).
# Los scripts *_aplicar_* ESCRIBEN en el bus eBUS.
# Topics: todos usan el prefijo ebusd/basv0/ (circuito basv0 del termostato); si el tuyo se llama distinto,
# sustituye 'ebusd/basv0/' en este fichero.
`;
const pkg = {input_select, input_datetime, input_text, mqtt: {sensor: sens}, template: [{sensor: resumen}], script: scripts};
fs.writeFileSync(path.join(out,'packages','aerotermia_horarios.yaml'), cab + dump(pkg));

// --- vista de dashboard ---
const tap = (script, data) => ({action:'perform-action', perform_action:`script.${script}`, ...(data?{data}:{})});
const refresh = (script, data) => [{type:'button', icon:'mdi:refresh', tap_action: tap(script, data)}];
const lista = (p, ico, prog, sel) => ({type:'entities', grid_options:{columns:'full'}, entities: DIAS.map(d => ({
  entity:`sensor.${p}_resumen_${slug(d)}`, name:d, icon:ico, tap_action: tap(sel, prog?{dia:d, programa:prog}:{dia:d})}))});
const bloque = (p, titulo, ico, prog) => [
  {type:'heading', heading:titulo, heading_style:'subtitle', icon:ico, badges: refresh('acs_leer_todos_horarios',{programa:prog})},
  lista(p, ico, prog, 'acs_seleccionar_y_cargar')];
const btn = (name, icon, an, tapa) => ({type:'button', name, icon, action_name:an, tap_action: tapa});
const run = (id, conf) => ({action:'perform-action', perform_action:'script.turn_on', target:{entity_id:`script.${id}`}, ...(conf?{confirmation:{text:conf}}:{})});
const aplicar = (id, conf) => ({type:'tile', grid_options:{columns:'full'}, entity:`script.${id}`, name:'⚠️ APLICAR al termostato (escribe en el bus)', icon:'mdi:content-save-alert', color:'red', hide_state:true, tap_action:{action:'perform-action', perform_action:'script.turn_on', target:{entity_id:`script.${id}`}, confirmation:{text:conf}}});
const vista = {type:'sections', max_columns:5, title:'Aerotermia Horarios', path:'horarios_aerotermia', icon:'mdi:air-filter', sections:[
 {type:'grid', cards:[
  {type:'heading', heading:'Programas horarios del termostato', icon:'mdi:water-boiler-auto', badges: refresh('acs_leer_todos_horarios',{programa:'Todos'})},
  {type:'markdown', grid_options:{columns:'full'}, content:"**Modo ACS del termostato:** {{ states('select.ebusd_basv0_hwcopmode_opmode3') }} · **Reducción de ruido ahora:** {{ states('binary_sensor.ebusd_broadcast_noisereduction_onoff') }} (nivel {{ states('number.ebusd_hmu00_noisereductionlevel_value') }} %)  \n{% if states('select.ebusd_basv0_hwcopmode_opmode3') != 'programado' %}⚠️ **El ACS no sigue el programa horario** (modo «{{ states('select.ebusd_basv0_hwcopmode_opmode3') }}»). Pon el modo en `programado` para que se aplique.  \n{% endif %}*Pulsa un día para cargarlo en el formulario de la derecha. La refrigeración y la reducción de ruido siguen su programa.*"},
  ...bloque('acs','ACS','mdi:water-boiler-auto','ACS'),
  ...bloque('refrigeracion','Refrigeración Z1','mdi:snowflake','Refrigeración'),
  ...bloque('ruido','Reducción de ruido','mdi:volume-off','Reducción de ruido'),
 ]},
 {type:'grid', cards:[
  {type:'heading', heading:'Editar un día', icon:'mdi:calendar-edit'},
  {type:'markdown', grid_options:{columns:'full'}, content:"Editando: **{{ states('input_select.acs_horario_programa') }} · {{ states('input_select.acs_horario_dia') }}** — hoy es {{ ['lunes','martes','miércoles','jueves','viernes','sábado','domingo'][now().weekday()] }}{% if is_state('script.acs_cargar_horario_dia', 'on') %}  \n⏳ **Cargando horario del termostato…**{% endif %}\n\n**1.** Elige programa y día, y carga su horario actual (24:00 se muestra como 23:59)"},
  {type:'entities', grid_options:{columns:'full'}, entities:[
   {entity:'input_select.acs_horario_programa', name:'Programa'},
   {entity:'input_select.acs_horario_dia', name:'Día'},
   btn('Cargar el horario actual del día','mdi:download','CARGAR', run('acs_cargar_horario_dia')),
   {type:'section', label:'2. Modifica las franjas (una franja en 00:00 - 00:00 se considera vacía; no dejes huecos)'},
   ...[['acs_horario_desde','Franja 1 desde'],['acs_horario_hasta','Franja 1 hasta'],['acs_horario_franja_2_desde','Franja 2 desde'],['acs_horario_franja_2_hasta','Franja 2 hasta'],['acs_horario_franja_3_desde','Franja 3 desde'],['acs_horario_franja_3_hasta','Franja 3 hasta']].map(([e,n])=>({entity:`input_datetime.${e}`, name:n})),
  ]},
  aplicar('acs_aplicar_horario','Se escribirán en el termostato todas las franjas del programa (ACS, Refrigeración o Reducción de ruido) y día elegidos. En Reducción de ruido, con las tres franjas en 00:00-00:00 el día se vacía. ¿Continuar?'),
 ]},
 {type:'grid', cards:[
  {type:'heading', heading:'Calefacción Z1 - Programa horario', icon:'mdi:radiator', badges: refresh('calefaccion_leer_todos_horarios')},
  {type:'markdown', grid_options:{columns:'full'}, content:"**Modo Z1:** {{ states('select.ebusd_basv0_z1opmode_opmode') }} · **Consigna actual:** {{ states('number.ebusd_basv0_z1actualroomtempdesired_tempv') }} °C  \n{% if states('select.ebusd_basv0_z1opmode_opmode') != 'auto' %}⚠️ **La calefacción no sigue el programa horario** (modo «{{ states('select.ebusd_basv0_z1opmode_opmode') }}»). Pon el modo Z1 en `auto` para que se aplique.  \n{% endif %}*Pulsa un día para cargarlo en el campo de texto (hasta 12 franjas por día).*"},
  {type:'heading', heading:'Resumen por día (pulsa para cargar)', heading_style:'subtitle', icon:'mdi:radiator'},
  lista('calefaccion','mdi:radiator',null,'calefaccion_seleccionar_y_cargar'),
  {type:'markdown', grid_options:{columns:'full'}, content:"{% set m = {'Lunes':'lunes','Martes':'martes','Miércoles':'miercoles','Jueves':'jueves','Viernes':'viernes','Sábado':'sabado','Domingo':'domingo'} %}{% set dia = states('input_select.calefaccion_horario_dia') %}**{{ dia }}**{% if is_state('script.calefaccion_cargar_horario_dia', 'on') %}  \n⏳ **Leyendo las franjas del termostato…**{% else %}\n{% for i in range(1, 13) %}{% set v = states('sensor.calefaccion_horario_' ~ m.get(dia, '') ~ '_' ~ i) %}{% if v not in ['sin franja', 'unknown', 'unavailable'] and '@' in v %}\n- {{ v.split('@')[0] }} → **{{ v.split('@')[1] }} °C**{% endif %}{% endfor %}{% endif %}"},
 ]},
 {type:'grid', cards:[
  {type:'heading', heading:'Editar un día de calefacción', icon:'mdi:calendar-edit'},
  {type:'markdown', grid_options:{columns:'full'}, content:"Editando: **Calefacción · {{ states('input_select.calefaccion_horario_dia') }}**{% if is_state('script.calefaccion_cargar_horario_dia', 'on') %}  \n⏳ **Cargando franjas del termostato…**{% endif %}\n\n**1.** Pulsa un día de la lista (o elige aquí) y carga su horario"},
  {type:'entities', grid_options:{columns:'full'}, entities:[
   {entity:'input_select.calefaccion_horario_dia', name:'Día'},
   btn('Cargar el horario actual del día','mdi:download','CARGAR', run('calefaccion_cargar_horario_dia')),
   {type:'section', label:'2. Edita el texto: HH:MM-HH:MM@T, separadas por comas (1 a 12 franjas, T de 5 a 30 en pasos de 0,5; 24:00 vale como final)'},
   {entity:'input_text.calefaccion_horario_texto', name:'Franjas'},
  ]},
  aplicar('calefaccion_aplicar_horario','Se escribirá en el termostato el programa de calefacción completo del día elegido. ¿Continuar?'),
 ]},
]};
fs.writeFileSync(path.join(out,'dashboard','vista_horarios.yaml'), '# Vista para el dashboard: editor -> modo YAML (RAW) -> añadir bajo "views:" (o pegar en una vista nueva).\n' + dump([vista]));

// --- opcion B: dashboard propio (aparece en el menu lateral) ---
fs.writeFileSync(path.join(out,'dashboard','aerotermia_horarios_dashboard.yaml'), '# Dashboard completo para la opcion B del README (entrada propia en el menu lateral).\n# Copiar a <config>/dashboards/aerotermia_horarios.yaml y registrarlo con configuracion_lovelace_ejemplo.yaml.\n' + dump({title:'Aerotermia Horarios', views:[vista]}));
fs.writeFileSync(path.join(out,'dashboard','configuracion_lovelace_ejemplo.yaml'), `# Opcion B: anadir a configuration.yaml (si ya tienes la clave lovelace:, anade solo la entrada de dashboards:).
# Tras reiniciar, "Aerotermia Horarios" aparece solo en el menu lateral.
lovelace:
  dashboards:
    aerotermia-horarios:
      mode: yaml
      filename: dashboards/aerotermia_horarios.yaml
      title: Aerotermia Horarios
      icon: mdi:air-filter
      show_in_sidebar: true
`);
console.log('ok', sens.length, 'sensores mqtt,', resumen.length, 'resumenes,', claves.length, 'scripts');
