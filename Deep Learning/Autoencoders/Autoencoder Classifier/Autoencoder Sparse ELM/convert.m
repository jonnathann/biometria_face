function [Y] = convert(entrada)
    
    line = size(entrada, 1);
    new_vector = [];
    
    for i = 1:line,
        [~, rotulo] =  max(entrada(i, 1:end));
        new_vector = [new_vector; rotulo];
    end
    Y = new_vector;
end

