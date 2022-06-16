module benchmark

import std/os/env
import std/text/parse

effect yield-num
  ctl yield-num(num : int) : ()


type tree<a>
  Leaf
  Node(left: tree<a>, v: a, right: tree<a>)

type generator<a>
  Empty
  Thunk(v: a, rest: () -> generator<a>)

fun make-tree(n: int) : div tree<int>
  if n == 0 then
    Leaf
  else
    val sub = make-tree(n - 1)
    Node(sub, n, sub)


fun iterate(tree: tree<int>) : <yield-num> () {
  match tree
    Leaf -> ()
    Node(left, v, right) -> {
      iterate(left)
      yield-num(v)
      iterate(right)
    }
}

fun consumer(g: () -> generator<int>, acc : int) : div int
  match g ()
    Empty -> acc
    Thunk(v, rest) -> consumer (rest, acc + v)

fun sum-generator(tree: tree<int>) : (() -> generator<int>) {
  with handler
    return(_)  fn () { Empty }
    raw ctl yield-num(x : int) {   
      fn () { 
        Thunk ( 
          x , 
          rcontext.resume(())
        ) 
      }
    }
  iterate(tree)
}

pub fun main()
  val sz = 
    match get-args()
      Nil -> 25
      Cons(arg0, _) -> 
        match parse-int(arg0)
          Just(sz) -> sz
          _        -> 25
  consumer(sum-generator(make-tree(sz)), 0).println
