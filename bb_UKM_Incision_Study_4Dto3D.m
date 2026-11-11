%% Step 2: split 4D -> 3D files and delete the first 20 repetitions
% Hui-Fen Chen & Bruno Pradier, University of Muenster

clear
A_settings;

parentdir = dir(workpath);
parentdir = parentdir([parentdir.isdir] & ~strncmp({parentdir.name}, '.', 1));

for a = 1:size(parentdir,1)
    localpath = [parentdir(a).folder '\' parentdir(a).name];
    preprocessed = localpath;

    % Run 1: to split 4D to 3D files
    niftifile = dir([localpath '\' parentdir(a).name '*.nii.gz']);
    if ~isempty(niftifile)
        display('File has not been unzipped; unzipping now')
        gunzip([niftifile(1).folder '\' niftifile(1).name]);
    else
        display('File is already unzipped; doing nothing')
    end

    niftifile2 = dir([localpath '\' parentdir(a).name '*.nii']);
    niftifile2 = strcat(niftifile2(1).folder, '\', niftifile2(1).name, ',1');

    spm('defaults','fmri'); spm_jobman('initcfg'); % Initialize spm jobman
    clear matlabbatch
    SPM_4Dto3D;

    % to delete the first 20 repetitions (and, for 1220-repetition scans,
    % everything after repetition 620)
    splitfile = cellstr(spm_select('FPList', localpath, ['^' parentdir(a).name '.*_\d{5}\.nii$']));
    nvol = size(splitfile,1);
    deletedfile = splitfile([1:ndiscard, ndiscard+nkeep+1:nvol]);
    for b = 1:size(deletedfile,1)
        delete(deletedfile{b});
    end
    fprintf('%s: %d repetitions, %d kept\n', parentdir(a).name, nvol, nvol - size(deletedfile,1));

    % the unzipped 4D file is not needed anymore (the .nii.gz stays)
    delete(niftifile2(1:end-2));
end
