let n = try int_of_string Sys.argv.(1) with _ -> 300

let s = try int_of_string Sys.argv.(2) with _ -> 300

let _ = Printf.printf "%d\n" (Generated_004_triples.sum_triples n s)
