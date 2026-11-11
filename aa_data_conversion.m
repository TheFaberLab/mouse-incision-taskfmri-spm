%% Step 1: DICOM -> NIfTI with dcm2niix
% needs:
% 1. dcm2niix.exe (path in A_settings.m)
% 2. the function script batches\runGL_dcm2niix.m
%
% expects the DICOM files of each EPI scan in rawpath\<session>\<scan>\
% or zipped as rawpath\<session>\<scan>.zip
% writes workpath\<session>_<scan>\<session>_<scan>.nii.gz
% Hui-Fen Chen & Bruno Pradier, University of Muenster

clear
A_settings;

sessions = dir(rawpath);
sessions = sessions([sessions.isdir] & ~strncmp({sessions.name}, '.', 1));

for a = 1:size(sessions,1)
    scans = dir(fullfile(rawpath, sessions(a).name));
    scans = scans(~strncmp({scans.name}, '.', 1));
    scans = scans([scans.isdir] | ~cellfun(@isempty, regexpi({scans.name}, '\.zip$')));

    for b = 1:size(scans,1)
        [~, scan] = fileparts(scans(b).name);  % E13.zip -> E13
        scanname = [sessions(a).name '_' scan];
        localfolder = fullfile(workpath, scanname);
        mkdir(localfolder);

        if scans(b).isdir
            dicomfolder = fullfile(rawpath, sessions(a).name, scans(b).name);
        else
            % unzip the DICOM files next to the output, not in rawpath
            dicomfolder = fullfile(localfolder, 'dicom');
            unzip(fullfile(rawpath, sessions(a).name, scans(b).name), dicomfolder);
        end

        % convert to nifti
        runGL_dcm2niix(glExe, scanname, dicomfolder, localfolder);

        % delete the unzipped DICOM files
        if ~scans(b).isdir
            rmdir(dicomfolder, 's');
        end
    end
end
