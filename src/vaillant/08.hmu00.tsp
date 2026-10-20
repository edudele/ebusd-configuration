import "@ebusd/ebus-typespec";
import "./_templates.tsp";
import "./hcmode_inc.tsp";
import "./errors_inc.tsp";
import "./b516stat_inc.tsp";
using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;
namespace Vaillant;

// @zz(0x08)
namespace Hmu00 {
  // Elementos adicionales del 08.hmu00.csv que no están en 08.hmu.tsp principal

  /** default *r for B511 messages */
  @base(MF, 0x11, 0)
  model r_b511 {}

  /** State0 - complete state message with multiple fields */
  @inherit(r_b511)
  @ext(0)
  model State0 {
    field1: UCH;
    field2: UIN;
    field3: UCH;
    field4: UCH;
    field5: UIN;
    field6: UCH;
  }

  /** default *r for extended statistics */
  @base(MF, 0x1a, 0x5, 0xff, 0x32)
  model r_stats {
    @maxLength(3)
    ign: IGN;
  }

  /** default *w for extended statistics */
  @write
  @base(MF, 0x1a, 0x6, 0xff)
  model w_stats {}

  /** State */
  @inherit(r_b511)
  @ext(7)
  model State {
    energy: UCH;
    @unit("kWh")
    energy_2: energy;
    onoff: UCH;
    state: UCH;
  }

  /** D.000 Heating energy yield current day */
  @inherit(r_stats)
  @ext(0)
  model DayHeatingYield {
    @divisor(10)
    energy: energy;
  }

  /** D.001 Cooling energy yield current day */
  @inherit(r_stats)
  @ext(1)
  model DayCoolingYield {
    @divisor(10)
    energy: energy;
  }

  /** D.002 Domestic energy yield current day */
  @inherit(r_stats)
  @ext(2)
  model DayHwcYield {
    @divisor(10)
    energy: energy;
  }

  /** D.014 Heating energy yield current month */
  @inherit(r_stats)
  @ext(0xe)
  model MonthHeatingYield {
    @divisor(10)
    energy: energy;
  }

  /** D.015 Heating work factor current month */
  @inherit(r_stats)
  @ext(0xf)
  model MonthHeatingWorkFactor {
    @divisor(10)
    d1b: D1B;
  }

  /** D.016 Heating energy yield total */
  @inherit(r_stats)
  @ext(0x10)
  model TotalHeatingYield {
    energy: energy;
  }

  /** D.017 Heating work factor total */
  @inherit(r_stats)
  @ext(0x11)
  model TotalHeatingWorkFactor {
    @divisor(10)
    d1b: D1B;
  }

  /** D.018 HWC energy yield current month */
  @inherit(r_stats)
  @ext(0x12)
  model MonthHwcEnergyYield {
    @divisor(10)
    energy: energy;
  }

  /** D.019 HWC work factor current month */
  @inherit(r_stats)
  @ext(0x13)
  model MonthHwcWorkFactor {
    @divisor(10)
    d1b: D1B;
  }

  /** D.022 Energy yield HWC total */
  @inherit(r_stats)
  @ext(0x16)
  model TotalHwcYield {
    energy: energy;
  }

  /** D.023 HWC work factor total */
  @inherit(r_stats)
  @ext(0x17)
  model TotalHwcWorkFactor {
    @divisor(10)
    d1b: D1B;
  }

  /** Compressor block time */
  @inherit(r_stats)
  @ext(0x1e)
  model CompressorBlocktime {
    @unit("min")
    uin: UIN;
  }

  /** Supply temperature weighted */
  @inherit(r_stats)
  @ext(0x1f)
  model SupplyTempWeighted {
    @unit("°C")
    @divisor(10)
    d2c: D2C;
  }

  /** Flow temperature 32 */
  @inherit(r_stats)
  @ext(0x20)
  model FlowTemp32 {
    @unit("°C")
    d2c: D2C;
  }

  /** D.033 Energy Integral */
  @inherit(r_stats)
  @ext(0x21)
  model EnergyIntegral {
    @unit("°min")
    slg: SLG;
  }

  /** D.035 Current yield power */
  @inherit(r_stats)
  @ext(0x23)
  model CurrentYieldPower {
    @unit("kW")
    @divisor(10)
    d1b: D1B;
  }

  /** D.036 Current consumed power */
  @inherit(r_stats)
  @ext(0x24)
  model CurrentConsumedPower {
    @unit("kW")
    @divisor(10)
    d1b: D1B;
  }

  /** D.037 Current compressor speed */
  @inherit(r_stats)
  @ext(0x25)
  model CurrentCompressorUtil {
    @unit("%")
    d1b: D1B;
  }

  /** D.038 Air inlet temperature */
  @inherit(r_stats)
  @ext(0x26)
  model AirInletTemp {
    temp: temp;
  }

  /** D.042 Cooling energy yield current month */
  @inherit(r_stats)
  @ext(0x2a)
  model MonthCoolingYield {
    @unit("kWh")
    @divisor(10)
    energy: energy;
  }

  /** Monthly cooling work factor (SEER) */
  @inherit(r_stats)
  @ext(0x2b)
  model MonthCoolingWorkFactor {
    @divisor(10)
    energy: energy;
  }

  /** Total Cop Cooling */
  @inherit(r_stats)
  @ext(0x2d)
  model TotalCoolingWorkFactor {
    @divisor(10)
    energy: energy;
  }

  /** D.044 Cooling energy yield total */
  @inherit(r_stats)
  @ext(0x2c)
  model TotalCoolingYield {
    energy: energy;
  }

  /** Water throughput */
  @inherit(r_stats)
  @ext(0x3c)
  model WaterThroughput {
    @unit("l/h")
    uin: UIN;
  }

  /** Flow pressure */
  @inherit(r_stats)
  @ext(0x3d)
  model FlowPressure {
    @unit("bar")
    @divisor(4)
    d2c: D2C;
  }

  /** D.064 Total working hours */
  @inherit(r_stats)
  @ext(0x40)
  model TotalHours {
    hoursum2: hoursum2;
  }

  /** D.065 Total heating working hours */
  @inherit(r_stats)
  @ext(0x41)
  model TotaHoursHeating {
    hoursum2: hoursum2;
  }

  /** D.067 Total cooling working hours */
  @inherit(r_stats)
  @ext(0x43)
  model TotaHoursCooling {
    hoursum2: hoursum2;
  }

  /** D.068 Total HWC working hours */
  @inherit(r_stats)
  @ext(0x44)
  model TotaHoursHwc {
    hoursum2: hoursum2;
  }

  /** Total energy usage */
  @inherit(r_stats)
  @ext(0x4d)
  model TotalEnergyUsage {
    @unit("kWh")
    energy: energy;
  }

  /** default *r for configuration params */
  @base(MF, 0x1a, 0x5, 0xff, 0x33)
  model r_config {
    @maxLength(3)
    ign: IGN;
  }

  /** default *rw for configuration params */
  @write
  @base(MF, 0x1a, 0x6, 0xff, 0x33)
  model rw_config {}

  /** D.222 Building circuit pump speed (heating). 0-100% (49=auto). Step 1. Factory 49 */
  @inherit(r_config, rw_config)
  @ext(0x16)
  model CircuitBuildingHeatingPumpSpeed {
    @unit("%")
    d1b: D1B;
  }

  /** D.223 Building circuit pump speed (cooling). 0-100% (49=auto). Step 1. Factory 49 */
  @inherit(r_config, rw_config)
  @ext(0x17)
  model CircuitBuildingCoolingPumpSpeed {
    @unit("%")
    d1b: D1B;
  }

  /** D.224 Building circuit pump speed (hwc). 0-100% (49=auto). Step 1. Factory 49 */
  @inherit(r_config, rw_config)
  @ext(0x18)
  model CircuitBuildingHwcPumpSpeed {
    @unit("%")
    d1b: D1B;
  }

  /** Minimum block time duration (in minutes) */
  @inherit(r_config, rw_config)
  @ext(0x19)
  model MainsBlocktimeMinDuration {
    @unit("min")
    uch: UCH;
  }

  /** D.227 Cooling Enabled */
  @inherit(r_config)
  @ext(0x1b)
  model CoolingEnabled {
    @values(Values_CoolingEnabled)
    uin: UIN;
  }

  /** D.231 Maximum exterior unit power */
  @inherit(r_config, rw_config)
  @ext(0x1f)
  model MaximunExteriorPowerUnit {
    @unit("A")
    d1b: D1B;
  }

  /** D.233 Heat exchanger */
  @inherit(r_config)
  @ext(0x21)
  model HeatExchangerEnabled {
    @values(Values_HeatExchangerEnabled)
    uin: UIN;
  }

  /** D.100 Compressor hours */
  @inherit(r_stats_ext)
  @ext(0)
  model CompressorHours {
    hoursum: hoursum;
  }

  /** D.101 Compressor starts */
  @inherit(r_stats_ext)
  @ext(1)
  model CompressorStarts {
    uin: UIN;
  }

  /** D.102 Building hours */
  @inherit(r_stats_ext)
  @ext(2)
  model BuildingPumpHours {
    hoursum: hoursum;
  }

  /** D.103 Building starts */
  @inherit(r_stats_ext)
  @ext(3)
  model BuildingPumpStarts {
    uin: UIN;
  }

  /** D.106 4-port valve hours */
  @inherit(r_stats_ext)
  @ext(6)
  model FourWayValveHours {
    hoursum: hoursum;
  }

  /** D.107 4-port valve switch oprations */
  @inherit(r_stats_ext)
  @ext(7)
  model FourWayValveSwitchingOperations {
    uin: UIN;
  }

  /** D.113 EEV Steps */
  @inherit(r_stats_ext)
  @ext(0xd)
  model EEVSteps {
    uin: UIN;
  }

  /** Domestic hot water mod (eco/normal/balance) */
  @inherit(r_stats_ext, rw_stats_ext)
  @ext(0x44)
  model HwcMode {
    uch: hmu_hwcmode;
  }

  /** D.181 Fan 1 hours */
  @inherit(r_stats_ext)
  @ext(0x51)
  model Fan1Hours {
    hoursum: hoursum;
  }

  /** D.182 Fan 1 starts */
  @inherit(r_stats_ext)
  @ext(0x52)
  model Fan1Starts {
    uin: UIN;
  }

  /** D.194 Fan 2 hours */
  @inherit(r_stats_ext)
  @ext(0x5e)
  model Fan2Hours {
    hoursum: hoursum;
  }

  /** D.195 Fan 2 starts */
  @inherit(r_stats_ext)
  @ext(0x5f)
  model Fan2Starts {
    uin: UIN;
  }

  /** default *r for extended stats *r */
  @base(MF, 0x1a, 0x5, 0xff, 0x34)
  model r_stats_ext {
    @maxLength(3)
    ign: IGN;
  }

  /** default *w for extended stats */
  @write
  @base(MF, 0x1a, 0x6, 0xff, 0x34)
  model w_stats_ext {}

  /** default *rw for extended stats */
  @write
  @base(MF, 0x1a, 0x6, 0xff, 0x34)
  model rw_stats_ext {}

  /** default *r for extended stats without ign (for special extended messages) */
  @base(MF, 0x1a, 0x5, 0xff, 0x34)
  model r_stats_ext_noign {}

  /** D.130 Total compressor starts */
  @inherit(r_stats_ext)
  @ext(0x1e)
  model TotalCompressorStarts {
    uin: UIN;
  }

  /** D.131 Max water pump pressure */
  @inherit(r_stats_ext)
  @ext(0x1f)
  model MaxWaterPumpPressure {
    @unit("mbar")
    value: UIN;

    @unit("mbar")
    minimun: UIN;

    @unit("mbar")
    maximun: UIN;

    @unit("mbar")
    step: D1B;
  }

  /** D.133 Cooling compressor start ºmin */
  @inherit(r_stats_ext)
  @ext(0x21)
  model CoolingCompressorStartkMin {
    value: UIN;
  }

  /** D.140 Noise reduction level min 30% max 60% */
  @inherit(r_stats_ext, rw_stats_ext)
  @ext(0x28)
  model NoiseReductionLevel {
    @unit("%")
    value: D1B;
  }

  /** Number of switching operations */
  @inherit(r_stats_ext)
  @ext(0x30)
  model NoOfSwitchingOps {
    uin: UIN;
  }

  /** D.145 Maximum block time hours. 0-9 h. Step 1 h. Factory 5 */
  @inherit(r_stats_ext, rw_stats_ext)
  @ext(0x2d)
  model MaximunBlockTimeHours {
    @unit("h")
    d1b: D1B;
  }

  /** D.167 Compressor Hysteresis. 0-15 K. Step 1 K. Factory 7 K */
  @inherit(r_stats_ext, rw_stats_ext)
  @ext(0x43)
  model CompressorHysteresis {
    value: UIN;
  }

  /** D.366 Fan boost */
  @inherit(r_stats_ext_noign)
  @ext(0x54, 0x1, 0x5)
  model FanBoost {
    value: UIN;
  }

  /** default *r Additional values from VWZ menu (Live Monitor Main) */
  @base(MF, 0x3, 0)
  model r_live {
    @maxLength(2)
    ign: IGN;
  }

  /** default *w Live Monitor */
  @write
  @base(MF, 0x3, 0)
  model w_live {}

  /** Payload needed sent: 03FFFF */
  @inherit(w_live)
  @ext()
  model ReadLiveMonitorMain {
    @maxLength(1)
    hex: HEX;
  }

  /** default *r for test values */
  @base(MF, 0x14, 0x5)
  model r_test {
    @maxLength(2)
    ign: IGN;
  }

  /** T.0.01 Building circuit pump power */
  @inherit(r_test)
  @ext(1, 3, 0xff, 0xff)
  model CircuitBuildingPumpPower {
    @unit("%")
    uin: UIN;
  }

  /** T.0.02 Fan 1 */
  @inherit(r_test)
  @ext(0x11, 3, 0xff, 0xff)
  model Fan1 {
    @unit("%")
    uin: UIN;
  }

  /** T.0.19 Condensate tray heater */
  @inherit(r_test)
  @ext(0x13, 3, 0xff, 0xff)
  model CondensateTrayHeater {
    @values(Values_onoff)
    uin: UIN;
  }

  /** T.0.20 4-port valve */
  @inherit(r_test)
  @ext(0x14, 3, 0xff, 0xff)
  model FourPortValve {
    @values(Values_onoff)
    uin: UIN;
  }

  /** T.0.21 Position: EEV */
  @inherit(r_test)
  @ext(0x15, 3, 0xff, 0xff)
  model PositionEEV {
    @unit("%")
    uin: UIN;
  }

  /** T.0.23 Heating coil compressor */
  @inherit(r_test)
  @ext(0x17, 3, 0xff, 0xff)
  model HeatingCoilCompressor {
    @values(Values_onoff)
    uin: UIN;
  }

  /** T.1.02 DHW prioritising diverter valve */
  @inherit(r_test)
  @ext(0x2, 3, 0xff, 0xff)
  model PrioritySwitchingValve {
    @values(Values_PrioritySwitchingValve)
    uin: UIN;
  }

  /** T.0.40 Flow temperature */
  @inherit(r_test)
  @ext(0x28, 3, 0xff, 0xff)
  model FlowTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.41 Return temperature */
  @inherit(r_test)
  @ext(0x29, 3, 0xff, 0xff)
  model ReturnTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.42 Building circuit water temperature */
  @inherit(r_test)
  @ext(0x2a, 3, 0xff, 0xff)
  model CircuitBuildingWaterPressure {
    @unit("bar")
    @divisor(10)
    uin: UIN;
  }

  /** T.0.43 Building circuit: Flow rate */
  @inherit(r_test)
  @ext(0x2b, 3, 0xff, 0xff)
  model CircuitBuildingFlowRate {
    @unit("l/h")
    uin: UIN;
  }

  /** T.1.44 Cylinder temperature */
  @inherit(r_test)
  @ext(0x2c, 3, 0xff, 0xff)
  model CylinderTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.1.46 Lockout contact S20 */
  @inherit(r_test)
  @ext(0x2e, 3, 0xff, 0xff)
  model LockoutContactS20 {
    @values(Values_LockoutContact)
    uin: UIN;
  }

  /** T.0.48 Air inlet temperature */
  @inherit(r_test)
  @ext(0x30, 3, 0xff, 0xff)
  model AirInletTempSens {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.55 Compressor outlet temperature */
  @inherit(r_test)
  @ext(0x37, 3, 0xff, 0xff)
  model CompressorOutletTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.56 Compressor inlet temperature */
  @inherit(r_test)
  @ext(0x38, 3, 0xff, 0xff)
  model CompressorInletTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.57 EEV outlet temperature */
  @inherit(r_test)
  @ext(0x39, 3, 0xff, 0xff)
  model EEVOutletTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.59 Capacitor outlet temperature */
  @inherit(r_test)
  @ext(0x3b, 3, 0xff, 0xff)
  model CondenserOutletTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.63 High pressure */
  @inherit(r_test)
  @ext(0x3f, 3, 0xff, 0xff)
  model HighPressure {
    @unit("bar")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.64 Low pressure */
  @inherit(r_test)
  @ext(0x40, 3, 0xff, 0xff)
  model LowPressure {
    @unit("bar")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.67  High-pressure switch */
  @inherit(r_test)
  @ext(0x43, 3, 0xff, 0xff)
  model HighPressureSwitch {
    @values(Values_HighPressureSwitch)
    uin: UIN;
  }

  /** T.1.69 Outdoor temperature */
  @inherit(r_test)
  @ext(0x45, 3, 0xff, 0xff)
  model OutdoorTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.1.70 System temperature */
  @inherit(r_test)
  @ext(0x46, 3, 0xff, 0xff)
  model SystemTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.1.71 DCF Status */
  @inherit(r_test)
  @ext(0x47, 3, 0xff, 0xff)
  model DCFStatus {
    uin: UIN;
  }

  /** T.1.72 Lockout contact S21 */
  @inherit(r_test)
  @ext(0x48, 3, 0xff, 0xff)
  model LockoutContactS21 {
    @values(Values_LockoutContact)
    uin: UIN;
  }

  /** T.0.85 Evaporation temperature */
  @inherit(r_test)
  @ext(0x55, 3, 0xff, 0xff)
  model EvaporationTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.86 Condensation temperature */
  @inherit(r_test)
  @ext(0x56, 3, 0xff, 0xff)
  model CondensationTemp {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.87 Overheating target value */
  @inherit(r_test)
  @ext(0x57, 3, 0xff, 0xff)
  model OverheatingTargetValue {
    @unit("K")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.88 Overheating actual value */
  @inherit(r_test)
  @ext(0x58, 3, 0xff, 0xff)
  model OverheatingActualValue {
    @unit("K")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.89 Subcooling target value */
  @inherit(r_test)
  @ext(0x59, 3, 0xff, 0xff)
  model SubcoolingTargetValue {
    @unit("K")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.90 Subcooling actual value */
  @inherit(r_test)
  @ext(0x5a, 3, 0xff, 0xff)
  model SubcoolingActualValue {
    @unit("K")
    @divisor(10)
    sin: SIN;
  }

  /** T.0.93 Compressor speed */
  @inherit(r_test)
  @ext(0x5d, 3, 0xff, 0xff)
  model CompressorSpeed {
    @unit("U/s")
    @divisor(10)
    sin: SIN;
  }

  /** T.1.119 MO1 output */
  @inherit(r_test)
  @ext(0x77, 3, 0xff, 0xff)
  model MO1Output {
    @values(Values_onoff)
    uin: UIN;
  }

  /** T.0.123 Temperature switch: Compressor outlet */
  @inherit(r_test)
  @ext(0x7b, 3, 0xff, 0xff)
  model TempSwitchCompressorOutlet {
    @values(Values_TempSwitch)
    uin: UIN;
  }

  /** T.1.124 Immersion heater safety cutout */
  @inherit(r_test)
  @ext(0x7c, 3, 0xff, 0xff)
  model ImmersionHeaterSafetyCutOut {
    @values(Values_LockoutContact)
    uin: UIN;
  }

  /** T.1.125 MPI input */
  @inherit(r_test)
  @ext(0x7d, 3, 0xff, 0xff)
  model MPIInput {
    sin: SIN;
  }

  /** T.1.126  MO2 output */
  @inherit(r_test)
  @ext(0x7e, 3, 0xff, 0xff)
  model MO2Output {
    @values(Values_onoff)
    uin: UIN;
  }

  /** T.1.127 MO3 output */
  @inherit(r_test)
  @ext(0x7f, 3, 0xff, 0xff)
  model MO3Output {
    @values(Values_onoff)
    uin: UIN;
  }

  /** Condensor inlet temperature (°C) */
  @inherit(r_test)
  @ext(0x81, 3, 0xff, 0xff)
  model CondensorInletTemp {
    @unit("°C")
    @divisor(10)
    temps2: temps2;
  }

  /** T1.130 Vorlauftemperatur Heizstab */
  @inherit(r_test)
  @ext(0x82, 3, 0xff, 0xff)
  model FlowTempImmersionHeater {
    @unit("°C")
    @divisor(10)
    sin: SIN;
  }

  /** default *r for run data (polled every minute by VR921) */
  @base(MF, 0x9, 0x54, 0x2, 0)
  model r_run {
    @maxLength(4)
    ign: IGN;
  }

  /** Compressor speed (polled every minute) */
  @inherit(r_run)
  @ext(0xd, 0xa)
  model RunDataCompressorSpeed {
    @unit("rps")
    exp: EXP;
  }

  /** EEV Position in different scale */
  @inherit(r_run)
  @ext(0x28, 0xa)
  model RunDataEEVPositionAbs {
    uin: UIN;
  }

  /** Fan 1 speed */
  @inherit(r_run)
  @ext(0x47, 0xa)
  model RunDataFan1Speed {
    @unit("rpm")
    exp: EXP;
  }

  /** Fan 2 speed */
  @inherit(r_run)
  @ext(0x49, 0xa)
  model RunDataFan2Speed {
    @unit("rpm")
    exp: EXP;
  }

  /** Status code */
  @inherit(r_run)
  @ext(0x53, 0xd)
  model RunDataStatuscode {
    scode: scode;
  }

  /** current consumed electrical power (Watt) */
  @inherit(r_run)
  @ext(0x5b, 0xd)
  model RunDataCurrentConsumedPower {
    powerv: powerv;
  }

  /** High pressure */
  @inherit(r_run)
  @ext(0x6a, 9)
  model RunDataHighPressure {
    pressv: pressv;
  }

  /** Compressor inlet temperature */
  @inherit(r_run)
  @ext(0x98, 8)
  model RunDataCompressorInletTemp {
    tempv: tempv;
  }

  /** Compressor outlet temperature */
  @inherit(r_run)
  @ext(0xa2, 8)
  model RunDataCompressorOutletTemp {
    tempv: tempv;
  }

  /** EEV outlet temperature */
  @inherit(r_run)
  @ext(0xac, 8)
  model RunDataEEVOutletTemp {
    tempv: tempv;
  }

  /** HMU hours */
  @inherit(r_run)
  @ext(0xb8, 0xb)
  model RunStatsHMUHours {
    @unit("hours")
    uin: UIN;
  }

  /** Hc hours */
  @inherit(r_run)
  @ext(0xb9, 0xb)
  model RunStatsHcHours {
    @unit("hours")
    uin: UIN;
  }

  /** Compressor hours */
  @inherit(r_run)
  @ext(0xc2, 0xb)
  model RunStatsCompressorHours {
    @unit("hours")
    uin: UIN;
  }

  /** Compressor starts */
  @inherit(r_run)
  @ext(0xc3, 0xb)
  model RunStatsCompressorStarts {
    cntstarts2: cntstarts2;
  }

  /** Building pump hours */
  @inherit(r_run)
  @ext(0xc4, 0xb)
  model RunStatsBuildingPumpHours {
    @unit("hours")
    uin: UIN;
  }

  /** Building circuit pump power */
  @inherit(r_run)
  @ext(0xc5, 9)
  model RunDataBuildingCPumpPower {
    @unit("%")
    exp: EXP;
  }

  /** 4 port valve hours */
  @inherit(r_run)
  @ext(0xc8, 0xb)
  model RunStats4PortValveHours {
    @unit("hours")
    uin: UIN;
  }

  /** 4 port valve switches */
  @inherit(r_run)
  @ext(0xc9, 0xb)
  model RunStats4PortValveSwitches {
    cntstarts2: cntstarts2;
  }

  /** Fan 1 hours */
  @inherit(r_run)
  @ext(0xd7, 0xb)
  model RunStatsFan1Hours {
    @unit("hours")
    uin: UIN;
  }

  /** Fan 1 starts */
  @inherit(r_run)
  @ext(0xd8, 0xb)
  model RunStatsFan1Starts {
    cntstarts2: cntstarts2;
  }

  /** Air intake temperature */
  @inherit(r_run)
  @ext(0xde, 8)
  model RunDataAirIntakeTemp {
    tempv: tempv;
  }

  /** Flow temperature (float, same sensor as Status01 flow) */
  @inherit(r_run)
  @ext(0xfc, 8)
  model RunDataFlowTemp {
    tempv: tempv;
  }

  /** Return temperature (float, same sensor as Status01 return) */
  @inherit(r_run)
  @ext(0x06, 9)
  model RunDataReturnTemp {
    tempv: tempv;
  }

  // Enums for Values
  enum Values_CoolingEnabled {
    off: 0,
    on: 1,
  }

  enum Values_HeatExchangerEnabled {
    off: 0,
    on: 1,
  }

  enum Values_PrioritySwitchingValve {
    heating: 0,
    acs: 1,
  }

  enum Values_HighPressureSwitch {
    open: 0,
    close: 1,
  }

  enum Values_TempSwitch {
    open: 0,
    close: 1,
  }

  enum Values_LockoutContact {
    close: 0,
    open: 1,
  }


  // Included parts
  union _includes {
    Hcmode_inc,
    Errors_inc,
    B516stat_inc,
  }
}


