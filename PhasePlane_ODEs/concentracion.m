%FICHERO PARA PROBAR EL GR�FICO DE LA CONCENTRACI�N
global tf
n=100000;%numero de puntos
con=zeros(1,n);%creamos la variable de la concentraci�n
i=1;%contador
for t=linspace(0,tf-2,n)
    con(i)=ec1c(t);%llamamos a la funci�n en cada uno de los tiempos
    i=i+1;
end
t=linspace(0,tf-2,n);%creamos la variable del tiempo
plot(t,con,'-r')%ploteamos ambas cosas
%cuanta menor sea la diferencia entre los puntos de t, m�s precisa se ver�
%la funci�n en el escal�n (entre 1 y 1.01 puede haber hasta dos puntos de
%diferencia en la concentraci�n seg�n los datos usados)
