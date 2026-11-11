%% Step 5: 1st level GLM with the mouse HRF (batches\SPM_post_1stOrder.m)
% 1st order (HRF only), t contrast, realignment parameters as regressors,
% thresholded at p < 0.05 uncorrected, cluster size >= 5 voxels
% writes workpath\<scan>\1stLevel_mouseHRF\ (SPM.mat, spmT_0001.nii, clusters.nii, statistics)
% Hui-Fen Chen & Bruno Pradier, University of Muenster

clear
A_settings;

parentdir = dir(workpath);
parentdir = parentdir([parentdir.isdir] & ~strncmp({parentdir.name}, '.', 1));

spm fmri; % the results are shown in the SPM windows

for a = 1:size(parentdir,1)
    folderpath = [parentdir(a).folder '\' parentdir(a).name];
    parentpath = folderpath;
    foldername = '1stLevel_mouseHRF';

    % for Make Directory
    string = strcat('Make Directory: Make Directory',{' '},"'",foldername,"'");

    % for the regressor text file
    multi_reg = dir([folderpath '\' 'rp_*']);
    multi_reg = [multi_reg.folder '\' multi_reg.name];

    % for the smoothed data (3D files)
    snms = cellstr(spm_select('FPList', folderpath, '^srav.*_\d{5}\.nii$'));
    snms = strcat(snms, ',1');

    spm('defaults','fmri'); spm_jobman('initcfg'); % Initialize spm jobman

    % set the mouse HRF (has to be done after every spm('defaults','fmri'))
    spm_get_defaults('stats.fmri.hrf', mouseHRF);
    [~, p] = spm_hrf(1);
    if ~isequal(p, mouseHRF)
        error('This SPM version does not use stats.fmri.hrf - the mouse HRF is not applied.');
    end

    % stimulation: 20 blocks, every 30 s, starting at 11 s, 10 s each
    onset = 11:30:size(snms,1);

    cd(folderpath); % the jpg figures are saved here
    clear matlabbatch
    SPM_post_1stOrder;

    % save the table of the results
    SPM_export_statistics_results;

    % mean image and binary cluster map into the result folder
    mean_image = dir([folderpath '\' 'mean' '*']);
    copyfile([mean_image.folder '\' mean_image.name],[parentpath '\' foldername '\']);
    clusterfile = dir([parentpath '\' foldername '\spm*_0001_clusters.nii']);
    movefile([clusterfile.folder '\' clusterfile.name],[parentpath '\' foldername '\clusters.nii']);
    clear hReg so SPM TabDat xSPM;

    % the 3D sra files are not needed anymore (sra<scan>.nii is the 4D version)
    if delete_sra3D
        for q = 1:size(snms,1)
            delete(snms{q}(1:end-2));
        end
    end
end
cd(here);
