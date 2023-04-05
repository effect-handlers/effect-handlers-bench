let n = try int_of_string Sys.argv.(1) with _ -> 10_000

let _ = Printf.printf "%d\n" (Generated.repeat n)
