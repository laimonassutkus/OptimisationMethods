function AddConstraint(file, constraint)
    % Read txt into cell A
    fid = fopen(file,'r');
    i = 1;
    tline = fgetl(fid);
    A{i} = tline;
    while ischar(tline)
        i = i+1;
        tline = fgetl(fid);
        A{i} = tline;
    end
    fclose(fid);
    % Change cell A
    A{7} = sprintf('%s\n\t\t%s %s', A{7}, constraint, '>= 0');
    % Write cell A into txt
    fid = fopen(file, 'w');
    for i = 1:numel(A)
        if A{i+1} == -1
            fprintf(fid,'%s', A{i});
            break
        else
            fprintf(fid,'%s\n', A{i});
        end
    end
end