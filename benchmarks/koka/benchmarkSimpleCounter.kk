module benchmarkSimpleCOunter

import std/os/env
import std/text/parse

effect increment
   ctl increment(j : int) : ()


fun operator(x : int, y : int) 
  abs (x - (503 * y) + 37) % 1009

fun looper(i : int, s : int) : <div, increment> int
  if (i == 0) then
    s
  else
    increment(i)
    looper(i - 1, s)

fun increment-handler(action : (() -> <div, increment> int) ) : div int
  with 
    ctl increment(j : int) { operator (j, resume(())) }
  action()

fun count(n : int) : div int
  fun step(l, s)
    if (l == 0) then
      s
    else
      step(l - 1, increment-handler( fn () looper(n, s)))
  step (1000, 0)


pub fun main()
  val n = 
    match get-args()
      Nil -> 20000
      Cons(arg0, _) -> 
        match parse-int(arg0)
          Just(n) -> n
          _        -> 20000
  count(n).println
