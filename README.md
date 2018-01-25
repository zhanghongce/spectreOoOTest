# SpectreOoOTest
This is to test the out-of-order behavior of the micro architecture
- On x86 TSO, load-load reordering is not permitted.
- However speculative load is allowed, and in the commit stage, the speculative load will be replayed if there is a load ahead.
- But if both commit stages are squashed, there would not be such correction.
- So there is possibility that the first load has not brought
in the cache but the second load does.
