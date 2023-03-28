let n = try int_of_string Sys.argv.(1) with _ -> 16

let _ = Printf.printf "%d\n" (Generated.max_path_merged_handler n)
