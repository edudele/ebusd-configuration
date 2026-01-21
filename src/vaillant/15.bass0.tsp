// 15.bass0.tsp - Based on 15.basv0.tsp with structure from 15.bass.csv
// This file inherits from 15.basv0 namespace and adds any specific differences
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
namespace Bass0 {
  // The Bass0 variant uses the same structure as Basv0
  // Include all Basv0 definitions
  union _includes {
    Basv0,
    Errors_inc,
  }
}
