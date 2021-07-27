let n = try int_of_string (Sys.argv.(1)) with _ -> 25

module MkGen (S :sig
  type 'a t
  val iter : ('a -> unit) -> 'a t -> unit
end) : sig
  val gen : 'a S.t -> (unit -> 'a option)
end = struct
  let gen : type a. a S.t -> (unit -> a option) = fun l ->
    let module M = struct effect Yield : a -> unit end in
    let open M in
    let rec step = ref (fun () ->
      match S.iter (fun v -> perform (Yield v)) l with
      | () -> None
      | effect (Yield v) k ->
          step := (fun () -> continue k ());
          Some v)
    in
    fun () -> !step ()
end

(* A generator for a list *)
module L = MkGen(struct
  type 'a t = 'a list
  let iter = List.iter
end)

type 'a tree =
| Leaf
| Node of 'a tree * 'a * 'a tree

let rec make = function
  | 0 -> Leaf
  | n -> let t = make (n-1) in Node (t,n,t)

let rec iter f = function
  | Leaf -> ()
  | Node (l, x, r) -> iter f l; f x; iter f r

(* A generator for a tree *)
module T = MkGen(struct
  type 'a t = 'a tree
  let iter = iter
end)

let main () =
  let next = T.gen (make n) in
  let rec consume acc =
    match next () with
    | None -> acc
    | Some v -> consume (v + acc)
  in
  Printf.printf "%d\n" (consume 0)

let _ = main ()
