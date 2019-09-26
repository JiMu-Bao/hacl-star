module Example

module I = Interface

open FStar.Mul

#set-options "--print_bound_var_types --print_implicits --print_full_names"

// Small simple example. Useful for debugging.

%splice[
  times_four_inline;
  times_sixteen_inline;
  times_sixteen'_inline
] (MetaInterface.specialize [ `Client.times_sixteen; `Client.times_sixteen' ])

let add: I.add_st I.W32 = FStar.UInt32.add_mod
let mul: I.mul_st I.W32 = FStar.UInt32.mul_mod
let times_four = times_four_inline add
let times_sixteen = times_sixteen_inline times_four
let times_sixteen' = times_sixteen'_inline times_four mul

// Rolling our sleeves up.

%splice[
  chacha20_core_inline
] (MetaInterface.specialize [ `Hacl.Impl.Chacha20.Vec.chacha20_core ])
