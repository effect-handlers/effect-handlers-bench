open OcamlHeader

type (_, _) eff_internal_effect += Choose : (unit, bool) eff_internal_effect

type (_, _) eff_internal_effect += Get : (unit, int) eff_internal_effect

type (_, _) eff_internal_effect += Set : (int, unit) eff_internal_effect

type tree = Leaf | Node of (tree * int * tree)

let _op_42 (_x_43 : int) (_y_44 : int) =
  abs (_x_43 - (503 * _y_44) + 37) mod 1009

let op = _op_42

type intlist = Nil | Cons of (int * intlist)

let rec _op_53 (* @ *) _x_60 (_ys_62 : intlist) =
  match _x_60 with
  | Nil -> _ys_62
  | Cons (_x_64, _xs_63) -> Cons (_x_64, _op_53 (* @ *) _xs_63 _ys_62)

let _op_53 (* @ *) = _op_53 (* @ *)

let rec _make_tree_67 _x_73 =
  match _x_73 with
  | 0 -> Leaf
  | _n_75 ->
      let _t_78 = _make_tree_67 (_n_75 - 1) in
      Node (_t_78, _n_75, _t_78)

let make_tree = _make_tree_67

let _max_79 (_a_80 : int) (_b_81 : int) = if _a_80 > _b_81 then _a_80 else _b_81

let max = _max_79

let _max_path_merged_handler_84 (_m_85 : int) =
  let rec _maxl_86 _x_145 (_x_341 : intlist) =
    match _x_341 with
    | Nil -> _x_145
    | Cons (_x_343, _xs_342) -> _maxl_86 (_max_79 _x_343 _x_145) _xs_342
  in
  let ____t_94 = _make_tree_67 _m_85 in
  let rec _looper_174 _x_175 (_n_176 : int) =
    if _n_176 = 0 then _x_175
    else
      let _s'_181, _l_180 =
        let rec _explore_235 (_x_154, _k_237) (_x_1 : int) =
          match _x_154 with
          | Leaf -> _k_237 _x_1 _x_1
          | Node (_left_207, _x_206, _right_205) ->
              let _l_157 (_y_208 : bool) (_x_0 : int) =
                if _y_208 then
                  _explore_235
                    ( _left_207,
                      fun (_b_312 : int) -> _k_237 (_op_42 _x_206 _b_312) )
                    (_op_42 _x_0 _x_206)
                else
                  _explore_235
                    ( _right_205,
                      fun (_b_338 : int) -> _k_237 (_op_42 _x_206 _b_338) )
                    (_op_42 _x_0 _x_206)
              in
              let _s'_118, _l_119 = _l_157 true _x_1 in
              let _s'_122, _r_123 = _l_157 false _s'_118 in
              (_s'_122, _op_53 (* @ *) _l_119 _r_123)
        in
        _explore_235
          ( ____t_94,
            fun (_x_126 : int) (_u_172 : int) -> (_u_172, Cons (_x_126, Nil)) )
          _x_175
      in
      _looper_174 (_maxl_86 0 _l_180) (_n_176 - 1)
  in
  _looper_174 0 10

let max_path_merged_handler = _max_path_merged_handler_84
