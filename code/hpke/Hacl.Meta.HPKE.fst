module Hacl.Meta.HPKE

friend Hacl.Impl.HPKE

#set-options "--z3rlimit 200 --max_fuel 0 --max_ifuel 0"

%splice[
  hpke_setupBaseI_higher;
  hpke_setupBaseR_higher;
  hpke_encryptBase_higher;
  hpke_decryptBase_higher
] (Meta.Interface.specialize (`Spec.Agile.HPKE.ciphersuite) [
    `Hacl.Impl.HPKE.setupBaseI;
    `Hacl.Impl.HPKE.setupBaseR;
    `Hacl.Impl.HPKE.encryptBase;
    `Hacl.Impl.HPKE.decryptBase
])
