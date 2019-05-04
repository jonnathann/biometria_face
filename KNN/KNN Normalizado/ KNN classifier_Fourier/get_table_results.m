function get_table_results(folder, classify, extraction, param_extractor)
    directory = dir(folder);
    directory_names = {directory.name};
    
    fid = fopen(strcat('TABLE-', folder,'-', classify{1}, '.txt'),'wt');
    titles = {classify{2}, 'ACCURACY', 'STANDARD', param_extractor};
    fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
    fprintf(fid, strcat('\t\t',strcat(folder,'-',classify{1}) ,'\t\t\n\n'));
    fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
    fprintf(fid, strcat('\t\t', titles{1}, '\t\t', titles{2}, '\t', titles{3}, '\t', titles{4}, '\n\n'));
    fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
    for i = 3:size(directory_names, 2)
        
        str = strcat(folder, '/', directory_names{i});
        aux = load(str);
        if strcmp(classify{1}, 'ELM') && strcmp(extraction, 'WAVELET')
            accuracy = {aux.structureELM.mean_accuracy};
            standard = {aux.structureELM.std};
            param_classify = {aux.structureELM.neurons};
            param_extraction = {aux.structureELM.wavelet};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
            
        end
        
        if strcmp(classify{1}, 'SVM') && strcmp(extraction, 'WAVELET')
            accuracy = {aux.structureSVM.mean_accuracy};
            standard = {aux.structureSVM.std};
            param_classify = {aux.structureSVM.gammas};
            param_extraction = {aux.structureSVM.wavelet};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        if strcmp(classify{1}, 'KNN') && strcmp(extraction, 'WAVELET')
            accuracy = {aux.structureKNN.mean_accuracy};
            standard = {aux.structureKNN.std};
            param_classify = {aux.structureKNN.k};
            param_extraction = {aux.structureKNN.wavelet};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        if strcmp(classify{1}, 'OPF') && strcmp(extraction, 'WAVELET')
            accuracy = {aux.structureOPF.mean_accuracy};
            standard = {aux.structureOPF.std};
            param_classify = {aux.structureOPF.dist};
            param_extraction = {aux.structureELM.wavelet};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        if strcmp(classify{1}, 'MLP') && strcmp(extraction, 'WAVELET')
            accuracy = {aux.structureMLP.mean_accuracy};
            standard = {aux.structureMLP.std};
            param_classify = {aux.structureMLP.neurons};
            param_extraction = {aux.structureMLP.wavelet};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        %extrator LBP
        
        if strcmp(classify{1}, 'ELM') && strcmp(extraction, 'LOCAL-BINARY-PATTERN')
            accuracy = {aux.structureELM.mean_accuracy};
            standard = {aux.structureELM.std};
            param_classify = {aux.structureELM.neurons};
            param_extraction = {aux.structureELM.mask};
            param_extraction{1}
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
            
        end
        
        if strcmp(classify{1}, 'SVM') && strcmp(extraction, 'LOCAL-BINARY-PATTERN')
            accuracy = {aux.structureSVM.mean_accuracy};
            standard = {aux.structureSVM.std};
            param_classify = {aux.structureSVM.gammas};
            param_extraction = {aux.structureSVM.mask};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        if strcmp(classify{1}, 'KNN') && strcmp(extraction, 'LOCAL-BINARY-PATTERN')
            accuracy = {aux.structureKNN.mean_accuracy};
            standard = {aux.structureKNN.std};
            param_classify = {aux.structureKNN.k};
            param_extraction = {aux.structureKNN.mask};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        if strcmp(classify{1}, 'OPF') && strcmp(extraction, 'LOCAL-BINARY-PATTERN')
            accuracy = {aux.structureOPF.mean_accuracy};
            standard = {aux.structureOPF.std};
            param_classify = {aux.structureOPF.dist};
            param_extraction = {aux.structureELM.mask};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        if strcmp(classify{1}, 'MLP') && strcmp(extraction, 'LOCAL-BINARY-PATTERN')
            accuracy = {aux.structureMLP.mean_accuracy};
            standard = {aux.structureMLP.std};
            param_classify = {aux.structureMLP.neurons};
            param_extraction = {aux.structureMLP.mask};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        %extrator Fourier
        
        if strcmp(classify{1}, 'ELM') && strcmp(extraction, 'FOURIER-TRANSFORM')
            accuracy = {aux.structureELM.mean_accuracy};
            standard = {aux.structureELM.std};
            param_classify = {aux.structureELM.neurons};
            param_extraction = {aux.structureELM.margins};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
            
        end
        
        if strcmp(classify{1}, 'SVM') && strcmp(extraction, 'FOURIER-TRANSFORM')
            accuracy = {aux.structureSVM.mean_accuracy};
            standard = {aux.structureSVM.std};
            param_classify = {aux.structureSVM.gammas};
            param_extraction = {aux.structureSVM.margins};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        if strcmp(classify{1}, 'KNN') && strcmp(extraction, 'FOURIER-TRANSFORM')
            accuracy = {aux.structureKNN.mean_accuracy};
            standard = {aux.structureKNN.std};
            param_classify = {aux.structureKNN.k};
            param_extraction = {aux.structureKNN.margins};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        if strcmp(classify{1}, 'OPF') && strcmp(extraction, 'FOURIER-TRANSFORM')
            accuracy = {aux.structureOPF.mean_accuracy};
            standard = {aux.structureOPF.std};
            param_classify = {aux.structureOPF.dist};
            param_extraction = {aux.structureELM.margins};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
        
        if strcmp(classify{1}, 'MLP') && strcmp(extraction, 'FOURIER-TRANSFORM')
            accuracy = {aux.structureMLP.mean_accuracy};
            standard = {aux.structureMLP.std};
            param_classify = {aux.structureMLP.neurons};
            param_extraction = {aux.structureMLP.margins};
            
            fprintf(fid, strcat('\t\t', num2str(param_classify{1}), '\t\t',num2str(accuracy{1}), '\t\t', num2str(standard{1}), '\t\t' ,param_extraction{1}, '\n\n'));
            fprintf(fid, strcat('\t', '-----------------------------------------------------------------------' ,'\t\t\n\n'));
        end
    end
    fclose(fid);
end