module benchmark

import std/os/env
import std/text/parse

effect flip
  ctl flip() : bool
effect fail
  ctl fail<a>() : a


fun hash-triple((a,b,c)) : int {
  (53 * a + 2809 * b + 148877 * c) % 1000000007
}


fun choice(n : int) {
  if (n < 1) then {
    fail()
  } elif (flip()) then {
    n
  } else {
    choice(n - 1)
  }
}

fun triple(n : int, s: int){
  val i = choice(n)
  val j = choice(i - 1)
  val k = choice(j - 1)
  if i + j + k == s then {
    (i, j, k)
  } else {
    fail()
  }
}

fun sum-triples(n : int, s : int) : div int {
  (handler
    ctl flip() { ((resume(True) : int) + resume(False)) % 1000000007 }
  ){
    (handler
      ctl fail()    0
    ){
      val r = triple(n, s)
      hash-triple(r)
    }
  }
}

fun with-int(s : string, default : int) : int{
  match parse-int(s)
    Just(n) -> n
    _ -> default
}

pub fun main()
  val (s, n) = 
    match get-args()
      Nil -> (300, 300)
      Cons(arg0, Cons(arg1, _)) -> 
        (with-int(arg0, 300), with-int(arg1, 300))
      Cons(arg0, _) -> 
        (with-int(arg0, 300), 300)
  sum-triples(s, n).println
