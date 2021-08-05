let n = try int_of_string Sys.argv.(1) with _ -> 13

let _ = Printf.printf "%d\n" (Generated_001_nqueens.queens_count n)