import "@ebusd/ebus-typespec";
import "./_templates.tsp";
using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;
namespace Vaillant;

/** Estadisticas de energia de la HMU (b516), periodos fijos. */
namespace B516stat_inc {
  /** energy statistics read */
  @base(MF, 0x16)
  model r_16 {}

  /** energy stat Total source Env usage All */
  @inherit(r_16)
  @ext(0x10, 0x00, 0xff, 0xff, 0x02, 0x00, 0x21, 0x34)
  model StatTotalEnvAll {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Total source Env usage Heat */
  @inherit(r_16)
  @ext(0x10, 0x00, 0xff, 0xff, 0x02, 0x03, 0x21, 0x34)
  model StatTotalEnvHeat {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Total source Env usage Water */
  @inherit(r_16)
  @ext(0x10, 0x00, 0xff, 0xff, 0x02, 0x04, 0x21, 0x34)
  model StatTotalEnvWater {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Total source Env usage Cool */
  @inherit(r_16)
  @ext(0x10, 0x00, 0xff, 0xff, 0x02, 0x05, 0x21, 0x34)
  model StatTotalEnvCool {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Total source Elec usage All */
  @inherit(r_16)
  @ext(0x10, 0x00, 0xff, 0xff, 0x03, 0x00, 0x21, 0x34)
  model StatTotalElecAll {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Total source Elec usage Heat */
  @inherit(r_16)
  @ext(0x10, 0x00, 0xff, 0xff, 0x03, 0x03, 0x21, 0x34)
  model StatTotalElecHeat {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Total source Elec usage Water */
  @inherit(r_16)
  @ext(0x10, 0x00, 0xff, 0xff, 0x03, 0x04, 0x21, 0x34)
  model StatTotalElecWater {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Total source Elec usage Cool */
  @inherit(r_16)
  @ext(0x10, 0x00, 0xff, 0xff, 0x03, 0x05, 0x21, 0x34)
  model StatTotalElecCool {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2025 source Env usage All */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x02, 0x00, 0x21, 0x32)
  model StatY2025EnvAll {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2025 source Env usage Heat */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x02, 0x03, 0x21, 0x32)
  model StatY2025EnvHeat {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2025 source Env usage Water */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x02, 0x04, 0x21, 0x32)
  model StatY2025EnvWater {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2025 source Env usage Cool */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x02, 0x05, 0x21, 0x32)
  model StatY2025EnvCool {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2025 source Elec usage All */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x03, 0x00, 0x21, 0x32)
  model StatY2025ElecAll {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2025 source Elec usage Heat */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x03, 0x03, 0x21, 0x32)
  model StatY2025ElecHeat {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2025 source Elec usage Water */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x03, 0x04, 0x21, 0x32)
  model StatY2025ElecWater {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2025 source Elec usage Cool */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x03, 0x05, 0x21, 0x32)
  model StatY2025ElecCool {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2026 source Env usage All */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x02, 0x00, 0x21, 0x34)
  model StatY2026EnvAll {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2026 source Env usage Heat */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x02, 0x03, 0x21, 0x34)
  model StatY2026EnvHeat {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2026 source Env usage Water */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x02, 0x04, 0x21, 0x34)
  model StatY2026EnvWater {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2026 source Env usage Cool */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x02, 0x05, 0x21, 0x34)
  model StatY2026EnvCool {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2026 source Elec usage All */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x03, 0x00, 0x21, 0x34)
  model StatY2026ElecAll {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2026 source Elec usage Heat */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x03, 0x03, 0x21, 0x34)
  model StatY2026ElecHeat {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2026 source Elec usage Water */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x03, 0x04, 0x21, 0x34)
  model StatY2026ElecWater {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat Y2026 source Elec usage Cool */
  @inherit(r_16)
  @ext(0x10, 0x03, 0xff, 0xff, 0x03, 0x05, 0x21, 0x34)
  model StatY2026ElecCool {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202609 source Env usage All */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x02, 0x00, 0x21, 0x35)
  model StatM202609EnvAll {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202609 source Env usage Heat */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x02, 0x03, 0x21, 0x35)
  model StatM202609EnvHeat {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202609 source Env usage Water */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x02, 0x04, 0x21, 0x35)
  model StatM202609EnvWater {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202609 source Env usage Cool */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x02, 0x05, 0x21, 0x35)
  model StatM202609EnvCool {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202609 source Elec usage All */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x03, 0x00, 0x21, 0x35)
  model StatM202609ElecAll {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202609 source Elec usage Heat */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x03, 0x03, 0x21, 0x35)
  model StatM202609ElecHeat {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202609 source Elec usage Water */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x03, 0x04, 0x21, 0x35)
  model StatM202609ElecWater {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202609 source Elec usage Cool */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x03, 0x05, 0x21, 0x35)
  model StatM202609ElecCool {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202610 source Env usage All */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x02, 0x00, 0x41, 0x35)
  model StatM202610EnvAll {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202610 source Env usage Heat */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x02, 0x03, 0x41, 0x35)
  model StatM202610EnvHeat {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202610 source Env usage Water */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x02, 0x04, 0x41, 0x35)
  model StatM202610EnvWater {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202610 source Env usage Cool */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x02, 0x05, 0x41, 0x35)
  model StatM202610EnvCool {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202610 source Elec usage All */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x03, 0x00, 0x41, 0x35)
  model StatM202610ElecAll {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202610 source Elec usage Heat */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x03, 0x03, 0x41, 0x35)
  model StatM202610ElecHeat {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202610 source Elec usage Water */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x03, 0x04, 0x41, 0x35)
  model StatM202610ElecWater {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

  /** energy stat M202610 source Elec usage Cool */
  @inherit(r_16)
  @ext(0x10, 0x02, 0xff, 0xff, 0x03, 0x05, 0x41, 0x35)
  model StatM202610ElecCool {
    @maxLength(7) ign: IGN;
    @unit("Wh") value: EXP;
  }

}
