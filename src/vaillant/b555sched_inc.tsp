import "@ebusd/ebus-typespec";
import "./_templates.tsp";
using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;
namespace Vaillant;

/** Programas horarios del termostato (b555): lectura a4/a5, escritura a6 del dia completo. */
namespace B555sched_inc {
  /** counter read */
  @base(MF, 0x55, 0xa4)
  model r_a4 {}

  /** slot read */
  @base(MF, 0x55, 0xa5)
  model r_a5 {}

  /** day write */
  @write
  @base(MF, 0x55, 0xa6)
  model w_a6 {}

  /** number of slots per weekday (heating timer zone 1) */
  @poll(5)
  @inherit(r_a4)
  @ext(0x00, 0x00)
  model Z1TimerHeatSlots {
    @maxLength(1) ign: IGN;
    mon: UCH;
    tue: UCH;
    wed: UCH;
    thu: UCH;
    fri: UCH;
    sat: UCH;
    sun: UCH;
    @maxLength(1) ign_1: IGN;
  }

  /** heating timer zone 1 monday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x00)
  model Z1TimerHeat_Monday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 monday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x01)
  model Z1TimerHeat_Monday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 monday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x02)
  model Z1TimerHeat_Monday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 monday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x03)
  model Z1TimerHeat_Monday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 monday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x04)
  model Z1TimerHeat_Monday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 monday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x05)
  model Z1TimerHeat_Monday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x00)
  model Z1TimerHeat_Tuesday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x01)
  model Z1TimerHeat_Tuesday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x02)
  model Z1TimerHeat_Tuesday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x03)
  model Z1TimerHeat_Tuesday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x04)
  model Z1TimerHeat_Tuesday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x05)
  model Z1TimerHeat_Tuesday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x00)
  model Z1TimerHeat_Wednesday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x01)
  model Z1TimerHeat_Wednesday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x02)
  model Z1TimerHeat_Wednesday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x03)
  model Z1TimerHeat_Wednesday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x04)
  model Z1TimerHeat_Wednesday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x05)
  model Z1TimerHeat_Wednesday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x00)
  model Z1TimerHeat_Thursday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x01)
  model Z1TimerHeat_Thursday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x02)
  model Z1TimerHeat_Thursday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x03)
  model Z1TimerHeat_Thursday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x04)
  model Z1TimerHeat_Thursday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x05)
  model Z1TimerHeat_Thursday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x00)
  model Z1TimerHeat_Friday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x01)
  model Z1TimerHeat_Friday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x02)
  model Z1TimerHeat_Friday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x03)
  model Z1TimerHeat_Friday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x04)
  model Z1TimerHeat_Friday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x05)
  model Z1TimerHeat_Friday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x00)
  model Z1TimerHeat_Saturday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x01)
  model Z1TimerHeat_Saturday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x02)
  model Z1TimerHeat_Saturday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x03)
  model Z1TimerHeat_Saturday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x04)
  model Z1TimerHeat_Saturday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x05)
  model Z1TimerHeat_Saturday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x00)
  model Z1TimerHeat_Sunday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x01)
  model Z1TimerHeat_Sunday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x02)
  model Z1TimerHeat_Sunday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x03)
  model Z1TimerHeat_Sunday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x04)
  model Z1TimerHeat_Sunday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x05)
  model Z1TimerHeat_Sunday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** number of slots per weekday (cooling timer zone 1) */
  @poll(5)
  @inherit(r_a4)
  @ext(0x00, 0x01)
  model Z1TimerCoolSlots {
    @maxLength(1) ign: IGN;
    mon: UCH;
    tue: UCH;
    wed: UCH;
    thu: UCH;
    fri: UCH;
    sat: UCH;
    sun: UCH;
    @maxLength(1) ign_1: IGN;
  }

  /** cooling timer zone 1 monday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x00, 0x00)
  model Z1TimerCool_Monday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 tuesday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x01, 0x00)
  model Z1TimerCool_Tuesday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 wednesday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x02, 0x00)
  model Z1TimerCool_Wednesday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 thursday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x03, 0x00)
  model Z1TimerCool_Thursday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 friday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x04, 0x00)
  model Z1TimerCool_Friday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 saturday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x05, 0x00)
  model Z1TimerCool_Saturday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 sunday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x06, 0x00)
  model Z1TimerCool_Sunday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** number of slots per weekday (hot water timer) */
  @poll(5)
  @inherit(r_a4)
  @ext(0x00, 0x02)
  model HwcTimerSlots {
    @maxLength(1) ign: IGN;
    mon: UCH;
    tue: UCH;
    wed: UCH;
    thu: UCH;
    fri: UCH;
    sat: UCH;
    sun: UCH;
    @maxLength(1) ign_1: IGN;
  }

  /** hot water timer monday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x00, 0x00)
  model HwcTimer_Monday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer tuesday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x01, 0x00)
  model HwcTimer_Tuesday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer wednesday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x02, 0x00)
  model HwcTimer_Wednesday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer thursday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x03, 0x00)
  model HwcTimer_Thursday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer friday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x04, 0x00)
  model HwcTimer_Friday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer saturday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x05, 0x00)
  model HwcTimer_Saturday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer sunday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x06, 0x00)
  model HwcTimer_Sunday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** set hot water timer monday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x02, 0x00)
  model HwcTimerSet_Monday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set hot water timer tuesday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x02, 0x01)
  model HwcTimerSet_Tuesday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set hot water timer wednesday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x02, 0x02)
  model HwcTimerSet_Wednesday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set hot water timer thursday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x02, 0x03)
  model HwcTimerSet_Thursday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set hot water timer friday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x02, 0x04)
  model HwcTimerSet_Friday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set hot water timer saturday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x02, 0x05)
  model HwcTimerSet_Saturday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set hot water timer sunday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x02, 0x06)
  model HwcTimerSet_Sunday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** hot water timer monday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x00, 0x01)
  model HwcTimer_Monday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer monday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x00, 0x02)
  model HwcTimer_Monday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer tuesday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x01, 0x01)
  model HwcTimer_Tuesday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer tuesday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x01, 0x02)
  model HwcTimer_Tuesday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer wednesday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x02, 0x01)
  model HwcTimer_Wednesday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer wednesday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x02, 0x02)
  model HwcTimer_Wednesday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer thursday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x03, 0x01)
  model HwcTimer_Thursday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer thursday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x03, 0x02)
  model HwcTimer_Thursday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer friday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x04, 0x01)
  model HwcTimer_Friday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer friday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x04, 0x02)
  model HwcTimer_Friday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer saturday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x05, 0x01)
  model HwcTimer_Saturday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer saturday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x05, 0x02)
  model HwcTimer_Saturday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer sunday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x06, 0x01)
  model HwcTimer_Sunday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** hot water timer sunday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x02, 0x06, 0x02)
  model HwcTimer_Sunday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** set cooling timer zone 1 monday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x01, 0x00)
  model Z1TimerCoolSet_Monday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set cooling timer zone 1 tuesday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x01, 0x01)
  model Z1TimerCoolSet_Tuesday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set cooling timer zone 1 wednesday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x01, 0x02)
  model Z1TimerCoolSet_Wednesday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set cooling timer zone 1 thursday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x01, 0x03)
  model Z1TimerCoolSet_Thursday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set cooling timer zone 1 friday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x01, 0x04)
  model Z1TimerCoolSet_Friday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set cooling timer zone 1 saturday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x01, 0x05)
  model Z1TimerCoolSet_Saturday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set cooling timer zone 1 sunday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x01, 0x06)
  model Z1TimerCoolSet_Sunday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** cooling timer zone 1 monday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x00, 0x01)
  model Z1TimerCool_Monday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 monday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x00, 0x02)
  model Z1TimerCool_Monday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 tuesday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x01, 0x01)
  model Z1TimerCool_Tuesday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 tuesday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x01, 0x02)
  model Z1TimerCool_Tuesday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 wednesday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x02, 0x01)
  model Z1TimerCool_Wednesday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 wednesday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x02, 0x02)
  model Z1TimerCool_Wednesday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 thursday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x03, 0x01)
  model Z1TimerCool_Thursday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 thursday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x03, 0x02)
  model Z1TimerCool_Thursday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 friday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x04, 0x01)
  model Z1TimerCool_Friday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 friday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x04, 0x02)
  model Z1TimerCool_Friday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 saturday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x05, 0x01)
  model Z1TimerCool_Saturday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 saturday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x05, 0x02)
  model Z1TimerCool_Saturday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 sunday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x06, 0x01)
  model Z1TimerCool_Sunday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** cooling timer zone 1 sunday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x01, 0x06, 0x02)
  model Z1TimerCool_Sunday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** set heating timer zone 1 monday (slotindex;slotcount;from;to;temp) */
  @inherit(w_a6)
  @ext(0x00, 0x00, 0x00)
  model Z1TimerHeatSet_Monday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
    @in result: UCH;
  }

  /** set heating timer zone 1 tuesday (slotindex;slotcount;from;to;temp) */
  @inherit(w_a6)
  @ext(0x00, 0x00, 0x01)
  model Z1TimerHeatSet_Tuesday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
    @in result: UCH;
  }

  /** set heating timer zone 1 wednesday (slotindex;slotcount;from;to;temp) */
  @inherit(w_a6)
  @ext(0x00, 0x00, 0x02)
  model Z1TimerHeatSet_Wednesday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
    @in result: UCH;
  }

  /** set heating timer zone 1 thursday (slotindex;slotcount;from;to;temp) */
  @inherit(w_a6)
  @ext(0x00, 0x00, 0x03)
  model Z1TimerHeatSet_Thursday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
    @in result: UCH;
  }

  /** set heating timer zone 1 friday (slotindex;slotcount;from;to;temp) */
  @inherit(w_a6)
  @ext(0x00, 0x00, 0x04)
  model Z1TimerHeatSet_Friday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
    @in result: UCH;
  }

  /** set heating timer zone 1 saturday (slotindex;slotcount;from;to;temp) */
  @inherit(w_a6)
  @ext(0x00, 0x00, 0x05)
  model Z1TimerHeatSet_Saturday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
    @in result: UCH;
  }

  /** set heating timer zone 1 sunday (slotindex;slotcount;from;to;temp) */
  @inherit(w_a6)
  @ext(0x00, 0x00, 0x06)
  model Z1TimerHeatSet_Sunday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
    @in result: UCH;
  }

  /** heating timer zone 1 monday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x06)
  model Z1TimerHeat_Monday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 monday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x07)
  model Z1TimerHeat_Monday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 monday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x08)
  model Z1TimerHeat_Monday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 monday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x09)
  model Z1TimerHeat_Monday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 monday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x0a)
  model Z1TimerHeat_Monday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 monday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x00, 0x0b)
  model Z1TimerHeat_Monday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x06)
  model Z1TimerHeat_Tuesday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x07)
  model Z1TimerHeat_Tuesday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x08)
  model Z1TimerHeat_Tuesday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x09)
  model Z1TimerHeat_Tuesday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x0a)
  model Z1TimerHeat_Tuesday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 tuesday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x01, 0x0b)
  model Z1TimerHeat_Tuesday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x06)
  model Z1TimerHeat_Wednesday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x07)
  model Z1TimerHeat_Wednesday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x08)
  model Z1TimerHeat_Wednesday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x09)
  model Z1TimerHeat_Wednesday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x0a)
  model Z1TimerHeat_Wednesday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 wednesday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x02, 0x0b)
  model Z1TimerHeat_Wednesday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x06)
  model Z1TimerHeat_Thursday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x07)
  model Z1TimerHeat_Thursday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x08)
  model Z1TimerHeat_Thursday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x09)
  model Z1TimerHeat_Thursday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x0a)
  model Z1TimerHeat_Thursday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 thursday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x03, 0x0b)
  model Z1TimerHeat_Thursday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x06)
  model Z1TimerHeat_Friday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x07)
  model Z1TimerHeat_Friday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x08)
  model Z1TimerHeat_Friday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x09)
  model Z1TimerHeat_Friday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x0a)
  model Z1TimerHeat_Friday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 friday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x04, 0x0b)
  model Z1TimerHeat_Friday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x06)
  model Z1TimerHeat_Saturday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x07)
  model Z1TimerHeat_Saturday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x08)
  model Z1TimerHeat_Saturday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x09)
  model Z1TimerHeat_Saturday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x0a)
  model Z1TimerHeat_Saturday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 saturday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x05, 0x0b)
  model Z1TimerHeat_Saturday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x06)
  model Z1TimerHeat_Sunday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x07)
  model Z1TimerHeat_Sunday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x08)
  model Z1TimerHeat_Sunday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x09)
  model Z1TimerHeat_Sunday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x0a)
  model Z1TimerHeat_Sunday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** heating timer zone 1 sunday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x00, 0x06, 0x0b)
  model Z1TimerHeat_Sunday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @unit("°C") @divisor(10) temp: UIN;
  }

  /** number of slots per weekday (silent mode timer) */
  @poll(5)
  @inherit(r_a4)
  @ext(0x00, 0x04)
  model SilentTimerSlots {
    @maxLength(1) ign: IGN;
    mon: UCH;
    tue: UCH;
    wed: UCH;
    thu: UCH;
    fri: UCH;
    sat: UCH;
    sun: UCH;
    @maxLength(1) ign_1: IGN;
  }

  /** silent mode timer monday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x00)
  model SilentTimer_Monday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x01)
  model SilentTimer_Monday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x02)
  model SilentTimer_Monday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x03)
  model SilentTimer_Monday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x04)
  model SilentTimer_Monday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x05)
  model SilentTimer_Monday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x06)
  model SilentTimer_Monday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x07)
  model SilentTimer_Monday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x08)
  model SilentTimer_Monday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x09)
  model SilentTimer_Monday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x0a)
  model SilentTimer_Monday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer monday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x00, 0x0b)
  model SilentTimer_Monday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x00)
  model SilentTimer_Tuesday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x01)
  model SilentTimer_Tuesday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x02)
  model SilentTimer_Tuesday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x03)
  model SilentTimer_Tuesday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x04)
  model SilentTimer_Tuesday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x05)
  model SilentTimer_Tuesday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x06)
  model SilentTimer_Tuesday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x07)
  model SilentTimer_Tuesday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x08)
  model SilentTimer_Tuesday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x09)
  model SilentTimer_Tuesday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x0a)
  model SilentTimer_Tuesday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer tuesday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x01, 0x0b)
  model SilentTimer_Tuesday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x00)
  model SilentTimer_Wednesday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x01)
  model SilentTimer_Wednesday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x02)
  model SilentTimer_Wednesday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x03)
  model SilentTimer_Wednesday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x04)
  model SilentTimer_Wednesday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x05)
  model SilentTimer_Wednesday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x06)
  model SilentTimer_Wednesday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x07)
  model SilentTimer_Wednesday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x08)
  model SilentTimer_Wednesday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x09)
  model SilentTimer_Wednesday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x0a)
  model SilentTimer_Wednesday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer wednesday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x02, 0x0b)
  model SilentTimer_Wednesday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x00)
  model SilentTimer_Thursday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x01)
  model SilentTimer_Thursday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x02)
  model SilentTimer_Thursday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x03)
  model SilentTimer_Thursday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x04)
  model SilentTimer_Thursday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x05)
  model SilentTimer_Thursday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x06)
  model SilentTimer_Thursday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x07)
  model SilentTimer_Thursday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x08)
  model SilentTimer_Thursday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x09)
  model SilentTimer_Thursday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x0a)
  model SilentTimer_Thursday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer thursday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x03, 0x0b)
  model SilentTimer_Thursday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x00)
  model SilentTimer_Friday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x01)
  model SilentTimer_Friday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x02)
  model SilentTimer_Friday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x03)
  model SilentTimer_Friday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x04)
  model SilentTimer_Friday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x05)
  model SilentTimer_Friday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x06)
  model SilentTimer_Friday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x07)
  model SilentTimer_Friday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x08)
  model SilentTimer_Friday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x09)
  model SilentTimer_Friday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x0a)
  model SilentTimer_Friday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer friday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x04, 0x0b)
  model SilentTimer_Friday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x00)
  model SilentTimer_Saturday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x01)
  model SilentTimer_Saturday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x02)
  model SilentTimer_Saturday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x03)
  model SilentTimer_Saturday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x04)
  model SilentTimer_Saturday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x05)
  model SilentTimer_Saturday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x06)
  model SilentTimer_Saturday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x07)
  model SilentTimer_Saturday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x08)
  model SilentTimer_Saturday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x09)
  model SilentTimer_Saturday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x0a)
  model SilentTimer_Saturday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer saturday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x05, 0x0b)
  model SilentTimer_Saturday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 1 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x00)
  model SilentTimer_Sunday0 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 2 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x01)
  model SilentTimer_Sunday1 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 3 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x02)
  model SilentTimer_Sunday2 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 4 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x03)
  model SilentTimer_Sunday3 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 5 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x04)
  model SilentTimer_Sunday4 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 6 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x05)
  model SilentTimer_Sunday5 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 7 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x06)
  model SilentTimer_Sunday6 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 8 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x07)
  model SilentTimer_Sunday7 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 9 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x08)
  model SilentTimer_Sunday8 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 10 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x09)
  model SilentTimer_Sunday9 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 11 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x0a)
  model SilentTimer_Sunday10 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** silent mode timer sunday slot 12 */
  @poll(5)
  @inherit(r_a5)
  @ext(0x00, 0x04, 0x06, 0x0b)
  model SilentTimer_Sunday11 {
    @maxLength(1) ign: IGN;
    from: HTM;
    to: HTM;
    @maxLength(2) ign_1: IGN;
  }

  /** set silent mode timer monday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x04, 0x00)
  model SilentTimerSet_Monday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer tuesday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x04, 0x01)
  model SilentTimerSet_Tuesday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer wednesday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x04, 0x02)
  model SilentTimerSet_Wednesday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer thursday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x04, 0x03)
  model SilentTimerSet_Thursday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer friday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x04, 0x04)
  model SilentTimerSet_Friday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer saturday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x04, 0x05)
  model SilentTimerSet_Saturday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer sunday (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0x00, 0x04, 0x06)
  model SilentTimerSet_Sunday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer monday zona ff (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x04, 0x00)
  model SilentTimerSetFF_Monday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer tuesday zona ff (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x04, 0x01)
  model SilentTimerSetFF_Tuesday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer wednesday zona ff (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x04, 0x02)
  model SilentTimerSetFF_Wednesday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer thursday zona ff (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x04, 0x03)
  model SilentTimerSetFF_Thursday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer friday zona ff (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x04, 0x04)
  model SilentTimerSetFF_Friday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer saturday zona ff (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x04, 0x05)
  model SilentTimerSetFF_Saturday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

  /** set silent mode timer sunday zona ff (slotindex;slotcount;from;to) */
  @inherit(w_a6)
  @ext(0xff, 0x04, 0x06)
  model SilentTimerSetFF_Sunday {
    slotindex: UCH;
    slotcount: UCH;
    from: HTM;
    to: HTM;
    @maxLength(2) @constValue("ffff") `const`: HEX;
    @in result: UCH;
  }

}
