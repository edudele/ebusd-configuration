// 15.ctlv0.tsp - Based on 15.basv0.tsp structure
// This file inherits from 15.basv0 namespace (ctlv variant 0)
import "@ebusd/ebus-typespec";
import "./_templates.tsp";
import "./15.basv0.tsp";
import "./errors_inc.tsp";
using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;
namespace Vaillant;

// @zz(0x15)
namespace Ctlv0 {
  // The Ctlv0 variant uses the same structure as Basv0
  // Include all Basv0 definitions
  union _includes {
    Basv0,
    Errors_inc,
  }
}
