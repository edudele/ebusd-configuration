# Horarios de la aerotermia Vaillant desde Home Assistant

Edita desde Home Assistant los programas horarios del termostato (VRC720 / `basv0`) a través de ebusd:
**ACS**, **refrigeración Z1**, **calefacción Z1** (hasta 12 franjas/día) y **reducción de ruido**.

> **Los scripts `*_aplicar_*` escriben de verdad en el bus eBUS.** Prueba primero con un día que no te importe.

## Qué incluye

| Fichero | Contenido |
|---|---|
| `packages/aerotermia_horarios.yaml` | 3 `input_select`, 6 `input_datetime`, 1 `input_text`; 147 sensores MQTT (franjas leídas de ebusd), agrupados en el dispositivo «Horarios aerotermia» y marcados como diagnóstico; 28 sensores de resumen por día; 8 scripts |
| `dashboard/vista_horarios.yaml` | Vista para pegar como pestaña (opción A) |
| `dashboard/aerotermia_horarios_dashboard.yaml` + `configuracion_lovelace_ejemplo.yaml` | Mismo contenido como dashboard propio con entrada en el menú lateral (opción B) |
| `build/build_package.cjs` | Regenera los dos ficheros anteriores desde un HA que ya los tenga (uso de mantenimiento) |

Scripts: `acs_leer_todos_horarios`, `acs_cargar_horario_dia`, `acs_seleccionar_y_cargar`, `acs_aplicar_horario` (ACS, refrigeración y ruido) y `calefaccion_leer_todos_horarios`, `calefaccion_cargar_horario_dia`, `calefaccion_seleccionar_y_cargar`, `calefaccion_aplicar_horario`.

## Requisitos

1. **ebusd con las definiciones `b555`** de este repositorio compiladas: `src/vaillant/b555sched_inc.tsp`, incluido desde `15.basv0.tsp` (`npm run compile-en`). Sin ellas no existen los mensajes `HwcTimer_*`, `Z1TimerHeat_*`, `SilentTimer_*`, `*TimerSet_*`, etc.
2. **Termostato con circuito `basv0`** y topics MQTT `ebusd/basv0/...`. Si tu circuito se llama distinto, sustituye `ebusd/basv0/` en el package.
3. **Integración MQTT** de HA conectada al mismo broker que ebusd, con `EBUSD_MQTTJSON=true` (los sensores leen `value_json.from.value` / `to.value`).
4. Para el panel informativo de la vista (no para los scripts) se usan entidades que crea el autodiscovery de ebusd; ajusta sus nombres si los tuyos difieren:
   `select.ebusd_basv0_hwcopmode_opmode3`, `select.ebusd_basv0_z1opmode_opmode`, `number.ebusd_basv0_z1actualroomtempdesired_tempv`, `binary_sensor.ebusd_broadcast_noisereduction_onoff`, `number.ebusd_hmu00_noisereductionlevel_value`.
5. Aplica solo a instalaciones con **una zona** (Z1) y sin recirculación; las zonas 2/3 y la circulación no están implementadas.

## Instalación

1. Activa los packages en `configuration.yaml` (si no los usas ya):
   ```yaml
   homeassistant:
     packages: !include_dir_named packages
   ```
2. Copia `packages/aerotermia_horarios.yaml` a tu carpeta `packages/`.
3. Comprueba la configuración (Herramientas para desarrolladores → YAML) y **reinicia** Home Assistant (los `input_*`, `template` y `mqtt` nuevos requieren reinicio la primera vez).
4. **Dashboard** (los packages no pueden crear dashboards; elige una de las dos opciones):
   - **Opción A: pestaña en tu dashboard** (recomendada). Abre tu dashboard → ⋮ → *Editar* → ⋮ → *Editor de código* y pega el contenido de `dashboard/vista_horarios.yaml` dentro de `views:`. Aparece como pestaña «Aerotermia Horarios». Si usas el dashboard automático por defecto, primero pulsa *Tomar el control* en ese menú.
   - **Opción B: entrada propia en el menú lateral** (automática, sin pegar nada). Copia `dashboard/aerotermia_horarios_dashboard.yaml` a `<config>/dashboards/aerotermia_horarios.yaml` y añade a `configuration.yaml` lo que hay en `dashboard/configuracion_lovelace_ejemplo.yaml`. Tras reiniciar sale en la barra lateral con el icono `mdi:air-filter`. Es un dashboard en YAML: se edita en el fichero, no desde la interfaz.
5. Pulsa el botón ↻ de la vista (`acs_leer_todos_horarios` / `calefaccion_leer_todos_horarios`) para que ebusd publique las franjas actuales.
6. **En ebusd** (`mqtt-hassio.cfg`): el `mqtt-hassio.cfg` de este repositorio ya excluye del autodiscovery las franjas (`hwctimer|z1timer|silenttimer` en `filter-non-name`), que si no aparecerían duplicadas (~250 entidades `heating_ebusd_basv0_…timer…`). Si usas otro `mqtt-hassio.cfg`, añade ese filtro al final de `filter-non-name` y reinicia ebusd. Las entidades que ya existan en HA hay que borrarlas a mano (Ajustes → Entidades, filtrar por «timer»). El refresco de las franjas no depende de ese filtro ni de la pasarela: las definiciones `b555` de este repositorio llevan prioridad de poll propia (`@poll(5)`), así que ebusd las sondea y publica en MQTT por sí mismo.
7. Opcional: asigna los scripts a una categoría desde Ajustes → Automatizaciones → Scripts (las categorías no se pueden definir en YAML).

Si ya tienes entidades con los mismos `unique_id` (por ejemplo, sensores `acs_horario_*` en tu `mqtt.yaml`), elimínalas para no duplicarlas.

## Cómo se usa

- **Ver**: las listas muestran el resumen de cada día (`sensor.<programa>_resumen_<día>`).
- **Editar ACS / refrigeración / ruido**: pulsa un día (carga sus franjas en el formulario), cambia las horas y *Aplicar*. Hasta 3 franjas; sin huecos ni solapes. Una franja 00:00–00:00 es vacía. Solo en *Reducción de ruido* se puede dejar el día vacío.
- **Editar calefacción**: pulsa un día y edita el texto `HH:MM-HH:MM@T, …` (1–12 franjas, T de 5 a 30 °C en pasos de 0,5; `24:00` vale como final).
- `input_datetime` no admite 24:00: se muestra 23:59 y se envía 24:00 (también 00:00 como "hasta").

## Avisos

- El termostato **rechaza una franja suelta**; los scripts envían siempre el **día completo**, en orden.
- **La app myVaillant / la pasarela reescribe los 7 días al guardar** y lee los horarios cada 10–20 min. Refresca (↻) antes de guardar desde la app y espera ese ciclo para ver aquí lo que cambies allí.
- Los horarios solo mandan con el modo adecuado: ACS con `hwcopmode` en automático, calefacción con `Z1OpMode` en automático.
- El script de ruido activa de verdad la reducción de ruido de la bomba (broadcast `b508`).
