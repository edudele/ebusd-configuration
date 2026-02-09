import "@ebusd/ebus-typespec";
import "./_templates.tsp";
import "./errors_inc.tsp";
using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;
namespace Vaillant;

// @zz(0x15)
namespace Basv0 {
  // ,70000,VRC 700,700 110
  // ##### Generell #####

  /** default *r */
  @base(MF, 0x24, 0x2, 0, 0, 0)
  model r_1 {
    @maxLength(4)
    ign: IGN;
  }

  /** default *w */
  @write
  @base(MF, 0x24, 0x2, 1, 0, 0)
  model w_1 {}

  /** default *wi for user level "install" */
  @write
  @auth("install")
  @base(MF, 0x24, 0x2, 1, 0, 0)
  model wi_1 {}

  /** continuos heating */
  @inherit(r_1, w_1)
  @ext(0x2, 0)
  model ContinuosHeating {
    /** -26=off, when the outside temperature falls below this threshold temperature the continuous heating function is started (off <=> function is disabled) */
    value: tempv;
  }

  /** frost delay time */
  @inherit(r_1, w_1)
  @ext(0x3, 0)
  model FrostOverRideTime {
    /** delay before frost protection is activated */
    value: hoursum2;
  }

  /** Global System OFF */
  @inherit(r_1, w_1)
  @ext(0x7, 0)
  model GlobalSystemOff {
    /** For switching system off */
    value: yesno;
  }

  /** hwc parallel loading */
  @inherit(r_1, w_1)
  @ext(0xa, 0)
  model HwcParallelLoading {
    /** heating and hot water parallel */
    value: onoff;
  }

  /** max room humidity */
  @inherit(r_1, w_1)
  @ext(0xe, 0)
  model MaxRoomHumidity {
    /** maximum room humidity */
    value: UIN;
  }

  /** Tri/Bi-valence manager */
  @inherit(r_1)
  @ext(0xf, 0)
  model HybridManager {
    @values(Values_HybridManager)
    value: UCH;
  }

  /** Secondary heater tariff value */
  @inherit(r_1)
  @ext(0x10, 0)
  model TariffAuxHeater {
    value: UIN;
  }

  /** adaptive heat curve */
  @inherit(r_1, w_1)
  @ext(0x14, 0)
  model AdaptHeatCurve {
    /** automatic correction of configured heat curve */
    value: yesno;
  }

  /** maximale Speicherladezeit */
  @inherit(r_1, w_1)
  @ext(0x17, 0)
  model MaxCylinderChargeTime {
    /** maximum cylinder charging time */
    value: minutes2;
  }

  /** hwc lock time */
  @inherit(r_1, w_1)
  @ext(0x18, 0)
  model HwcLockTime {
    /** Sperrzeit WW-Bedarf */
    value: minutes2;
  }

  /** preset flow rate solar circuit for solar yield calculation */
  @inherit(r_1, w_1)
  @ext(0x19, 0)
  model SolarFlowRateQuantity {
    @unit("l/min")
    value: EXP;
  }

  /** pump additional time */
  @inherit(r_1, w_1)
  @ext(0x1b, 0)
  model PumpAdditionalTime {
    /** Ladepumpe Nachlaufzeit */
    value: minutes2;
  }

  /** exclusively alternate heating below alternative point (-21=off) */
  @inherit(r_1, w_1)
  @ext(0x22, 0)
  model HcAlternativePoint {
    value: tempv;
  }

  /** Function of back-up boiler (Off/Hc/Hwc/Hc+Hwc) */
  @inherit(r_1, w_1)
  @ext(0x24, 0)
  model BackupBoiler {
    value: backmode2;
  }

  /** Emergency operation temperature */
  @inherit(r_1)
  @ext(0x26, 0)
  model HcEmergencyTemperature {
    value: tempv;
  }

  /** hysteresis cylinder charge */
  @inherit(r_1, w_1)
  @ext(0x27, 0)
  model CylinderChargeHyst {
    /** Hysterese Speicherladung */
    value: calibrationv;
  }

  /** offset cylinder charge */
  @inherit(r_1, w_1)
  @ext(0x29, 0)
  model CylinderChargeOffset {
    /** Speicherlad. Offset */
    value: calibrationv;
  }

  /** Time hot water legionella run is scheduled (when HwcLegionellaDay is not 0) */
  @inherit(r_1, w_1)
  @ext(0x2a, 0)
  model HwcLegionellaTime {
    value: HTM;
  }

  /** Day hot water legionella run is scheduled */
  @inherit(r_1, w_1)
  @ext(0x2b, 0)
  model HwcLegionellaDay {
    value: daysel2;
  }

  /** next maintenance */
  @inherit(r_1, w_1)
  @ext(0x2c, 0)
  model MaintenanceDate {
    /** Datum nächste Wartung */
    value: date;
  }

  /** Offset outside temperature (used to determined DisplayedOutsideTemp) */
  @inherit(r_1, w_1)
  @ext(0x2d, 0)
  model OffsetOutsideTemp {
    @unit("K")
    value: tempv;
  }

  /** FM5 VR71 module configuration (possible range 1-11 for VRC720 and FM5 used values are 1 2 3 and 6) */
  @inherit(r_1, w_1)
  @ext(0x2f, 0)
  model FM5Config {
    value: UIN;
  }

  /** date */
  @inherit(r_1, w_1)
  @ext(0x34, 0)
  model Date {
    /** Aktuelles Datum */
    value: date;
  }

  /** time */
  @inherit(r_1, w_1)
  @ext(0x35, 0)
  model Time {
    /** Aktuelle Uhrzeit */
    value: HTI;
  }

  /** Systemschema */
  @inherit(r_1, w_1)
  @ext(0x36, 0)
  model HydraulicScheme {
    /** Systemschema */
    value: UIN;
  }

  /** water pressure */
  @inherit(r_1)
  @ext(0x39, 0)
  model WaterPressure {
    /** Wasserdruck */
    value: pressv;
  }

  /** Subtract from z1RoomTemp to get dew point */
  @inherit(r_1)
  @ext(0x3a, 0)
  model DewPointOffset {
    value: tempv;
  }

  /** total solar yield */
  @inherit(r_1, w_1)
  @ext(0x3d, 0)
  model SolarYieldTotal {
    /** Solarertrag gesamt */
    value: energy4;
  }

  /** total environmental yield */
  @inherit(r_1, w_1)
  @ext(0x3e, 0)
  model YieldTotal {
    /** Umweltertrag gesamt */
    value: energy4;
  }

  /** Function to deactivate when Energy Supply Company sends a blocking signal */
  @inherit(r_1, w_1)
  @ext(0x45, 0)
  model ESCOBlockFunction {
    value: escomode;
  }

  /** hwc max flow temp desired */
  @inherit(r_1, w_1)
  @ext(0x46, 0)
  model HwcMaxFlowTempDesired {
    /** maximum flow temperature setpoint of Hwc */
    value: tempv;
  }

  /** system flow temp */
  @inherit(r_1)
  @ext(0x4b, 0)
  model SystemFlowTemp {
    /** Systemvorlauf */
    value: tempv;
  }

  /** multifunction relay setting */
  @inherit(r_1, w_1)
  @ext(0x4d, 0)
  model MultiRelaySetting {
    value: mamode;
  }

  /** this months fuel consumption heating */
  @inherit(r_1, w_1)
  @ext(0x4e, 0)
  model PrFuelSumHcThisMonth {
    /** Aktueller Monat Brennstoffverbrauch Heizung */
    value: energy4;
  }

  /** this months energy consumption heating */
  @inherit(r_1, w_1)
  @ext(0x4f, 0)
  model PrEnergySumHcThisMonth {
    /** Aktueller Monat Stromverbrauch Heizung */
    value: energy4;
  }

  /** this months energy consumption hot water */
  @inherit(r_1, w_1)
  @ext(0x50, 0)
  model PrEnergySumHwcThisMonth {
    /** Aktueller Monat Stromverbrauch hot water */
    value: energy4;
  }

  /** this months fuel consumption hot water */
  @inherit(r_1, w_1)
  @ext(0x51, 0)
  model PrFuelSumHwcThisMonth {
    /** Aktueller Monat Brennstoffverbrauch hot water */
    value: energy4;
  }

  /** last months fuel consumption heating */
  @inherit(r_1, w_1)
  @ext(0x52, 0)
  model PrFuelSumHcLastMonth {
    /** Letzter Monat Brennstoffverbrauch Heizung */
    value: energy4;
  }

  /** last months energy consumption heating */
  @inherit(r_1, w_1)
  @ext(0x53, 0)
  model PrEnergySumHcLastMonth {
    /** Letzter Monat Stromverbrauch Heizung */
    value: energy4;
  }

  /** last months energy consumption hot water */
  @inherit(r_1, w_1)
  @ext(0x54, 0)
  model PrEnergySumHwcLastMonth {
    /** Letzter Monat Stromverbrauch hot water */
    value: energy4;
  }

  /** last months fuel consumption hot water */
  @inherit(r_1, w_1)
  @ext(0x55, 0)
  model PrFuelSumHwcLastMonth {
    /** Letzter Monat Brennstoffverbrauch hot water */
    value: energy4;
  }

  /** total fuel consumption heating */
  @inherit(r_1, w_1)
  @ext(0x56, 0)
  model PrFuelSumHc {
    /** Brennstoffverbrauch Heizung gesamt */
    value: energy4;
  }

  /** total energy consumption heating */
  @inherit(r_1, w_1)
  @ext(0x57, 0)
  model PrEnergySumHc {
    /** Stromverbrauch Heizung gesamt */
    value: energy4;
  }

  /** total energy consumption hot water */
  @inherit(r_1, w_1)
  @ext(0x58, 0)
  model PrEnergySumHwc {
    /** Stromverbrauch hot water gesamt */
    value: energy4;
  }

  /** total fuel consumption hot water */
  @inherit(r_1, w_1)
  @ext(0x59, 0)
  model PrFuelSumHwc {
    /** Brennstoffverbrauch hot water gesamt */
    value: energy4;
  }

  /** multifunction input configuration */
  @inherit(r_1, w_1)
  @ext(0x6a, 0)
  model MultiInputSetting {
    @values(Values_MultiInputSetting)
    value: UIN;
  }

  /** outside temperature */
  @inherit(r_1)
  @ext(0x73, 0)
  model DisplayedOutsideTemp {
    /** Außentemperatur */
    value: tempv;
  }

  /** code for installer menu */
  @inherit(r_1, w_1)
  @ext(0x76, 0)
  model KeyCodeforConfigMenu {
    /** 000-999; code for the installer's menues */
    value: UIN;
  }

  /** average outside temperature */
  @inherit(r_1, w_1)
  @ext(0x95, 0)
  model OutsideTempAvg {
    /** gerundete mittlere Außentemperatur (alle 3h aktualisiert) */
    value: tempv;
  }

  /** maintenance due */
  @inherit(r_1)
  @ext(0x96, 0)
  model MaintenanceDue {
    /** zeigt an ob die Wartung fällig ist */
    value: yesno;
  }

  /** Green IQ mode on thermostat */
  @inherit(r_1)
  @ext(0x9a, 0)
  model GreenIQ {
    value: onoff;
  }

  /** hc storage temperature top */
  @inherit(r_1)
  @ext(0x9f, 0)
  model HcStorageTempTop {
    /** Temp.fühler Hz, oben */
    value: tempv;
  }

  /** hc storage temperature bottom */
  @inherit(r_1)
  @ext(0xa0, 0)
  model HcStorageTempBottom {
    /** Temp.fühler Hz, unten */
    value: tempv;
  }

  /** Offset storage tank loading. Offset */
  @inherit(r_1, w_1)
  @ext(0xa2, 0)
  model HwcCylinderOffset {
    value: calibrationv;
  }

  /** Bivalence point heating */
  @inherit(r_1, w_1)
  @ext(0x23, 0)
  model HcBivalencePoint {
    value: tempv;
  }

  /** Bivalence point heating HWC */
  @inherit(r_1, w_1)
  @ext(1, 0)
  model HwcBivalencePoint {
    value: EXP;
  }

  // ##### hot water circuit #####

  /** default *r */
  @base(MF, 0x24, 0x2, 0, 1, 0)
  model r_2 {
    @maxLength(4)
    ign: IGN;
  }

  /** default *w */
  @write
  @base(MF, 0x24, 0x2, 1, 1, 0)
  model w_2 {}

  /** Indicates if Hwc is enabled/disabled */
  @inherit(r_2, w_2)
  @ext(1, 0)
  model HwcEnabled {
    value: yesno;
  }

  /** Hwc circulation pump status (also turns on during a legionella run) */
  @inherit(r_2)
  @ext(0x2, 0)
  model HwcCircPumpStatus {
    value: onoff;
  }

  /** hwc operation mode */
  @inherit(r_2, w_2)
  @ext(0x3, 0)
  model HwcOpMode {
    /** operation mode of Hwc */
    value: opmode3;
  }

  /** hwc temperature desired */
  @inherit(r_2, w_2)
  @ext(0x4, 0)
  model HwcTempDesired {
    /** setpoint of domestic hot water circuit */
    value: tempv;
  }

  /** hwc storage temperature */
  @inherit(r_2)
  @ext(0x5, 0)
  model HwcStorageTemp {
    /** Speicheristtemperatur */
    value: tempv;
  }

  /** Indicates ongoing hot/legionella water run */
  @inherit(r_2)
  @ext(0x6, 0)
  model HwcReheatingActive {
    value: yesno;
  }

  /** hwc flow temperature */
  @inherit(r_2)
  @ext(0x8, 0)
  model HwcFlowTemp {
    /** desired flow temp for Hwc */
    value: tempv;
  }

  /** hwc holiday start period */
  @inherit(r_2, w_2)
  @ext(0x9, 0)
  model HwcHolidayStartPeriod {
    /** start date of holidays */
    value: hfrom;
  }

  /** hwc holiday end period */
  @inherit(r_2, w_2)
  @ext(0xa, 0)
  model HwcHolidayEndPeriod {
    /** end date of holidays */
    value: hto;
  }

  /** hwc SF mode */
  @inherit(r_2, w_2)
  @ext(0xd, 0)
  model HwcSFMode {
    value: sfmode;
  }

  @inherit(r_2)
  @ext(0xf, 0)
  model HwcStatus {
    value: zoneStatus;
  }

  @inherit(r_2, w_2)
  @ext(0x10, 0)
  model HwcHolidayStartTime {
    value: HTI;
  }

  @inherit(r_2, w_2)
  @ext(0x11, 0)
  model HwcHolidayEndTime {
    value: HTI;
  }

  // ##### heating circuit 1 #####

  /** default *r */
  @base(MF, 0x24, 0x2, 0, 0x2, 0)
  model r_3 {
    @maxLength(4)
    ign: IGN;
  }

  /** default *w */
  @write
  @base(MF, 0x24, 0x2, 1, 0x2, 0)
  model w_3 {}

  /** CircuitType heating circuit 1 */
  @inherit(r_3)
  @ext(0x2, 0)
  model Hc1CircuitType {
    mctype: mctype;
    @maxLength(1)
    ign: IGN;
  }

  /** Dew point monitoring enable/disable for Hc1 */
  @inherit(r_3, w_3)
  @ext(0x5, 0)
  model Hc1DewPointMonitoring {
    value: onoff;
  }

  /** Cooling function enable/disable for Hc1 */
  @inherit(r_3, w_3)
  @ext(0x6, 0)
  model Hc1CoolingEnabled {
    value: onoff;
  }

  /** ActualFlowTempDesired heating circuit 1 */
  @inherit(r_3)
  @ext(0x7, 0)
  model Hc1ActualFlowTempDesired {
    /** current flow temperature setpoint of Hc1 */
    value: tempv;
  }

  /** FlowTemp heating circuit 1 */
  @inherit(r_3)
  @ext(0x8, 0)
  model Hc1FlowTemp {
    /** current flow temperature of Hc1 */
    value: tempv;
  }

  /** Dew point temperature margin for Hc1 */
  @inherit(r_3, w_3)
  @ext(0xa, 0)
  model Hc1DewPointOffset {
    value: tempv;
  }

  /** ExcessTemp heating circuit 1 */
  @inherit(r_3, w_3)
  @ext(0xb, 0)
  model Hc1ExcessTemp {
    /** excess temperature of Hc1 (flow temperature's setpoint is increased by this value to keep the mixing valve in its control range) */
    value: calibrationv;
  }

  /** Desired Temperature Heating Circuit 1 */
  @inherit(r_3, w_3)
  @ext(0xc, 0)
  model Hc1DesiredTemp {
    value: tempv;
  }

  /** target setback temperatur Hc1 (fixed circuit type) */
  @inherit(r_3, w_3)
  @ext(0xd, 0)
  model Hc1DesiredSetbackTemp {
    value: tempv;
  }

  /** AutoOffMode heating circuit 1 */
  @inherit(r_3, w_3)
  @ext(0xe, 0)
  model Hc1AutoOffMode {
    /** operation of Hc1 during the lowering time; no influence if room temperature modulation is set to thermostat */
    value: offmode;
  }

  /** HeatCurve heating circuit 1 */
  @inherit(r_3, w_3)
  @ext(0xf, 0)
  model Hc1HeatCurve {
    /** heating curve of Hc1 */
    value: EXP;
  }

  /** MaxFlowTempDesired Heating Circuit 1 */
  @inherit(r_3, w_3)
  @ext(0x10, 0)
  model Hc1MaxFlowTempDesired {
    /** maximum heating flow temperature setpoint (end emphasis) of Hc1 */
    value: tempv;
  }

  /** minimum cooling flow temperature setpoint of Hc1 */
  @inherit(r_3, w_3)
  @ext(0x11, 0)
  model Hc1MinCoolingFlowTempDesired {
    value: tempv;
  }

  /** MinFlowTempDesired Heating Circuit 1 */
  @inherit(r_3, w_3)
  @ext(0x12, 0)
  model Hc1MinFlowTempDesired {
    /** minimum heating flow temperature setpoint (end emphasis) of Hc1 */
    value: tempv;
  }

  /** operation mode of external Hwc circuit */
  @inherit(r_3, w_3)
  @ext(0x13, 0)
  model Hc1ExtHwcOpMode {
    value: opmode2;
  }

  /** Switch off temperature threshold Heating Circuit 1 */
  @inherit(r_3, w_3)
  @ext(0x14, 0)
  model Hc1SummerTempLimit {
    /** if outside temperature > summer limit => heating is OFF;applies to comfort and night setback setpoint */
    value: tempv;
  }

  /** RoomTempSwitchOn heating circuit 1 */
  @inherit(r_3, w_3)
  @ext(0x15, 0)
  model Hc1RoomTempSwitchOn {
    /** room temperature modulation of Hc1 */
    value: rcmode;
  }

  /** current day of screed Hc1 drying schedule (1 to 29 0=screed drying off) */
  @inherit(r_3, w_3)
  @ext(0x16, 0)
  model Hc1ScreedDryingDay {
    value: UIN;
  }

  /** current Hc1 screed drying desired temp */
  @inherit(r_3)
  @ext(0x17, 0)
  model Hc1ScreedDryingDesiredTemp {
    value: tempv;
  }

  @inherit(r_3)
  @ext(0x18, 0)
  model Hc1ExtHwcActive {
    value: onoff;
  }

  /** indicator of external heat demand for Hc1 */
  @inherit(r_3)
  @ext(0x19, 0)
  model Hc1ExtHeatDemand {
    value: onoff;
  }

  /** MixerMovement heating circuit 1 */
  @inherit(r_3)
  @ext(0x1a, 0)
  model Hc1MixerMovement {
    /** status of mixer (<0 closing, >0 opening) */
    value: EXP;
  }

  /** Status Heating Circuit 1 */
  @inherit(r_3, w_3)
  @ext(0x1b, 0)
  model Hc1Status {
    /** status of zone 1 */
    value: UCH;
  }

  /** HeatCurveAdaption heating circuit 1 */
  @inherit(r_3)
  @ext(0x1c, 0)
  model Hc1HeatCurveAdaption {
    /** adaption applied to heating curve of Hc1 */
    value: EXP;
  }

  /** PumpStatus heating circuit 1 */
  @inherit(r_3, w_3)
  @ext(0x1e, 0)
  model Hc1PumpStatus {
    /** pump status of zone 1 */
    @values(Values_Hc1PumpStatus)
    value: UIN;
  }

  // ##### heating circuit 2 #####

  /** default *r */
  @base(MF, 0x24, 0x2, 0, 0x2, 1)
  model r_4 {
    @maxLength(4)
    ign: IGN;
  }

  /** default *w */
  @write
  @base(MF, 0x24, 0x2, 1, 0x2, 1)
  model w_4 {}

  /** CircuitType heating circuit 2 */
  @inherit(r_4)
  @ext(0x2, 0)
  model Hc2CircuitType {
    mctype: mctype;
    @maxLength(1)
    ign: IGN;
  }

  /** ActualFlowTempDesired heating circuit 2 */
  @inherit(r_4)
  @ext(0x7, 0)
  model Hc2ActualFlowTempDesired {
    /** current flow temperature setpoint of Hc2 */
    value: tempv;
  }

  /** FlowTemp heating circuit 2 */
  @inherit(r_4)
  @ext(0x8, 0)
  model Hc2FlowTemp {
    /** current flow temperature of Hc2 */
    value: tempv;
  }

  /** ExcessTemp heating circuit 2 */
  @inherit(r_4, w_4)
  @ext(0xb, 0)
  model Hc2ExcessTemp {
    /** excess temperature of Hc2 (flow temperature's setpoint is increased by this value to keep the mixing valve in its control range) */
    value: calibrationv;
  }

  /** AutoOffMode heating circuit 2 */
  @inherit(r_4, w_4)
  @ext(0xe, 0)
  model Hc2AutoOffMode {
    /** operation of Hc2 during the lowering time; no influence if room temperature modulation is set to thermostat */
    value: offmode;
  }

  /** HeatCurve heating circuit 2 */
  @inherit(r_4, w_4)
  @ext(0xf, 0)
  model Hc2HeatCurve {
    /** heating curve of Hc2 */
    value: EXP;
  }

  /** MaxFlowTempDesired heating circuit 2 */
  @inherit(r_4, w_4)
  @ext(0x10, 0)
  model Hc2MaxFlowTempDesired {
    /** maximum flow temperature setpoint (end emphasis) of Hc2 */
    value: tempv;
  }

  /** MinFlowTempDesired heating circuit 2 */
  @inherit(r_4, w_4)
  @ext(0x12, 0)
  model Hc2MinFlowTempDesired {
    /** minimum flow temperature setpoint (end emphasis) of Hc2 */
    value: tempv;
  }

  /** summer outside switchoff temperature heating circuit 2 */
  @inherit(r_4, w_4)
  @ext(0x14, 0)
  model Hc2SummerTempLimit {
    /** if outside temperature > summer limit => heating is OFF;applies to comfort and night setback setpoint */
    value: tempv;
  }

  /** RoomTempSwitchOn heating circuit 2 */
  @inherit(r_4, w_4)
  @ext(0x15, 0)
  model Hc2RoomTempSwitchOn {
    /** room temperature modulation of Hc2 */
    value: rcmode;
  }

  /** MixerMovement heating circuit 2 */
  @inherit(r_4)
  @ext(0x1a, 0)
  model Hc2MixerMovement {
    /** status of mixer (<0 closing, >0 opening) */
    value: EXP;
  }

  /** HeatCurveAdaption heating circuit 2 */
  @inherit(r_4)
  @ext(0x1c, 0)
  model Hc2HeatCurveAdaption {
    /** adaption applied to heating curve of Hc2 */
    value: EXP;
  }

  /** Status heating circuit 2 */
  @inherit(r_4, w_4)
  @ext(0x1b, 0)
  model Hc2Status {
    /** status of zone 2 */
    value: UCH;
  }

  /** PumpStatus heating circuit 2 */
  @inherit(r_4, w_4)
  @ext(0x1e, 0)
  model Hc2PumpStatus {
    /** pump status of zone 2 */
    value: UIN;
  }

  // ##### heating circuit 3 #####

  /** default *r */
  @base(MF, 0x24, 0x2, 0, 0x2, 0x2)
  model r_5 {
    @maxLength(4)
    ign: IGN;
  }

  /** default *w */
  @write
  @base(MF, 0x24, 0x2, 1, 0x2, 0x2)
  model w_5 {}

  /** CircuitType heating circuit 3 */
  @inherit(r_5)
  @ext(0x2, 0)
  model Hc3CircuitType {
    mctype: mctype;
    @maxLength(1)
    ign: IGN;
  }

  /** ActualFlowTempDesired heating circuit 3 */
  @inherit(r_5)
  @ext(0x7, 0)
  model Hc3ActualFlowTempDesired {
    /** current flow temperature setpoint of Hc3 */
    value: tempv;
  }

  /** FlowTemp heating circuit 3 */
  @inherit(r_5)
  @ext(0x8, 0)
  model Hc3FlowTemp {
    /** current flow temperature of Hc3 */
    value: tempv;
  }

  /** ExcessTemp heating circuit 3 */
  @inherit(r_5, w_5)
  @ext(0xb, 0)
  model Hc3ExcessTemp {
    /** excess temperature of Hc3 (flow temperature's setpoint is increased by this value to keep the mixing valve in its control range) */
    value: calibrationv;
  }

  /** AutoOffMode heating circuit 3 */
  @inherit(r_5, w_5)
  @ext(0xe, 0)
  model Hc3AutoOffMode {
    /** operation of Hc3 during the lowering time; no influence if room temperature modulation is set to thermostat */
    value: offmode;
  }

  /** HeatCurve heating circuit 3 */
  @inherit(r_5, w_5)
  @ext(0xf, 0)
  model Hc3HeatCurve {
    /** heating curve of Hc3 */
    value: EXP;
  }

  /** MaxFlowTempDesired heating circuit 3 */
  @inherit(r_5, w_5)
  @ext(0x10, 0)
  model Hc3MaxFlowTempDesired {
    /** maximum flow temperature setpoint (end emphasis) of Hc3 */
    value: tempv;
  }

  /** MinFlowTempDesired heating circuit 3 */
  @inherit(r_5, w_5)
  @ext(0x12, 0)
  model Hc3MinFlowTempDesired {
    /** minimum flow temperature setpoint (end emphasis) of Hc3 */
    value: tempv;
  }

  /** summer outside switchoff temperature heating circuit 3 */
  @inherit(r_5, w_5)
  @ext(0x14, 0)
  model Hc3SummerTempLimit {
    /** if outside temperature > summer limit => heating is OFF;applies to comfort and night setback setpoint */
    value: tempv;
  }

  /** RoomTempSwitchOn heating circuit 3 */
  @inherit(r_5, w_5)
  @ext(0x15, 0)
  model Hc3RoomTempSwitchOn {
    /** room temperature modulation of Hc3 */
    value: rcmode;
  }

  /** MixerMovement heating circuit 3 */
  @inherit(r_5)
  @ext(0x1a, 0)
  model Hc3MixerMovement {
    /** status of mixer (<0 closing, >0 opening) */
    value: EXP;
  }

  /** HeatCurveAdaption heating circuit 3 */
  @inherit(r_5)
  @ext(0x1c, 0)
  model Hc3HeatCurveAdaption {
    /** adaption applied to heating curve of Hc3 */
    value: EXP;
  }

  /** Status heating circuit 3 */
  @inherit(r_5, w_5)
  @ext(0x1b, 0)
  model Hc3Status {
    /** status of zone 2 */
    value: UCH;
  }

  /** PumpStatus heating circuit 3 */
  @inherit(r_5, w_5)
  @ext(0x1e, 0)
  model Hc3PumpStatus {
    /** pump status of zone 3 */
    value: UIN;
  }

  // ##### zone 1 #####

  /** default *r */
  @base(MF, 0x24, 0x2, 0, 0x3, 0)
  model r_6 {
    @maxLength(4)
    ign: IGN;
  }

  /** default *w */
  @write
  @base(MF, 0x24, 0x2, 1, 0x3, 0)
  model w_6 {}

  /** cooling operation mode zone 1 */
  @inherit(r_6, w_6)
  @ext(1, 0)
  model z1OpModeCooling {
    /** operation mode for cooling of zone 1 */
    value: opmode;
  }

  /** cooling setpoint zone 1 */
  @inherit(r_6, w_6)
  @ext(0x2, 0)
  model z1CoolingTemp {
    /** desired cooling setpoint for zone 1 */
    value: tempv;
  }

  /** holiday period start zone 1 */
  @inherit(r_6, w_6)
  @ext(0x3, 0)
  model z1HolidayStartPeriod {
    /** start date of holidays for zone 1 */
    value: hfrom;
  }

  /** holiday period end zone 1 */
  @inherit(r_6, w_6)
  @ext(0x4, 0)
  model z1HolidayEndPeriod {
    /** end date of holidays for zone 1 */
    value: hto;
  }

  /** room setpoint holiday period zone 1 */
  @inherit(r_6, w_6)
  @ext(0x5, 0)
  model z1HolidayTemp {
    /** holiday setpoint for zone 1 */
    value: tempv;
  }

  /** operation mode zone 1 */
  @inherit(r_6, w_6)
  @ext(0x6, 0)
  model z1OpMode {
    /** operation mode of zone 1 */
    value: opmode;
  }

  /** quick veto temperature zone 1 */
  @inherit(r_6, w_6)
  @ext(0x8, 0)
  model z1QuickVetoTemp {
    /** manual override setpoint for zone 1 */
    value: tempv;
  }

  /** night temperature zone 1 */
  @inherit(r_6, w_6)
  @ext(0x9, 0)
  model z1NightTemp {
    /** night setpoint for zone 1 */
    value: tempv;
  }

  /** valve status zone 1 */
  @inherit(r_6, w_6)
  @ext(0x12, 0)
  model z1ValveStatus {
    /** valve status of zone 1 */
    @values(Values_z1ValveStatus)
    value: UCH;
  }

  /** room zone mapping zone 1 */
  @inherit(r_6, w_6)
  @ext(0x13, 0)
  model z1RoomZoneMapping {
    /** configures which room temperature is assigned to zone 1 */
    value: zmapping;
  }

  /** room temperature desired zone 1 */
  @inherit(r_6, w_6)
  @ext(0x14, 0)
  model z1ActualRoomTempDesired {
    /** current room setpoint considering all basic conditions passed to the control algorithms */
    value: tempv;
  }

  /** cooling setpoint zone 1 */
  @inherit(r_6, w_6)
  @ext(0x15, 0)
  model z1ManualCoolingTemp {
    /** desired cooling setpoint for zone 1 */
    value: tempv;
  }

  /** Kurzbezeichnung zone 1 */
  @inherit(r_6, w_6)
  @ext(0x16, 0)
  model z1Shortname {
    /** short name of zone 1 */
    value: shortname;
  }

  /** zone 1 label (first part) */
  @inherit(r_6, w_6)
  @ext(0x17, 0)
  model z1Name1 {
    /** name of zone 1 */
    value: zname;
  }

  /** zone 1 label (second part) */
  @inherit(r_6, w_6)
  @ext(0x18, 0)
  model z1Name2 {
    /** name of zone 1 */
    value: zname;
  }

  /** end time of holidays for zone 1 */
  @inherit(r_6, w_6)
  @ext(0x20, 0)
  model z1HolidayEndTime {
    value: HTI;
  }

  /** start time of holidays for zone 1 */
  @inherit(r_6, w_6)
  @ext(0x21, 0)
  model z1HolidayStartTime {
    value: HTI;
  }

  /** desired temperature zone 1 */
  @inherit(r_6, w_6)
  @ext(0x22, 0)
  model z1ManualTemp {
    /** day setpoint for zone 1 */
    value: tempv;
  }

  /** Desired Cooling Room Temperature Zone 1 manual controlled */
  @inherit(r_6, w_6)
  @ext(0x23, 0)
  model z1CoolingRoomTempDesiredManualControlled {
    /** manual controlled desired cooling room temperature for zone 1 */
    value: tempv;
  }

  /** end date of Quick Veto mode Zone 1 */
  @inherit(r_6)
  @ext(0x24, 0)
  model z1QuickVetoEndDate {
    /** Quick Veto mode end date Zone 1 */
    value: date;
  }

  /** Duration of Quick Veto mode in Hours Zone 1 */
  @inherit(r_6, w_6)
  @ext(0x26, 0)
  model z1QuickVetoDuration {
    /** valid values are 0.5-12 in 0.5 increments (default 3) writing enables quick veto mode */
    value: EXP;
  }

  /** room humidity zone 1 */
  @inherit(r_6)
  @ext(0x28, 0)
  model z1RoomHumidity {
    @unit("%")
    /** room humidity zone1 */
    value: EXP;
  }

  /** SF mode zone 1 */
  @inherit(r_6, w_6)
  @ext(0xe, 0)
  model z1SFMode {
    value: sfmode;
  }

  /** room temperature zone 1 */
  @inherit(r_6)
  @ext(0xf, 0)
  model z1RoomTemp {
    /** current room temperature in zone 1 */
    value: tempv;
  }

  @inherit(r_6)
  @ext(0x1b, 0)
  model z1Status {
    value: zoneStatus;
  }

  /** Quick Veto End Time Zone 1 */
  @inherit(r_6)
  @ext(0x1e, 0)
  model z1QuickVetoEndTime {
    /** manual override end time for zone 1 */
    value: HTI;
  }

  // ##### zone 2 #####

  /** default *r */
  @base(MF, 0x24, 0x2, 0, 0x3, 1)
  model r_7 {
    @maxLength(4)
    ign: IGN;
  }

  /** default *w */
  @write
  @base(MF, 0x24, 0x2, 1, 0x3, 1)
  model w_7 {}

  /** cooling operation mode zone 2 */
  @inherit(r_7, w_7)
  @ext(1, 0)
  model z2OpModeCooling {
    /** operation mode for cooling of zone 2 */
    value: opmode;
  }

  /** cooling setpoint zone 2 */
  @inherit(r_7, w_7)
  @ext(0x2, 0)
  model z2CoolingTemp {
    /** desired cooling setpoint for zone 2 */
    value: tempv;
  }

  /** holiday period start zone 2 */
  @inherit(r_7, w_7)
  @ext(0x3, 0)
  model z2HolidayStartPeriod {
    /** start date of holidays for zone 2 */
    value: hfrom;
  }

  /** holiday period end zone 2 */
  @inherit(r_7, w_7)
  @ext(0x4, 0)
  model z2HolidayEndPeriod {
    /** end date of holidays for zone 2 */
    value: hto;
  }

  /** room setpoint holiday period zone 2 */
  @inherit(r_7, w_7)
  @ext(0x5, 0)
  model z2HolidayTemp {
    /** holiday setpoint for zone 2 */
    value: tempv;
  }

  /** operation mode zone 2 */
  @inherit(r_7, w_7)
  @ext(0x6, 0)
  model z2OpMode {
    /** operation mode of zone 2 */
    value: opmode;
  }

  /** desired temperature zone 2 */
  @inherit(r_7, w_7)
  @ext(0x7, 0)
  model z2DayTemp {
    /** day setpoint for zone 2 */
    value: tempv;
  }

  /** quick veto temperature zone 2 */
  @inherit(r_7, w_7)
  @ext(0x8, 0)
  model z2QuickVetoTemp {
    /** manual override setpoint for zone 2 */
    value: tempv;
  }

  /** night temperature zone 2 */
  @inherit(r_7, w_7)
  @ext(0x9, 0)
  model z2NightTemp {
    /** night setpoint for zone 2 */
    value: tempv;
  }

  /** bank holiday start zone 2 */
  @inherit(r_7, w_7)
  @ext(0xc, 0)
  model z2BankHolidayStartPeriod {
    /** start date of bank holidays for zone 2 */
    value: hfrom;
  }

  /** bank holiday end zone 2 */
  @inherit(r_7, w_7)
  @ext(0xd, 0)
  model z2BankHolidayEndPeriod {
    /** end date of bank holidays for zone 2 */
    value: hto;
  }

  /** SF mode zone 2 */
  @inherit(r_7, w_7)
  @ext(0xe, 0)
  model z2SFMode {
    value: sfmode;
  }

  /** room temperature zone 2 */
  @inherit(r_7)
  @ext(0xf, 0)
  model z2RoomTemp {
    /** current room temperature in zone 2 */
    value: tempv;
  }

  /** valve status zone 2 */
  @inherit(r_7, w_7)
  @ext(0x12, 0)
  model z2ValveStatus {
    /** valve status of zone 2 */
    value: UCH;
  }

  /** room zone mapping zone 2 */
  @inherit(r_7, w_7)
  @ext(0x13, 0)
  model z2RoomZoneMapping {
    /** configures which room temperature is assigned to zone 2 */
    value: zmapping;
  }

  /** room temperature desired zone 2 */
  @inherit(r_7, w_7)
  @ext(0x14, 0)
  model z2ActualRoomTempDesired {
    /** current room setpoint considering all basic conditions passed to the control algorithms */
    value: tempv;
  }

  /** Kurzbezeichnung zone 2 */
  @inherit(r_7, w_7)
  @ext(0x16, 0)
  model z2Shortname {
    /** short name of zone 2 */
    value: shortname;
  }

  /** zone 2 label (first part) */
  @inherit(r_7, w_7)
  @ext(0x17, 0)
  model z2Name1 {
    /** name of zone 2 */
    value: zname;
  }

  /** zone 2 label (second part) */
  @inherit(r_7, w_7)
  @ext(0x18, 0)
  model z2Name2 {
    /** name of zone 2 */
    value: zname;
  }

  // ##### zone 3 #####

  /** default *r */
  @base(MF, 0x24, 0x2, 0, 0x3, 0x2)
  model r_8 {
    @maxLength(4)
    ign: IGN;
  }

  /** default *w */
  @write
  @base(MF, 0x24, 0x2, 1, 0x3, 0x2)
  model w_8 {}

  /** cooling operation mode zone 3 */
  @inherit(r_8, w_8)
  @ext(1, 0)
  model z3OpModeCooling {
    /** operation mode for cooling of zone 3 */
    value: opmode;
  }

  /** cooling setpoint zone 3 */
  @inherit(r_8, w_8)
  @ext(0x2, 0)
  model z3CoolingTemp {
    /** desired cooling setpoint for zone 3 */
    value: tempv;
  }

  /** holiday period start zone 3 */
  @inherit(r_8, w_8)
  @ext(0x3, 0)
  model z3HolidayStartPeriod {
    /** start date of holidays for zone 3 */
    value: hfrom;
  }

  /** holiday period end zone 3 */
  @inherit(r_8, w_8)
  @ext(0x4, 0)
  model z3HolidayEndPeriod {
    /** end date of holidays for zone 3 */
    value: hto;
  }

  /** room setpoint holiday period zone 3 */
  @inherit(r_8, w_8)
  @ext(0x5, 0)
  model z3HolidayTemp {
    /** holiday setpoint for zone 3 */
    value: tempv;
  }

  /** operation mode zone 3 */
  @inherit(r_8, w_8)
  @ext(0x6, 0)
  model z3OpMode {
    /** operation mode of zone 3 */
    value: opmode;
  }

  /** desired temperature zone 3 */
  @inherit(r_8, w_8)
  @ext(0x7, 0)
  model z3DayTemp {
    /** day setpoint for zone 3 */
    value: tempv;
  }

  /** quick veto temperature zone 3 */
  @inherit(r_8, w_8)
  @ext(0x8, 0)
  model z3QuickVetoTemp {
    /** manual override setpoint for zone 3 */
    value: tempv;
  }

  /** night temperature zone 3 */
  @inherit(r_8, w_8)
  @ext(0x9, 0)
  model z3NightTemp {
    /** night setpoint for zone 3 */
    value: tempv;
  }

  /** bank holiday start zone 3 */
  @inherit(r_8, w_8)
  @ext(0xc, 0)
  model z3BankHolidayStartPeriod {
    /** start date of bank holidays for zone 3 */
    value: hfrom;
  }

  /** bank holiday end zone 3 */
  @inherit(r_8, w_8)
  @ext(0xd, 0)
  model z3BankHolidayEndPeriod {
    /** end date of bank holidays for zone 3 */
    value: hto;
  }

  /** SF mode zone 3 */
  @inherit(r_8, w_8)
  @ext(0xe, 0)
  model z3SFMode {
    value: sfmode;
  }

  /** room temperature zone 3 */
  @inherit(r_8)
  @ext(0xf, 0)
  model z3RoomTemp {
    /** current room temperature in zone 3 */
    value: tempv;
  }

  /** valve status zone 3 */
  @inherit(r_8, w_8)
  @ext(0x12, 0)
  model z3ValveStatus {
    /** valve status of zone 3 */
    value: UCH;
  }

  /** room zone mapping zone 3 */
  @inherit(r_8, w_8)
  @ext(0x13, 0)
  model z3RoomZoneMapping {
    /** configures which room temperature is assigned to zone 3 */
    value: zmapping;
  }

  /** room temperature desired zone 3 */
  @inherit(r_8, w_8)
  @ext(0x14, 0)
  model z3ActualRoomTempDesired {
    /** current room setpoint considering all basic conditions passed to the control algorithms */
    value: tempv;
  }

  /** shortlabel zone 3 */
  @inherit(r_8, w_8)
  @ext(0x16, 0)
  model z3Shortname {
    /** short name of zone 3 */
    value: shortname;
  }

  /** label zone 3 part 1 */
  @inherit(r_8, w_8)
  @ext(0x17, 0)
  model z3Name1 {
    /** name of zone 3 */
    value: zname;
  }

  /** label zone 3 part 2 */
  @inherit(r_8, w_8)
  @ext(0x18, 0)
  model z3Name2 {
    /** name of zone 3 */
    value: zname;
  }

  // ##### broadcast #####
  /** default *r */
  @base(MF, 0x8)
  model broadcast_r {
    @maxLength(1)
    ign: IGN;
  }

  /** default *b */
  @zz(0xfe)
  @passive
  @base(MF, 0x8)
  model broadcast_b {
    @maxLength(1)
    ign: IGN;
  }

  /** default *w */
  @write
  @zz(0xfe)
  @base(MF, 0x8)
  model broadcast_w {}

  // ##### Included parts #####
  union _includes {
    Errors_inc,
  }
}

// Enums for Values

enum Values_HybridManager {
  Trivalence_tariff_based: 0,
  Bivalence_Outside_temperature_based: 1,
}

enum Values_MultiInputSetting {
  not_connected: 0,
  _1x_circulation: 1,
  photovoltaics: 2,
  Ext_Cooling: 3,
}

enum Values_Hc1PumpStatus {
  off: 0,
  on: 1,
}

enum Values_z1ValveStatus {
  close: 0,
  open: 1,
}

@unit("%")
scalar percent0 extends UIN;
