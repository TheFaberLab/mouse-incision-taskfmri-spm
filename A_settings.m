%% Settings - edit the paths, then run aa_ ... ee_ one after the other
% Hui-Fen Chen & Bruno Pradier, University of Muenster

here = fileparts(mfilename('fullpath'));

SPMpath  = 'C:\DLC\SPM\spm12';                        % SPM12
glExe    = fullfile(here, 'dcm2niix', 'dcm2niix.exe'); % dcm2niix v1.0.20261029 (included)
rawpath  = fullfile(here, 'test_data');               % DICOMs: rawpath\<session>\<scan>\
workpath = fullfile(here, 'test_output');             % one folder per scan is created here

% volumes: the first 20 repetitions are discarded (pre-steady state),
% the next 600 are kept (620-repetition scans; for 1220-repetition scans
% only volumes 21-620 are used, as in the original analysis)
ndiscard = 20;
nkeep    = 600;

% mouse HRF: parameters p of SPM's double gamma function (spm_hrf.m)
% (Chen et al. 2023, Front Neurosci, doi:10.3389/fnins.2023.1187328)
mouseHRF = [4.95 8.69 1.1 1.1 1.8 0 32];

% delete the 3D sra*.nii files after the 1st level (ee_); the 4D file stays
delete_sra3D = true;

% all preprocessing parameters (scan parameters, realignment, smoothing)
% are written directly in batches\SPM_preprocessing_srav.m, as in the
% original analysis

if exist(SPMpath, 'dir')
    addpath(SPMpath);
elseif isempty(which('spm'))
    error('SPM12 not found: set SPMpath in A_settings.m');
end
addpath(fullfile(here, 'batches'));

% if SPM was added to the path with all its subfolders, old compatibility
% functions (external\fieldtrip\compat) hide MATLAB built-ins such as
% startsWith/endsWith; remove them for this session (the saved path is not changed)
p = strsplit(path, pathsep);
p = p(~cellfun(@isempty, regexp(p, 'fieldtrip[\\/]compat', 'once')));
if ~isempty(p)
    rmpath(p{:});
    fprintf('removed %d fieldtrip compat folder(s) from the path\n', numel(p));
end
clear p
