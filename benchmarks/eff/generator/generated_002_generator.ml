open OcamlHeader

type (_, _) eff_internal_effect += Yield : (int, unit) eff_internal_effect

type int_tree = Leaf | Node of (int_tree * int * int_tree)

type generator = None | Thunk of (int * (unit -> generator))

let rec _make_tree_42 _x_48 =
  match _x_48 with
  | 0 -> Leaf
  | _n_50 ->
      let _t_53 = _make_tree_42 (_n_50 - 1) in
      Node (_t_53, _n_50, _t_53)

let make_tree = _make_tree_42

let _sum_generator_54 (_n_55 : int) =
  let rec _looper_105 (_gen_107, _acc_106) =
    match _gen_107 () with
    | None -> _acc_106
    | Thunk (_x_110, _k_109) -> _looper_105 (_k_109, _acc_106 + _x_110)
  in
  _looper_105
    ( (let rec _iterate_122 (_x_100, _k_124) =
         match _x_100 with
         | Leaf -> _k_124 ()
         | Node (_l_103, _x_102, _r_101) ->
             _iterate_122
               ( _l_103,
                 fun (_ : unit) (() : unit) ->
                   Thunk
                     ( _x_102,
                       _iterate_122
                         (_r_101, fun (_x_133 : unit) -> _k_124 _x_133) ) )
       in
       _iterate_122 (_make_tree_42 _n_55, fun (_x_61 : unit) (() : unit) -> None)),
      0 )

let sum_generator = _sum_generator_54
