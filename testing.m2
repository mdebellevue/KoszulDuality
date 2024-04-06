R = ZZ/101[x,y,z]
f = x^2+2*x*y + 3 * x * z + 4 * y^2 + 5 * y * z + 6 * z^2
g = x*z+y*z
I = ideal{f,g}

quadraticMap I
quadraticDualMap I
k = ZZ/101
V = k^3
V = labeledModule V
Qd = V ** V
    
f = x^2+2*x*y + 3 * x * z + 4 * y^2 + 5 * y * z + 6 * z^2
stf = standardForm f
-- accessing via hash works, but only stf#hashtable
A = toNCRing R
