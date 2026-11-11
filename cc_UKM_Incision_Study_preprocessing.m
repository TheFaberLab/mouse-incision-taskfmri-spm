%% Step 3: increase voxel size (x10), slice timing correction, realignment
%% and smoothing (batches\SPM_preprocessing_srav.m)
% Hui-Fen Chen & Bruno Pradier, University of Muenster

clear
A_settings;

parentdir = dir(workpath);
parentdir = parentdir([parentdir.isdir] & ~strncmp({parentdir.name}, '.', 1));

for a = 1:size(parentdir,1)
    inputpath = [parentdir(a).folder '\' parentdir(a).name];
    preprocessed = inputpath;
    cd(preprocessed); % the realignment figure is saved here

    spm('defaults','fmri'); spm_jobman('initcfg'); % Initialize spm jobman
    fnms = cellstr(spm_select('FPList', preprocessed, ['^' parentdir(a).name '.*_\d{5}\.nii$']));
    fnms = strcat(fnms, ',1');

    clear matlabbatch
    SPM_preprocessing_srav; % increasing voxel size and 3 more preprocessing steps for SPM
end
cd(here);
