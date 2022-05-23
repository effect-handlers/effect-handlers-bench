let n = try int_of_string Sys.argv.(1) with _ -> 20_000

let _ = Printf.printf "%d\n" (Generated_007_simple_counter.count n)
