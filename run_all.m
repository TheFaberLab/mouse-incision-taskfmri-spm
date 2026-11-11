function run_all(steps)
% runs the scripts aa_ ... ee_ one after the other
%   run_all                  all steps
%   run_all({'cc','dd'})     only these steps
% from PowerShell: see README.md
% Hui-Fen Chen & Bruno Pradier, University of Muenster

here = fileparts(mfilename('fullpath'));
addpath(here);
cd(here);

if nargin < 1 || isempty(steps)
    steps = {'aa', 'bb', 'cc', 'dd', 'ee'};
end
if ischar(steps)
    steps = {steps};
end

for k = 1:numel(steps)
    script = dir(fullfile(here, [steps{k} '_*.m']));
    if numel(script) ~= 1
        error('step %s: no unique script %s_*.m found', steps{k}, steps{k});
    end
    [~, name] = fileparts(script.name);

    fprintf('\n===== %s  start %s =====\n', datestr(now), name);
    t = tic;
    evalin('base', name); % in the base workspace, like starting the script by hand
    fprintf('===== %s  done %s (%.1f min) =====\n', datestr(now), name, toc(t)/60);
end
cd(here);
fprintf('\nall steps done\n');
