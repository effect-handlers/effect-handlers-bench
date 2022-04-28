module benchmarkGenerator

import std/os/env
import std/text/parse

effect choose
  ctl choose() : bool


type tree<a>
  Leaf
  Node(left: tree<a>, v: a, right: tree<a>)


fun operator(x, y) 
  abs (x - (503 * y) + 37) % 1009

type generator<a>
  Empty
  Thunk(v: a, rest: () -> generator<a>)

fun make-tree(n: int) : div tree<int>
  if n == 0 then
    Leaf
  else
    val sub = make-tree(n - 1)
    Node(sub, n, sub)


fun max-l(l : list<int>) : int
  l.maximum

fun sum-paths(tree: tree<int>){
  var state := 0
  fun explore(tr: tree<int>) {
    match tr
      Leaf -> state
      Node(left, v, right) ->
        val next = if choose() then left else right
        state := operator(state, v)
        operator(v, explore(next))
  }
  val choose-handler = handler
    return(x) [x]
    ctl choose() resume(True) ++ resume(False)
  fun iterate(n: int){
    if n == 0 then state
    else {
      val l = choose-handler(fn () explore(tree))
      val s = l.max-l
      state := s
      iterate(n - 1)
    }
  }
  iterate(10)
}


pub fun main()
  val sz = 
    match get-args()
      Nil -> 16
      Cons(arg0, _) -> 
        match parse-int(arg0)
          Just(sz) -> sz
          _        -> 16
  sum-paths(make-tree(sz)).println