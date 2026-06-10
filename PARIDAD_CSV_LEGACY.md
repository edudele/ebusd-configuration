# Paridad funcional con los CSV legacy (08.hmu00 y 15.basv0)

Objetivo: que el CSV generado por TypeSpec para **`08.hmu00`** y **`15.basv0`** sea
**funcionalmente equivalente** a los CSV del repositorio antiguo
(`ebusd-configuration-old/ebusd-2.1.x/en/vaillant/`) que están en producción:
mismos mensajes (circuito, nombre, dirección, PBSB+ID), mismos tipos/divisores/
unidades y los mismos juegos de valores (decodificación), para que ebusd y Home
Assistant sigan viendo los mismos datos.

La comparación se hizo resolviendo plantillas e `!include` del CSV antiguo y
normalizando ambos formatos a una forma canónica (mensaje + campos), no comparando
texto.

## Correcciones aplicadas (bugs reales de decodificación)

### `src/vaillant/08.hmu00.tsp`
- **State0 / State**: el `@base` tenía un byte `0` de más → el ID salía `0000`/`0007`
  en lugar de `00`/`07` (mensajes rotos). Corregido `@base(MF, 0x11)`.
- **AirInletTemp** (D.038): usaba `temps` (SCH, 1 byte) cuando el legacy usa `temp`
  (D2C, 2 bytes, /16). Corregido a `D2C` °C → la temperatura ahora se decodifica bien.
- **CurrentCompressorUtil** (D.037): tenía un `@divisor(10)` inexistente en el
  legacy → el % salía /10. Divisor eliminado.
- **FanBoost** (D.366): el ID era inventado (`05ff34540105`). Corregido al ID legacy
  `05ff3541` (placeholder sin campo, como en el viejo).

### `src/vaillant/hcmode_inc.tsp` (compartido por los equipos de calor)
- **SetMode**: se restauraron los campos de bits del legacy
  (`disablehc/disablehwctapping/disablehwcload` y
  `remoteControlHcPump/releaseBackup/releaseCooling` como BI0/BI1/BI2) en lugar de
  dos `UCH` planos, y el modo usa el juego de valores legacy
  `0=auto;1=off;2=heat;3=acs;23=sync` (faltaba `23=sync` y `3` decía `water`).
- Se eliminó el `SetMode` extra de nivel *install* (el legacy solo tiene `uw`).

### `src/vaillant/15.basv0.tsp`
- **MultiRelaySetting**: `mamode` corregido para incluir `4=inactive` (faltaba).
- **Hc{1,2,3}RoomTempSwitchOn**: `rcmode` legacy `0=off;1=activo;2=ampliado`
  (el repo nuevo decía `modulating/thermostat`).
- **Hc1ExtHwcOpMode**: `opmode2` legacy `0=off;1=time_controlled;2=manual`
  (el repo nuevo decía `auto`).
- **BackupBoiler**: `backmode2` con las etiquetas correctas
  `off/heating_circuit/warm_water_circuit/heating_warm_water_circuit`.
  (definidos como juegos de valores locales para no alterar el resto de archivos)

### `src/vaillant/_templates.tsp`
- `Values_mamode`: añadido `inactive: 4`.

### `src/vaillant/errors_inc.tsp` (compartido)
- `Errorhistory` comentado para igualar el legacy, donde `errorhistory` está
  desactivado en `errors.inc`.

> Nota: los cambios en `hcmode_inc.tsp`, `errors_inc.tsp` y `_templates.tsp` son
> includes/plantillas compartidos, por lo que regeneran también otros CSV de
> Vaillant. En todos los casos el cambio **acerca** esos archivos al
> comportamiento del repo antiguo (que compartía esas mismas definiciones), no lo
> rompe.

## Diferencias que NO se pueden eliminar (límites del toolchain TypeSpec→CSV)

Son inherentes al compilador `@ebusd/ebus-typespec` y no afectan a la
decodificación numérica:

1. **Formato del CSV**: cabecera distinta, `PBSB`+`ID` fusionados (`b51a,05ff3200`),
   nombres de campo autogenerados (`value`, `ign`, …) y `r;w` emitido como dos
   líneas `r` y `w`. ebusd lee este formato sin problema.
2. **Nombres de mensaje siempre en PascalCase**: el emisor fuerza mayúscula inicial
   (`message: s => pascalCase(s)`), por lo que `z1…`→`Z1…`, `currenterror`→
   `Currenterror`, `clearerrorhistory`→`Clearerrorhistory`. No es posible mantener
   la minúscula inicial sin parchear el compilador.
3. **Nombres de campo siempre en minúscula** (`remoteControlHcPump`→
   `remotecontrolhcpump`).
4. **Etiquetas de enum = identificador TypeSpec**: no admiten espacios, puntos ni
   acentos. Por eso no se reproducen literalmente, p.ej.:
   - `scode`: `S.104 Calefacción: compresor activo` → `S_104_Calefaccion_compresor_activo`
   - `zoneStatus`: `ventilation boost` → `ventilation_boost`
   - `zmapping`: `VR91.1` → `VR91_1`
   - `escomode`, `HybridManager`, `MultiInputSetting`, … (espacios → `_` o forma corta)
   El valor numérico→estado se mantiene; solo cambia el texto del estado.
5. **D1B↔SCH**: el compilador emite `SCH` donde el legacy ponía `D1B`. Son el mismo
   tipo (entero de 1 byte con signo, factor 1): decodifican idéntico.
6. **Placeholders convertidos en sensores**: `CoolingCompressorStartkMin` y
   `CompressorHysteresis` estaban sin campo en el legacy y el repo nuevo los lee
   como `UIN`. Es una adición inofensiva (datos extra), no una rotura.
7. **`NoiseReduction` (broadcast)**: en el legacy estaba dentro de `15.basv0.csv`;
   en el nuevo se emite en `broadcast.csv`. ebusd lo carga igualmente.

## Cómo regenerar
```bash
npm install --legacy-peer-deps
npm run maintsp && npx tsp compile --emit @ebusd/ebus-typespec src/main.tsp --output-dir outcsv
```
