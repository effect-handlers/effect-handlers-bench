# Handler Sieve

Computes the sum of all primes less than `n` using trial division. Builds up a
list of primes found so far implicitly in the context using nested handlers for
a `prime` effect that decides if a given number is prime. The `prime` effect is
initially handled by a handler that always returns true. Whenever we find a
prime number we continue with `prime` handled by a new handler that will now
also check divisibility by the new prime.

## Examples

### Small

Input: 10

Output: 17

### Large

Input: 60000

Output: 171848738

## Metadata

### Labels

DEEP_STACK_OF_HANDLERS

### References

### Rationale

We create a statically unbounded number of nested handlers.

