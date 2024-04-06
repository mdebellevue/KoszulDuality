needsPackage "TensorComplexes"
needsPackage "NCAlgebra"    
    
quadraticSpace = method()
quadraticSpace = method()
quadraticSpace(ZZ,Ring) := (n,R) -> (
    V := labeledModule R^n;
    V ** V)
quadraticSpace(Ring) := R -> (
    k := coefficientRing R;
    n := numgens R;
    quadraticSpace(n,k))
quadraticSpace(Ideal) := I -> quadraticSpace (ring I)


listToHash = L -> (
    -- Take a quadratic monomial given as a list and convert it to a hash table
    -- e.g., {0,0} is x_0^2, so should be 0 => 2
    -- {1,2} is x_1x_2, so should be 1 => 1, 2 => 2
    if L#0 == L#1 then new HashTable from {L#0=>2}
    -- This actually still counts them twice because of how hashtables work :(
    else new HashTable from {L#0=>1, L#1=>1}
    -- Below makes it so that xy, yx are both counted, so they're counted twice
    -- else if L#0 > L#1 then new HashTable from {L#1=>1,L#0=>1}
    -- else if L#0 < L#1 then new HashTable from {L#0=>1,L#1=>1}
    )


-- hashToList = H -> keys H
    
stfToCol = (stf,L) -> (
    -* Inputs:
      - stf: A polynomial in standard form
      - L: a list of numbers, representing support of a monomial
        - 0 -> x_0, 1 -> x_1, {0,1} -> x_0x_1
     Outputs:
      - Column vector of coefficients w.r.t. monomials of L
     Caveats:
      - L must be ordered ({0,1} for x*y rather than {1,0} for x*y)
      - Otherwise these monomials were counted twice because of commutivity
    *- 
    for tu in L list (
	{try (
		-- For commutivity reasons
		if tu#0>t#1 then 0 else(
		    myKey := listToHash(tu);
		    print myKey;
		    coef := stf#myKey
    	    	    )
		)
	     else 0}
	)
    )
numgens NCIdeal := J -> #(J.generators)

toNCRing Ideal := I -> (
    R := I.ring;
    S := R/I;
    nS := toNCRing S;
    nS.ideal
    )

quadraticMap = method()
quadraticMap Ideal := I -> (J := toNCRing I;
    quadraticMap J
    )
quadraticMap Ring := R -> quadraticMap(ideal R)
quadraticMap NCRing := A -> quadraticMap(ideal A)
quadraticMap NCIdeal := I -> (
   -- TODO: Do you want it to be the map I -> V ** V
   -- OR the quadratic dual map I^perp -> V^* ** V^*
   -- Maybe call the latter quadraticDualMap
   
   -- not defined for quotient rings
    A := I.ring;
   if class A =!= NCPolynomialRing then
      error "Expected an ideal in the tensor algebra.";
    -- decide if you want to do something different with non-quadratics
    Iq := quadraticClosure I;
    k := coefficientRing A;
    bas := basis(2,A);
    mat := sparseCoeffs(Iq.generators,Monomials=>flatten entries bas);
    Aq := quadraticSpace(A);
    mu := numgens Iq;
    IgenSpace := k^mu;
    IgenSpace = labeledModule IgenSpace;
    map(Aq,IgenSpace,mat)
    )

quadraticDualMap = method()
quadraticDualMap(Ideal) := I -> quadraticDualMap(toNCRing I)
quadraticDualMap(Ring) := R -> quadraticDualMap(ideal R)

quadraticDualMap(NCIdeal) := I -> (
    Iperp := homogDual(I);
    quadraticMap(Iperp)
    )
quadraticDualMap(NCRing) := R -> quadraticDualMap(ideal R)

higherQuadraticRelationSpaces = method()
higherQuadraticRelationSpaces(ZZ,Matrix) := (n,m) -> (
    -- Given W \subset V ** V, (represented as image of a matrix)
    -- Computes the higher spaces W_i^n = \oplus_i^{n-1} V^{i} ** W ** V^{n-i-2}
    rsqrd := rank target mat;
    r := sqrt(rsqrd);
    if floor r != r then error "dimension of target must be perfect square (W must be quadratic)" else r = floor r;
    k := ring mat;
    V := k^r;
    W := image mat;
    for i to n-1 list V^**i**W**V^**(n-i-1)
    )
higherQuadraticRelationSpaces(ZZ,LabeledModuleMap) := (n,m) -> higherQuadraticRelationSpaces(n,matrix m)  
higherQuadraticRelationSpaces(ZZ,NCIdeal) := (n,I) -> higherQuadraticRelationSpaces(n,quadraticDualMap(I))  
higherQuadraticRelationSpaces(ZZ,Ideal) := (n,I) -> higherQuadraticRelationSpaces(n,toNCRing I)
higherQuadraticRelationSpaces(ZZ,Ring) := (n,R) -> higherQuadraticRelationSpaces(n,ring R)
higherQuadraticRelationSpaces(ZZ,NCRing) := (n,R) -> higherQuadraticRelationSpaces(n,ring R)
higherQuadraticRelationSpaces(ZZ,NCIdeal) := (n,I) -> higherQuadraticRelationSpaces(n,quadraticDualMap(I))  
    
-- Should be able to add in stuff from homog dual pretty easily
-- Note: There's already Koszul Duality in the NCAlgebra package, but it doesn't implement it as a labeled basis.
    
-- Should be able to get the labeled basis by using sparseCoeffs
-- I.e., map(V**V, W, sparseCoeffs(gens I))

-* Problems with labeledModuleMaps:
1. Hom isn't defined for labeled module maps.
2. Image, ker, coker, etc., aren't defined for labeled module maps

*-
