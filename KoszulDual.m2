needsPackage "TensorComplexes"
    
quadraticSpace = method()
quadraticSpace = method()
quadraticSpace(ZZ,Ring) := (n,R) -> (
    V := labeledModule R^n;
    V ** V)
quadraticSpace(Ring) := R -> (
    k := baseRing R;
    n := numgens R;
    quadraticSpace(n,k))

listToHash = L -> (
    -- Take a quadratic monomial given as a list and convert it to a hash table
    -- e.g., {0,0} is x_0^2, so should be 0 => 2
    -- {1,2} is x_1x_2, so should be 1 => 1, 2 => 2
