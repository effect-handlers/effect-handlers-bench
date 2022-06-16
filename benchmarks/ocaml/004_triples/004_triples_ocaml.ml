effect Choose : unit -> bool

let s = try int_of_string (Sys.argv.(1)) with _ -> 300

let n = try int_of_string (Sys.argv.(2)) with _ -> 300


effect Flip : unit -> bool
exception Fail

let rec choice n =
  if (n < 1)
    then raise Fail
    else if (perform (Flip ()))
      then n
      else choice (n - 1)

let triple n s =
  let i = choice n in
  let j = choice (i - 1) in
  let k = choice (j - 1) in
  if (i + j + k = s)
    then ((i, j, k) )
    else raise Fail

let hash_triple (a,b,c) = 
  (53 * a + 2809 * b + 148877 * c) mod 1000000007 (* 2089 = 53 * 53, 148877 = 53 * 2089  *)

let main n s =
  let sum = 
    try
    try
      let r = triple n s in
      hash_triple r
    with
    | Fail -> 0
    with
    | effect (Flip ()) k ->
        let l = continue (Obj.clone_continuation k) true in
        let r = continue k false in
        (l + r) mod 1000000007
  in
  Printf.printf "%d\n" sum

let _ = main s n

