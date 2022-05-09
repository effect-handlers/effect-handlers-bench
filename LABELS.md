# Labels

## BACKTRACKING

Handlers are used to simulate backtracking in a searching algorithm.

## CONCURRENCY

Handlers are used to simulate concurrency.

## ESCAPING_CONTINUATION

Continuation is wrapped and is executed outside of the original handler.

## MULTIPLE_RESUMPTIONS

Captured continuations are resumed multiple times.

## SINGLE_RESUMPTION

Captured continuations are resumed at most once.

## EXACTLY_ONCE_RESUMPTION

Captured continuations are resumed exactly once.

## DEEP_RESUMPTION_STACK

Resumed continuations form a deep stack (continuations are resumed in a non-tail position).

## DEEP_STACK_OF_HANDLERS

Handlers form a deep stack (might be dynamically interleaved).
