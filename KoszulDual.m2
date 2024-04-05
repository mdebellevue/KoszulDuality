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
    if L#0 == L#1 then new HashTable from {L#0=>2}
    else if L#0 > L#1 then new HashTable from {L#1=>1,L#0=>1}
    else if L#0 < L#1 then new HashTable from {L#0=>1,L#1=>1}
    )

-- hashToList = H -> keys H
    
    
    -- Take a quadratic monomial given as a list and convert it to a hash table
    -- e.g., {0,0} is x_0^2, so should be 0 => 2
    -- {1,2} is x_1x_2, so should be 1 => 1, 2 => 2
