close all;
clc;
clear all;

% RL:
% 0 Rand
% 1 Epsilon-greedy
% 2 Thomson Sampling
% 3 Upper Confidence Bound 1

RL = 2;
print= 0;
draw = 0;

Metodo = 'EVRPSATS';
MAX_TRIALS = 20;

CollectionDirectory = 'EVRP/evrp-benchmark-set/Complete/';
a = struct2cell(dir(strcat(CollectionDirectory,'/')));
carpeta='Resultados/';

mkdir (sprintf(carpeta))
disp(CollectionDirectory)
archivos=size(a,2);
if (isfile(strcat(carpeta,'general.mat')))
    load(strcat(carpeta,'general.mat'));
    [contador,~]=size(general);
    indx=3+contador;
    contador=contador+1;
else
    contador=1;
    indx=3;
end
for t=indx:archivos
    if(~strcmp(a{1,t}, '.') && ...
            ~strcmp(a{1,t}, '..') && ...
            a{5,t} == 1)
        path = strcat([a{1,3}]);
        disp(path)
    end
    prueba = strcat([a{1,t}]);
    dir=strcat(CollectionDirectory,prueba);


    %% Iterator for MAX_TRIALS (20) tests
    model=Model(dir);
    best_Sol_length=zeros(1,MAX_TRIALS);
    time=zeros(1,MAX_TRIALS);
    
    disp(prueba)
    for iter=1:MAX_TRIALS
        rng(iter);
        tic;
        [BestSol(iter),best_Sol_length(1,iter),flag(iter),MemoryHeuristics{iter}]=EVRPSARL(model,RL,print,draw);
     	time(1,iter)=toc;
    end
    n=cellstr(prueba(1:end-4));
    mean(best_Sol_length)
    general(contador,:)=[n,min(best_Sol_length),max(best_Sol_length),mean(best_Sol_length),std(best_Sol_length),mean(time)];
    name=strcat(carpeta,prueba(1:end-4),'.mat');
    name2=strcat(carpeta,'Heuristics',prueba(1:end-4),'.mat');
    save(name,'BestSol')
    save(name2,'MemoryHeuristics')
    name3=strcat(carpeta,'general','.mat');
    save(name3,'general')
    contador=contador+1;
end

