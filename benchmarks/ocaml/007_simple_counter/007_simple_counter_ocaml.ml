effect Increment : int -> unit

let n = try int_of_string (Sys.argv.(1)) with _ -> 20_000

let op x y = abs (x - (503 * y) + 37) mod 1009

let main () = 
  let rec step l s = 
    if l = 0 then s else 
    step (l-1) (match (
      let rec looper i = 
        if i = 0 then
          s
        else ( 
          perform (Increment i);
          looper (i - 1)
        )
      in
      looper n
    ) with
    | x -> x
    | effect (Increment j) k -> op j (continue k ()))
  in 
  Printf.printf "%d\n" (step 1000 0)

let _ = main ()
