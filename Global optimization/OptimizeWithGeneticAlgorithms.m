function [xval,maxf]=OptimizeWithGeneticAlgorithms(fun,range,bits,pop,gens,mu,matenum)  
    % GA optimization 
    % fun – the target function 
    % range[x1 x2] – the range of x: from x1 to x2 
    % bits – the number of bits in a word 
    % pop – the number of chromosomes in the population 
    % gens – the number of generations 
    % mu – the mutation parameter 
    Y = ones(1,pop); 
    axis ([0 gens range(1) range(2)])  
    newpop=[ ]; 
    a=range(1); 
    b=range(2); 
    newpop=genbin(bits,pop);  
    for i=1:gens     
        for iii = 1:pop         
            XXX(iii) = bin2real(newpop(iii,:),a,b);     
        end
        YYY = i*Y;     
        plot(YYY,XXX,'o')     
        hold on     
        selpop = selectga(fun,newpop,a,b);     
        newgen = matesome(selpop,matenum);     
        newgen1 = mutate(newgen,mu);     
        newpop = newgen; 
    end
    [fit,fitot] = fitness(fun,newpop,a,b); 
    [maxf,mostfit] = max(fit); 
    xval = bin2real(newpop(mostfit,:),a,b);
end

function chromosome=genbin(bitl,numchrom) 
    % generation of a binary population 
    % word length bitl
    % size of the population numchrom 
    maxchros=2^bitl; 
    if numchrom >= maxchros    
        numchrom = maxchros; 
    end
    chromosome = round(rand(numchrom,bitl));
end

function deci=bin2real(chrom,a,b) 
    % binary chromosome -> decimal number in the range from a to b 
    [pop bitlength] = size(chrom); 
    maxchrom=2^bitlength-1; 
    % weights of binary digits 
    realel=chrom.*((2*ones(1,bitlength)).^fliplr([0:bitlength-1])); 
    % sumation  
    tot=sum(realel); 
    % range 
    deci=a+tot*(b-a)/maxchrom; 
end

function [fit,fitot]=fitness(kriter,chrom,a,b) 
    % Fitness for the set of chromosomes in the range between a and b 
    % 'kriter' – the title of the external target function 
    [pop bitl]=size(chrom); 
    for k=1:pop     
        v(k)=bin2real(chrom(k,:),a,b);     
        fit(k)=feval(kriter,v(k)); 
    end
    fitot=sum(fit);
end

function newchrom=selectga(kriter,chrom,a,b) 
    % the title of the target function - ‘kriter’   
    [pop bitlength]=size(chrom); 
    fit=[];   
    % the assessment of chromosomes 
    [fit,fitot] = fitness(kriter,chrom,a,b);   
    for chromnum=1:pop     
        sval(chromnum)=sum(fit(1,1:chromnum)); 
    end  
    % roulette  
    parname=[]; 
    for i=1:pop     
        rval=floor(fitot*rand);     
        if rval<sval(1)        
            parname=[parname 1];     
        else
            for j=1:pop-1            
                sl=sval(j);            
                su=sval(j)+fit(j+1);            
                if (rval>=sl) && (rval<=su)               
                    parname=[parname j+1];            
                end
            end
        end
    end
    newchrom(1:pop,:)=chrom(parname,:);
end

function chrom1=matesome(chrom,kiek) 
    % crossover procedure 
    % chrom – the initial set of genes 
    % chrom1 – genes after the crossover 
    % kiek – crossover degree from 0 to 1 
    mateind = [ ]; 
    chrom1 = chrom; 
    [pop bitlength] = size(chrom); 
    ind = 1:pop; 
    u = floor(pop*kiek); 
    if floor(u/2) ~= u/2    
        u = u-1; 
    end  
    % random crossover 
    while length(mateind)~=u       
        i = round(rand*pop);       
        if i == 0          
            i = 1;       
        end  
          if ind(i) ~= -1          
              mateind = [mateind i];          
              i = -1;       
          end      
    end
    % crossover at a random point 
    for i = 1:2:u-1 
        splitpos = floor(rand*bitlength);     
        if splitpos == 0        
            splitpos = 1;     
        end
        i1 = mateind(i);     
        i2 = mateind(i+1);     
        tempgene = chrom(i1,splitpos+1:bitlength);     
        chrom1(i1,splitpos+1:bitlength)=chrom(i2,splitpos+1:bitlength);     
        chrom1(i2,splitpos+1:bitlength)=tempgene; 
    end
end

function chrom=mutate(chrom,mu) 
    % mutation of chromosomes 
    % mu – the mutation strength; usually assumed as a small positive number 
    [pop bitlength] = size(chrom); 
    for i=1:pop     
        for j=1:bitlength         
            if rand <= mu            
                if chrom(i,j) == 1               
                    chrom(i,j) = 0;            
                else
                    chrom(i,j) = 1;            
                end
            end
        end
    end
end








