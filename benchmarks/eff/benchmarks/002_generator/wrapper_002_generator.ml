let n = try int_of_string Sys.argv.(1) with _ -> 25

let _ = Printf.printf "%d\n" (Generated_002_generator.sum_generator n)
