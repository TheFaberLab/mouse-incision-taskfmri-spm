%% Step 4: merge 3D files to 4D files and delete the 3D files
% writes per scan: v<scan>.nii, a<scan>.nii, ra<scan>.nii, sra<scan>.nii
% sra<scan>.nii is the final, smoothed 4D file
% Hui-Fen Chen & Bruno Pradier, University of Muenster

clear
A_settings;

parentdir = dir(workpath);
parentdir = parentdir([parentdir.isdir] & ~strncmp({parentdir.name}, '.', 1));

for a = 1:size(parentdir,1)
    preprocessed = [parentdir(a).folder '\' parentdir(a).name];
    name = parentdir(a).name;

    spm('defaults','fmri'); spm_jobman('initcfg'); % Initialize spm jobman
    vname   = strcat('v',   name, '.nii');
    vnms    = strcat(cellstr(spm_select('FPList', preprocessed, ['^v'    name '.*_\d{5}\.nii$'])), ',1');
    aname   = strcat('a',   name, '.nii');
    anms    = strcat(cellstr(spm_select('FPList', preprocessed, ['^av'   name '.*_\d{5}\.nii$'])), ',1');
    raname  = strcat('ra',  name, '.nii');
    ranms   = strcat(cellstr(spm_select('FPList', preprocessed, ['^rav'  name '.*_\d{5}\.nii$'])), ',1');
    sraname = strcat('sra', name, '.nii');
    sranms  = strcat(cellstr(spm_select('FPList', preprocessed, ['^srav' name '.*_\d{5}\.nii$'])), ',1');

    % to delete the 3D files after splitting (the ones without prefix)
    dfnms   = strcat(cellstr(spm_select('FPList', preprocessed, ['^'     name '.*_\d{5}\.nii$'])), ',1');

    clear matlabbatch
    SPM_3Dto4DandDelete; % only sra* 3D.nii files will be left (for the 1st level)
end
