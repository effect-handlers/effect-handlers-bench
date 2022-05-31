effect Choose : unit -> bool

let n = try int_of_string (Sys.argv.(1)) with _ -> 16

let op x y = abs (x - (503 * y) + 37) mod 1009

type 'a tree =
| Leaf
| Node of 'a tree * 'a * 'a tree

let rec make = function
  | 0 -> Leaf
  | n -> let t = make (n-1) in Node (t,n,t)

let main () =
  let tree = make n in
  let state = ref 0 in
  let rec explore t = 
    match t with 
    | Leaf -> !state
    | Node (l, s, r) ->
      let next = if (perform (Choose ())) then l else r in
      state := op !state s;
      op s (explore next)
  in
  let rec looper n = 
    if n = 0 then 
      !state 
    else (
      let l = match (explore tree) with
        | _x -> [_x]
        | effect (Choose ()) k -> 
          let l = continue (Obj.clone_continuation k) true in
          let r = continue k false in
          l @ r
      in
      let s = List.fold_left max 0 l in
      state := s;
      looper (n-1)
    )
  in
  Printf.printf "%d\n" (looper 10)

let _ = main ()
