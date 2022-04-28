module benchmarkNQueens

import std/os/env
import std/text/parse

alias solution = list<int>
alias solutions = list<list<int>>

effect search
  ctl pick(size : int) : int
  ctl fail() : ()

fun safe( queen : int, diag : int, ^xs : solution ) : bool
  match xs
    Cons(q,qs) -> (queen != q && queen != q + diag && queen != q - diag && safe(queen,diag + 1,qs))
    _          -> True

fun find-one-solution(size : int, queen : int) : <div, search> solution 
  if queen == 0 
    then Nil
  else 
    val sol = find-one-solution(size, queen - 1)
    val next = pick(size)
    if safe(next, 1, sol) 
      then Cons(next, sol)
    else 
      fail()
      Nil

fun count-solutions(size) : div int
  with handler
    return(_)        1
    ctl fail()       0
    ctl pick(sz)      {
      //list(1, sz).map(resume).sum // This is slower on my machine
      fun loop(i : int, acc : int){
        if i == sz then
          resume(i) + acc
        else
          loop(i + 1, (resume(i) + acc))
      }
      loop(1, 0)
    }
  find-one-solution(size, size)

pub fun main()
  val sz = 
    match get-args()
      Nil -> 8
      Cons(arg0, _) -> 
        match parse-int(arg0)
          Just(sz) -> sz
          _        -> 8
  count-solutions(sz).println