%C�LCULO DE LA INTEGRAL DE C(T) MEDIANTE SUMAS (PROCEDIMIENTO ANAL�TICO)
function con=optilinGen(x)
global Tf lambda N
ti=[0,x(1:N-1)];%vector de tiempos en los que se administra la dosis
di=x(N:2*N-1);%cantidad de f�rmaco administrado en cada caso
con=0;%se comienza sin concentraci�n
%EXPRESI�N OBTENIDA CON EL C�LCULO DE LAS INTEGRALES
for i=1:1:N
    suma=(di(i)*(1-exp(lambda*(ti(i)-Tf))))/lambda;
    con=con+suma;
end
end