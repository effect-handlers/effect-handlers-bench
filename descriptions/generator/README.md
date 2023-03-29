# Generator

The goal of the benchmark is to compute the sum of the elements in a complete
binary tree of height `h` using a generator. The generator is implemented using
effect handlers.

The tree is explored in a depth-first fashion, exploring the left subtree,
yielding the value of the node, and then exploring the right subtree.

The values in the binary tree nodes are defined as follows. If the height is 0,
then the tree has no nodes. Hence, the output should be 0. If the tree has
height `h`, then the root node has value `h`, all the nodes in the next level
have value `h-1`, all the nodes in the subsequent level has value `h-2`, and so
on.

The binary tree should be constructed using a space-efficient DAG representation
which represents complete binary tree of height `h` with `h` nodes. The OCaml
function `make_tree` below constructs such a complete binary tree:

```ocaml
type 'a tree =
| Leaf
| Node of 'a tree * 'a * 'a tree

let rec make_tree = function
  | 0 -> Leaf
  | n -> let t = make_tree (n-1) in Node (t,n,t)
```

The input is the height of the complete binary tree.

The output is the sum of the elements in the binary tree.

## Examples

### Small

Input: 5

Output: 57

### Large

Input: 25

Output: 67108837

## Metadata

### Labels

ESCAPING_CONTINUATION

### References

### Rationale

