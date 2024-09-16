needsPackage "NCAlgebra"
needsPackage "Complexes"

numgens NCIdeal := J -> #(J.generators)

toNCRing Ideal := I -> (
    R := I.ring;
    S := R/I;
    nS := toNCRing S;
    nS.ideal
    )

homogDual Ideal := I -> homogDual toNCRing I

priddyComplex = method()
priddyComplex (NCRing,ZZ,ZZ) := (R,n,m) -> (
    Rs := homogDual R;
    diffs := for i from m to n list i => priddyDifferential (R,Rs,i);
    new NCChainComplex from diffs
    )

-- Probably a more elegant way to do this
priddyComplex (Ring, ZZ,ZZ) := (R,n,m) -> (
    Rs := homogDual R;
    diffs := for i from m to n list priddyDifferential (R,Rs,i);
    complex diffs
    )

priddyComplex(NCRing,ZZ) := (R,n) -> priddyComplex(R,n,0)
priddyComplex(Ring,ZZ) := (R,n) -> priddyComplex(R,n,0)

priddyDifferential = method()
-- Computes the i'th priddy differential of a pair of Koszul dual rings
-- WARNING: no error checking, no check that they are indeed dual, no check that they're quadratic

priddyDifferential (NCRing, NCRing, ZZ) := (R,Rs,i) -> (
    e := numgens R - 1;
    transpose fold(plus, for j to e list (
	    R_j * leftMultiplicationMap(Rs_j,i)
	    )
	)
    )

-- Probably a more elegant way to do this
priddyDifferential (Ring, NCRing, ZZ) := (R,Rs,i) -> (
    e := numgens R - 1;
    transpose fold(plus, for j to e list (
	    R_j * leftMultiplicationMap(Rs_j,i)
	    )
	)
    )

-- NCRingElemeng * MatrixOfScalars is not defined (eyeroll)
NCRingElement * Matrix := (r,m) -> ncMatrix(r * (entries m))
Matrix NCRingElement := (m,r) -> ncMatrix((entries m) * r)
    
  
    
    
    
    
