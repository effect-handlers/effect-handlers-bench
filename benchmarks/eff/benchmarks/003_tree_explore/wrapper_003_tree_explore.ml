let n = try int_of_string Sys.argv.(1) with _ -> 16

let _ = Printf.printf "%d\n" (Generated_003_tree_explore.max_path_merged_handler n)
