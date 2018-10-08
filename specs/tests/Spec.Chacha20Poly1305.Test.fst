module Spec.Chacha20Poly1305.Test

open FStar.Mul
open Lib.IntTypes
open Lib.RawIntTypes
open Lib.Sequence
open Lib.ByteSequence


(* Tests: RFC7539 *)
let k = List.Tot.map u8_from_UInt8 [
  0x80uy; 0x81uy; 0x82uy; 0x83uy; 0x84uy; 0x85uy; 0x86uy; 0x87uy;
  0x88uy; 0x89uy; 0x8auy; 0x8buy; 0x8cuy; 0x8duy; 0x8euy; 0x8fuy;
  0x90uy; 0x91uy; 0x92uy; 0x93uy; 0x94uy; 0x95uy; 0x96uy; 0x97uy;
  0x98uy; 0x99uy; 0x9auy; 0x9buy; 0x9cuy; 0x9duy; 0x9euy; 0x9fuy]

let n = List.Tot.map u8_from_UInt8 [
  0x07uy; 0x00uy; 0x00uy; 0x00uy; 0x40uy; 0x41uy; 0x42uy; 0x43uy;
  0x44uy; 0x45uy; 0x46uy; 0x47uy]

let p = List.Tot.map u8_from_UInt8 [
  0x4cuy; 0x61uy; 0x64uy; 0x69uy; 0x65uy; 0x73uy; 0x20uy; 0x61uy;
  0x6euy; 0x64uy; 0x20uy; 0x47uy; 0x65uy; 0x6euy; 0x74uy; 0x6cuy;
  0x65uy; 0x6duy; 0x65uy; 0x6euy; 0x20uy; 0x6fuy; 0x66uy; 0x20uy;
  0x74uy; 0x68uy; 0x65uy; 0x20uy; 0x63uy; 0x6cuy; 0x61uy; 0x73uy;
  0x73uy; 0x20uy; 0x6fuy; 0x66uy; 0x20uy; 0x27uy; 0x39uy; 0x39uy;
  0x3auy; 0x20uy; 0x49uy; 0x66uy; 0x20uy; 0x49uy; 0x20uy; 0x63uy;
  0x6fuy; 0x75uy; 0x6cuy; 0x64uy; 0x20uy; 0x6fuy; 0x66uy; 0x66uy;
  0x65uy; 0x72uy; 0x20uy; 0x79uy; 0x6fuy; 0x75uy; 0x20uy; 0x6fuy;
  0x6euy; 0x6cuy; 0x79uy; 0x20uy; 0x6fuy; 0x6euy; 0x65uy; 0x20uy;
  0x74uy; 0x69uy; 0x70uy; 0x20uy; 0x66uy; 0x6fuy; 0x72uy; 0x20uy;
  0x74uy; 0x68uy; 0x65uy; 0x20uy; 0x66uy; 0x75uy; 0x74uy; 0x75uy;
  0x72uy; 0x65uy; 0x2cuy; 0x20uy; 0x73uy; 0x75uy; 0x6euy; 0x73uy;
  0x63uy; 0x72uy; 0x65uy; 0x65uy; 0x6euy; 0x20uy; 0x77uy; 0x6fuy;
  0x75uy; 0x6cuy; 0x64uy; 0x20uy; 0x62uy; 0x65uy; 0x20uy; 0x69uy;
  0x74uy; 0x2euy]

let aad = List.Tot.map u8_from_UInt8 [
  0x50uy; 0x51uy; 0x52uy; 0x53uy; 0xc0uy; 0xc1uy; 0xc2uy; 0xc3uy;
  0xc4uy; 0xc5uy; 0xc6uy; 0xc7uy]

let xcipher = List.Tot.map u8_from_UInt8 [
  0xd3uy; 0x1auy; 0x8duy; 0x34uy; 0x64uy; 0x8euy; 0x60uy; 0xdbuy;
  0x7buy; 0x86uy; 0xafuy; 0xbcuy; 0x53uy; 0xefuy; 0x7euy; 0xc2uy;
  0xa4uy; 0xaduy; 0xeduy; 0x51uy; 0x29uy; 0x6euy; 0x08uy; 0xfeuy;
  0xa9uy; 0xe2uy; 0xb5uy; 0xa7uy; 0x36uy; 0xeeuy; 0x62uy; 0xd6uy;
  0x3duy; 0xbeuy; 0xa4uy; 0x5euy; 0x8cuy; 0xa9uy; 0x67uy; 0x12uy;
  0x82uy; 0xfauy; 0xfbuy; 0x69uy; 0xdauy; 0x92uy; 0x72uy; 0x8buy;
  0x1auy; 0x71uy; 0xdeuy; 0x0auy; 0x9euy; 0x06uy; 0x0buy; 0x29uy;
  0x05uy; 0xd6uy; 0xa5uy; 0xb6uy; 0x7euy; 0xcduy; 0x3buy; 0x36uy;
  0x92uy; 0xdduy; 0xbduy; 0x7fuy; 0x2duy; 0x77uy; 0x8buy; 0x8cuy;
  0x98uy; 0x03uy; 0xaeuy; 0xe3uy; 0x28uy; 0x09uy; 0x1buy; 0x58uy;
  0xfauy; 0xb3uy; 0x24uy; 0xe4uy; 0xfauy; 0xd6uy; 0x75uy; 0x94uy;
  0x55uy; 0x85uy; 0x80uy; 0x8buy; 0x48uy; 0x31uy; 0xd7uy; 0xbcuy;
  0x3fuy; 0xf4uy; 0xdeuy; 0xf0uy; 0x8euy; 0x4buy; 0x7auy; 0x9duy;
  0xe5uy; 0x76uy; 0xd2uy; 0x65uy; 0x86uy; 0xceuy; 0xc6uy; 0x4buy;
  0x61uy; 0x16uy]

let xmac = List.Tot.map u8_from_UInt8 [
  0x1auy; 0xe1uy; 0x0buy; 0x59uy; 0x4fuy; 0x09uy; 0xe2uy; 0x6auy;
  0x7euy; 0x90uy; 0x2euy; 0xcbuy; 0xd0uy; 0x60uy; 0x06uy; 0x91uy]

#set-options "--max_fuel 0 --z3rlimit 25"

let test () =
  assert_norm(List.Tot.length k = 32);
  assert_norm(List.Tot.length n = 12);
  assert_norm(List.Tot.length p = 114);
  assert_norm(List.Tot.length aad = 12);
  assert_norm(List.Tot.length xcipher = 114);
  assert_norm(List.Tot.length xmac = 16);
  let k = of_list k in
  let n = of_list n in
  let p = of_list p in
  let aad = of_list aad in
  let xcipher = of_list xcipher in
  let xmac = of_list xmac in
  let enc = Spec.Chacha20Poly1305.aead_encrypt k n 114 p 12 aad in
  let cipher = sub enc 0 114 in
  let mac = sub enc 114 16 in
  let dec = Spec.Chacha20Poly1305.aead_decrypt k n 114 cipher mac 12 aad in
  let result_encryption = for_all2 (fun a b -> uint_to_nat #U8 a = uint_to_nat #U8 b) cipher xcipher in
  let result_mac_compare = for_all2 (fun a b -> uint_to_nat #U8 a = uint_to_nat #U8 b) mac xmac in
  let dec_p = match dec with | Some p -> p | None -> create 114 (u8 0) in
  let result_decryption = for_all2 (fun a b -> uint_to_nat #U8 a = uint_to_nat #U8 b) dec_p p in
  if result_encryption && result_mac_compare && result_decryption then IO.print_string "\nSuccess!\n"
  else IO.print_string "\nFailure :("
