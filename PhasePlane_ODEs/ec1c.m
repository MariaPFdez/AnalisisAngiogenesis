%FICHERO QUE INTRODUCE LA FUNCI�N CONCENTRACI�N
function con=ec1c(t)
global tf
%inicializo las variables
%ti=[0:2:14];%tiempos en los que se aplica el f�rmaco TNP
%ti=[0:1:10];%tiempos en los que se aplica el f�rmaco Endostatina
% ti=[0:1:14];%tiempos en los que se aplica el f�rmaco Angiostatina
% n=length(ti);
% di=20*ones(n);%dosis que se aplica cada vez SEG�N ART�CULO
D=300;
% n=15;%cantidad de d�as que se aplican las dosis
% ti=linspace(0,14,n);%tiempos en los que se aplica el f�rmaco, equiespaciados
% di=D*ones(n)/n;%cantidad de dosis que se aplica cada vez
ti=[0:1.32:1.32*14];
di=10*ones(1,n);
con=0;%al principio no hay ning�n f�rmaco
%k1=10.1;%para el f�rmaco TNP
%k1=1.7;%para el f�rmaco Endostatina
k1=0.38;%para el f�rmaco Angiostatina
for i=2:1:n
    if t<=ti(i) && t>ti(i-1)
        con=[di(1:i-1)].*exp(-k1.*(t.*ones(1,i-1)-[ti(1:i-1)]));%calculo a la vez todos los elementos del sumatorio en forma de vector
        con=sum(con);%sumo las componentes del vector
        return
    else
        i=i+1;
    end
end
%lo que ocurre una vez deja de administrarse el f�rmaco
if t>ti(n)
    con=[di(1:n)].*exp(-k1.*(t.*ones(1,n)-[ti(1:n)]));%calculo a la vez todos los elementos del sumatorio en forma de vector
    con=sum(con);%sumo las componentes del vector
end
end