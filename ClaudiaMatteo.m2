needsPackage "NCAlgebra"

k = ZZ/101;
R = k[x,y,z]/(ideal(x*y,(x+y)*z,x^2+x*z+y^2));
A = homogDual(R);
ideal A
-* Output: 
o5 = Two-sided ideal {y -x , zy-zx+yz-xz+x , z }
*-
ncGroebnerBasis ideal A
-* Output:
                     2   3
o6 = zxy-yzx-yxz+xzx-xyz+x z-x ; Lead Term = (zxy, 1)
       2  2                  2
     zx -x z; Lead Term = (zx , 1)
       2  2                  2
     yx -x y; Lead Term = (yx , 1)
      2  2                2
     y -x ; Lead Term = (y , 1)
                  2
     zy-zx+yz-xz+x ; Lead Term = (zy, 1)
      2                2
     z ; Lead Term = (z , 1)


*-

a=5
Q = k[x,y,z,u,v,w]
I = ideal{x^2,x*y, y*z, z^2,z*u, u^2, u*v, v*w,w^2, x*z + a*z*w - u*w,z*w+ x*u + (a - 2)*u*w}
R = Q/I
    
A = homogDual(R);

-- Did not finish after a few minutes

