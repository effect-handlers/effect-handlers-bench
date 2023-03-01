open OcamlHeader

type (_, _) eff_internal_effect += Increment : (int, unit) eff_internal_effect

let _count_42 (_n_43 : int) =
  let rec _step_198 _x_199 (_s_200 : int) =
    if _x_199 = 0 then _s_200
    else
      _step_198 (_x_199 - 1)
        (let rec _looper_214 _x_215 =
           if _x_215 = 0 then _s_200
           else
             let _b_226 = _x_215 - (503 * _looper_214 (_x_215 - 1)) + 37 in
             (if _b_226 > 0 then _b_226 else ~-_b_226) mod 1009
         in
         _looper_214 _n_43)
  in
  _step_198 1000 0

let count = _count_42
