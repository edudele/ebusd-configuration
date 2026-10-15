import "@ebusd/ebus-typespec";
import "../_templates.tsp";
using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;

namespace Vaillant;
alias MF = 0xb5; // Ebus.Id.Values_manufacturers.Vaillant

/** temperature */
@unit("°C")
scalar temps extends SCH;

/** temperature */
@unit("°C")
scalar temps2 extends SIN;

/** temperature */
@unit("°C")
scalar tempv extends EXP;

/** pressure */
@unit("bar")
scalar press extends FLT;

/** pressure */
@unit("bar")
scalar pressv extends EXP;

/** percentage */
@unit("%")
scalar percentv extends EXP;

/** date */
scalar date extends HDA3;

/** weekday */
scalar day extends BDY;

/** day selector */
@values(Values_daysel)
scalar daysel extends UCH;

/** day selector */
@values(Values_daysel2)
scalar daysel2 extends UCH;

/** days */
scalar days extends UCH;

/** time */
scalar time extends VTI;

/** time */
scalar time2 extends VTM;

/** minutes */
@unit("min")
@divisor(120)
scalar minutes extends ULG;

/** minutes */
@unit("min")
scalar minutes4 extends ULG;

/** minutes */
@unit("min")
scalar minutes0 extends UCH;

/** minutes */
@unit("min")
scalar minutes2 extends UIN;

/** minutes */
@unit("min")
@factor(5)
scalar minutes5 extends UCH;

/** hours */
@unit("h")
scalar hoursum extends ULG;

/** hours */
@unit("h")
scalar hoursum2 extends UIN;

/** hours */
@unit("h")
scalar hours extends UCH;

/** hours */
@unit("h")
scalar hours1 extends D1C;

/** hours */
@unit("h")
@factor(12)
scalar hours12 extends UCH;

/** hour */
@unit("h")
scalar hour extends UCH;

/** seconds */
@unit("s")
@divisor(2)
scalar seconds extends ULG;

/** seconds */
@unit("s")
scalar seconds0 extends UCH;

/** seconds */
@unit("s")
scalar seconds2 extends UIN;

/** seconds */
@unit("s")
scalar seconds4 extends ULG;

@unit("K")
scalar calibration extends D2C;

@unit("K")
scalar calibration0 extends UCH;

@unit("K")
scalar calibration1 extends D1C;

@unit("K")
@divisor(2)
scalar calibrations extends SCH;

@unit("K")
scalar calibrationv extends EXP;

@unit("°min")
scalar integral extends SIN;

/** boiler mode */
@values(Values_hcmode)
scalar hcmode extends UCH;

/** boiler mode */
@values(Values_hcmode2)
scalar hcmode2 extends UCH;

/** hc pump mode */
@values(Values_hcpumpmode)
scalar hcpumpmode extends UCH;

/** hybrid manager mode */
@values(Values_hmmode)
scalar hmmode extends UCH;

/** mixer mode */
@values(Values_mcmode)
scalar mcmode extends UCH;

/** mixer type */
@values(Values_mctype)
scalar mctype extends UCH;

/** mixer type */
@values(Values_mctype7)
scalar mctype7 extends BI0_7;

/** hot water mode */
@values(Values_hwcmode)
scalar hwcmode extends UCH;

/** hot water mode */
@values(Values_hwcmode2)
scalar hwcmode2 extends UCH;

/** hot water mode (eco/normal/balance) */
@values(Values_hmu_hwcmode)
scalar hmu_hwcmode extends UCH;

/** mixer State */
@values(Values_mixer)
scalar mixer extends UCH;

/** zone valve state */
@values(Values_openclose)
scalar openclose extends UCH;

/** day/night mode */
@values(Values_daynight)
scalar daynight extends UCH;

/** Status */
scalar status extends UCH;

/** ESCO */
@values(Values_escomode)
scalar escomode extends UCH;

@values(Values_onoff)
scalar onoff extends UCH;

@values(Values_yesno)
scalar yesno extends UCH;

@values(Values_onoff2)
scalar onoff2 extends UCH;

@values(Values_yesno2)
scalar yesno2 extends UCH;

@values(Values_errorok)
scalar errorok extends UCH;

/** sensor status */
@values(Values_sensor)
scalar sensor extends UCH;

model tempsensor {
  temp: temp;
  sensor: sensor;
}

@unit("°C")
scalar tempmirror extends UIN;

model tempmirrorsensor {
  temp: temp;
  tempmirror: tempmirror;
  sensor: sensor;
}

model presssensor {
  press: press;
  sensor: sensor;
}

/** pressure */
@unit("mbar")
scalar pressm extends ULG;

/** pressure */
@unit("mbar")
scalar pressm2 extends UIN;

@divisor(100)
scalar uin100 extends UIN;

/** Heating curve */
@divisor(100)
scalar curve extends UIN;

/** phase 1 state */
@values(Values_phase1)
scalar phase1 extends BI0;

/** phase 2 state */
@values(Values_phase2)
scalar phase2 extends BI1;

/** phase 3 state */
@values(Values_phase3)
scalar phase3 extends BI2;

model phase {
  phase: phase1;
  phase_1: phase2;
  phase_2: phase3;
}

scalar code extends PIN;

/** error number */
scalar error extends UIN;

model errors {
  error: error;
  error_2: error;
  error_3: error;
  error_4: error;
  error_5: error;
}

model errorhistory {
  status: status;
  time: time2;
  date: date;
  error: error;
}

/** from */
scalar from extends TTM;

/** to */
scalar to extends TTM;

/** slot 1 from/to */
model slot1 {
  from: from;
  to: to;
}

/** slot 2 from/to */
model slot2 {
  from: from;
  to: to;
}

/** slot 3 from/to */
model slot3 {
  from: from;
  to: to;
}

/** slots 1-3 */
model slot1_3 {
  slot: slot1;
  slot_1: slot2;
  slot_2: slot3;
}

model timer {
  slot1_: slot1_3;
  daysel: daysel;
}

@values(Values_backtype)
scalar backtype extends UCH;

@values(Values_backmode)
scalar backmode extends UCH;

@values(Values_backmode2)
scalar backmode2 extends UCH;

@unit("kW")
scalar power extends UCH;

@unit("kWh")
scalar energy extends UIN;

@unit("kWh")
scalar energyr extends UIR;

@unit("kWh")
scalar energy4 extends ULG;

@unit("kWh")
@divisor(1000)
scalar energye extends EXP;

/** start count */
scalar cntstarts extends ULG;

/** start count */
scalar cntstarts2 extends UIN;

/** pump power */
@values(Values_pumppow)
scalar pumppow extends UCH;

/** pump state */
@values(Values_pumpstate)
scalar pumpstate extends UCH;

/** DCF receiver state */
@values(Values_dcfstate)
scalar dcfstate extends UCH;

/** phase state */
@values(Values_phaseok)
scalar phaseok extends UCH;

/** valve position */
@values(Values_switchvalve)
scalar switchvalve extends UCH;

/** valve position */
@values(Values_switchvalve2)
scalar switchvalve2 extends UCH;

/** holiday period from */
scalar hfrom extends HDA3;

/** holiday period to */
scalar hto extends HDA3;

/** holiday period 1 from; 2 from; 1 to; 2 to */
model holiday {
  hfrom: hfrom;
  hfrom_1: hfrom;
  hto: hto;
  hto_1: hto;
}

/** heating state */
@values(Values_hpstatus)
scalar hpstatus extends UCH;

/** frequency */
@unit("Hz")
scalar frequency extends UIN;

/** selected zone */
@values(Values_zonesel)
scalar zonesel extends UIN;

@values(Values_zonestatus)
scalar zonestatus extends UIN;

@values(Values_sfmode)
scalar sfmode extends UCH;

@values(Values_sfmodezone)
scalar sfmodezone extends UCH;

@values(Values_sfmodehwc)
scalar sfmodehwc extends UCH;

@values(Values_opmode)
scalar opmode extends UIN;

@values(Values_opmode2)
scalar opmode2 extends UIN;

@values(Values_opmode3)
scalar opmode3 extends UIN;

@values(Values_zmapping)
scalar zmapping extends UIN;

/** heat circuit name */
@maxLength(11)
scalar hcname extends STR;

/** zone name */
@maxLength(5)
scalar zname extends STR;

/** name */
@maxLength(6)
scalar shortname extends STR;

/** phone number */
@maxLength(9)
scalar phone extends STR;

/** phone number */
@maxLength(6)
scalar shortphone extends STR;

@values(Values_mamode)
scalar mamode extends UIN;

@values(Values_offmode)
scalar offmode extends UIN;

@values(Values_offmode2)
scalar offmode2 extends UIN;

@values(Values_rcmode)
scalar rcmode extends UIN;

@values(Values_rcmode2)
scalar rcmode2 extends UIN;

/** index of a time slot */
scalar slotIndex extends UCH;

/** number of slots on a day */
scalar slotCount extends UCH;

/** number of slots per weekday */
model slotCountWeek {
  @maxLength(1) ign: IGN;
  slotCount: slotCount;
  slotCount_1: slotCount;
  slotCount_2: slotCount;
  slotCount_3: slotCount;
  slotCount_4: slotCount;
  slotCount_5: slotCount;
  slotCount_6: slotCount;
  @maxLength(1) ign_1: IGN;
}

/** timeslot from/until */
model slotTimeFrame {
  htm: HTM;
  htm_1: HTM;
}

/** desired temperature of a slot */
@unit("°C")
@divisor(10)
scalar slotTemp extends UIN;

/** complete slot for writing with target temperature */
model wTimeSlotWithTemp {
  slotIndex: slotIndex;
  slotCount: slotCount;
  slotTimeFrame: slotTimeFrame;
  slotTemp: slotTemp;
}

/** constant value for writing a slot without target temperature */
@constValue(0xffff)
scalar wTimeSlotConst extends U2L;

/** complete slot for writing without target temperature */
model wTimeSlotWithoutTemp {
  slotIndex: slotIndex;
  slotCount: slotCount;
  slotTimeFrame: slotTimeFrame;
  wTimeSlotConst: wTimeSlotConst;
}

/** complete slot for reading with target temperature */
model rTimeSlotWithTemp {
  @maxLength(1) ign: IGN;
  slotTimeFrame: slotTimeFrame;
  slotTemp: slotTemp;
}

/** complete slot for reading without target temperature */
model rTimeSlotWithoutTemp {
  @maxLength(1) ign: IGN;
  slotTimeFrame: slotTimeFrame;
  @maxLength(2) ign_1: IGN;
}

/** Status code */
@values(Values_appliancecode)
scalar appliancecode extends UCH;

/** HMU Status code */
@values(Values_hmucode)
scalar hmucode extends UIN;

enum Values_daysel {
  selected: 0,
  `Mo-Fr`: 1,
  `Sa-Su`: 2,
  `Mo-Su`: 3,
}

enum Values_daysel2 {
  off: 0,
  Mon: 1,
  Tue: 2,
  Wed: 3,
  Thu: 4,
  Fri: 5,
  Sat: 6,
  Sun: 7,
  Daily: 8,
}

enum Values_opmode3 {
  apagado: 0,
  programado: 1,
  manual: 2,
  night: 3,
}

enum Values_hcmode {
  auto: 0,
  off: 1,
  heat: 2,
  acs: 3,
  sync: 23,
}

enum Values_hcmode2 {
  off: 0,
  cooling: 1,
  heat: 3,
  water: 4,
}

enum Values_hcpumpmode {
  off: 0,
  heat: 1,
  cool: 2,
  exthwc: 3,
}

enum Values_hmmode {
  trivalence: 0,
  bivalence: 1,
}

enum Values_mcmode {
  disabled: 0,
  on: 1,
  off: 2,
  auto: 3,
  eco: 4,
  low: 5,
}

enum Values_mctype {
  inactive: 0,
  mixer: 1,
  fixed: 2,
  hwc: 3,
  returnincr: 4,
  pool: 5,
}

enum Values_mctype7 {
  inactive: 0,
  mixer: 1,
  fixed: 2,
  hwc: 3,
  returnincr: 4,
  pool: 5,
  circulation: 6,
}

enum Values_escomode {
  `HeatPump off`: 0,
  `Backup Boiler off`: 1,
  `HP+BB off`: 2,
  `Heating off`: 3,
  `Cooling off`: 4,
  `Heating+Cooling off`: 5,
}

enum Values_hwcmode {
  disabled: 0,
  on: 1,
  off: 2,
  auto: 3,
}

enum Values_hwcmode2 {
  off: 0,
  on: 1,
  auto: 2,
  manual: 3,
}

enum Values_hmu_hwcmode {
  eco: 0,
  normal: 1,
  balance: 2,
}

enum Values_mixer {
  off: 0,
  open: 1,
  close: 2,
}

enum Values_openclose {
  close: 0,
  open: 1,
}

enum Values_daynight {
  night: 0,
  day: 1,
  load: 4,
  floorpaving: 7,
}

enum Values_onoff {
  off: 0,
  on: 1,
}

enum Values_yesno {
  no: 0,
  yes: 1,
}

enum Values_onoff2 {
  off: 240,
  on: 15,
}

enum Values_yesno2 {
  no: 240,
  yes: 15,
}

enum Values_errorok {
  ok: 0,
  error: 1,
}

enum Values_sensor {
  ok: 0,
  circuit: 85,
  cutoff: 170,
}

enum Values_phase1 {
  missing: 0,
  present: 1,
}

enum Values_phase2 {
  missing: 0,
  present: 1,
}

enum Values_phase3 {
  missing: 0,
  present: 1,
}

enum Values_backtype {
  `not present`: 0,
  externalheat: 1,
  externalwater: 2,
  externalheatandwater: 3,
  internalheatandwater: 4,
}

enum Values_backmode {
  `no backup`: 0,
  withbackup: 1,
  onlybackup: 2,
}

enum Values_backmode2 {
  off: 0,
  `heating circuit`: 1,
  `warm water circuit`: 2,
  `heating + warm water circuit`: 3,
}

enum Values_pumppow {
  `0`: 0,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
  `5`: 5,
  `6`: 6,
  off: 7,
}

enum Values_pumpstate {
  off: 0,
  on: 1,
  overrun: 2,
  hwc: 4,
}

enum Values_dcfstate {
  nosignal: 0,
  ok: 1,
  sync: 2,
  valid: 3,
}

enum Values_phaseok {
  error: 0,
  ok: 7,
}

enum Values_switchvalve {
  heat: 0,
  water: 1,
}

enum Values_switchvalve2 {
  heat: 0,
  both: 50,
  water: 100,
  standby: 254,
}

enum Values_hpstatus {
  off: 0,
  heat: 3,
  standby: 6,
  otshutdown: 7,
  water: 8,
}

enum Values_zonesel {
  alle: 0,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
  `5`: 5,
  `6`: 6,
}

enum Values_zonestatus {
  auto: 0,
  `ventilation boost`: 1,
  party: 3,
  `quick veto`: 4,
  `one day away from home`: 5,
  `one day at home`: 6,
  `holiday away`: 7,
  `holiday at home`: 8,
  load: 9,
  off: 10,
}

enum Values_sfmode {
  auto: 0,
  ventilation: 1,
  party: 2,
  veto: 3,
  onedayaatway: 4,
  onedayhome: 5,
  load: 6,
}

enum Values_sfmodezone {
  auto: 0,
  ventilation: 1,
  veto: 3,
}

enum Values_sfmodehwc {
  auto: 0,
  load: 6,
}

enum Values_opmode {
  off: 0,
  auto: 1,
  day: 2,
  night: 3,
}

enum Values_opmode2 {
  off: 0,
  `time controlled`: 1,
  manual: 2,
}

enum Values_zmapping {
  none: 0,
  VRC700: 1,
  `VR91.1`: 2,
  `VR91.2`: 3,
  `VR91.3`: 4,
}

enum Values_mamode {
  circulation: 0,
  dryer: 1,
  zone: 2,
  legiopump: 3,
  inactive: 4,
}

enum Values_offmode {
  eco: 0,
  night: 1,
}

enum Values_offmode2 {
  eco: 0,
  normal: 1,
}

enum Values_rcmode {
  off: 0,
  activo: 1,
  ampliado: 2,
}

enum Values_rcmode2 {
  inactive: 0,
  active: 1,
  expanded: 2,
}

enum Values_appliancecode {
  off: 0,
  prerun: 1,
  pump_prerun: 2,
  ignition: 3,
  on: 4,
  overrun: 5,
  fan_overrun: 6,
  pump_overrun: 7,
  shutdown: 8,
  measure: 9,
  hwc_desired: 10,
  hwc_prerun: 11,
  hwc_pump_prerun: 12,
  hwc_ignition: 13,
  hwc_on: 14,
  hwc_overrun: 15,
  hwc_fan_overrun: 16,
  hwc_pump_overrun: 17,
  hwc_shutdown: 18,
  frost_protect: 34,
}

enum Values_hmucode {
  frost_protect: 34,
  standby: 100,
  heat_compressor_shutdown: 101,
  heat_compressor_blocked: 102,
  heat_prerun: 103,
  heat_compressor_active: 104,
  heat_overrun: 107,
  cool_compressor_shutdown: 111,
  cool_compressor_blocked: 112,
  cool_prerun: 113,
  cool_compressor_active: 114,
  cool_overrun: 117,
  heat_immersion_heater_active: 125,
  hwc_compressor_blocked: 132,
  hwc_prerun: 133,
  hwc_compressor_active: 134,
  hwc_immersion_heater_active: 135,
  hwc_overrun: 137,
  heat_immersion_heater_shutdown: 141,
  heat_immersion_heater_blocked: 142,
  hwc_immersion_heater_shutdown: 151,
  hwc_immersion_heater_blocked: 152,
  air_purging_program_active: 202,
  compressor_oil_heating_active: 240,
  fan1_blocked: 252,
  fan1_airinlet_too_high: 255,
  fan1_airinlet_too_low: 256,
  fan2_blocked: 260,
  building_circuit_flow_too_low: 275,
  building_circuit_pump_fault: 277,
  frequency_converter_fault_compressor: 280,
  frequency_converter_fault_mains_voltage: 281,
  frequency_converter_fault_overheating: 282,
  deicing_time_too_long: 283,
  deicing_flow_temp_too_low: 284,
  compressor_outlet_temp_too_high: 285,
  hot_gas_temp_switch_open: 286,
  fan1_wind: 287,
  fan2_wind: 288,
  current_limt_active: 289,
  high_pressure_switch_open: 302,
  compressor_outlet_temp_too_high_1: 303,
  evaporation_temp_too_low: 304,
  condensation_temp_too_low: 305,
  evaporation_temp_too_high: 306,
  condensation_temp_too_high: 308,
  building_circuit_return_temp_too_low: 312,
  building_circuit_return_temp_too_high: 314,
  immersion_heater_flow_temp_too_high: 351,
  deicing_active: 516,
  frequency_converter_fault: 575,
  connection_fault_frequency_converter: 581,
  four_port_valve_position_fault: 590,
}

/** default *r for register */
@base(MF, 0x9, 0xd)
model r {}

/** default *w for register */
@write
@base(MF, 0x9, 0xe)
model w {}

/** default *u for register */
@passive
@base(MF, 0x9, 0x29)
model u {
  @maxLength(2)
  ign: IGN;
}

/** default *wi for register with user level "install" */
@write
@auth("install")
@base(MF, 0x9, 0xe)
model wi {}

/** default *ws for register with user level "service" */
@write
@auth("service")
@base(MF, 0x9, 0xe)
model ws {}

/** read/write register */
@inherit(r, w)
model Register<T> {
  value: T;
}

/** read only register */
@inherit(r)
model ReadonlyRegister<T> {
  value: T;
}

/** installer level register */
@inherit(r, wi)
model InstallRegister<T> {
  value: T;
}

/** service level register */
@inherit(r, ws)
model ServiceRegister<T> {
  value: T;
}

/** read/write updated register */
@inherit(r, w, u)
model UpdateRegister<T> {
  value: T;
}

/** read only updated register */
@inherit(r, u)
model ReadonlyUpdateRegister<T> {
  value: T;
}

/** installer level updated register */
@inherit(r, wi, u)
model InstallUpdateRegister<T> {
  value: T;
}

/** service level updated register */
@inherit(r, ws, u)
model ServiceUpdateRegister<T> {
  value: T;
}

/** default *r for mode */
@base(MF, 0x04)
model rm {}

/** default *w for mode */
@write
@base(MF, 0x05)
model wm {}

/** default *r for timer */
@base(MF, 0x15)
model rt {
  @maxLength(1)
  ign: IGN;
}

/** default *w for timer */
@write
@base(MF, 0x15)
model wt {}

/** timer */
@inherit(rt, wt)
model Timer<T> {
  /** timer value */
  value: T;
}

/** display contrast */
@minValue(0)
@maxValue(15)
scalar displaycontrast extends UCH;

/** zone status */
@values(Values_zoneStatus)
scalar zoneStatus extends UIN;

/** power */
@unit("W")
scalar powerv extends EXP;

/** Status code for heat pump operations */
@values(Values_scode)
scalar scode extends UIN;

/** Zone status values */
enum Values_zoneStatus {
  auto: 0,
  ventilation_boost: 1,
  party: 3,
  quick_veto: 4,
  one_day_away_from_home: 5,
  one_day_at_home: 6,
  holiday_away: 7,
  holiday_at_home: 8,
  load: 9,
}


/** Status code values for heat pump */
enum Values_scode {
  `S.34 Modo calefacción: Protección heladas`: 34,
  `S.100 En espera`: 100,
  `S.101 Calefacción: desconexión del compresor`: 101,
  `S.102 Calefacción: compresor bloqueado`: 102,
  `S.103 Calefacción: pre-funcionamiento`: 103,
  `S.104 Calefacción: compresor activo`: 104,
  `S.107 Calefacción: post-funcionamiento`: 107,
  `S.111 Refrigeración: desconexión del compresor`: 111,
  `S.112 Refrigeración: compresor bloqueado`: 112,
  `S.113 Refrigeración: pre-funcionamiento compresor`: 113,
  `S.114 Refrigeración: compresor activo`: 114,
  `S.117 Refrigeración: post-funcionamiento compresor`: 117,
  `S.125 Calefacción: calentador inmersión activo`: 125,
  `S.132 ACS: compresor bloqueado`: 132,
  `S.133 ACS: pre-funcionamiento`: 133,
  `S.134 ACS: compresor activo`: 134,
  `S.135 ACS: calentador inmersión activo`: 135,
  `S.137 ACS: post-funcionamiento`: 137,
  `S.141 Calefacción: desconexión calentador inmersión`: 141,
  `S.142 Calefacción: calentador de inmersión bloqueado`: 142,
  `S.151 ACS: desconexión calentador inmersión`: 151,
  `S.152 ACS: calentador inmersión bloqueado`: 152,
  `S.173 Tiempo bloqueo empresa suministro electricidad`: 173,
  `S.202 Programa comprobación: purga circuito del edificio activa`: 202,
  `S.203 Prueba actuadores activa`: 203,
  `S.212 Error conexión: regulador no detectado`: 212,
  `S.240 Aceite compresor y ambiente demasiado fríos`: 240,
  `S.252 Unidad ventilador 1: ventilador bloqueado`: 252,
  `S.255 Unidad ventilador 1: temperatura entrada aire muy alta`: 255,
  `S.256 Unidad ventilador 1: temperatura entrada aire muy baja`: 256,
  `S.260 Unidad ventilador 2: ventilador bloqueado`: 260,
  `S.272 Circuito edificio: presión disponible (bomba) limitación activa`: 272,
  `S.273 Circuito edificio: temperatura ida demasiado baja`: 273,
  `S.275 Circuito edificio: caudal demasiado bajo`: 275,
  `S.276 Circuito edificio: contacto bloqueo S20 abierto`: 276,
  `S.277 Circuito edificio: error en bomba`: 277,
  `S.280 Error convertidor: Compresor`: 280,
  `S.281 Error convertidor: Tensión de red`: 281,
  `S.282 Error convertidor: Sobrecalentamiento`: 282,
  `S.283 Tiempo eliminación hielo demasiado largo`: 283,
  `S.284 Temperatura ida eliminación hielo muy justa`: 284,
  `S.285 Temperatura de salida compresor muy baja`: 285,
  `S.286 Interruptor temperatura gas caliente abierto`: 286,
  `S.287 Ventilador 1: viento`: 287,
  `S.288 Ventilador 2: viento`: 288,
  `S.289 Limitación tensión activada`: 289,
  `S.290 Retardo de conexión activo`: 290,
  `S.302 Interruptor de alta presión abierto`: 302,
  `S.303 Temperatura salida compresor demasiado alta`: 303,
  `S.304 Temperatura evaporación demasiado baja`: 304,
  `S.305 Temperatura condensación demasiado baja`: 305,
  `S.306 Temperatura evaporación demasiado alta`: 306,
  `S.308 Temperatura condensación demasiado alta`: 308,
  `S.312 Circuito edificio: temperatura retorno demasiado baja`: 312,
  `S.314 Circuito edificio: temperatura retorno demasiado alta`: 314,
  `S.516 Eliminación de hielo activa`: 516,
  `S.575 Convertidor frecuencia: error interno`: 575,
  `S.581 Error de conexión: convertidor frecuencia no detectado`: 581,
  `S.590 Error: posición incorrecta válvula de 4 vías`: 590,
}
