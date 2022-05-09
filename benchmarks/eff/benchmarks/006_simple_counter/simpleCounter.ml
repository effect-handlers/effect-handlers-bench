let n = try int_of_string Sys.argv.(1) with _ -> 100_000

let _ = Printf.printf "%d\n" (Generated_006_simple_counter.count n)
