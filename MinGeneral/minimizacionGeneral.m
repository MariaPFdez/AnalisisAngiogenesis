%MINIMIZACI�N DE LA INTEGRAL DE LA DIFERENCIA ENTRE LA CONCENTRACI�N DEL
%F�RMACO EN CASO GENERAL (CON VARIABLES N, T_1...,T_N,D_1,...,D_N) Y UNA CONCENTRACI�N IDEAL
global Tf
global cd
global dmin
global dmax
global D
global lambda
global N
format short e
Tf=30;%�ltimo d�a en el que se ven los efectos
dmin=4;%cantidad de f�rmaco m�nima que se puede administrar
dmax=30;%cantidad de f�rmaco m�ximo que se puede administrar
D=300;%cantidad total de f�rmaco administrado
lambda=0.38;%el factor de la exponencial decreciente


%% PLOTEO EL VALOR DE LA FUNCI�N J PARA CADA UNA DE LAS CD EN FUNCI�N DE N
% j=0;
% k=0;
% fval=zeros(length(D/dmax:1:D/dmin),1);
% for cd=10:1:30
%     j=0;
%     k=k+1;
%     for N=D/dmin:-1:D/dmax
%         x0=[linspace(1,30,N),D*ones(1,N)/N];%x=[t=(t1,...,tN),d=(d1,...,dN)];
%         fun=@(x) optisqGen(x)-2*cd*optilinGen(x)+cd^2*Tf;%funci�n ya integrada a minimizar
%         A=sparse(N,2*N);%condiciones lineales de desigualdad
%         A(1:N,1:N)=diag(ones(N,1))+diag(-ones(N-1,1),1);A(N,N+1:2*N)=ones(N,1);A(N,N)=0;
%         b=-0.3*ones(N,1);b(N,1)=D;
%         Aeq=[];beq=[];%no hay condiciones lineales de igualdad
%         lb=[zeros(1,N),dmin*ones(1,N)];%valores m�nimos de los tiempos y las dosis administradas
%         ub=[0,Tf*ones(1,N-2),0.999*Tf,dmax*ones(1,N)];%valores m�ximos de los tiempos y las dosis administradas
%         options=optimset('TolCon',eps,'TolX', eps,'TolFun',eps,'MaxIter',1e12,'MaxFunEvals',1e12);
%         [x,fval(length(fval)-j,1)]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,[],options)%el m�nimo valor de la funci�n se obtiene para x
%         j=j+1;
%     end
%     plot([D/dmax:1:D/dmin],fval),xlabel('Number of doses \it{N}'),ylabel('Objective function of (P_1) \it{J}'),title('\it{J} \rm{function for} \it{N} \in \rm{[}\it{D/d_{max}},\it{D/d_{min}}\rm{]} if \it{c_d} \in \rm{[}\it{D/d_{max}},\it{D/d_{min}}\rm{]}')
%     hold on
%     legendInfo{k}=[num2str(cd) '(mg/kg)'];
%     legend(legendInfo)
% end


%% PLOTEO EL N QUE MINIMIZA LA FUNCI�N PARA CADA CD (ME DA TAMBI�N INFO TANTO DE LOS X COMO DE LOS J EN CADA CASO)
% len=length(ceil(D/dmax):1:floor(D/dmin));
% vecN=zeros(len,1); %aqu� aparecer�n los valores de las N que minimizan
% %la funci�n para cada cd
% eval=sparse(len,1); %aqu� escribo el valor de la J que resulta
% xopti=sparse(2*floor(D/dmin),len); %aqu� escribo el vector x en cada caso
% %(tiene la informaci�n del tiempo de aplicaci�n y la dosis)
% j=0;
% k=0;
% fval=sparse(len,1);
% x=sparse(2*floor(D/dmin),len);
% tic
% for cd=ceil(D/dmax):1:floor(D/dmin)
%     j=0;
%     k=k+1;
%     for N=floor(D/dmin):-1:ceil(D/dmax)
%         x0=[linspace(1,30,N),D*ones(1,N)/N];%x=[t=(t1,...,tN),d=(d1,...,dN)];
%         fun=@(x) optisqGen(x)-2*cd*optilinGen(x)+cd^2*Tf;%funci�n ya integrada a minimizar
%         A=sparse(N,2*N); %condiciones lineales de desigualdad
%         A(1:N,1:N)=diag(ones(N,1))+diag(-ones(N-1,1),1);A(N,N+1:2*N)=ones(N,1);A(N,N)=0;
%         b=-0.3*ones(N,1);b(N,1)=D;
%         Aeq=[];beq=[];%no hay condiciones lineales de igualdad
%         lb=[zeros(1,N),dmin*ones(1,N)];%valores m�nimos de los tiempos y las dosis administradas
%         ub=[0,Tf*ones(1,N-2),0.999*Tf,dmax*ones(1,N)];%valores m�ximos de los tiempos y las dosis administradas
%         options=optimset('TolCon',eps,'TolX', eps,'TolFun',eps,'MaxIter',1e12,'MaxFunEvals',1e12);
%         [x(1:2*N,len-j),fval(len-j,1)]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,[],options);%el m�nimo valor de la funci�n se obtiene para x
%         x(1:2*N,len-j)=round(x(1:2*N,len-j),2);%redondeo las x
%         fval(len-j,1)=fun(x(1:2*N,len-j));%calculo el valor de la funci�n para la x redondeada
%         if j>=1
%             if fval(len-j,1)>fval(len-j+1,1)
%                 vecN(k)=N+1;
%                 eval(k)=fval(len-j,1);
%                 xopti(1:2*N,k)=x(1:2*N,len-j+1);
%                 break
%             end
%         end
%         if j==len-1
%             if fval(len-j,1)<fval(len-j+1,1)
%                 vecN(k)=N;
%                 break
%             end
%         end
%         j=j+1;
%     end
% end
% toc
% plot([D/dmax:1:D/dmin],vecN,'.'),xlabel('Cd (mg/kg)'),ylabel('N (n� dosis)')
% hold on %EL N �PTIMO AUMENTA A MEDIDA QUE LO HACE CD
% %vecN=[12,13,14,15,16,18,19,20,21,22,23,24,25,27,28,28,28,28,28,28,28];



%% TOMO UN VECTOR X, UN CD Y SU N �PTIMO (OBTENCI�N DE GR�FICAS)
cd=4;
N=10;
x0=[linspace(0,30,N),20*ones(1,N)];%x=[t=(t1,...,tN),d=(d1,...,dN)];
fun=@(x) optisqGen(x)-2*cd*optilinGen(x)+cd^2*Tf;%funci�n ya integrada a minimizar
A=sparse(N,2*N); %condiciones lineales de desigualdad
A(1:N,1:N)=diag(ones(N,1))+diag(-ones(N-1,1),1);A(N,N+1:2*N)=ones(N,1);A(N,N)=0;
b=-0.3*ones(N,1);b(N,1)=D;
Aeq=[];beq=[];%no hay condiciones lineales de igualdad
lb=[zeros(1,N),dmin*ones(1,N)];%valores m�nimos de los tiempos y las dosis administradas
ub=[Tf*ones(1,N-1),0.999*Tf,dmax*ones(1,N)];%valores m�ximos de los tiempos y las dosis administradas
options=optimset('TolCon',eps,'TolX', eps,'TolFun',eps,'MaxIter',1e12,'MaxFunEvals',1e12);
[x,fval,exitflag,output]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,[],options);%el m�nimo valor de la funci�n se obtiene para x
x2=round(x,2);
fval2=fun(x2);
abs(fval-fval2);%NO VARIA APENAS HACIENDO LA APROXIMACION
for i=2:1:N %para no tomar la primera concentraci�n que suele ser distinta
    %utilizo el eps por tener una heaviside en cada x2(i)
    min(i-1)=ec1cGen(x2(i)-eps,x2);%valor de la concentraci�n en cada m�nimo
    max(i-1)=ec1cGen(x2(i)+10*eps,x2);%valor de la concentraci�n en cada m�ximo
end
minimum=round(mean(min),2); %calculo un valor m�nimo de la concentraci�n
maximum=round(mean(max),2); %calculo un valor m�ximo de la concentraci�n
concentracionGen(x2); %para plotear el resultado


% %% L�NEAS DE C�DIGO PARA LOS EJEMPLOS NUM�RICOS
% fun([linspace(0,27,10),10*ones(1,10)])
% fun([0,1,2,3,4,5,6,7,8,9,10*ones(1,10)])
